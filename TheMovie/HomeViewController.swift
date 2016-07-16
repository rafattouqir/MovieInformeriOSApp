//
//  HomeViewController.swift
//  TheMovie
//
//  Created by Rafat Touqir Rafsun on 7/16/16.
//  Copyright © 2016 Rafat Touqir Rafsun. All rights reserved.
//

import UIKit
import XLPagerTabStrip


enum TAB:String {
    case ComingSoon = "Coming Soon",NewRelease = "New Release",TopRated = "Top Rated"
}

class HomeViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var shadowView: UIView!
    
    
    var isFromPush = false
    let blueInstagramColor = UIColor.whiteColor()
    
    override func viewDidLoad() {
        
        tabStripConfig()
        
        super.viewDidLoad()
        
        
        // TODO :- This was translucent but,after navigation to next controller it caused issues
//        self.navBar?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//        self.navBar?.shadowImage = UIImage()
        
        
        
        
        
        
    }
    
    func tabStripConfig() {
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = Colors.colorSliderBackground
        settings.style.buttonBarItemBackgroundColor = Colors.colorSliderBackground
        settings.style.selectedBarBackgroundColor = blueInstagramColor
        settings.style.buttonBarItemFont = .boldSystemFontOfSize(16)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .whiteColor()
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(white: 0.8, alpha: 1)
            newCell?.label.textColor = self?.blueInstagramColor
        }
        
        
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = self.storyboard?.instantiateViewControllerWithIdentifier("MovieCollectionViewController") as! MovieCollectionViewController
        child_1.itemInfo = IndicatorInfo(title: TAB.ComingSoon.rawValue)
        let child_2 = self.storyboard?.instantiateViewControllerWithIdentifier("MovieCollectionViewController") as! MovieCollectionViewController
        child_2.itemInfo = IndicatorInfo(title: TAB.NewRelease.rawValue)
        let child_3 = self.storyboard?.instantiateViewControllerWithIdentifier("MovieCollectionViewController") as! MovieCollectionViewController
        child_3.itemInfo = IndicatorInfo(title: TAB.TopRated.rawValue)
        return [child_1, child_2,child_3]
    }
    
    
    
}
