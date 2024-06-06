//
//  WebViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 04.04.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView = WKWebView()
    
    var targerURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame.size = view.bounds.size
        
        if let url = URL(string: targerURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
