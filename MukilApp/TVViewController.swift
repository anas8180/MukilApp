//
//  TVViewController.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit
import MediaPlayer

class TVViewController: UITableViewController {

    var dataArray : NSArray = NSArray ()
    var moviePlayer:MPMoviePlayerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.addRevealButton()
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            kBaseURL+"feed_Televisions",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
               // println("JSON: " + responseObject.description)
                
                self.dataArray = responseObject.valueForKey("Tv") as! NSArray
                println(self.dataArray)
                self.tableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.dataArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomTableViewCell

        // Configure the cell...
        
        self.configureCell(cell, indexPath: indexPath)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let url:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("ios") as! String
        
        self.PlayVide(url)
    }
    
    // MARK: - Configure Cell
    
    func configureCell(cell:CustomTableViewCell,indexPath:NSIndexPath)
    {
        var titleString:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("name") as! String
        
        var linkString:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("logo") as! String
        
        cell.title.text = titleString
        
        //Creating a instance of UITableview ans also as property
        var url = NSURL(string: linkString)
        let request: NSURLRequest = NSURLRequest(URL: url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let getImage: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if error == nil {
                let image = UIImage(data: data)
                
                // Store the image in to our cache
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if let cellToUpdate = self.tableView.cellForRowAtIndexPath(indexPath)
                    {
                        (self.tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell).thumImage.image = image
                    }
                    
                })
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
        })
        
        getImage.resume()
        
    }
    
    // MARK: - Play Video
    
    func PlayVide(urlString : String) {
        
        var url = NSURL(string : urlString)!
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer.view.frame = self.view.bounds
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerDidFinishPlaying:" , name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)

        self.view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
        
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded

    }

    func moviePlayerDidFinishPlaying(notification: NSNotification) {
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
