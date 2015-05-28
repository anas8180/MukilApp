//
//  ProgramViewController.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {

    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialize view controllers to display and place in array
        self.addRevealButton()
        
        self.title = "PROGRAMS"
        
        var controllerArray : [UIViewController] = []
        
       let controller1:ProgramCollectioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsCollectionVC") as! ProgramCollectioViewController
        
        controller1.title = "All Programs"
        controller1.appendUrl = "feed_Programs"
        controllerArray.append(controller1)
        
        let controller2:ProgramCollectioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsCollectionVC") as! ProgramCollectioViewController
        controller2.title = "Mukil FM"
        controller2.appendUrl = "feed_Program?cid=1&type=radio"
        controllerArray.append(controller2)
        
        let controller3:ProgramCollectioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsCollectionVC") as! ProgramCollectioViewController
        controller3.title = "Unmatchi FM"
        controller3.appendUrl = "feed_Program?cid=7&type=radio"
        controllerArray.append(controller3)
        
        let controller4:ProgramCollectioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramsCollectionVC") as! ProgramCollectioViewController
        controller4.title = "Mukil TV"
        controller4.appendUrl = "feed_Program?cid=1&type=tv"
        controllerArray.append(controller4)

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
