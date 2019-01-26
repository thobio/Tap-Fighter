//
//  ViewController.swift
//  TapFighter
//
//  Created by Thobio Joseph on 04/10/17.
//  Copyright © 2017 Love2Code. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,GADBannerViewDelegate {
    
    @IBOutlet var bannerViewAd: GADBannerView!
    @IBOutlet var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userdefaul = UserDefaults.standard
        let highScore = userdefaul.string(forKey: "key")
        if highScore == nil {
            highScoreLabel.text = "0"
        }else{
            highScoreLabel.text = highScore
        }
        bannerView()
    }
    // BannerView
    func bannerView(){
        bannerViewAd.isHidden = true
        bannerViewAd.delegate = self
        bannerViewAd.adUnitID = appUnitId
        bannerViewAd.adSize = kGADAdSizeSmartBannerPortrait
        bannerViewAd.rootViewController = self
        bannerViewAd.load(GADRequest())
    }
    //adBannerView delegete
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerViewAd.isHidden = false
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerViewAd.isHidden = true
    }
    
    // StartGame Function
    @IBAction func startGameActionFunction(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

