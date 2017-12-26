//
//  TabbarControllerTopControllerResolverTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 26.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Core
@testable import VISPER_Wireframe

class TabbarControllerTopControllerResolverTests: XCTestCase {
    
    func testIsNotResponsibleForWrongController() {
        
        let topControllerResolver = TabbarControllerTopControllerResolver()
        
        let controller = UIViewController()
        
        XCTAssertFalse(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testIsResponsibleForCorrectController() {
        
        let topControllerResolver = TabbarControllerTopControllerResolver()
        
        let controller = UITabBarController()
        
        XCTAssertTrue(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testResolvesCorrectController() {
        
        let topControllerResolver = TabbarControllerTopControllerResolver()
        
        let controller = UITabBarController()
        controller.viewControllers = [UIViewController(),UIViewController(),UIViewController()]
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, controller.viewControllers![controller.selectedIndex])
        
    }
    
    func testResolvesRootControllerIfNoOtherTopControllerWasFound() {
        
        let topControllerResolver = TabbarControllerTopControllerResolver()
        
        let controller = UITabBarController()
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, controller)
        
    }
    
}
