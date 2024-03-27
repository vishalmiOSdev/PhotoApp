//
//  UIViewControllerExtensions.swift
//  BT-Photos
//
//  Created by Vishal M on 28/03/24.
//

import Foundation
import UIKit



extension UIViewController{
    
    func showErrorAlert(message: String){
        showAlert(title: "Error", message: message)
    }
    
    func showAlert(title : String , message : String, completion : @escaping ((UIAlertAction) -> Swift.Void) = {_ in }) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: completion)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}




extension UIViewController: StatusController {

        func showStatus(isLoading: Bool = false, title: String? = nil, description: String? = nil, actionTitle: String? = nil, image: UIImage? = nil, action: (() -> Void)? = nil)  {
            let status = Status(isLoading: isLoading, title: title, description: description, actionTitle: actionTitle, action: action)
            
            show(status: status)
        }
}
    


