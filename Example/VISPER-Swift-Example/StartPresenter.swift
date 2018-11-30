//
//  StartPresenter.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Swift

class StartPresenter: Presenter {
    
    var userName: ObservableProperty<String>
    let wireframe: Wireframe
    var referenceBag = SubscriptionReferenceBag()

    init(userName: ObservableProperty<String>, wireframe: Wireframe) {
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
        
        let subscription = self.userName.subscribe { (value) in
            controller.buttonTitle = "Hello \(value)"
        }
        self.referenceBag.addReference(reference: subscription)
        
        controller.tapEvent = { [weak self] (_) in
            guard let presenter = self else { return }
            let path = "/message/\(presenter.userName.value)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            let url = URL(string:path)
            try! presenter.wireframe.route(url: url!)
        }
        
    }
}
