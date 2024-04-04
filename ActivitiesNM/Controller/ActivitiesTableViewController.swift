//
//  ActivitiesTableViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import UIKit
import CoreData

class ActivitiesTableViewController: UITableViewController {
    
    @IBOutlet var emptyRestaurantView: UIImageView!
    var activities: [Activity] = []

    var fetchResultController : NSFetchedResultsController<Activity>!
    
    var searchController: UISearchController!
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
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
        
        tableView.dataSource = dataSource
        
        tableView.backgroundView = emptyRestaurantView
        
        fetchActivityData()
        
        searchController = UISearchController(searchResultsController: nil)
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти нужную активность..."
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(identifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true)
        }
    }
    
    //MARK: - Fetch Data
    func fetchActivityData(searchText: String = "") {
        let fetchRequest = Activity.fetchRequest()
        
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "location CONTAINS[cd] %@ OR name CONTAINS[cd] %@", searchText, searchText)
        }
        
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
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
    }
    
    func updateSnapshot(animatingChange: Bool = true) {
        if let fetchedObjects = fetchResultController.fetchedObjects {
            activities = fetchedObjects
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Categories, Activity>()
        snapshot.appendSections([.activities])
        snapshot.appendItems(activities, toSection: .activities)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)

        tableView.backgroundView?.isHidden = !activities.isEmpty
    }
    
    //MARK: - UITableView Diffable Data Source
    func configureDataSource() -> ActivityTableViewDiffableDataSource {
                
        let cellIdentifier = "itemcell"
        
        let dataSource = ActivityTableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, activity in
                        
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActivitiesTableViewCell
            
            cell.presentationImageView.image = UIImage(data: activity.image)
            cell.nameLabel.text = activity.name
            cell.locationLabel.text = activity.location
            cell.typeLabel.text = activity.type
            cell.favoriteImageView.isHidden = !activity.isFavorite
            
            return cell
        }
        return dataSource
    }
    
    lazy var dataSource = configureDataSource()
    
    //MARK: - UITableViewDelegate Protocol
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let activity = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, sourceView, complitionHandler in
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext
                
                context.delete(activity)
                appDelegate.saveContext()
                
                self.updateSnapshot()
            }
            
            complitionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Поделиться") { action, sourceView, complitionHandler in
            
            let defaultText = "Советую посетить \(activity.type) \(activity.name) в \(activity.location)"
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: activity.name) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true)
            
            complitionHandler(true)
            
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { action, sourceView, complitionHandler in
            
            let cell = tableView.cellForRow(at: indexPath) as! ActivitiesTableViewCell
            
            self.activities[indexPath.row].isFavorite = !self.activities[indexPath.row].isFavorite
            cell.favoriteImageView.isHidden = !self.activities[indexPath.row].isFavorite
            
            complitionHandler(true)
        }
        
        favoriteAction.backgroundColor = UIColor.systemOrange
        let isFavorite = self.activities[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill"
        favoriteAction.image = UIImage(systemName: isFavorite)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeConfiguration
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivityDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ActivityDetailViewController
                destinationController.activity = self.activities[indexPath.row]
                
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    @IBAction func unwindToHome(seque: UIStoryboardSegue) {
        dismiss(animated: true)
    }
}

//MARK: - NSFetchedResultsControllerDelegate Protocol
extension ActivitiesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}


//MARK: - UISearchResultsUpdating Protocol
extension ActivitiesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        fetchActivityData(searchText: searchText)
    }
}

