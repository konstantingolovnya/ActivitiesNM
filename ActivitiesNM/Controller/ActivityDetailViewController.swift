//
//  ActivityDetailViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 29.02.2024.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: ActivityDetailHeaderView!
    
    var activity = Activity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        headerView.headerImageView.image = UIImage(named: activity.name)
        headerView.nameLabel.text = activity.name
        headerView.typeLabel.text = activity.type
        
        let heartImage = activity.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = activity.isFavorite ? .systemRed : .white
        headerView.heartButton.setImage(UIImage(named: heartImage), for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
}
    

//MARK: - UITableViewDelegate Protocol, UITableViewDataSource Protocol
extension ActivityDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailTextCell.self), for: indexPath) as! ActivityDetailTextCell
            cell.descriptionLabel.text = activity.description
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailTwoColumnCell.self), for: indexPath) as! ActivityDetailTwoColumnCell
            cell.column1TitleLabel.text = "Адрес"
            cell.column1TextLabel.text = activity.location
            cell.column2TitleLabel.text = "Телефон"
            cell.column2TextLabel.text = activity.phoneNumber
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}
