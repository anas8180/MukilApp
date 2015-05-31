//
//  ShortFilmViewController.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ShortFilmViewController: UIViewController {

    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addRevealButton()

        self.title = "SHORT FILMS"
        
        var controllerArray : [UIViewController] = []

        let controller1:ShortFilmCollectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SFCollectionVC") as! ShortFilmCollectionViewController
        controller1.title = "Teaser"
        controller1.appendUrl = "feed_Teaser"
        controllerArray.append(controller1)
        
        let controller2:ShortFilmCollectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SFCollectionVC") as! ShortFilmCollectionViewController
        controller2.title = "Movies"
        controller2.appendUrl = "feed_Trailor"
        controllerArray.append(controller2)
        
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
