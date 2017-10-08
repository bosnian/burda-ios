//
//  NokiaViewController.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit
import WebKit

class NokiaViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var url = "https://account.health.nokia.com/oauth2_user/authorize2?response_type=code&redirect_uri=http://egosharp.herokuapp.com/code_callback&client_id=1a27e60343ec89d53596f555a0f2b9a2d09b6746d8ba5c8f60ee213bb1f91bcd&scope=user.info,user.metrics,user.activity&state=768uyFys"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nokia Health"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 54.0 / 255.0, green: 173.0 / 255.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        
        webView.navigationDelegate = self
        let urlLink = NSURL(string: url)
        if let url = urlLink {
            webView.load(URLRequest(url: url as URL))
        }
    }
    
    func close() {
        webView.stopLoading()
        dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(navigationResponse.response.url)
        decisionHandler(.allow)
    }
}
