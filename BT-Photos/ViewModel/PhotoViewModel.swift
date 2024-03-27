//
//  PhotoViewModel.swift
//  BT-Photos
//
//  Created by Vishal M on 27/03/24.
//

import Foundation

class PhotosViewModel {
    var photos: [Photo] = []
    var currentAlbumId = 1
    
    func fetchPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        print("--- PhotosViewModel: fetchPhotos called ---")
        WebService.shared.fetchPhotos(albumId: currentAlbumId) { fetchedPhotos, error in
            if let error = error {
                completion(nil, error)
            } else if let fetchedPhotos = fetchedPhotos {
                self.photos = fetchedPhotos
                completion(fetchedPhotos, nil)
            }
        }
    }
    
}

