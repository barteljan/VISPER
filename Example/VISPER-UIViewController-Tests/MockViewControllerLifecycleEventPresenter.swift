//
//  ViewControllerLifecycleEventPresenter.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 13.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_UIViewController
import VISPER_Presenter

class MockViewControllerLifecycleEventPresenter: ViewControllerLifecycleEventPresenter {
    
    var events = [LifecycleEvent]()
    
    var invokedIsResponsibleFor = false
    var invokedIsResponsibleForCount = 0
    var invokedIsResponsibleForParameters: (event: NSObject, view: UIView?, controller: UIViewController)?
    var invokedIsResponsibleForParametersList = [(event: NSObject, view: UIView?, controller: UIViewController)]()
    var stubbedIsResponsibleForResult: Bool! = false
    
    override func isResponsibleFor(event: NSObject, view: UIView?, controller: UIViewController) -> Bool {
        invokedIsResponsibleFor = true
        invokedIsResponsibleForCount += 1
        invokedIsResponsibleForParameters = (event, view, controller)
        invokedIsResponsibleForParametersList.append((event, view, controller))
        return stubbedIsResponsibleForResult
    }
    
    var invokedReceivedEvent = false
    var invokedReceivedEventCount = 0
    var invokedReceivedEventParameters: (event: NSObject, view: UIView?, controller: UIViewController)?
    var invokedReceivedEventParametersList = [(event: NSObject, view: UIView?, controller: UIViewController)]()
    
    override func receivedEvent(_ event: NSObject, view: UIView?, controller: UIViewController) {
        super.receivedEvent(event, view: view, controller: controller)
        invokedReceivedEvent = true
        invokedReceivedEventCount += 1
        invokedReceivedEventParameters = (event, view, controller)
        invokedReceivedEventParametersList.append((event, view, controller))
        
        guard let event = event as? LifecycleEvent else {
            fatalError("call it with a LifecycleEvent")
        }
        
        self.events.append(event)
    }
    
    var invokedLoad = false
    override func load(view: UIView?, controller: UIViewController) {
        self.invokedLoad = true
    }
    
    var invokedViewDidLoad = false
    override func viewDidLoad(view: UIView, controller: UIViewController){
        self.invokedViewDidLoad = true
    }
    
    var invokedViewWillAppear = false
    override func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController) {
        self.invokedViewWillAppear = true
    }
    
    var invokedViewDidAppear = false
    override func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController) {
        self.invokedViewDidAppear = true
    }
    
    var invokedViewWillDisappear = false
    override func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController) {
        self.invokedViewWillDisappear = true
    }
    
    var invokedViewDidDisappear = false
    override  open func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController){
        self.invokedViewDidDisappear = true
    }
}
