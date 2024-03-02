//
//  ActivitiesTableViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import UIKit

class ActivitiesTableViewController: UITableViewController {
    
    var activities = [
        Activity(
            name: "Royal",
            type: "Billiard Club",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        ),
        Activity(
            name: "Khabarovsk",
            type: "Cinema",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        ),
        Activity(
            name: "Hollywood",
            type: "Cinema",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        ),
        Activity(
            name: "Volkonsky",
            type: "Shooting complex",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        ),
        Activity(
            name: "Time Quest",
            type: "Quest",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        ),
        Activity(
            name: "VR GameClub",
            type: "Virtual Reality Club",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        ),
        Activity(
            name: "Spartak",
            type: "Ski resort",
            location: "Russia, Khabarovsk",
            description: "Отличный кинотеатр где можно провести выходные и посмотреть кино всей семьей. Есть игровые зоны для детей и зона игровых автоматов. В вечернее время можно поиграть в боулинг или бильярд",
            phoneNumber: "+7(999)999-99-99",
            isFavorite: false
        )
    ]
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
                
        var snapshot = NSDiffableDataSourceSnapshot<Categoties, Activity>()
        snapshot.appendSections([.activities])
        snapshot.appendItems(activities, toSection: .activities)
        
        dataSource.apply(snapshot)
        
        tableView.dataSource = dataSource
    }
    
    //MARK: - UITableView Diffable Data Source
    func configureDataSource() -> ActivityTableViewDiffableDataSource {
                
        let cellIdentifier = "itemcell"
        
        let dataSource = ActivityTableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, activity in
                        
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActivitiesTableViewCell
            
            cell.presentationImageView.image = UIImage(named: activity.name)
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
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let favoriteActionTitle = activities[indexPath.row].isFavorite ? "Удалить из избранного" : "Добавить в избранное"
//
//        
//        let optionMenu = UIAlertController(title: nil, message: "Что бы Вы хотели сделать?", preferredStyle: .actionSheet)
//        
//        optionMenu.addAction(UIAlertAction(title: "Отменить", style: .cancel))
//        
//        let reserveAction = UIAlertAction(title: "Записаться", style: .default) { action in
//            
//            let alertMessage = UIAlertController(title: "Временно не доступно", message: "К сожалению данная активность не доступна в настоящее время. Пожалуйста, повторите позже.", preferredStyle: .alert)
//            
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .cancel))
//            
//            self.present(alertMessage, animated: true)
//        }
//        optionMenu.addAction(reserveAction)
//        
//        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default) { action in
//            
//            let cell = tableView.cellForRow(at: indexPath) as! ActivitiesTableViewCell
//            
//            cell.favoriteImageView.isHidden = self.activities[indexPath.row].isFavorite
//            
//            self.activities[indexPath.row].isFavorite = !self.activities[indexPath.row].isFavorite
//            
//        }
//        optionMenu.addAction(favoriteAction)
//        
//        if let popoverController = optionMenu.popoverPresentationController {
//            if let cell = tableView.cellForRow(at: indexPath) {
//                popoverController.sourceView = cell
//                popoverController.sourceRect = cell.bounds
//            }
//        }
//        
//        present(optionMenu, animated: true)
//        
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let activity = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, sourceView, complitionHandler in
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([activity])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivityDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ActivityDetailViewController
                destinationController.activity = self.activities[indexPath.row]
            }
        }
    }
    
}
