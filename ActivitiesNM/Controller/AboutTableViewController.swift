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
    
    var sectionContent = [
        [
            LinkItem(
                text: "Rate us on App Store",
                link: "https://www.apple.com/ios/app-store/",
                image: "store"
            ),
            LinkItem(
                text: "Tell us your feedback",
                link: "https://www.apple.com/feedback/iphone/",
                image: "chat"
            )
        ],
        [
            LinkItem(
                text: "Twitter",
                link: "https://twitter.com/Apple",
                image: "twitter"
            ),
            LinkItem(
                text: "Facebook",
                link: "https://www.facebook.com/apple",
                image: "facebook"
            ),
            LinkItem(
                text: "Instagram",
                link: "https://www.instagram.com/apple/",
                image: "instagram"
            )
        ]
    ]
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        tableView.dataSource = dataSource
        updateSnapshot()
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        
        let cellIdentifier = "aboutcell"
        
        let dataSource = UITableViewDiffableDataSource<Section, LinkItem>(tableView: tableView, cellProvider: { tableView, indexPath, linkItem in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            
            return cell
        })
        
        return dataSource
    }
    
   
    
    func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus])
        snapshot.appendItems(sectionContent[0], toSection: .feedback)
        snapshot.appendItems(sectionContent[1], toSection: .followus)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "showWebView", sender: self)
        case 1:
            openWithSafariViewController(indexPath: indexPath)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWebView" {
            if let destinationController = segue.destination as? WebViewController, let indexPath = tableView.indexPathForSelectedRow, let linkItem = self.dataSource.itemIdentifier(for: indexPath) {
                
                destinationController.targerURL = linkItem.link
            }
        }
    }
    
    func openWithSafariViewController(indexPath: IndexPath) {
        
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        if let url = URL(string: linkItem.link) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true)
        }
    }
}
