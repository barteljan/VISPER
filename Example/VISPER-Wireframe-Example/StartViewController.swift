//
//  StartViewController.swift
//  VISPER-Wireframe-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
 
    typealias ButtonTap = (_ sender: UIButton) -> Void
    
    weak var messageButton: UIButton! {
        didSet {
            self.messageButton?.setTitle(self.messageButtonTitle, for: .normal)
        }
    }
    
    var messageButtonTitle: String? {
        didSet {
            self.messageButton?.setTitle(self.messageButtonTitle, for: .normal)
        }
    }
    
    weak var swiftUIButton: UIButton! {
        didSet {
            self.swiftUIButton?.setTitle(self.swiftUIButtonTitle, for: .normal)
        }
    }
    
    var swiftUIButtonTitle: String? {
        didSet {
            self.swiftUIButton?.setTitle(self.swiftUIButtonTitle, for: .normal)
        }
    }
    
    var tapMessageEvent: ButtonTap?
    var tapSwiftUiEvent: ButtonTap?
    
    override func loadView() {
        
        let view = UIView()
        self.view = view
        
        let messageButton = UIButton()
        self.messageButton = messageButton
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.addTarget(self, action: #selector(self.tappedMessageButton(sender:)), for: .touchUpInside)
        
        let swiftUIButton = UIButton()
        swiftUIButton.backgroundColor = .lightGray
        self.swiftUIButton = swiftUIButton
        swiftUIButton.translatesAutoresizingMaskIntoConstraints = false
        swiftUIButton.addTarget(self, action: #selector(self.tappedSwiftUIButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(messageButton)
        self.view.addSubview(swiftUIButton)
        
        NSLayoutConstraint.activate([
            messageButton.topAnchor.constraint(equalTo: self.view.topAnchor),
            messageButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            messageButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            messageButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            swiftUIButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            swiftUIButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            swiftUIButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            swiftUIButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
            
        ])
        
    }
    
    @objc func tappedMessageButton(sender: UIButton) {
        self.tapMessageEvent?(sender)
    }
    
    @objc func tappedSwiftUIButton(sender: UIButton) {
        self.tapSwiftUiEvent?(sender)
    }
    
    
}
