//
//  TabBarController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 07.04.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabBarItem: Int {
        case navigation
        case about
        case discover
        
        var title: String {
            switch self {
            case .navigation:
                return "Избранные"
            case .about:
                return "О приложении"
            case .discover:
                return "Рекомендации"
            }
        }
        
        var iconName: String {
            switch self {
            case .navigation:
                return "tag.fill"
            case .about:
                return "square.stack"
            case .discover:
                return "wand.and.rays"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        
        let dataSource: [TabBarItem] = [.navigation, .discover, .about]
        
        self.viewControllers = dataSource.map({ tabBarItem in
            switch tabBarItem {
            case .navigation:
                let activitiesTableViewController = ActivitiesTableViewController()
                return self.wrappedInNavigationController(with: activitiesTableViewController)
            case .about:
                let aboutTableViewController = AboutTableViewController()
                return self.wrappedInNavigationController(with: aboutTableViewController)
            case .discover:
                let discoverTableViewControler = DiscoverTableViewController()
                return self.wrappedInNavigationController(with: discoverTableViewControler)
            }
        })
        
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    private func wrappedInNavigationController(with viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    
}
