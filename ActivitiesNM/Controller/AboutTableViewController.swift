//
//  AboutTableViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 04.04.2024.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    enum Section {
        case feedback
        case followus
    }
    
    struct LinkItem: Hashable {
        var text: String
        var link: String
        var image: String
    }
    
    private let sectionContent = [
        [
            LinkItem(text: "Rate us on App Store", link: "https://www.apple.com/ios/app-store/", image: "store"),
            LinkItem(text: "Tell us your feedback", link: "https://www.apple.com/feedback/iphone/", image: "chat")
        ],
        [
            LinkItem(text: "Twitter", link: "https://twitter.com/Apple", image: "twitter"),
            LinkItem(text: "Facebook", link: "https://www.facebook.com/apple", image: "facebook"),
            LinkItem(text: "Instagram", link: "https://www.instagram.com/apple/", image: "instagram")
        ]
    ]
    
    lazy var dataSource = configureDataSource()
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        let header = AboutImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.25))
        tableView.tableHeaderView = header
        tableView.register(AboutTableViewCell.self, forCellReuseIdentifier: String(describing: AboutTableViewCell.self))
        tableView.dataSource = dataSource
        updateSnapshot()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "О приложении"
        
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    // MARK: - TableViewDiffableDataSource
    private func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        let cellIdentifier = String(describing: AboutTableViewCell.self)
        return UITableViewDiffableDataSource<Section, LinkItem>(tableView: tableView) { tableView, indexPath, linkItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            return cell
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus])
        snapshot.appendItems(sectionContent[0], toSection: .feedback)
        snapshot.appendItems(sectionContent[1], toSection: .followus)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            openWebViewController(for: indexPath)
        case 1:
            openWithSafariViewController(for: indexPath)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Navigation
    private func openWebViewController(for indexPath: IndexPath) {
        guard let linkItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let destinationController = WebViewController()
        destinationController.targetURL = linkItem.link
        present(destinationController, animated: true)
    }
    
    private func openWithSafariViewController(for indexPath: IndexPath) {
        guard let linkItem = dataSource.itemIdentifier(for: indexPath) else { return }
        if let url = URL(string: linkItem.link) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true)
        }
    }
}
