//
//  AmessageVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/18/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class AmessageVC: UIViewController {
    
    //segue data
    var segueFrom:String!
    var segueMessage:String!
    var segueDate:String!
    var segueMessageDetails:String!
    //var segueIsRead:String!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMessageUI()
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension AmessageVC{
    func setUpMessageUI(){
        titleLabel.text = segueFrom
        messageLabel.text = segueMessage
        messageDetail.text = segueMessageDetails
    }
}

extension AmessageVC{
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailToCompose" {
            if let vc = segue.destination as? CompseMessageVC {
                vc.segueHead = "fromDetail"//
                vc.segueFrom = segueFrom
                vc.segueMessage = segueMessage
                vc.segueDate = segueDate
                vc.segueMessageDetails = segueMessageDetails
            }
        }
    }
}
