//
//  ArtistDetailViewController.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {

    var profileID : String!
    var profileName : String!
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = profileName
        
        let urlString: String = kBaseURL + "Artists/?prof=" + self.profileID
        let url = NSURL(string: urlString)
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
