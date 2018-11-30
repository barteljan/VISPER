//
//  MessageFeature.swift
//  VISPER-Wireframe-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Core
import VISPER_Wireframe

class MessageFeature: ViewFeature {
    
    var routePattern: String = "/message/:username"
    var priority: Int = 0
    
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        let username: String = routeResult.parameters["username"] as? String ?? "unknown"
        
        let alert = UIAlertController(title: nil,
                                    message: "Nice to meet you \(username)",
                             preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Goodbye", style: .cancel, handler: nil))
        
        return alert
    }
    
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionModal(animated: true,
                                         presentationStyle: .popover)
    }
    
}
