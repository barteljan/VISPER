//
//  StartViewController.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    typealias ButtonTap = (_ sender: UIButton) -> Void
    
    weak var button: UIButton! {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    var buttonTitle: String? {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    var tapEvent: ButtonTap?
    
    override func loadView() {
        
        let view = UIView()
        self.view = view
        
        let button = UIButton()
        self.button = button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.tapped(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
    }
    
    @objc func tapped(sender: UIButton) {
        self.tapEvent?(sender)
    }
    
}
