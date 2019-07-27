//
//  FlickerSearchView.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 27/07/19.
//  Copyright © 2019 Pankaj Raghav. All rights reserved.
//

import UIKit

class FlickerSearchView: UIViewController,UICollectionViewDataSource ,UISearchBarDelegate{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var flickerSearchViewModel = FlickerSearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        
    }
    
    
    // MARK:- COLLECTION VIEW  DATASOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickerSearchViewModel.flickerPhotoModel?.photo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerCell", for: indexPath as IndexPath) as! FlickerCell
        cell.updateData(photoModel: (flickerSearchViewModel.flickerPhotoModel?.photo![indexPath.row])!)
        
        return cell
        
    }
    
    // MARK:-  KEYBOARD DISMISS
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    // MARK:- SEARCH BAR BUTTON ACTION
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        if !searchBar.text!.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            self.activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            flickerSearchViewModel.getFlicker(searchText: searchBar.text!) { (result : Result<String , NetworkError>) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                switch result {
                case .success(let message):
                    print(message)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                case .failure(let error) :
                    print(error.localizedDescription)
                    
                }
                
            }
            
        }
    }
 
}

