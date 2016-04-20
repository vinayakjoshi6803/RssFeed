//
//  RSSImageDownloader.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/19/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
import UIKit


class RSSImageDownloader:NSObject{
    
    // using convenience initializer as it allows multiple parameters and initialization at the same time
    // following success and failure block pattern to clearly specify the outcome of the network call
    convenience init(strImgURL: String , success:(image: UIImage)->Void, failure:(error: NSError)-> Void){
        
        self.init() // when we use convenience init it is must to have this line self.init()
        
        let url = NSURL(string: strImgURL)
        
        _ = RSSServiceManager.init(url: url!, success: { (data) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                let image : UIImage = UIImage(data: data!)!
                success(image: image)
            })
            
        }) { (error) in
            failure(error: error!)
        }

    }
}