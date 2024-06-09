//
//  ActivityDetailViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 29.02.2024.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    lazy var tableView = UITableView()
    
    var activity: Activity!
    
    var hasChanges = false
    
    var completionHandler: ((Bool) -> Void)?
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        showFavoriteImage()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completionHandler?(hasChanges)
    }
    
    //MARK: - Setup Methods
    private func setupView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = ""
        
        let saveAsFavoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(saveAsFavoriteButtonTapped))
        navigationItem.rightBarButtonItem = saveAsFavoriteButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        
        let headerView = ActivityDetailHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 3))
        headerView.headerImageView.image = UIImage(data: activity.image)
        headerView.nameLabel.text = activity.name
        headerView.typeLabel.text = activity.type
        
        if let rating = activity.rating {
            headerView.ratingImage.image = UIImage(named: rating.image)
        }
        tableView.tableHeaderView = headerView
        
        let footerView = ActivityDetailFooterView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        footerView.rateButton.addTarget(self, action: #selector(rateButtonAction), for: .touchUpInside)
        tableView.tableFooterView = footerView
        
        tableView.register(ActivityDetailTextCell.self, forCellReuseIdentifier: String(describing: ActivityDetailTextCell.self))
        tableView.register(ActivityDetailTwoColumnCell.self, forCellReuseIdentifier: String(describing: ActivityDetailTwoColumnCell.self))
        tableView.register(ActivityDetailMapCell.self, forCellReuseIdentifier: String(describing: ActivityDetailMapCell.self))
    }
    
    //MARK: - Favorite Action
    @objc private func saveAsFavoriteButtonTapped() {
        activity.isFavorite.toggle()
        showFavoriteImage()
        hasChanges = true
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.saveContext()
        }
    }
    
    private func showFavoriteImage() {
        let heartImage = activity.isFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.tintColor = activity.isFavorite ? .systemRed : .white
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: heartImage)
    }
    
    @objc private func rateButtonAction() {
        let destinationController = ReviewViewController()
        destinationController.activity = activity
        destinationController.delegate = self
        
        present(destinationController, animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ActivityDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailTextCell.self), for: indexPath) as! ActivityDetailTextCell
            cell.descriptionLabel.text = activity.summary
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailTwoColumnCell.self), for: indexPath) as! ActivityDetailTwoColumnCell
            cell.column1TitleLabel.text = "Адрес"
            cell.column1TextLabel.text = activity.location
            cell.column2TitleLabel.text = "Телефон"
            cell.column2TextLabel.text = activity.phone
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivityDetailMapCell.self), for: indexPath) as! ActivityDetailMapCell
            cell.configure(with: activity.location)
            cell.selectionStyle = .none
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let destinationController = MapViewController()
            destinationController.activity = activity
            show(destinationController, sender: self)
        }
    }
}

//MARK: - RateActivityDelegate
extension ActivityDetailViewController: RateActivityDelegate {
    
    func rateActivity(rating: String) {
        activity.rating = Activity.Rating(rawValue: rating.lowercased())
        hasChanges = true
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.saveContext()
        }
        dismiss(animated: true) {
            self.updateHeaderViewWithRating()
        }
    }
    
    private func updateHeaderViewWithRating() {
        guard let header = tableView.tableHeaderView as? ActivityDetailHeaderView, let rating = activity.rating else { return }
        
        header.ratingImage.image = UIImage(named: rating.image)
        
        let scaleTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        header.ratingImage.alpha = 0
        header.ratingImage.transform = scaleTransform
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7) {
            header.ratingImage.alpha = 1
            header.ratingImage.transform = .identity
        }
    }
}
