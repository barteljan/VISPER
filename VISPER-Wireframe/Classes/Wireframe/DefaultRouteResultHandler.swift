//
//  DefaultRouteResultHandler.swift
//  VISPER-Wireframe
//
//  Created by bartel on 25.12.17.
//

import Foundation
import VISPER_Core
import VISPER_Presenter
import VISPER_Objc

open class DefaultRouteResultHandler: RouteResultHandler {
    
    public init(){}
    
    open func handleRouteResult(routeResult: RouteResult,
                                optionProvider: RoutingOptionProvider,
                                routingHandlerContainer: RoutingHandlerContainer,
                                controllerProvider: ComposedControllerProvider,
                                presenterProvider: PresenterProvider,
                                routingDelegate: RoutingDelegate,
                                routingObserver: RoutingObserver,
                                routingPresenter: RoutingPresenter,
                                wireframe: Wireframe,
                                completion: @escaping () -> Void) throws {
        
        var modifiedRouteResult = routeResult
        var routingDelegate = routingDelegate
        
        //check if someone wants to modify your routing option
        let modifiedRoutingOption : RoutingOption? = optionProvider.option(routeResult: modifiedRouteResult)
        
        modifiedRouteResult.routingOption = modifiedRoutingOption
        
        //check if there is a routing handler responsible for this RouteResult/RoutingOption combination
        let handlerPriority = routingHandlerContainer.priorityOfHighestResponsibleProvider(routeResult: modifiedRouteResult)
        
        //check if there is a controller provider responsible for this RouteResult/RoutingOption combination
        let controllerPriority  = controllerProvider.priorityOfHighestResponsibleProvider(routeResult: modifiedRouteResult)
        
        //call handler and terminate if its priority is higher than the controllers provider
        if controllerPriority != nil && handlerPriority != nil {
            if handlerPriority! >= controllerPriority! {
                try self.callHandler(routeResult: modifiedRouteResult,
                                     container: routingHandlerContainer,
                                     completion: completion)
                return
            }
        } else if controllerPriority == nil && handlerPriority != nil {
            try self.callHandler(routeResult: modifiedRouteResult,
                                 container: routingHandlerContainer,
                                 completion: completion)
            return
        }
        
        //proceed with controller presentation if no handler with higher priority was found
        
        //check if a controller could be provided by the composedControllerProvider
        guard controllerProvider.isResponsible(routeResult: modifiedRouteResult) else {
            throw DefaultWireframeError.canNotHandleRoute(routeResult: modifiedRouteResult)
        }
        
        let controller = try controllerProvider.makeController(routeResult: modifiedRouteResult)
        
        //get all presenters responsible for this route pattern / controller combination
        for presenter in try presenterProvider.makePresenters(routeResult: modifiedRouteResult, controller: controller) {
            if presenter.isResponsible(routeResult:modifiedRouteResult, controller: controller) {
                try presenter.addPresentationLogic(routeResult: modifiedRouteResult, controller: controller)
                controller.retainPresenter(PresenterObjc(presenter: presenter))
            }
        }
        
        routingDelegate.routingObserver = routingObserver
        
        //check if we have a presenter responsible for this option
        guard routingPresenter.isResponsible(routeResult: modifiedRouteResult) else {
            throw DefaultWireframeError.noRoutingPresenterFoundFor(result: modifiedRouteResult)
        }
        
        
        try self.runOnMainThread {
            //present view controller
            try routingPresenter.present(controller: controller,
                                         routeResult: modifiedRouteResult,
                                         wireframe: wireframe,
                                         delegate: routingDelegate,
                                         completion: completion)
        }
        
    }
    
    func runOnMainThread(_ completion: @escaping () throws -> Void ) throws {
        if Thread.isMainThread {
            try completion()
        } else {
            try DispatchQueue.main.sync { () -> Void in
                try completion()
            }
        }
    }
    
    func callHandler(routeResult: RouteResult,
                     container: RoutingHandlerContainer,
                     completion: @escaping () -> Void) throws{
        if let handler = container.handler(routeResult: routeResult) {
            handler(routeResult)
            completion()
            return
        }
        throw DefaultWireframeError.canNotHandleRoute(routeResult: routeResult)
    }
    
    open func controller(routeResult: RouteResult,
                         controllerProvider: ControllerProvider,
                         presenterProvider: PresenterProvider,
                         routingDelegate: RoutingDelegate,
                         routingObserver: RoutingObserver,
                         wireframe: Wireframe) throws -> UIViewController? {
        
        
        if controllerProvider.isResponsible(routeResult: routeResult) {
            
            let controller = try controllerProvider.makeController(routeResult: routeResult)
            
            //get all presenters responsible for this route pattern / controller combination
            for presenter in try presenterProvider.makePresenters(routeResult: routeResult, controller: controller) {
                try presenter.addPresentationLogic(routeResult: routeResult, controller: controller)
            }
            
            var routingDelegate = routingDelegate
            routingDelegate.routingObserver = routingObserver
            
            try routingDelegate.willPresent(controller: controller,
                                            routeResult: routeResult,
                                            routingPresenter: nil,
                                            wireframe: wireframe)
            
            routingDelegate.didPresent(controller: controller,
                                       routeResult: routeResult,
                                       routingPresenter: nil,
                                       wireframe: wireframe)
            
            return controller
            
        }
        
        return nil
        
    }
    
}
