//
//  PhoneCall.swift
//  Compadres
//
//  Created by Brian Bird on 8/18/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func callThisNumber(digits: String) {
        open(scheme: "tel://\(digits)")
    }
    
    //Supports CALL
    func open(scheme: String) {
        //http://useyourloaf.com/blog/openurl-deprecated-in-ios10/
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
}//callThisNumber(member: 7024371111)
