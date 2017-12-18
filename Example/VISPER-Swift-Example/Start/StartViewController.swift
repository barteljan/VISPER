//
//  StartViewController.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 17.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var pushButton: UIButton!
    
    var modalButtonPressed : (() -> Void)?
    var pushedButtonPressed : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalButton.addTarget(self, action: #selector(onModal), for: .touchUpInside)
        self.pushButton.addTarget(self, action: #selector(onPush), for: .touchUpInside)
    }
    
    @objc func onModal(){
        if let callback = self.modalButtonPressed {
            callback()
        }
    }

    @objc func onPush(){
        if let callback = self.pushedButtonPressed {
            callback()
        }
    }
}
