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
    
    var targetURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame.size = view.bounds.size
        
        loadTargetURL()
    }
    
    private func loadTargetURL() {
            guard let url = URL(string: targetURL) else {
                print("Invalid URL string: \(targetURL)")
                return
            }
            let request = URLRequest(url: url)
            webView.load(request)
        }
}
