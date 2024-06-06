////
////  DiscoverTableViewController.swift
////  ActivitiesNM
////
////  Created by Konstantin on 25.04.2024.
////
//
//import UIKit
//import CoreData
//
//class DiscoverTableViewController: UITableViewController {
//    
//    var networkManager = NetworkManager()
//    
//    var activities: [ActivityData]!
//        
//    var spinner = UIActivityIndicatorView()
//    
//    lazy var dataSource = configureDataSource()
//    
//    //MARK: - View controller life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.cellLayoutMarginsFollowReadableWidth = true
//        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Рекомендации"
//        
//        if let appearance = navigationController?.navigationBar.standardAppearance {
//            appearance.configureWithTransparentBackground()
//            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
//                
//                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
//                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
//            }
//            
//            navigationController?.navigationBar.standardAppearance = appearance
//            navigationController?.navigationBar.compactAppearance = appearance
//            navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        }
//        
//        networkManager.deligate = self
//        networkManager.fetchActivities()
//        
//        tableView.dataSource = dataSource
//        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: String(describing: ActivitiesTableViewCell.self))
//        
//        spinner.style = .medium
//        spinner.hidesWhenStopped = true
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(spinner)
//        
//        NSLayoutConstraint.activate([
//            spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
//            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//        
//        spinner.startAnimating()
//    }
//    
//    //MARK: - TableViewDiffableDataSource
//    func updateSnapshot(animatingChange: Bool = false) {
//        var snapshot = NSDiffableDataSourceSnapshot<Categories, ActivityData>()
//        snapshot.appendSections([.activities])
//        snapshot.appendItems(activities, toSection: .activities)
//        dataSource.apply(snapshot, animatingDifferences: false)
//    }
//    
//    func configureDataSource() -> UITableViewDiffableDataSource<Categories, ActivityData> {
//        let cellIdentifier = String(describing: ActivitiesTableViewCell.self)
//        
//        let dataSource = UITableViewDiffableDataSource<Categories, ActivityData>(tableView: tableView) {(tableView, indexPath, activity) -> UITableViewCell? in
//           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActivitiesTableViewCell
//            cell.nameLabel.text = self.activities[indexPath.row].name
//            cell.locationLabel.text = self.activities[indexPath.row].location
//            cell.typeLabel.text = self.activities[indexPath.row].type
//            cell.favoriteImageView.isHidden = true
//            
//            if let urlString = self.activities[indexPath.row].image {
//                self.networkManager.loadImage(from: urlString) { result in
//                    switch result {
//                    case .success(let data):
//                        if let image = UIImage(data: data) {
//                            cell.presentationImageView.image = image
//                        }
//                    case .failure(let error):
//                        print("Error loading image: \(error)")
//                    }
//                }
//            }
//            return cell
//        }
//        return dataSource
//    }
//    
//    //MARK: - TableViewDelegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let activity = self.activities[indexPath.row]
//        
//            let destinationController = ActivityDetailViewController()
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                let context = appDelegate.persistentContainer.viewContext
//                destinationController.activity = Activity(context: context)
//                destinationController.activity.isFavorite = false
//                destinationController.activity.location = activity.location ?? ""
//                destinationController.activity.name = activity.name ?? ""
//                destinationController.activity.type = activity.type ?? ""
//                destinationController.activity.phone = activity.phone ?? ""
//                destinationController.activity.summary = activity.summary ?? ""
//                
//                if let urlString = self.activities[indexPath.row].image {
//                    self.networkManager.loadImage(from: urlString) { result in
//                        switch result {
//                        case .success(let data):
//                            destinationController.activity.image = data
//                            self.presentDetailViewController(activity: destinationController.activity)
//                        case .failure(let error):
//                            print("Error loading image: \(error)")
//                        }
//                    }
//                }
//            }
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let addToMyActivityAction = UIContextualAction(style: .destructive, title: "Добавить в мои активности") { action, sourceView, complitionHandler in
//            
//            let targetActivity = self.activities[indexPath.row]
//            
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                let context = appDelegate.persistentContainer.viewContext
//                
//                let newActivity = Activity(context: context)
//                newActivity.isFavorite = false
//                newActivity.location = targetActivity.location ?? ""
//                newActivity.name = targetActivity.name ?? ""
//                newActivity.type = targetActivity.type ?? ""
//                newActivity.phone = targetActivity.phone ?? ""
//                newActivity.summary = targetActivity.summary ?? ""
//                
//                if let urlString = self.activities[indexPath.row].image {
//                    self.networkManager.loadImage(from: urlString) { result in
//                        switch result {
//                        case .success(let data):
//                            newActivity.image = data
//                        case .failure(let error):
//                            print("Error loading image: \(error)")
//                        }
//                    }
//                }
//                appDelegate.saveContext()
//                
//                self.updateSnapshot()
//            }
//            complitionHandler(true)
//        }
//        addToMyActivityAction.backgroundColor = UIColor.systemGreen
//        addToMyActivityAction.image = UIImage(systemName: "plus")
//        
//        let swipeConfiguration = UISwipeActionsConfiguration(actions: [addToMyActivityAction])
//        return swipeConfiguration
//    }
//    
//    //MARK: - Present DetailViewController
//    func presentDetailViewController(activity: Activity) {
//        let destinationController = ActivityDetailViewController()
//        destinationController.hidesBottomBarWhenPushed = true
//        destinationController.activity = activity
//        destinationController.completionHandler = { wasEdited in
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//            let context = appDelegate.persistentContainer.viewContext
//            if !wasEdited {
//                context.delete(activity)
//            }
//            do {
//                try context.save()
//            } catch {
//                print("Error when saving new activity")
//            }
//        }
//        show(destinationController, sender: self)
//    }
//}
//
////MARK: - Networking
//extension DiscoverTableViewController: NetworkManagerDeligate {
//    func didGetActivities(activities: [ActivityData]) {
//        
//        self.activities = activities
//        self.updateSnapshot()
//        
//        DispatchQueue.main.async {
//            self.spinner.stopAnimating()
//        }
//    }
//    
//    func didFailWithError(error: any Error) {
//        print(error)
//    }
//}
