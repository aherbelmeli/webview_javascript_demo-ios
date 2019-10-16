//
//  WebViewClient.swift
//  WebViewJavascriptExample-iOS
//
//  Created by Augusto Herbel on 16/10/2019.
//  Copyright © 2019 Augusto Herbel. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class WebViewClient: NSObject, WKUIDelegate, WKScriptMessageHandler {
    
    static let shared = WebViewClient()
    
    private let stringURL = "demo.html"
    private let objectName = "interOp"
    private var webView: WKWebView!
    
    private override init() {
        super.init()
        webView = WKWebView()
        webView.isHidden = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.configuration.userContentController.add(self, name: objectName)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        //guard let url =  URL(string: stringURL) else { return }
        
        let url = Bundle.main.url(forResource: "demo", withExtension: "html", subdirectory: "")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        
        let text = "un text"
        webView.evaluateJavaScript("showText(\'" + text + "\')") { (any, error) in
            if (error == nil) {
                // show Result
            } else {
                // show Error
            }
        }
        //webView.load(URLRequest(url: url))
    }
    
    public func addToView(_ view: UIView) {
        webView.frame = view.layer.bounds
        view.addSubview(webView)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
            super.observeValue(forKeyPath: nil, of: object, change: change, context: context)
            return
        }
        switch keyPath {
        case "estimatedProgress":
            break
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if (message.name == "interOp") {
            print("-----------> Web message: \(message.body)")
            if let response: [String : Any] = message.body as? [String : Any] {
                handleEventMessage(response: response)
            }
        }
        //close_app = Logout
        //close_app = LockApp
        //close_app = CancelLogin
    }
    
    func injectJavascript(_ webView: WKWebView) {
        
    }
    
    func handleEventMessage(response: [String : Any]) {
        let message = response["message"] as? String
        switch message {
        case "close_app":
            let body = response["data"]
            break
        case "showMessage":
            
            break
        default:
            break
        }
    }
}

//MARK: WebView navigation

extension WebViewClient : WKNavigationDelegate{
    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    
}
