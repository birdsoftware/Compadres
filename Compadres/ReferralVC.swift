//
//  ReferralVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/25/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class ReferralVC: UIViewController {

    @IBOutlet weak var referralName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapDismissKeyboard()
        //keyboard notification for push fields up/down
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
    @IBAction func requestButtonAction(_ sender: Any) {
        //TOAST Update Sent
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: .autoreverse, animations: { () -> Void in
            self.view.makeToast("Referral Sent. Thank You!", duration: 1.5, position: .center)
        }, completion: { finished in
            //self.performSegue(withIdentifier: "unwindToPatientFeed", sender: self)
            let storyboard = UIStoryboard(name: "dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController
            self.present(vc, animated: false, completion: nil)
            // reload table
        })
    }
}

extension ReferralVC {
    // #MARK: - Hide Keyboard
    func tapDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
        topConstraint.constant = 80
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    //Move view up and down with keyboard will show
    @objc func keyboardWillShow(sender: NSNotification){
        //if let keyboardSize = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            //let keyboardHeight = keyboardSize.height
            topConstraint.constant = -40//-keyboardHeight+80
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        //}
    }
}
