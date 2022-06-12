//
//  DashboardVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/16/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var firstButton: RoundedButton!
    @IBOutlet weak var secondButton: RoundedButton!
    
    @IBOutlet weak var messagesCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let messageCount = 3
        createBadgeFrom(UIlabel:messagesCountLabel, text: " \(messageCount) ")
    }
    @IBAction func callAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
    
    @IBAction func button1Action(_ sender: Any) {
        firstButton.isHidden = true
    }
    @IBAction func button2Action(_ sender: Any) {
        secondButton.isHidden = true
    }
}

extension DashboardVC{
    func createBadgeFrom(UIlabel:UILabel, text: String) {
        //if text == " 0 "{
        //    UIlabel.isHidden = true
        //} else {
            UIlabel.isHidden = false
            UIlabel.clipsToBounds = true
            UIlabel.layer.cornerRadius = UIlabel.font.pointSize * 1.2 / 2
            UIlabel.backgroundColor = .red//.bostonBlue()
            UIlabel.textColor = .white
            UIlabel.text = text
        //}
    }
}
