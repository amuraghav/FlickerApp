//
//  FlickerCell.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 27/07/19.
//  Copyright © 2019 Pankaj Raghav. All rights reserved.
//

import UIKit

class FlickerCell: UICollectionViewCell {
    
    @IBOutlet weak var flickerImageView: UIImageView!
    
    // MARK:- UPDATE CELL DATA
    
    func updateData(photoModel : FlickrPhotoModel) {
        //        http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
        //        http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg
        
        let picUrl = String(format: "http://farm%d.static.flickr.com/%@/%@_%@.jpg", photoModel.farm!,photoModel.server!,photoModel.id!,photoModel.secret!)
        
        // LOAD IMAGE
        
        flickerImageView.loadImage(from: URL(string: picUrl)!) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.flickerImageView.image = UIImage(data: data)
            }
        }
        
    }
}
