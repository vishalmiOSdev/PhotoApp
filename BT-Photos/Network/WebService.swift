//
//  WebService.swift
//  BT-Photos
//
//  Created by Vishal M on 27/03/24.
//

import Foundation


class WebService {
    static let shared = WebService()
    
    private init() {}
    
    func fetchPhotos(albumId: Int, completion: @escaping ([Photo]?, Error?) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos"

        guard let url = URL(string: urlString) else {
            print(" Failed to create a valid URL")
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(photos, nil)
               
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

