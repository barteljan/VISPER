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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example3VisperVC";
    }
    
    
    @IBAction func closeViewController(_ sender: AnyObject) {
        
        let event = self.visperServiceProvider.createEvent(withName: "shouldCloseViewController", sender: self, info: [AnyHashable: Any]())
       
        self.notifyPresenters(of: self.view, withEvent: event as! NSObject)
        
    }
    
    @IBAction func loadDataWithSwift(_ sender: AnyObject) {
        let event = self.visperServiceProvider.createEvent(withName: "loadDataWithSwift", sender: self, info: [AnyHashable: Any]())
        
        self.notifyPresenters(of: self.view, withEvent: event as! NSObject)
    }
    
    @objc func setText(_ text:String){
        self.textLabel.text = text
    }
}
