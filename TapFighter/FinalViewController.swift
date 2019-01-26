//
//  FinalViewController.swift
//  TapFighter
//
//  Created by Thobio Joseph on 05/10/17.
//  Copyright © 2017 Love2Code. All rights reserved.
//

import UIKit
import GoogleMobileAds
import MessageUI

class FinalViewController: UIViewController,GADBannerViewDelegate,MFMessageComposeViewControllerDelegate {

    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var currentScore: UILabel!
    var scoreData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentScore.text = scoreData
        bannerViewFunction()
    }

    func bannerViewFunction(){
        bannerView.isHidden = true
        bannerView.delegate = self
        bannerView.adUnitID = appUnitId
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    @IBAction func challengeYourFriends(_ sender: Any) {
        if MFMessageComposeViewController.canSendText() {
            let message:MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.recipients = nil
            message.body = "My TapFighter final score is \(currentScore.text!)"
            self.present(message, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Warning", message: "This devices Can not send SMS message.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restartGame(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
