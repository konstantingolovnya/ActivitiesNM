//
//  ActivityDetailView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 11.04.2024.
//

import UIKit

class ActivityDetailView: UIView {
    
    lazy var headerView = ActivityDetailHeaderView()
    
    lazy var tableView = UITableView()
    
    lazy  var rateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оценить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = UIColor(named: "Navigation Bar Title")
        button.configuration?.cornerStyle = .capsule
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonView: UIView = {
       let view = UIView()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = rateButton
        
        
//        NSLayoutConstraint.activate([
//            
//        ])
    }
}
