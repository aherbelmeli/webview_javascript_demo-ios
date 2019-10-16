//
//  ViewController.swift
//  WebViewJavascriptExample-iOS
//
//  Created by Augusto Herbel on 16/10/2019.
//  Copyright © 2019 Augusto Herbel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebViewClient.shared.addToView(self.pageView)
    }


}

