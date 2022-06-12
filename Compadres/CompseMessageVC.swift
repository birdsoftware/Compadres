//
//  CompseMessageVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/19/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class CompseMessageVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var sendToPicker: UIPickerView!
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var sendToLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var toList = ["Compadres Service", "Compadres Support", "Tow Support"]
    
    //segue data
    var segueHead:String!
    
    var segueFrom:String!
    var segueMessage:String!
    var segueDate:String!
    var segueMessageDetails:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        sendToPicker.delegate = self
        sendToPicker.dataSource = self
        tapDismissKeyboard()
        updateIsReview()
    }

    @IBAction func backButtonAction(_ sender: Any) {
            let storyboard = UIStoryboard(name: "Messages", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "messagesID") as UIViewController //PTV
            self.present(vc, animated: false, completion: nil)
    }
    @IBAction func sendButtonAction(_ sender: Any) {
        //TOAST Update Sent
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: .autoreverse, animations: { () -> Void in
            self.view.makeToast("Message Sent", duration: 1.0, position: .center)
        }, completion: { finished in
            //self.performSegue(withIdentifier: "unwindToPatientFeed", sender: self)
            let storyboard = UIStoryboard(name: "Messages", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "messagesID") as UIViewController //PTV
            self.present(vc, animated: false, completion: nil)
            // reload table
        })
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension CompseMessageVC{
    // #MARK: - UI Hide Keyboard
    func updateIsReview(){
        if segueHead == "fromDetail" {
            titleLabel.text = "Reply Message"
            subjectTextField.text = "Re: " + segueMessage
            sendToLabel.text = segueFrom
            messageTextView.text = "\n>" + segueMessageDetails
        }
    }
    func tapDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){ view.endEditing(true) }
}

extension CompseMessageVC{
    // #MARK: - Picker View
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // returns the number of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return toList.count
    }
    // returns data to display in care team picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return toList[row]
    }
    // picker value selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        sendToLabel.text = toList[row]
        //availDay = dayList[row]
    }
}
