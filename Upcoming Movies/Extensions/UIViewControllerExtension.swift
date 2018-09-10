//
//  UIViewControllerExtension.swift
//  Upcoming Movies
//
//  Created by Matheus Oliveira Rabelo on 9/10/18.
//  Copyright © 2018 Matheus Rabelo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentError(withTitle title: String, andMessage message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil))
        
        DispatchQueue.main.async {
            let feedback = UINotificationFeedbackGenerator()
            feedback.prepare()
            feedback.notificationOccurred(.error)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
