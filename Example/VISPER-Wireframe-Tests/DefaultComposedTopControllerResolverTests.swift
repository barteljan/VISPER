//
//  DefaultComposedTopControllerResolverTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 26.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Core
@testable import VISPER_Wireframe


class DefaultComposedTopControllerResolverTests: XCTestCase {
    
    func testIsAlwaysResponsible(){
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let controller = UIViewController()
        
        XCTAssertTrue(topControllerResolver.isResponsible(controller: controller))
    }
    
    func testReturnInputControllerIfNoOtherWasFound(){
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let controller = UIViewController()
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(controller, topController)
        
    }
    
    func testCallsIsResponsibleOfChild(){
    
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let mockResolver = MockTopControllerResolver()
        mockResolver.stubbedIsResponsibleResult = false
    
        topControllerResolver.add(resolver: mockResolver, priority: 0)
        
        let controller = UIViewController()
        
        let _ = topControllerResolver.topController(of: controller)
        
        XCTAssertTrue(mockResolver.invokedIsResponsible)
        XCTAssertEqual(mockResolver.invokedIsResponsibleParameters?.controller, controller)
        
    }
    
    func testCallsChildsTopControllerIfResponsible(){
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let mockResolver = MockTopControllerResolver()
        mockResolver.stubbedIsResponsibleResult = true
        mockResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: mockResolver, priority: 0)
        
        
        
        let controller = topControllerResolver.topController(of: UIViewController())
        
        XCTAssertTrue(mockResolver.invokedIsResponsible)
        XCTAssertEqual(mockResolver.stubbedTopControllerResult, controller)
        
    }
    
    func testDoesNotCallChildsTopControllerIfNotResponsible(){
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let mockResolver = MockTopControllerResolver()
        mockResolver.stubbedIsResponsibleResult = false
        mockResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: mockResolver, priority: 0)
        
        let _ = topControllerResolver.topController(of: UIViewController())
        
        XCTAssertTrue(mockResolver.invokedIsResponsible)
        XCTAssertFalse(mockResolver.invokedTopController)
        
    }
    
    func testCallsHighPriorizedResolverFirst() {
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let mediumPriorizedResolver = MockTopControllerResolver()
        mediumPriorizedResolver.stubbedIsResponsibleResult = true
        mediumPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: mediumPriorizedResolver, priority: 20)
        
        let highPriorizedResolver = MockTopControllerResolver()
        highPriorizedResolver.stubbedIsResponsibleResult = true
        highPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: highPriorizedResolver, priority: 100)
        
        let lowPriorizedResolver = MockTopControllerResolver()
        lowPriorizedResolver.stubbedIsResponsibleResult = true
        lowPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: lowPriorizedResolver, priority: 10)
        
        let _ = topControllerResolver.topController(of: UIViewController())
        
        XCTAssertTrue(highPriorizedResolver.invokedIsResponsible)
        XCTAssertTrue(highPriorizedResolver.invokedTopController)
        
        XCTAssertFalse(mediumPriorizedResolver.invokedIsResponsible)
        XCTAssertFalse(mediumPriorizedResolver.invokedTopController)
        
        XCTAssertFalse(lowPriorizedResolver.invokedIsResponsible)
        XCTAssertFalse(lowPriorizedResolver.invokedTopController)
        
    }
    
    func testCallsMediumPriorizedResolverSecond() {
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let mediumPriorizedResolver = MockTopControllerResolver()
        mediumPriorizedResolver.stubbedIsResponsibleResult = true
        mediumPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: mediumPriorizedResolver, priority: 20)
        
        let highPriorizedResolver = MockTopControllerResolver()
        highPriorizedResolver.stubbedIsResponsibleResult = false
        highPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: highPriorizedResolver, priority: 100)
        
        let lowPriorizedResolver = MockTopControllerResolver()
        lowPriorizedResolver.stubbedIsResponsibleResult = true
        lowPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: lowPriorizedResolver, priority: 10)
        
        let _ = topControllerResolver.topController(of: UIViewController())
        
        XCTAssertTrue(highPriorizedResolver.invokedIsResponsible)
        XCTAssertFalse(highPriorizedResolver.invokedTopController)
        
        XCTAssertTrue(mediumPriorizedResolver.invokedIsResponsible)
        XCTAssertTrue(mediumPriorizedResolver.invokedTopController)
        
        XCTAssertFalse(lowPriorizedResolver.invokedIsResponsible)
        XCTAssertFalse(lowPriorizedResolver.invokedTopController)
        
    }
    
    func testCallsLowPriorizedResolverSecond() {
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        let mediumPriorizedResolver = MockTopControllerResolver()
        mediumPriorizedResolver.stubbedIsResponsibleResult = false
        mediumPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: mediumPriorizedResolver, priority: 20)
        
        let highPriorizedResolver = MockTopControllerResolver()
        highPriorizedResolver.stubbedIsResponsibleResult = false
        highPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: highPriorizedResolver, priority: 100)
        
        let lowPriorizedResolver = MockTopControllerResolver()
        lowPriorizedResolver.stubbedIsResponsibleResult = true
        lowPriorizedResolver.stubbedTopControllerResult = UIViewController()
        
        topControllerResolver.add(resolver: lowPriorizedResolver, priority: 10)
        
        let _ = topControllerResolver.topController(of: UIViewController())
        
        XCTAssertTrue(highPriorizedResolver.invokedIsResponsible)
        XCTAssertFalse(highPriorizedResolver.invokedTopController)
        
        XCTAssertTrue(mediumPriorizedResolver.invokedIsResponsible)
        XCTAssertFalse(mediumPriorizedResolver.invokedTopController)
        
        XCTAssertTrue(lowPriorizedResolver.invokedIsResponsible)
        XCTAssertTrue(lowPriorizedResolver.invokedTopController)
        
    }
    
    func testComplexControllerStructure() {
        
        let topControllerResolver = DefaultComposedTopControllerResolver()
        
        //add them with low priority to make customization easy
        let navigationControllerResolver = NavigationControllerTopControllerResolver()
        topControllerResolver.add(resolver: navigationControllerResolver, priority: -1000)
        
        let tabbarControllerResolver = TabbarControllerTopControllerResolver()
        topControllerResolver.add(resolver: tabbarControllerResolver, priority: -1000)
        
        //since this is the most general resolver, it shoul be called last
        let childVCControllerResolver = ChildViewControllerTopControllerResolver()
        topControllerResolver.add(resolver: childVCControllerResolver, priority: -5000)
        
        
        let tabbarController = UITabBarController()
        
        let navigationController = UINavigationController()
    
        let parentVC = UIViewController()
    
        navigationController.viewControllers = [UIViewController(),UIViewController(),parentVC]
        
        let childVC = UIViewController()
        
        parentVC.addChildViewController(childVC)
        
        tabbarController.viewControllers = [UIViewController(),navigationController,UIViewController()]
        
        tabbarController.selectedIndex = 1
        
        let controller = topControllerResolver.topController(of: tabbarController)
        XCTAssertEqual(controller, childVC)
        
    }
    
    
}
