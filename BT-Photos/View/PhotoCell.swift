//
//  PhotoCellCollectionViewCell.swift
//  BT-Photos
//
//  Created by Vishal M on 27/03/24.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
@IBOutlet weak var imageView: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 4
    }
    
    func updateCell(item: Photo?) {
        
    
    var imageUrl = URL(string: "")
    if let url = item?.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if url.hasSuffix("_.png") {
                imageUrl = URL(string: url.remoteImagePathBasedOnScale())
            } else {
                imageUrl = URL(string: url)
            }
        }
    
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: imageUrl,
                              placeholderImage: UIImage(named: "placeholder"))

    }
    
}

