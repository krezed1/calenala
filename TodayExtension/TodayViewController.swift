//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Daniel Krezelok on 27/06/2017.
//  Copyright © 2017 Krezelok, Daniel. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://google.com")
        let request = URLRequest(url: url!)
        webView?.loadRequest(request)
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
