//
//  MapKit.swift
//  Compadres
//
//  Created by Brian Bird on 8/24/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit
import MapKit

class MapKit: MKPinAnnotationView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension MKPinAnnotationView {
    class func bluePinColor() -> UIColor {
        return UIColor.blue
    }
}
