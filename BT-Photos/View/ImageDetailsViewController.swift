//
//  ImageDetailViewController.swift
//  BT-Photos
//
//  Created by Vishal M on 27/03/24.
//

import UIKit
import SDWebImage

class ImageDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleDetailLabel: UILabel!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        
        self.title = "Photo"
        
        guard let photo = photo else { return }
        
        var imageUrl = URL(string: "")
        if let url = photo.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if url.hasSuffix("_.png") {
                    imageUrl = URL(string: url.remoteImagePathBasedOnScale())
                } else {
                    imageUrl = URL(string: url)
                }
            }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: imageUrl,
                                  placeholderImage: UIImage(named: "placeholder"))
        
        
        titleDetailLabel.text = photo.title
    }
    
    
}
