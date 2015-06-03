//
//  FrontViewController.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    var dataArray:NSArray = NSArray ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addRevealButton()
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            kBaseURL+"feed_homepage",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                  println("JSON: " + responseObject.description)
                
                self.dataArray = responseObject.valueForKey("Home_Page") as! NSArray
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
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.dataArray.count
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
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
            return CGSizeMake(147, 147)
        }
        else if widhScreen == 375
        {
            return CGSizeMake(173, 173)
        }
        else
        {
            return CGSizeMake(188, 188)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        
        self.configureCell(cell, indexPath: indexPath)
        
        
        return cell
    }

    func configureCell(cell:CustomCollectionViewCell,indexPath:NSIndexPath)
    {
        
        var titleString:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("widgets") as! String
        
//        var imageUrl:String!
//        
//        if let val:String = self.dataArray.objectAtIndex(indexPath.row).objectForKey("Url") as? String {
//            imageUrl = self.dataArray.objectAtIndex(indexPath.row).objectForKey("Url") as! String
//        }
//        else{
//            imageUrl = self.dataArray.objectAtIndex(indexPath.row).objectForKey("teaser") as! String
//        }
//        
//        var linkString:String = "https://i.ytimg.com/vi/" + imageUrl + "/hqdefault.jpg"
        
        cell.title.text = titleString
        
//        //Creating a instance of UITableview ans also as property
//        var url = NSURL(string: linkString)
//        let request: NSURLRequest = NSURLRequest(URL: url!)
//        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession(configuration: config)
//        let getImage: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
//            if error == nil {
//                let image = UIImage(data: data)
//                
//                // Store the image in to our cache
//                dispatch_async(dispatch_get_main_queue(), {
//                    
//                    if let cellToUpdate = self.collectionView!.cellForItemAtIndexPath(indexPath)
//                    {
//                        (self.collectionView!.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell).thumImage.image = image
//                    }
//                    
//                })
//            }
//            else {
//                println("Error: \(error.localizedDescription)")
//            }
//        })
//        
//        getImage.resume()
        
        var colorValue:String = self.dataArray .objectAtIndex(indexPath.row).objectForKey("Color") as! String
        
        cell.backgroundColor = self.colorWithHexString(colorValue)
        
    }
    
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (count(cString) != 6) {
            return UIColor.grayColor()
        }
        
        var rString = (cString as NSString).substringToIndex(2)
        var gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        var bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
