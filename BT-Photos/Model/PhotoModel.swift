//
//  PhotoModel.swift
//  BT-Photos
//
//  Created by Vishal M on 27/03/24.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
