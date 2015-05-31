//
//  ShortFilmCollectionViewController.swift
//  MukilApp
//
//  Created by mohamed on 31/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class ShortFilmCollectionViewController: UICollectionViewController {

    var appendUrl:String!
    var dataArray:NSArray = NSArray ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            kBaseURL+self.appendUrl,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
                self.dataArray = responseObject.valueForKey("Shortfilm") as! NSArray
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.dataArray.count
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0.0
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var screenSzie:CGSize = UIScreen.mainScreen().bounds.size
        var widhScreen = screenSzie.width
        
        if widhScreen == 320
        {
           return CGSizeMake(158, 158)
        }
        else if widhScreen == 375
        {
            return CGSizeMake(184, 184)
        }
        else
        {
            return CGSizeMake(204, 204)
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        
        self.configureCell(cell, indexPath: indexPath)
        
        
        return cell
    }
    
    func configureCell(cell:CustomCollectionViewCell,indexPath:NSIndexPath)
    {
        
        var titleString:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("title") as! String
        
        var imageUrl:String!
        
        if let val:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("Url") as? String {
            imageUrl = self.dataArray.objectAtIndex(indexPath.row).objectForKey("Url") as! String
        }
        else{
            imageUrl = self.dataArray.objectAtIndex(indexPath.row).objectForKey("teaser") as! String
        }
        
        var linkString:String = "https://i.ytimg.com/vi/" + imageUrl + "/hqdefault.jpg"
        
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
