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
    
    @IBOutlet weak var counterLabel: UILabel! {
        didSet {
            self.update()
        }
    }
    
    var state : StartViewState! {
        didSet{
            self.update()
        }
    }
    
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
    
    func update(){
        if let state = self.state, let counterLabel = self.counterLabel {
            let timesOpened = "Opend an other controller " + String(state.timesOpendAController) + " times"
            counterLabel.text = timesOpened
        }
    }
}
