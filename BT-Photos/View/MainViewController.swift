//
//  ViewController.swift
//  BT-Photos
//
//  Created by Vishal M on 27/03/24.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var albumIdTextField: UITextField!
    @IBOutlet weak var fetchButton: UIButton!
    
    
   
    
    let viewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchButton()
        fetchAndUpdateUI()
        
        configureUI()
    }
    
    func configureUI(){
        
        self.title = "Photos"
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        fetchButton.layer.borderColor = UIColor.lightGray.cgColor
        fetchButton.layer.borderWidth = 0.5
        fetchButton.layer.cornerRadius = 4
        fetchButton.backgroundColor = UIColor.cyan
        
        
        albumIdTextField.placeholder = "Enter ID"
       
    }
    
    func setupFetchButton() {
        fetchButton.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
    }
    
    @objc func fetchButtonTapped() {
        
        if let albumIdString = albumIdTextField.text, let albumId = Int(albumIdString), albumId >= 1 && albumId <= 100 {
            viewModel.currentAlbumId = albumId
            fetchAndUpdateUI()
        } else {
            self.showErrorAlert(message: "Please enter a valid album ID between 1 and 100.")
        }
        
    }
    
    func fetchAndUpdateUI() {
        
        
        
        self.showStatus(isLoading: true)
        
        viewModel.fetchPhotos { _, error in
            DispatchQueue.main.async {
                // Hide activity indicator
                self.hideStatus()
                
                if let error = error {
                    self.showStatus(title: "Error", description: error.localizedDescription, actionTitle: "Retry") {
                        self.fetchAndUpdateUI()
                    }
                } else {
                    // Reset status view upon successful fetch
                    self.collectionView.reloadData()
                    if self.viewModel.photos.isEmpty {
                        self.showAlert(title: "No Images", message: "No images available for the specified album ID. Please try another ID.")
                    }
                }
            }
        }
    }


}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    

        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let item = viewModel.photos[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
            cell?.updateCell(item: item)
            return cell ?? UICollectionViewCell()
        }


       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
        let photo = viewModel.photos[indexPath.item]
         showImageDetails(photo: photo)
           
        }

    
    func showImageDetails(photo: Photo) {
        
        guard let imageDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailsViewController") as? ImageDetailsViewController else {
            return
        }
        imageDetailsVC.photo = photo
        navigationController?.pushViewController(imageDetailsVC, animated: true)
    }
}



