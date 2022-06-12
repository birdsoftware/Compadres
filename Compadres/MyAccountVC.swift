//
//  MyAccountVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/18/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class MyAccountVC: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var paymentDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func callAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension MyAccountVC{
    //labels to update
    
}
