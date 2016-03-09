//
//  Example3VisperViewController.swift
//  VISPER
//
//  Created by Jan Bartel on 09.03.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER

class Example3VisperViewController: UIViewController {

    
    @IBOutlet weak var textLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example3VisperVC";
    }
    
    
    @IBAction func closeViewController(sender: AnyObject) {
        
        let event = self.visperServiceProvider.createEventWithName("shouldCloseViewController", sender: self, info: [NSObject : AnyObject]())
       
        self.notifyPresentersOfView(self.view, withEvent: event)
        
    }
    
    @IBAction func loadDataWithSwift(sender: AnyObject) {
        let event = self.visperServiceProvider.createEventWithName("loadDataWithSwift", sender: self, info: [NSObject : AnyObject]())
        
        self.notifyPresentersOfView(self.view, withEvent: event)
    }
    
    func setText(text:String){
        self.textLabel.text = text
    }
}
