//
//  DetailViewController.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/18/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var webEventDetail: UIWebView!

    var rssEvent: RSSEvent? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    private func configureView() {
        // Update the user interface for the detail item.
        if let link = rssEvent?.linkURL!.removelineBrakes() {
            loadURL(link)
        }
        if let title = rssEvent?.title.removelineBrakes(){
            self.title = title
        }
    }
    // loading the link in webview
    private func loadURL(rssLink: String!){
        if  let url = NSURL.init(string: rssLink.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!){
            let request = NSURLRequest(URL: url)
            webEventDetail?.loadRequest(request)
            webEventDetail?.scalesPageToFit = true
            webEventDetail?.contentMode = UIViewContentMode.ScaleAspectFit
        }
     }
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

