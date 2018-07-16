//
//  HelloWorldFeature.swift
//  VISPER-Wireframe-Example
//
//  Created by bartel on 16.07.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import UIKit
import VISPER_Wireframe
import VISPER_Core


class BlueFeature: ViewFeature {
    
    var routePattern: String = "/Blue"
    var priority: Int = 0
    let wireframe: Wireframe
    
    init(wireframe: Wireframe){
        self.wireframe = wireframe
    }
    
    // return a routing option to show how this controller should be presented
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
    
    
    // create a blue controller which will be created when the "blue" route is called
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        let controller = UIViewController()
        controller.view.backgroundColor = .blue
        
        let button = UIButton(type: .custom)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tab here to enter a new world", for: .normal)
        
        controller.view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(nextWorld), for: .touchUpInside)
        
        return controller
    }
    
    @objc func nextWorld() {
        try! self.wireframe.route(url: URL(string: "/Green")!)
    }
  
}
