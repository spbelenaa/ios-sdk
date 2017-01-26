//
//  ViewController.swift
//  ADFrameworkApp
//
//  Created by Alexey Fedotov on 09/01/2017.
//  Copyright © 2017 HyperADX. All rights reserved.
//

import UIKit
import HADFramework

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionRows[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = sectionRows[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        adSelected(sectionRows[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionNames = ["Native", "Banners", "Interstitial"]
    var sectionRows = [["Native Ad", "TableView with Native Ads", "CollectionView with Native Ads", "Native Ads Templates"],["Banner Ad Height 50", "Banner Ad Height 90", "Banner Ad 300x250", "TableView with Banner Ads", "CollectionView with Banner Ads"],["Interstitial"]]
    //"Video Interstitial"
    
    var interstitialAd:HADInterstitialAd?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //set custom params
        HAD.setCustomParams(params: ["fooKey":"fooValue","barKey":"barValue"])
        HAD.setAge(value: 33)
        HAD.setKeywords(value: "one,two,free")
        HAD.setCustomParam(key: "hy", value: "per")
    }
    
    func adSelected(_ adName:String){
        
        switch adName {
        case "Native Ad":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "TableView with Native Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "CollectionView with Native Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "Native Ads Templates":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "Banner Ad Height 50":
            showBanner(size: .height50Banner)
            break
        case "Banner Ad Height 90":
            showBanner(size: .height90Banner)
            break
        case "Banner Ad 300x250":
            showBanner(size: .height250Rectangle)
            break
        case "TableView with Banner Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "CollectionView with Banner Ads":
            performSegue(withIdentifier: adName, sender: nil)
            break
        case "Interstitial":
            showInterstitial()
            break
        default:
            print("Error: Ad not found")
        }
    }
    
    func showInterstitial() {
        interstitialAd = HADInterstitialAd(placementID: "5b3QbMRQ")
        interstitialAd?.delegate = self
        interstitialAd?.loadAd()
    }
    
    func showBanner(size:HADAdSize) {
        let bannerView = HADAdView(placementID: "5b3QbMRQ", adSize:size, viewController: self)
        bannerView.delegate = self
        bannerView.loadAd()
        
        //create controller
        let adController = UIViewController()
        adController.view.backgroundColor = UIColor.lightGray
        adController.view.addSubview(bannerView)
        
        //set ad size
        bannerView.frame = CGRect(x:0, y:100, width:self.view.frame.width, height:HADAdSize.getSize(size).height)
        
        //show controller with ad
        self.navigationController?.pushViewController(adController, animated: true)
    }
}


// MARK: - HADAdViewDelegate
extension MainViewController: HADAdViewDelegate {
    func hadViewDidLoad(adView: HADAdView) {
        print("hadViewDidLoad")
    }
    
    func hadViewDidClick(adView: HADAdView) {
        print("hadViewDidClick")
    }
    
    func hadViewDidFail(adView: HADAdView, withError error: NSError?) {
        print("hadViewDidFail: \(error?.localizedDescription)")
    }
}

// MARK: - HADInterstitialAdDelegate
extension MainViewController: HADInterstitialAdDelegate {
    func hadInterstitialAdDidLoad(interstitialAd: HADInterstitialAd) {
        interstitialAd.showAdFromRootViewController(self)
    }
    
    func hadInterstitialAdDidClick(interstitialAd: HADInterstitialAd) {
        print("hadInterstitialDidClick")
    }
    
    func hadInterstitialAdDidClose(interstitialAd: HADInterstitialAd) {
        print("hadInterstitialAdDidClose")
    }
    
    func hadInterstitialAdWillClose(interstitialAd: HADInterstitialAd) {
        print("hadInterstitialWillClose")
    }
    
    func hadInterstitialAdDidFail(interstitialAd: HADInterstitialAd, withError error: NSError?) {
        print("hadInterstitialDidFail: \(error)")
    }
}


