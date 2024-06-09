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
            case .navigation: return "Избранные"
            case .about: return "О приложении"
            case .discover: return "Рекомендации"
            }
        }
        
        var iconName: String {
            switch self {
            case .navigation: return "tag.fill"
            case .about: return "square.stack"
            case .discover: return "wand.and.rays"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.navigation, .discover, .about]
        
        self.viewControllers = dataSource.map { tabBarItem in
            let viewController: UIViewController
            switch tabBarItem {
            case .navigation:
                viewController = ActivitiesTableViewController()
            case .about:
                viewController = AboutTableViewController()
            case .discover:
                viewController = DiscoverTableViewController()
            }
            return wrappedInNavigationController(viewController)
        }
        
        guard let viewControllers = self.viewControllers else { return }
        viewControllers.enumerated().forEach {
            let item = dataSource[$0]
            $1.tabBarItem.title = item.title
            $1.tabBarItem.image = UIImage(systemName: item.iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
    
    private func wrappedInNavigationController(_ viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
}

