//
//  MovieCollectionViewController.swift
//  TheMovie
//
//  Created by Rafat Touqir Rafsun on 7/16/16.
//  Copyright © 2016 Rafat Touqir Rafsun. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Kingfisher

class MovieCollectionViewController: UIViewController {
    
    var itemInfo : IndicatorInfo?
    var page = 1
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellID = "movieCell"
    let numberOfItemsPerRow = 2
    var activityIndicator:UIActivityIndicatorView?
    var movies:[Movie]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        fetchResultInBackground()
        
    }
    
    func fetchResultInBackground() {
        //add and animate
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        activityIndicator?.hidesWhenStopped = true
        let barButton = UIBarButtonItem(customView: activityIndicator!)
        self.navigationItem.setRightBarButtonItem(barButton, animated: true)
        activityIndicator?.startAnimating()
        
        
        var url:String = ""
        
        switch itemInfo!.title {
        case TAB.ComingSoon.rawValue:
            url = Urls.URL_UPCOMING
        case TAB.NewRelease.rawValue:
            url = Urls.URL_NOW_PLAYING
        case TAB.TopRated.rawValue:
            url = Urls.URL_TOP_RATED
        default:
            break
        }
        
        ConnectionHelper.instance.load(url,params: ["page":"\(page)"], responseBlock: { (json:JSON?,errorStr:String?) in
            
            
            self.activityIndicator?.stopAnimating()
            self.navigationItem.rightBarButtonItem = nil
            
            
            
            
            if let json = json{
                
                if let resultsJSON = json["results"].array where resultsJSON.count>0{
                    
                    if self.movies == nil{
                        self.movies = []
                    }
                    
                    for result in resultsJSON{
                        self.movies?.append(Movie(fromJson: result))
                    }
                    
                    self.collectionView.reloadData()
                    
                }else{
                    
                    Helper.showToast(message: Strings.NO_MOVIE_FOUND)
                }
                
            }else{
                Helper.showToast(message: errorStr)
            }
            
            
            
        })

        
        
        
        
    }
    
    
    
}





extension MovieCollectionViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! MovieCollectionViewCell
        
        
        if let photoPath = movies?[indexPath.row].posterPath{
            
            let photoURL = Urls.URL_IMAGE_BASE + photoPath
            
            cell.imageViewMovie.kf_showIndicatorWhenLoading = true
            cell.imageViewMovie.kf_setImageWithURL(NSURL(string: photoURL)!,
                                                         placeholderImage: nil,
                                                         optionsInfo: [.Transition(ImageTransition.Fade(1))])
        }
        
        
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size:CGFloat = CGFloat((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: CGFloat(size)*1.5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        let row = indexPath.row
        
        if let movieID = movies?[indexPath.row].id{
            let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
            detailViewController.movieID = movieID
            self.pushVC(detailViewController)
        }
        
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = collectionView.contentOffset
        let bounds = collectionView.bounds
        let size = collectionView.contentSize
        let inset = collectionView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reload_distance:CGFloat = 20
        
        if(y > h + reload_distance) {
            if let activity = self.activityIndicator where !activity.isAnimating(){
                page += 1
                fetchResultInBackground()
            }
        }
    }
    
}


extension MovieCollectionViewController:IndicatorInfoProvider{
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo ?? IndicatorInfo(title: "View")
    }
}