//
//  SpecialsVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/25/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class SpecialsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var SpecialCollectionView: UICollectionView!
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    
    var dataFile:Array<Dictionary<String,String>> = [["mileage":"127817","year":"2007","detail1":"CADILLAC Escalade","model":"2007 Cadillac Escalade","image":"car1","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/49/sport/39/2007-cadillac-escalade.html"],
                    ["mileage":"100000","year":"2008","detail1":"JEEP Patriot","model":"2008 Jeep Patriot","image":"car2","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/49/sport/19/2008-jeep-patriot.html"],
                    ["mileage":"109718","year":"2009","detail1":"CHEVROLET HHR","model":"2009 Chevrolet HHR","image":"car3","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/49/sport/40/2009-chevrolet-hhr.html"],
                    ["mileage":"97089","year":"2009","detail1":"DODGE Journey","model":"2009 Dodge Journey","image":"car4","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/49/sport/42/2009-dodge-journey.html"],
                    ["mileage":"89824","year":"2010","detail1":"JEEP Patriot","model":"2010 Jeep Patriot","image":"car5","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/49/sport/20/2010-jeep-patriot.html"],
                    ["mileage":"91975","year":"2011","detail1":"MITSUBISHI Outlander","model":"2011 Mitsubishi Outlander","image":"car6","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/49/sport/56/2011-mitsubishi-outlander.html"],
                    ["mileage":"164531","year":"2001","detail1":"FORD F-150","model":"2001 Ford F-150","image":"car7","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/48/truck/14/2001-ford-f-150.html"],
                    ["mileage":"144128","year":"2001","detail1":"TOYOTA Tacoma","model":"2001 Toyota Tacoma","image":"car8","link":"http://compadresautosales.com/our-inventory/118/view_vehicle/48/truck/28/2001-toyota-tacoma.html"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SpecialCollectionView.delegate = self
        SpecialCollectionView.dataSource = self
    }
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func callButtonAction(_ sender: Any) {
        callThisNumber(digits: "7024371111")
    }
}

extension SpecialsVC {
    //collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFile.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "specialCollectionCell", for: indexPath) as! specials
        let data:Dictionary<String,String> = dataFile[indexPath.row]
        cell.image.image = UIImage(named: data["image"]!)
        cell.model.text = data["model"]
        cell.detail1.text = data["detail1"]
        cell.year.text = data["year"]
        cell.mileage.text = data["mileage"]
        cell.textView.attributedText = buildLink(str:"View Listing", url: data["link"]!)
        return cell
    }
    //link
    func buildLink(str: String, url: String) -> NSMutableAttributedString{
        //var str = "Google"
        let attributedString = NSMutableAttributedString(string:str, attributes:[NSLinkAttributeName: NSURL(string: url)!])//"http://www.google.com")!])
        return attributedString
    }
    //scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //
        //let contentOffSet = self.channelsCollView.contentOffset.y
    }
}
