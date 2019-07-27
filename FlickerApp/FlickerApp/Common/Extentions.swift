//
//  Extentions.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 28/07/19.
//  Copyright © 2019 Pankaj Raghav. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView{
    
    func loadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
