//
//  ProgramsWebViewController.swift
//  MukilApp
//
//  Created by mohamed on 28/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ProgramsWebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    var appendUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = NSURL(string: appendUrl)
        let request:NSURLRequest = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
