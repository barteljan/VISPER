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

class StartViewController: UIViewController, UITextFieldDelegate {
    
    typealias ButtonTap = (_ sender: UIButton) -> Void
    typealias NameChanged = (_ sender: UITextField, _ username: String?) -> Void
    
    weak var button: UIButton! {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    weak var nameField: UITextField?
    
    var buttonTitle: String? {
        didSet {
            self.button?.setTitle(self.buttonTitle, for: .normal)
        }
    }

    var tapEvent: ButtonTap?
    var nameChanged: NameChanged?
    
    override func loadView() {
        
        let view = UIView()
        self.view = view
        
        let nameField = UITextField(frame: .null)
        self.nameField = nameField
        self.navigationItem.titleView = nameField
        nameField.placeholder = "enter your username here"
        nameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        nameField.backgroundColor = .white
        
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
    
    @objc func textFieldChanged(textField: UITextField) {
        self.nameChanged?(textField, textField.text)
    }
    
}
