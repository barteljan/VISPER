//
//  StartPresenter.swift
//  VISPER-Wireframe-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Core

class StartPresenter: Presenter {
    
    var userName: String
    let wireframe: Wireframe
    
    init(userName: String, wireframe: Wireframe) {
        self.userName = userName
        self.wireframe = wireframe
    }
    
    func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        return controller is StartViewController
    }
    
    func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        
        guard let controller = controller as? StartViewController else {
            fatalError("needs a StartViewController")
        }
        
        controller.buttonTitle = "Hello \(self.userName)"
        
        controller.tapEvent = { [weak self] (_) in
            guard let presenter = self else { return }
            let path = "/message/\(presenter.userName)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            let url = URL(string:path)
            try! presenter.wireframe.route(url: url!)
        }
        
    }
}
