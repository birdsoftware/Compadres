//
//  messagesTVC.swift
//  Compadres
//
//  Created by Brian Bird on 8/18/17.
//  Copyright © 2017 MPM. All rights reserved.
//

import UIKit

class messagesTVC: UITableViewCell {
//identifier: messagesCell
   
    @IBOutlet weak var blueImage: UIImageView!
    @IBOutlet weak var grayImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var dateTime: UILabel!

}

class directoryTopCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

class directoryLevel2Cell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
}

class specials: UICollectionViewCell {
    //specialCollectionCell
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var detail1: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var mileage: UILabel!
    
}
