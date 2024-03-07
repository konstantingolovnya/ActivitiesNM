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
        navigationItem.backButtonTitle = ""
        
        headerView.headerImageView.image = UIImage(named: activity.name)
        headerView.nameLabel.text = activity.name
        headerView.typeLabel.text = activity.type

        
        let heartImage = activity.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = activity.isFavorite ? .systemRed : .white
        headerView.heartButton.setImage(UIImage(named: heartImage), for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    @IBAction func rateActivity(segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        dismiss(animated: true) {
            if let rating = Activity.Rating(rawValue: identifier) {
                self.activity.rating = rating
                self.headerView.ratingImage.image = UIImage(named: rating.image)
                
                let scaleTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.headerView.ratingImage.alpha = 0
                self.headerView.ratingImage.transform = scaleTransform
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7) {
                    self.headerView.ratingImage.alpha = 1
                    self.headerView.ratingImage.transform = .identity
                }
            }
        }
        
    }
    
}
    


//MARK: - UITableViewDelegate Protocol, UITableViewDataSource Protocol
extension ActivityDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailTextCell.self), for: indexPath) as! ActivityDetailTextCell
            cell.descriptionLabel.text = activity.description
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailTwoColumnCell.self), for: indexPath) as! ActivityDetailTwoColumnCell
            cell.column1TitleLabel.text = "Адрес"
            cell.column1TextLabel.text = activity.location
            cell.column2TitleLabel.text = "Телефон"
            cell.column2TextLabel.text = activity.phoneNumber
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailMapCell.self), for: indexPath) as! ActivityDetailMapCell
            cell.configure(location: activity.location)
            cell.selectionStyle = .none
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMap":
            let destinationCintroller = segue.destination as! MapViewController
            destinationCintroller.activity = activity
            
        case "showReview":
            let destinationController = segue.destination as! ReviewViewController
            destinationController.activity = activity
            
        default: break
        }
    }
}
