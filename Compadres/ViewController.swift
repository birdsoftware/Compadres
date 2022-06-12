//
//  ViewController.swift
//  Compadres
//
//  Created by Brian Bird on 8/16/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPhonePasswordIcons()
        tapDismissKeyboard()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        checkCredentials()
    }


}

extension ViewController{
    //UI Setup
    func setUpPhonePasswordIcons(){
        phoneTextField.leftViewMode = .always
        phoneTextField.leftView = UIImageView(image: UIImage(named: "man-user.png"))
        pwdTextField.leftViewMode = .always
        pwdTextField.leftView = UIImageView(image: UIImage(named: "key.png"))
    }
    func tapDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension ViewController{
    //password auth
    func checkCredentials(){
        let userPhone = phoneTextField.text!
        let userPassword = pwdTextField.text!
        
        if(userPhone.isEmpty || userPassword.isEmpty){
            
            simpleAlert(title: "New user Sign In failure", message: "Make sure Phone and Password fields are not empty", buttonTitle: "OK")
            return
        } else {
            if(userPhone == "123" && userPassword == "123"){
                seguePatientTabBar()
            }
        }
    }
}

extension ViewController{
    //segue
    func seguePatientTabBar(){
        self.performSegue(withIdentifier: "segueMainToWelcome", sender: self)
    }
}
