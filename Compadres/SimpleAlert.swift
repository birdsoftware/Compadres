//
//  SimpleAlert.swift
//  Compadres
//
//  Created by Brian Bird on 8/16/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func simpleAlert(title:String, message:String, buttonTitle:String) {
        
        let myAlert = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        myAlert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in })
        present(myAlert, animated: true){}
        
    }
}
