//
//  welcome2VC.swift
//  Compadres
//
//  Created by Brian Bird on 8/16/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class welcome2VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func completeButtonAction(_ sender: Any) {
        segueDB()
    }
}

extension welcome2VC{
    //segue
    func segueDB(){
        self.performSegue(withIdentifier: "segueWelcome2ToDashboard", sender: self)
    }
}
