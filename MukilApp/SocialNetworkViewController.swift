//
//  SocialNetworkViewController.swift
//  MukilApp
//
//  Created by mohamed on 28/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class SocialNetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addRevealButton()
        self.title = "Social Network"
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
