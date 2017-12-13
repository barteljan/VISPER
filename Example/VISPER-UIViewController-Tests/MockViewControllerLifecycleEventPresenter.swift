//
//  ViewControllerLifecycleEventPresenter.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 13.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_UIViewController

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
    
    override func receivedEvent(event: NSObject, view: UIView?, controller: UIViewController) {
        super.receivedEvent(event: event, view: view, controller: controller)
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
    var invokedLoadEvent: LoadViewEvent?
    override func load(_ view: UIView!, with viewController: UIViewController, event: LoadViewEvent) {
        self.invokedLoad = true
        self.invokedLoadEvent = event
    }
    
    var invokedViewDidLoad = false
    var invokedViewDidLoadEvent: ViewDidLoadEvent?
    override func viewDidLoad(_ view: UIView!, with viewController: UIViewController, event: ViewDidLoadEvent) {
        self.invokedViewDidLoad = true
        self.invokedViewDidLoadEvent = event
    }
    
    var invokedViewWillAppear = false
    var invokedViewWillAppearEvent: ViewWillAppearEvent?
    override func viewWillAppear(_ animated: Bool, view: UIView!, with viewController: UIViewController, on event: ViewWillAppearEvent) {
        self.invokedViewWillAppear = true
        self.invokedViewWillAppearEvent = event
    }
    
    var invokedViewDidAppear = false
    var invokedViewDidAppearEvent: ViewDidAppearEvent?
    override func viewDidAppear(_ animated: Bool, view: UIView!, with viewController: UIViewController, on event: ViewDidAppearEvent) {
        self.invokedViewDidAppear = true
        self.invokedViewDidAppearEvent = event
    }
    
    var invokedViewWillDisappear = false
    var invokedViewWillDisappearEvent: ViewWillDisappearEvent?
    override func viewWillDisappear(_ animated: Bool, view: UIView!, with viewController: UIViewController, on event: ViewWillDisappearEvent) {
        self.invokedViewWillDisappear = true
        self.invokedViewWillDisappearEvent = event
    }
    
    var invokedViewDidDisappear = false
    var invokedViewDidDisappearEvent: ViewDidDisappearEvent?
    override func viewDidDisappear(_ animated: Bool, view: UIView!, with viewController: (UIViewController!), on event: ViewDidDisappearEvent) {
        self.invokedViewDidDisappear = true
        self.invokedViewDidDisappearEvent = event
    }
}
