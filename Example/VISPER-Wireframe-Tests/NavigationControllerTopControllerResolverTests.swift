//
//  VISPERExampleTopControllerResolverTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 26.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Core
@testable import VISPER_Wireframe

class NavigationControllerTopControllerResolverTests: XCTestCase {
    
    func testIsNotResponsibleForWrongController() {
       
        let topControllerResolver = NavigationControllerTopControllerResolver()
        
        let controller = UIViewController()
        
        XCTAssertFalse(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testIsResponsibleForCorrectController() {
        
        let topControllerResolver = NavigationControllerTopControllerResolver()
        
        let controller = UINavigationController()
        
        XCTAssertTrue(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testResolvesCorrectController() {
        
        let topControllerResolver = NavigationControllerTopControllerResolver()
        
        let controller = UINavigationController()
        controller.viewControllers = [UIViewController(),UIViewController(),UIViewController()]
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, controller.viewControllers.last!)
        
    }
    
    func testResolvesRootControllerIfNoOtherTopControllerWasFound() {
        
        let topControllerResolver = NavigationControllerTopControllerResolver()
        
        let controller = UINavigationController()
        
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, controller)
    
    }
    
}
