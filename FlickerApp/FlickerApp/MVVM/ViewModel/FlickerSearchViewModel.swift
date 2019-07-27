//
//  FlickerSearchViewModel.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 28/07/19.
//  Copyright © 2019 Pankaj Raghav. All rights reserved.
//

import Foundation

class FlickerSearchViewModel: NSObject {
    var flickerPhotoModel : PhotosModel?
    
    
 // MARK:- GET FLICKER FROM API
    
    func getFlicker(searchText: String, completion: @escaping (Swift.Result< String , NetworkError>) -> Void){
        let urlString = baseUrl + searchText
  
        ServiceManager().performRequest(request: APIRequest(url: urlString)) { (result : Result< ResponseModel , NetworkError>) in
            
            switch result {
            case .success(let flickerModel):
                self.flickerPhotoModel = flickerModel.photos
                completion(.success("Sucess"))
            case .failure(let error) :
                print(error.localizedDescription)
                
                
            }
            
        }

    }
    
    
}
