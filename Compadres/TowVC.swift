//
//  TowVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/24/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TowVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    lazy var geocoder = CLGeocoder()
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.requestAlwaysAuthorization() //For when app is open & in background
        if CLLocationManager.locationServicesEnabled() {
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.startUpdatingLocation()
        }
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        
        tapDismissKeyboard()
        //keyboard notification for push fields up/down
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)
    }

    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
    @IBAction func requestButtonAction(_ sender: Any) {
        //TOAST Update Sent
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: .autoreverse, animations: { () -> Void in
            self.view.makeToast("Request Sent. Expect a Call Back Soon", duration: 1.5, position: .center)
        }, completion: { finished in
            //self.performSegue(withIdentifier: "unwindToPatientFeed", sender: self)
            let storyboard = UIStoryboard(name: "dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController //PTV
            self.present(vc, animated: false, completion: nil)
            // reload table
        })
    }
}

extension TowVC {
    // #MARK: - Hide Keyboard
    func tapDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
        topConstraint.constant = 60
        bottomConstraint.constant = 10
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    //Move view up and down with keyboard will show
    @objc func keyboardWillShow(sender: NSNotification){
        topConstraint.constant = 20
        bottomConstraint.constant = 190
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

extension TowVC {
    // #MARK: - MAP
     func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        //geocodeButton.isHidden = false
        //activityIndicatorView.stopAnimating()
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            //locationLabel.text = "Unable to Find Address for Location"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                print("\(placemark.compactAddress!)") //locationLabel.text = placemark.compactAddress
                addressLabel.text = placemark.compactAddress
            } else {
                print("No Matching Addresses Found") //locationLabel.text = "No Matching Addresses Found"
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            let location = CLLocation(latitude: lat, longitude: lng)
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                // Process Response
                self.processResponse(withPlacemarks: placemarks, error: error)
            }
        }
    }
}

extension CLPlacemark {
    var compactAddress: String? {
        if let name = name {
            var result = name
            if let street = thoroughfare {
                result += ", \(street)"
            }
            if let city = locality {
                result += ", \(city)"
            }
            if let state = administrativeArea {
                result += " \(state) "
            }
            if let postalCode = postalCode {
                result += ", \(postalCode)"
            }
            return result
        }
        return nil
    }
}
