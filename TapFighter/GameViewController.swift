//
//  GameViewController.swift
//  TapFighter
//
//  Created by Thobio Joseph on 05/10/17.
//  Copyright © 2017 Love2Code. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController,GADBannerViewDelegate {
    @IBOutlet var timeLeftGameLabel: UILabel!
    @IBOutlet var smallImageIcon: UIImageView!
    @IBOutlet var leftsmallIconConstraint: NSLayoutConstraint!
    @IBOutlet var tapMeLabel: UILabel!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var tapGestureOutlet: UITapGestureRecognizer!
    
    var tapInt = 0
    
    var startInt = 3
    var startTimer = Timer()
    
    var gameint = 10
    var gameTimer = Timer()
    
    var recodeData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recodeData = UserDefaults.standard.string(forKey: "key")
        initFunctionGameStarted()
        bannerViewFunction()
        startTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(startTimerFunc), userInfo: nil, repeats: true)
    }
    
    func initFunctionGameStarted(){
        timeLeftGameLabel.alpha = 0
        leftsmallIconConstraint.constant = 0
        tapMeLabel.text = String(startInt)
        tapGestureOutlet.isEnabled = false
        
    }
    
    @IBAction func tapGestureFunction(_ sender: UITapGestureRecognizer) {
        tapInt += 1
        tapMeLabel.text = String(tapInt)
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
    
    @objc func startTimerFunc(){
        startInt -= 1
        tapMeLabel.text = String(startInt)
        if startInt == 0 {
            tapMeLabel.text = "Tap Me"
            startTimer.invalidate()
            tapGestureOutlet.isEnabled = true
            UIView.animate(withDuration: 16, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                self.timeLeftGameLabel.alpha = 1
                self.leftsmallIconConstraint.constant = 125
            }, completion: nil)
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func handleTimer() {
        gameint -= 1
        timeLeftGameLabel.text = "Time Left:\(gameint)"
        if gameint == 0 {
            gameTimer.invalidate()
            tapGestureOutlet.isEnabled = false
            if recodeData == nil {
                let HightScore = tapMeLabel.text
                let userDefault = UserDefaults.standard
                userDefault.set(HightScore, forKey: "key")
            }else{
                let score:Int? = Int(tapMeLabel.text!)
                let recode:Int? = Int(recodeData)
                
                if score! > recode! {
                    let HightScore = tapMeLabel.text
                    let userDefault = UserDefaults.standard
                    userDefault.set(HightScore, forKey: "key")
                }
            }
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(endGame), userInfo: nil, repeats: false)
        }
    }
    
  @objc func endGame () {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! FinalViewController
    
    if tapMeLabel.text == "Tap Me"{
        vc.scoreData = "0"
    }else{
        vc.scoreData = tapMeLabel.text
    }
    
        self.present(vc, animated: false, completion: nil)
    }
}
