//
//  ViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    
    var videoPlayerLayer: AVPlayerLayer?

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo() {
        
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        //Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 0.3)
    }

}
