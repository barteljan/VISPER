//
//  ModalViewControllerTopControllerResolverTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 26.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Core
@testable import VISPER_Wireframe

class ModalViewControllerTopControllerResolverTests: XCTestCase {
    
    func showVC(controller: UIViewController) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = controller
        XCTAssertNotNil(controller.view,"\(controller)s view should be created")
        window?.makeKeyAndVisible()
    }
    
    func testIsNotResponsibleForWrongController() {
        
        let topControllerResolver = ModalViewControllerTopControllerResolver()
        
        let controller = UIViewController()
        
        XCTAssertFalse(topControllerResolver.isResponsible(controller: controller))
        
    }
    
    func testIsResponsibleForCorrectController() {
        
        let topControllerResolver = ModalViewControllerTopControllerResolver()
        
        let navController = UINavigationController()
        self.showVC(controller: navController)
        
        let expectCompletion = self.expectation(description: "completionCalled")
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            navController.present(UIViewController(), animated: false) {
                XCTAssertTrue(topControllerResolver.isResponsible(controller: navController))
                expectCompletion.fulfill()
            }
        }
        
        self.wait(for: [expectCompletion], timeout: 2.0)
        
    }
    
    func testResolvesCorrectController() {
        let topControllerResolver = ModalViewControllerTopControllerResolver()
        
        let navController = UINavigationController()
        navController.viewControllers = [UIViewController(),UIViewController()]
        self.showVC(controller: navController)
        
        let expectCompletion = self.expectation(description: "completionCalled")
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            let controller = UIViewController()
            navController.present(controller, animated: false) {
                let topController = topControllerResolver.topController(of: navController)
                XCTAssertEqual(controller, topController)
                expectCompletion.fulfill()
            }
        }
        
        self.wait(for: [expectCompletion], timeout: 2.0)
        
    }
    
    func testResolvesRootControllerIfNoOtherTopControllerWasFound() {
        
        let topControllerResolver = ModalViewControllerTopControllerResolver()
        
        let controller = UINavigationController()
        controller.viewControllers = [UIViewController(),UIViewController()]
        
        let topController = topControllerResolver.topController(of: controller)
        
        XCTAssertEqual(topController, controller)
    }
    
}
