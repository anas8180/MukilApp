//
//  ContactViewController.swift
//  MukilApp
//
//  Created by mohamed on 01/06/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addRevealButton()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView MEthods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0
        {
            return 170
        }
        else
        {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifer:String!
        
        if indexPath.row == 0
        {
            cellIdentifer = "logoCell"
        }
        else if indexPath.row == 1
        {
            cellIdentifer = "nameCell"
        }
        else if indexPath.row == 2
        {
            cellIdentifer = "emailCell"
        }
        else if indexPath.row == 3
        {
            cellIdentifer = "mobileCell"
        }
        else if indexPath.row == 4
        {
            cellIdentifer = "subjectCell"
        }
        else
        {
            cellIdentifer = "messageCell"
        }


        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as! UITableViewCell
        
        return cell
        
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
