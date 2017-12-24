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
    
    @IBAction func exit(_ sender: Any) {
        if let callback = exitCallBack {
            callback()
        }
    }
    
}
