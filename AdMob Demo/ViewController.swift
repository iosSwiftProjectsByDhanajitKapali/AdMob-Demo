//
//  ViewController.swift
//  AdMob Demo
//
//  Created by unthinkable-mac-0025 on 03/08/21.
//

import GoogleMobileAds
import UIKit

class ViewController: UIViewController {

    //Create the banner ad
    private let banner : GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            //"ca-app-pub-3793956697697775/2493667053"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
    }()
    
    private var interstitialAd : GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        banner.rootViewController = self
        banner.delegate = self
        view.addSubview(banner)
        
        //createAd()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: view.frame.size.height-100, width: view.frame.width, height: 100).integral
    }

    //Button to Present an ad
    @IBAction func showAdButtonPressed(_ sender: UIButton) {
        createAd()
    }
    
    ///Create Interstitial ad from AdMob
    private func createAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910", request: request, completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
            interstitialAd = ad
            interstitialAd?.fullScreenContentDelegate = self
            interstitialAd?.present(fromRootViewController: self)
        })
    } //:createAd()
}

extension ViewController : GADBannerViewDelegate{
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

extension ViewController : GADFullScreenContentDelegate{
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad presented full screen content.
      func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}
