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
        
        webView.navigationDelegate = self
        let urlLink = NSURL(string: url)
        if let url = urlLink {
            webView.load(URLRequest(url: url as URL))
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(navigationResponse.response.url)
        decisionHandler(.allow)
    }
}
