//
//  ProgramsDetailViewController.swift
//  MukilApp
//
//  Created by mohamed on 28/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ProgramsDetailViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?

    var appendDict:[String : String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println(self.appendDict)
        
        var controllerArray : [UIViewController] = []
        
        let controller1:ProgramsWebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsWebViewVC") as! ProgramsWebViewController
        controller1.title = "Audio"
        controller1.appendUrl = "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/" + appendDict["Audio"]!
        controllerArray.append(controller1)
        
        let controller4:VideoPlayListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("VideoPlayListVC") as! VideoPlayListViewController
        controller4.title = "Video"
        controller4.appendUrl = "https://gdata.youtube.com/feeds/api/playlists/" + appendDict["Video"]! + "?v=2&alt=jsonc"
        controllerArray.append(controller4)
        
        let controller2:ProgramsWebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsWebViewVC") as! ProgramsWebViewController
        controller2.title = "Facebook"
        controller2.appendUrl = "https://www.facebook.com/" + appendDict["Facebook"]!
        controllerArray.append(controller2)
        
        let controller3:ProgramsWebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsWebViewVC") as! ProgramsWebViewController
        controller3.title = "Google Plus"
        controller3.appendUrl = "https://plus.google.com/" + appendDict["Google"]!
        controllerArray.append(controller3)
        
//        let controller4:ProgramCollectioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsCollectionVC") as! ProgramCollectioViewController
//        controller4.title = "Mukil TV"
//        controller4.appendUrl = "feed_Program?cid=1&type=tv"
//        controllerArray.append(controller4)
        
        // Customize menu (Optional)
        var parameters: [String: AnyObject] = ["scrollMenuBackgroundColor": UIColor(red: 62.0/255.0, green: 153.0/255.0, blue: 234.0/255.0, alpha: 1.0),
            "viewBackgroundColor": UIColor.whiteColor(),
            "selectionIndicatorColor": UIColor.whiteColor(),
            "bottomMenuHairlineColor": UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0),
            "menuItemFont": UIFont(name: "HelveticaNeue", size: 13.0)!,
            "menuHeight": 40.0,
            "menuItemWidth": 90.0,
            "centerMenuItems": true]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 64.0, self.view.frame.width, self.view.frame.height-64.0), options: parameters)
        
        self.view.addSubview(pageMenu!.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dimissViewController(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
