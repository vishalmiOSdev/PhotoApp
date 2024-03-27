//
//  StringExtension.swift
//  BT-Photos
//
//  Created by Vishal M on 28/03/24.
//

import Foundation
import UIKit

extension String {
    
    func remoteImagePathBasedOnScale() -> String {
        
        if UIScreen.main.scale == 1.0 {
           return replacingOccurrences(of: ".png", with: "@1x.png")
        }
        else if UIScreen.main.scale == 2.0 {
            return replacingOccurrences(of: ".png", with: "@2x.png")
        }
        
        return replacingOccurrences(of: ".png", with: "@3x.png")
        
    }
    
}

