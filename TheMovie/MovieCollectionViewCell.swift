//
//  MovieCollectionViewCell.swift
//  TheMovie
//
//  Created by Rafat Touqir Rafsun on 7/16/16.
//  Copyright © 2016 Rafat Touqir Rafsun. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageViewMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
//        self.imageViewMovie.layer.cornerRadius = 10
//        self.imageViewMovie.layer.masksToBounds = true
//        self.imageViewMovie.clipsToBounds = true
//        self.clipsToBounds = true
        
//        self.layer.shadowColor = UIColor.whiteColor().CGColor;
//        self.layer.shadowOffset = CGSizeMake(0, 7.0);
//        self.layer.shadowRadius = 2.0;
//        self.layer.shadowOpacity = 1.0;
//        self.layer.masksToBounds = true;
//        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).CGPath;

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

//        self.contentView.layer.cornerRadius = 2.0;
//        self.contentView.layer.borderWidth = 1.0;
//        self.contentView.layer.borderColor = UIColor.clearColor().CGColor;
//        self.contentView.layer.masksToBounds = true;
        
    }
    
    
}
