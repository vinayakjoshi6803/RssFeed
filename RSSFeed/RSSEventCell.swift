//
//  RSSEventCell.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/19/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
import UIKit

public class RSSEventCell: UITableViewCell{

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!

    public func configureWithEvent(event: RSSEvent){
        
        self.lblTitle.text = event.title.removelineBrakes()
        self.lblDetails.text = event.descriptions.removelineBrakes()

        // the current feed dont have image urls specific to items, hence putting this default url
        let defaultImageLink = "http://configurator.suzuki.co.uk/cars/uploads/equipment/image_big/thumb/original/Swift_Web_Resize_CoolWhitePearlMetallic-0.png"
        
        // downlaods image on separate thread
        _ = RSSImageDownloader.init(strImgURL: defaultImageLink, success: { (image) in

            // hurrey we got the image now move back to main thread and put it on cell
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.imgView.image = image
            })
            }) { (error) in
                // TODO: error handling is pending
                
        }
    }
}



