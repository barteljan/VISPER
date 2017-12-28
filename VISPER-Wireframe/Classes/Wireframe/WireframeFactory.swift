//
//  WireframeFactory.swift
//  VISPER-Wireframe
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core
import VISPER_UIViewController

open class WireframeFactory {
    
    public init(){}
    
    open func makeWireframe(controllerContainer: ControllerContainer = DefaultControllerContainer()) -> Wireframe {
        let wireframe = DefaultWireframe()
        self.configure(wireframe: wireframe, controllerContainer: controllerContainer)
        return wireframe
    }
    
    open func configure(wireframe: Wireframe,controllerContainer: ControllerContainer){
        self.addDefaultRoutingPresenters(wireframe: wireframe, controllerContainer: controllerContainer)
        self.addDefaultTopControllerResolvers(wireframe: wireframe)
        self.addDefaultControllerDismisser(wireframe: wireframe)
    }
    
    open func addDefaultRoutingPresenters(wireframe: Wireframe,
                                          controllerContainer: ControllerContainer) {
        
        //add them with low priority to make customization easy
        let modalRoutingPresenter = ModalRoutingPresenter(controllerContainer: controllerContainer)
        wireframe.add(routingPresenter: modalRoutingPresenter, priority: -1000)
        
        let pushRoutingPresenter = PushRoutingPresenter(controllerContainer: controllerContainer)
        wireframe.add(routingPresenter: pushRoutingPresenter, priority: -1000)
        
        let replaceTopVCRoutingPresenter = ReplaceTopVCRoutingPresenter(controllerContainer: controllerContainer)
        wireframe.add(routingPresenter: replaceTopVCRoutingPresenter, priority: -1000)
        
        let rootVCRoutingPresenter = RootVCRoutingPresenter(controllerContainer: controllerContainer)
        wireframe.add(routingPresenter: rootVCRoutingPresenter, priority: -1000)
        
        let showRoutingPresenter = ShowRoutingPresenter(controllerContainer: controllerContainer)
        wireframe.add(routingPresenter: showRoutingPresenter, priority: -1000)
        
        let backToRoutingPresenter = BackToRoutingPresenter(controllerContainer: controllerContainer)
        wireframe.add(routingPresenter: backToRoutingPresenter, priority: -1000)
    }
    
    open func addDefaultTopControllerResolvers(wireframe: Wireframe) {
        
        //add them with low priority to make customization easy
        let navigationControllerResolver = NavigationControllerTopControllerResolver()
        wireframe.add(topControllerResolver: navigationControllerResolver, priority: -1000)
        
        let tabbarControllerResolver = TabbarControllerTopControllerResolver()
        wireframe.add(topControllerResolver: tabbarControllerResolver, priority: -1000)
        
        //since this is the most general resolver, it shoul be called last
        let childVCControllerResolver = ChildViewControllerTopControllerResolver()
        wireframe.add(topControllerResolver: childVCControllerResolver, priority: -5000)
        
        //add modal resolver with higher than default priority (modal presented controller are nearly always the top vc's)
        let modalVCControllerResolver = ModalViewControllerTopControllerResolver()
        wireframe.add(topControllerResolver: modalVCControllerResolver, priority: 1000)
        
    }
    
    open func addDefaultControllerDismisser(wireframe: Wireframe) {
        
        let modalDismisser = ModalControllerDismisser()
        wireframe.add(controllerDimisser: modalDismisser, priority: 0)
        
        let navigationControllerDismisser = NavigationControllerDismisser()
        wireframe.add(controllerDimisser: navigationControllerDismisser, priority: 0)
    }
    
    
}
