//
//  FlickerPhotoModel.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 27/07/19.
//  Copyright © 2019 Pankaj Raghav. All rights reserved.
//

import Foundation


public struct ResponseModel : Decodable{
    public let photos   :PhotosModel?
    public let stat     : String?
    
}

public struct PhotosModel : Decodable{
    public let page     : Int?
    public let pages    : Int?
    public let perpage  : Int?
    public let total    : String
    public let photo    : [FlickrPhotoModel]?
}


public struct FlickrPhotoModel : Decodable{
  
    public let id       : String?
    public let owner    : String?
    public let secret   : String?
    public let server   : String?
    public let farm     : Int?
    public let title    : String?
    public let ispublic : Int?
    public let isfriend : Int?
    public let isfamily : Int?
   
}

