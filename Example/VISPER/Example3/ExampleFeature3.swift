//
//  ExampleFeature3.swift
//  VISPER
//
//  Created by Jan Bartel on 09.03.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER

class ExampleFeature3: VISPERFeature {

    override init() {
        super.init()
        self.addRoutePattern("/example3")
    }
    
    
    override func bootstrapWireframe(wireframe: IVISPERWireframe!, commandBus: VISPERCommandBus!) {
        super.bootstrapWireframe(wireframe, commandBus: commandBus)
        
        let handler = Example3CommandHandler()
        commandBus.addHandler(handler)
        
    }
    
    override func controllerForRoute(routePattern: String!, routingOptions options: IVISPERRoutingOption!, withParameters parameters: [NSObject : AnyObject]!) -> UIViewController! {
        
        if(routePattern == "/example3"){
            
            let presenter = Example3VisperViewControllerPresenter(wireframe: self.wireframe, commandBus: self.commandBus)
            
            let controller = Example3VisperViewController(nibName: "Example3VisperViewController", bundle: nil)
            
            controller.addVisperPresenter(presenter)
            
            return controller
        }
        
        return nil
    }
    
    
    override func optionForRoutePattern(routePattern: String!, parameters dictionary: [NSObject : AnyObject]?, currentOptions: IVISPERRoutingOption!) -> IVISPERRoutingOption? {
        
        if(currentOptions == nil && routePattern == "/example3"){
            return VISPER.routingOptionModal()
        }
        
        return currentOptions
    }
    
}
