//
//  RadioPlayViewController.swift
//  MukilApp
//
//  Created by mohamed on 01/06/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit
import AVFoundation

class RadioPlayViewController: UIViewController {

    var dataDict : [String : String]!
    var audioPlayer = AVPlayer()
    var streamUrl : String!
    var isPlay : Bool!
    var muted : Bool!
    var currentProgram : [String : String]!

    @IBOutlet var voulmeSlider: UISlider!
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var controlButton: UIButton!
    @IBOutlet var radioName: UILabel!
    @IBOutlet var nowView: UIImageView!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.transparentView.backgroundColor = UIColor(patternImage: UIImage(named: "transparent")!)
        streamUrl = self.dataDict["stream_high"]!
        self.configureView(streamUrl)
        
        isPlay = true
        muted = false
//        self.voulmeSlider.transform = CGAffineTransformMakeRotation((45 * CGFloat(M_PI)) / 2.0)
        self.voulmeSlider.hidden = true
        self.getCurrentProgram()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func controlAction(sender: UIButton) {
        
        if isPlay == true {
            audioPlayer.pause()
            isPlay = false
            sender.setImage(UIImage(named: "play_button"), forState:.Normal)
        }
        else{
            audioPlayer.play()
            isPlay = true
            sender.setImage(UIImage(named: "stop_button"), forState:.Normal)
        }
    }
    @IBAction func volumeMuteAction(sender: UIButton) {
        

        if muted == true
        {
            audioPlayer.volume = 1.0
            voulmeSlider.value = 1.0
            muted = false
            sender.setImage(UIImage(named: "volume_mute"), forState:.Normal)
        }
        else
        {
            audioPlayer.volume = 0.0
            voulmeSlider.value = 0.0
            muted = true
            sender.setImage(UIImage(named: "volume_unmute"), forState:.Normal)
        }
        
    }
    @IBAction func changeVolume(sender: UIButton) {
        
        if voulmeSlider.hidden {
            
            voulmeSlider.hidden = false
        }
        else {
            voulmeSlider.hidden = true
        }
    }
    @IBAction func changeQuality(sender: UISegmentedControl) {
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0 :
                streamUrl = self.dataDict["stream_low"]!
        case 0 :
                streamUrl = self.dataDict["stream_high"]!
        case 0 :
                streamUrl = self.dataDict["stream_high"]!
        default:
            break

        }
        
        self.configureView(streamUrl)

    }
    
    @IBAction func sliderValueChange(sender: UISlider) {
        
        audioPlayer.volume = sender.value
    }
    
    // MARK: - Get Current Program Details
    
    func getCurrentProgram()
    {
        let appendStrin:String = "feed_Channel_program?rId=" + self.dataDict["id"]!
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            kBaseURL + appendStrin,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
//                self.dataArray = responseObject.valueForKey("Radio") as! NSArray
//                println(self.dataArray)
//                self.tableView.reloadData()
                
                self.currentProgram  = responseObject.valueForKey("Channel") as! [String : String]
                println(self.currentProgram)
                self.setCurrentProgram()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            }
        )


    }
    
    // MARK: - downloadImage
    
    func setCurrentProgram()
    {
        
        var currentProgramName:String = self.currentProgram["Current Program"]!
        radioName.text = currentProgramName
        
        let link:String = self.currentProgram["Current Program Image"]!
        let url = NSURL(string: link)
        let request: NSURLRequest = NSURLRequest(URL: url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let getImage: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if error == nil {
                let image = UIImage(data: data)
                
                // Store the image in to our cache
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.logoImage.image = image
                })
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
        })
        
        getImage.resume()
  
    }
    
    // MARK: - Configure Player
    
    func configureView(url:String) {
        
        var playerItem = AVPlayerItem( URL:NSURL( string:url ) )
        audioPlayer = AVPlayer(playerItem:playerItem)
        audioPlayer.rate = 1.0
        audioPlayer.volume = 0.5
        audioPlayer.play()
        
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
