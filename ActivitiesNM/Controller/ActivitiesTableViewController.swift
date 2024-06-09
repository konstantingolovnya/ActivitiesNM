//
//  ActivitiesTableViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import UIKit
import CoreData

class ActivitiesTableViewController: UITableViewController {
        
    var activities: [Activity] = []
    var fetchResultController: NSFetchedResultsController<Activity>!
    var searchController: UISearchController!
    lazy var dataSource = configureDataSource()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureAddNewActivityButton()
        configureBackgroundView()
        fetchActivityData()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationItem.title = "ActivitiesNM"
        
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            
            if let font = UIFont(name: "Nunito-Bold", size: 45) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: font]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func configureAddNewActivityButton() {
        let addNewActivityButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addNewActivityButtonTapped))
        navigationItem.rightBarButtonItem = addNewActivityButton
    }
    
    private func configureBackgroundView() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "emptydata"))
        tableView.backgroundView?.contentMode = .scaleAspectFit
    }
    
    private func configureTableView() {
        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: String(describing: ActivitiesTableViewCell.self))
        tableView.dataSource = dataSource
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти нужную активность..."
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func fetchActivityData(searchText: String = "") {
        let fetchRequest = Activity.fetchRequest()
        
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "location CONTAINS[cd] %@ OR name CONTAINS[cd] %@", searchText, searchText)
        }
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            updateSnapshot()
        } catch {
            print(error)
        }
    }
    
    private func updateSnapshot(animatingChange: Bool = true) {
        guard let fetchedObjects = fetchResultController.fetchedObjects else { return }
        activities = fetchedObjects
        
        var snapshot = NSDiffableDataSourceSnapshot<Categories, Activity>()
        snapshot.appendSections([.activities])
        snapshot.appendItems(activities, toSection: .activities)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
        tableView.backgroundView?.isHidden = !activities.isEmpty
    }
    
    private func configureDataSource() -> ActivityTableViewDiffableDataSource {
        return ActivityTableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, activity in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivitiesTableViewCell.self), for: indexPath) as! ActivitiesTableViewCell
            cell.presentationImageView.image = UIImage(data: activity.image)
            cell.nameLabel.text = activity.name
            cell.locationLabel.text = activity.location
            cell.typeLabel.text = activity.type
            cell.favoriteImageView.isHidden = !activity.isFavorite
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let activity = dataSource.itemIdentifier(for: indexPath) else { return UISwipeActionsConfiguration() }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            context.delete(activity)
            appDelegate.saveContext()
            self.updateSnapshot()
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Поделиться") { _, sourceView, completionHandler in
            let defaultText = "Советую посетить \(activity.type) \(activity.name) в \(activity.location)"
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(named: activity.name) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            if let popoverController = activityController.popoverPresentationController {
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceView.bounds
            }
            self.present(activityController, animated: true)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = .systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { _, _, completionHandler in
            let cell = tableView.cellForRow(at: indexPath) as! ActivitiesTableViewCell
            self.activities[indexPath.row].isFavorite.toggle()
            cell.favoriteImageView.isHidden = !self.activities[indexPath.row].isFavorite
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = .systemOrange
        let isFavorite = self.activities[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill"
        favoriteAction.image = UIImage(systemName: isFavorite)
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationController = ActivityDetailViewController()
        destinationController.activity = activities[indexPath.row]
        destinationController.hidesBottomBarWhenPushed = true
        show(destinationController, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func addNewActivityButtonTapped() {
        let destinationController = UINavigationController(rootViewController: NewActivityController())
        present(destinationController, animated: true)
    }
}

extension ActivitiesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}

extension ActivitiesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        fetchActivityData(searchText: searchText)
    }
}
