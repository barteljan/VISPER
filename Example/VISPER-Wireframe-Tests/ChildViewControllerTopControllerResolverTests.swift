//
//  ChildViewControllerTopControllerResolverTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 26.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Core
@testable import VISPER_Wireframe


class ChildViewControllerTopControllerResolverTests: XCTestCase {
    
    
    func testIsNotResponsibleForWrongController() {
        
        let topControllerResolver = ChildViewControllerTopControllerResolver()
        
        let controller = UIViewController()
        
        XCTAssertFalse(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testIsResponsibleForCorrectController() {
        
        let topControllerResolver = ChildViewControllerTopControllerResolver()
        
        let controller = UIViewController()
        controller.addChild(UIViewController())
        
        XCTAssertTrue(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testResolvesCorrectController() {
    
        let topControllerResolver = ChildViewControllerTopControllerResolver()
        
        let controller = UIViewController()
        let child1 = UIViewController()
        controller.addChild(child1)
        let child2 = UITabBarController()
        controller.addChild(child2)
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, child2)
        
    }
    
    func testResolvesRootControllerIfNoOtherTopControllerWasFound() {
        
        let topControllerResolver = ChildViewControllerTopControllerResolver()
        
        let controller = UIViewController()
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, controller)
        
    }
    
}
