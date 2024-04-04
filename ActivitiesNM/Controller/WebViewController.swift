//
//  WebViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 04.04.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var targerURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: targerURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
