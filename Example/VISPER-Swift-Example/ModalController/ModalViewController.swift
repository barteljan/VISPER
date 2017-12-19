//
//  ModalViewController.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 19.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    var exitCallBack: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(_ sender: Any) {
        if let callback = exitCallBack {
            callback()
        }
    }
    
}
