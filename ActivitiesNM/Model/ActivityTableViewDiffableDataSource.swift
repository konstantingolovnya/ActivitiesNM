//
//  ActivityTableViewDiffableDataSource.swift
//  ActivitiesNM
//
//  Created by Konstantin on 27.02.2024.
//

import UIKit

enum Categoties {
    case activities
}

class ActivityTableViewDiffableDataSource: UITableViewDiffableDataSource<Categoties, Activity> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
