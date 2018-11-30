//
//  Utilities.swift
//  TwitSplit
//
//  Created by Fahad Iqbal on 11/29/18.
//  Copyright © 2018 innoverzgen. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAddTweetPopup(handler: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "New Tweet (\(kMaxlength))", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter your message"
        })
        
        let tweetAction = UIAlertAction(title: "Tweet", style: .default, handler: { alert -> Void in
            guard let text = alertController.textFields?.first?.text else { return }
            handler(text)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(tweetAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
        
        return alertController
    }
    
    
}
