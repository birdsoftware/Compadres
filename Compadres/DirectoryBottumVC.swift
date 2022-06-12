//
//  DirectoryBottumVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/23/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit
import MapKit
import MessageUI //email

class DirectoryBottumVC: UIViewController, MKMapViewDelegate, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var titleThisView: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dirBusinessPhoneButton: RoundedButton!
    @IBOutlet weak var myLocationButton: RoundedButton!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    var location = CLLocation()
    let span = MKCoordinateSpanMake(0.03,0.03)
    var region = MKCoordinateRegion()
    var locationManager:CLLocationManager!
    var toggleMyLocation = true
    let mechanic = UIImage(named: "mechanic.png")
    
    //segue Data
    var segueTitles:String!
    var selectedDic:Dictionary<String,String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        titleThisView.text = selectedDic["title"]
        addressLabel.text = selectedDic["location"]
        dirBusinessPhoneButton.setTitle(selectedDic["phone"], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createMapView()
    }
    
    @IBAction func showUserButton(_ sender: Any) {
        if toggleMyLocation {
            map.showsUserLocation = true
            map.setUserTrackingMode(.follow, animated: true)
            myLocationButton.backgroundColor = .blue
            myLocationButton.setTitleColor(.white, for: .normal)
        } else {
            map.setRegion(region, animated: true)
            myLocationButton.backgroundColor = UIColor(hex:0xE6E6E6)
            myLocationButton.setTitleColor(.black, for: .normal)
        }
        toggleMyLocation = !toggleMyLocation
    }
    @IBAction func directionButtonAction(_ sender: Any) {
        DirectionsMap().showMap(destAddress: selectedDic["location"]!, destName: selectedDic["title"]!)
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
    @IBAction func mailButtonAction(_ sender: Any) {
        mail()
    }
    @IBAction func callShownNumberAction(_ sender: Any){
        var phoneString = self.selectedDic["phone"]!
        if phoneString.isEmpty == true {
            callThisNumber(digits: "7024371111")
        } else{
            phoneString = phoneString.replacingOccurrences(of: "(", with: "")
            phoneString = phoneString.replacingOccurrences(of: ")", with: "")
            phoneString = phoneString.replacingOccurrences(of: "-", with: "")
            phoneString = phoneString.replacingOccurrences(of: " ", with: "")
            //let integerPhone = Int(phoneString)
            callThisNumber(digits: phoneString)
            //print("phone: \(integerPhone!)")
        }
    }
}

extension DirectoryBottumVC {
    // #MARK: - Map
    func createMapView(){
        let address = selectedDic["location"]!
        
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let goodLocation = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            self.location = goodLocation
            self.region = MKCoordinateRegion(center:self.location.coordinate, span:self.span)
            self.map.setRegion(self.region, animated:false)
            
            let twoDLocation = CLLocationCoordinate2DMake(self.location.coordinate.latitude, self.location.coordinate.longitude)
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = twoDLocation
            dropPin.title = self.selectedDic["title"]
            dropPin.subtitle = self.selectedDic["phone"]
            self.map.addAnnotation(dropPin)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            let myPicture = UIImage(named: "mechanicBlue.png")

            annotationView.image = myPicture
            annotationView.frame.size = CGSize(width: 60.0, height: 60.0)
        }
        return annotationView
    }
}

extension DirectoryBottumVC {
    // #MARK: - mail
    func mail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        simpleAlert(title:"Could Not Send Email", message:"Your device could not send e-mail.  Please check e-mail configuration and try again.", buttonTitle:"OK")
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension DirectoryBottumVC{
    // #MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueBottumToLevel2" {
            if let vc = segue.destination as? DirectoryLevel2VC {
                vc.segueTitle = segueTitles
            }
        }
    }
}
