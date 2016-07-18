//
//  DetailViewController.swift
//  TheMovie
//
//  Created by Rafat Touqir Rafsun on 7/16/16.
//  Copyright © 2016 Rafat Touqir Rafsun. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageViewTopBanner: UIImageView!
    
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    @IBOutlet weak var labelMovieType: UILabel!
    
    
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelAwards: UILabel!
    
    
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    
    @IBOutlet weak var labelProductionCompanyName: UILabel!
    @IBOutlet weak var labelProductionBudget: UILabel!
    
    @IBOutlet weak var labelProductionCountryName: UILabel!
    @IBOutlet weak var labelProductionCountryLanguage: UILabel!
    
    
    
    
    
    
    
    @IBOutlet weak var collectionViewSimilarMovie: UICollectionView!
    let cellIDSimilarMovie = "cellSimilarMovie"
    var movieID:Int?
    var individualMovieDetail:IndividualMovieDetail?
    
    var similarMovies:[Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        

        
        
        
        collectionViewSimilarMovie.dataSource = self
        collectionViewSimilarMovie.delegate = self
        
        
        fetchResultInBackground()
        
        
        
    }

    
    func updateViews() {
        
        
        
        if let photoPath = individualMovieDetail?.posterPath{
            
            let photoURL = Urls.URL_IMAGE_BASE + photoPath
            
            imageViewTopBanner.kf_showIndicatorWhenLoading = true
            imageViewTopBanner.kf_indicator?.activityIndicatorViewStyle = .White
            imageViewTopBanner.kf_setImageWithURL(NSURL(string: photoURL)!,
                                                          placeholderImage: nil,
                                                          optionsInfo: [.Transition(ImageTransition.Fade(1))])
        }
        
        
        
        let movieTitle = individualMovieDetail?.originalTitle ?? "Movie"
        labelMovieName.text = movieTitle
        self.title = movieTitle
        if let time = individualMovieDetail?.releaseDate{
            
            
            let split = time.characters.split{$0 == "-"}.map(String.init)
            //split only date,later time remaining can be shown from current date difference
            if let dateString = split.first{
                labelMovieYear.text = dateString
            }
        }

        
        var genreOut:String = ""
        
        
        individualMovieDetail?.genres?.forEach({ (genre:Genre) in
            genreOut = genreOut.stringByAppendingString( genre.name ?? "").stringByAppendingString(", ")
            
        })
        
        labelMovieType.text = genreOut
        
        
        labelRating.text = String(format: "%0.2f",individualMovieDetail?.popularity ?? 0)
        labelAwards.text = individualMovieDetail?.voteAverage?.toString ?? ""
        
        labelMovieDescription.text = individualMovieDetail?.overview ?? ""
        
        labelProductionCompanyName.text = individualMovieDetail?.productionCompanies?.first?.name ?? ""
        labelProductionBudget.text = individualMovieDetail?.budget?.toString ?? ""
        labelProductionCountryName.text = individualMovieDetail?.productionCountries?.first?.name ?? ""
        labelProductionCountryLanguage.text = individualMovieDetail?.spokenLanguages?.first?.name ?? ""
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchResultInBackground() {
        //add and animate
        
        let url = Urls.URL_INDIVIDUAL_MOVIES(movieID!.toString)
        
        ConnectionHelper.instance.load(url,params: ["api_token":Urls.API_KEY], responseBlock: { (json:JSON?,errorStr:String?) in
            
            
            if let json = json{
                
                self.individualMovieDetail = IndividualMovieDetail(fromJson: json)
                
                
                //fetch similar movie
                let url = Urls.URL_SIMILAR_MOVIES(self.movieID!.toString)
                ConnectionHelper.instance.load(url, params: ["api_token":Urls.API_KEY],responseBlock: { (json:JSON?,errorStr:String?) in
                    
                    
                    if let resultsJSON = json?["results"].array where resultsJSON.count>0{
                        
                        self.similarMovies = []
                        for result in resultsJSON{
                            self.similarMovies?.append(Movie(fromJson: result))
                        }
                        
                        self.collectionViewSimilarMovie.reloadData()
                        
                    }else{
                        
                        Helper.showToast(message: Strings.NO_SIMILAR_MOVIE_FOUND)
                    }
                
                })
                
                
                
                self.updateViews()
                
            }else{
                Helper.showToast(message: errorStr)
            }
            
            
            
        })
        
        
        
        
        
    }
    
    func addDismissButtonToNav() {
        
        let navButton = UIBarButtonItem(image: UIImage(named: "back"), style: .Plain, target: self, action: #selector(closeAction(_:)))
        navButton.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        self.navigationItem.leftBarButtonItem = navButton
    }

    // MARK: - Actions
    
    func closeAction(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}



extension DetailViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIDSimilarMovie, forIndexPath: indexPath) as! DetailSimilarMovieCollectionViewCell
        
        if let photoPath = similarMovies?[indexPath.row].posterPath{
            
            let photoURL = Urls.URL_IMAGE_BASE + photoPath
            
            cell.imageViewSimilarMovie.kf_showIndicatorWhenLoading = true
            
            cell.imageViewSimilarMovie.kf_indicator?.activityIndicatorViewStyle = .White
            cell.imageViewSimilarMovie.kf_setImageWithURL(NSURL(string: photoURL)!,
                                                   placeholderImage: nil,
                                                   optionsInfo: [.Transition(ImageTransition.Fade(1))])
        }
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing)
        let size:CGFloat = CGFloat(collectionView.bounds.height - totalSpace)
        return CGSize(width: size*0.8, height: CGFloat(size))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //        let row = indexPath.row
        
        if let movieID = similarMovies?[indexPath.row].id{
            let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
            detailViewController.movieID = movieID
            self.pushVC(detailViewController)
        }
        
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = collectionViewSimilarMovie.contentOffset
        let bounds = collectionViewSimilarMovie.bounds
        let size = collectionViewSimilarMovie.contentSize
        let inset = collectionViewSimilarMovie.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reload_distance:CGFloat = 20
        
        if(y > h + reload_distance) {
//            print("more rows \(x+=1)")
        }
    }
    
}
