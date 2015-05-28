//
//  AudioViewController.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

let reuseIdentifier = "CustomCell"

class AudioViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var dataArray :NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        self.addRevealButton()
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            kBaseURL+"feed_Audios",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
         //         println("JSON: " + responseObject.description)
                
                self.dataArray = responseObject.valueForKey("Audios") as! NSArray
                println(self.dataArray)
                self.collectionView!.reloadData()
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let indexPath = self.collectionView!.indexPathForCell(sender as! CustomCollectionViewCell)
        
        
        let destinationVC = segue.destinationViewController as! ProgramsWebViewController
        
        
        let audio:String = self.dataArray.objectAtIndex(indexPath!.row).objectForKey("audio") as! String
        let title:String = self.dataArray.objectAtIndex(indexPath!.row).objectForKey("title") as! String

        
        destinationVC.appendUrl = "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/" + audio
        destinationVC.title = title

    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.dataArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
    
        // Configure the cell
        self.configureCell(cell, indexPath: indexPath)
    
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var screenSzie:CGSize = UIScreen.mainScreen().bounds.size
        var widhScreen = screenSzie.width
        
        return CGSizeMake(widhScreen, 200)
        
    }
    
    // MARK: - Configure Cell
    
    func configureCell(cell:CustomCollectionViewCell,indexPath:NSIndexPath)
    {
        var titleString:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("title") as! String
        
        var linkString:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("Image") as! String
        
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
                    
                    if let cellToUpdate = self.collectionView!.cellForItemAtIndexPath(indexPath)
                    {
                        (self.collectionView!.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell).thumImage.image = image
                    }
                    
                })
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
        })
        
        getImage.resume()

    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
