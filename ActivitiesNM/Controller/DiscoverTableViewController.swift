//
//  DiscoverTableViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 25.04.2024.
//

import UIKit
import CoreData

class DiscoverTableViewController: UITableViewController {

    var networkManager = NetworkManager()
    var activities: [ActivityData] = []
    var spinner = UIActivityIndicatorView(style: .medium)

    lazy var dataSource = configureDataSource()

    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSpinner()

        networkManager.delegate = self
        networkManager.fetchActivities()
    }

    //MARK: - Setup methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Рекомендации"

        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }

    private func setupTableView() {
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: String(describing: ActivitiesTableViewCell.self))
    }

    private func setupSpinner() {
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        spinner.startAnimating()
    }

    //MARK: - TableViewDiffableDataSource
    private func configureDataSource() -> UITableViewDiffableDataSource<Categories, ActivityData> {
        let cellIdentifier = String(describing: ActivitiesTableViewCell.self)
        return UITableViewDiffableDataSource<Categories, ActivityData>(tableView: tableView) { tableView, indexPath, activity in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActivitiesTableViewCell
            cell.nameLabel.text = activity.name
            cell.locationLabel.text = activity.location
            cell.typeLabel.text = activity.type
            cell.favoriteImageView.isHidden = true

            if let urlString = activity.image {
                self.networkManager.loadImage(from: urlString) { result in
                    switch result {
                    case .success(let data):
                        cell.presentationImageView.image = UIImage(data: data)
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            }
            return cell
        }
    }

    private func updateSnapshot(animatingChange: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Categories, ActivityData>()
        snapshot.appendSections([.activities])
        snapshot.appendItems(activities, toSection: .activities)
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }

    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = activities[indexPath.row]
        loadActivityDetails(for: activity)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToMyActivityAction = UIContextualAction(style: .normal, title: "Добавить в мои активности") { action, sourceView, completionHandler in
            self.addActivityToMyList(at: indexPath)
            completionHandler(true)
        }
        addToMyActivityAction.backgroundColor = .systemGreen
        addToMyActivityAction.image = UIImage(systemName: "plus")
        return UISwipeActionsConfiguration(actions: [addToMyActivityAction])
    }

    //MARK: - Helper methods
    private func loadActivityDetails(for activityData: ActivityData) {
//        let destinationController = ActivityDetailViewController()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let activity = Activity(context: context)
            activity.isFavorite = false
            activity.name = activityData.name ?? ""
            activity.location = activityData.location ?? ""
            activity.type = activityData.type ?? ""
            activity.phone = activityData.phone ?? ""
            activity.summary = activityData.summary ?? ""

            if let urlString = activityData.image {
                networkManager.loadImage(from: urlString) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            activity.image = data
                            self.presentDetailViewController(activity: activity)
                        }
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.presentDetailViewController(activity: activity)
                }
            }
        }
    }

    private func addActivityToMyList(at indexPath: IndexPath) {
        let targetActivity = activities[indexPath.row]
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let newActivity = Activity(context: context)
            newActivity.isFavorite = false
            newActivity.location = targetActivity.location ?? ""
            newActivity.name = targetActivity.name ?? ""
            newActivity.type = targetActivity.type ?? ""
            newActivity.phone = targetActivity.phone ?? ""
            newActivity.summary = targetActivity.summary ?? ""

            if let urlString = targetActivity.image {
                networkManager.loadImage(from: urlString) { result in
                    switch result {
                    case .success(let data):
                        newActivity.image = data
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            }
            appDelegate.saveContext()
        }
    }

    private func presentDetailViewController(activity: Activity) {
        let destinationController = ActivityDetailViewController()
        destinationController.hidesBottomBarWhenPushed = true
        destinationController.activity = activity
        destinationController.completionHandler = { wasEdited in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            if !wasEdited {
                context.delete(activity)
            }
            do {
                try context.save()
            } catch {
                print("Error when saving new activity")
            }
        }
        show(destinationController, sender: self)
    }
}

//MARK: - NetworkManagerDelegate
extension DiscoverTableViewController: NetworkManagerDelegate {
    func didGetActivities(_ activities: [ActivityData]) {
        self.activities = activities
        updateSnapshot()
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }

    func didFailWithError(_ error: Error) {
        print("Network error: \(error.localizedDescription)")
    }
}
