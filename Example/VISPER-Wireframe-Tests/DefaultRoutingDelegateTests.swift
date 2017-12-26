//
//  DefaultRoutingDelegateTests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 02.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
import VISPER_Core
import VISPER_Objc

class DefaultRoutingDelegateTests: XCTestCase {
    
    
    func testCallsWillPresentOnComposedRoutingObserver() throws{
        
        //Arrange
        let composedObserver = MockComposedRoutingObserver()
        
        let delegate = DefaultRoutingDelegate()
        delegate.routingObserver = composedObserver
        
        let routePattern = "/a/route/pattern"
        
        let controller = UIViewController()
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:], routingOption: MockRoutingOption())
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        //Act
        try delegate.willPresent(controller: controller,
                                routeResult: routeResult,
                           routingPresenter: routingPresenter,
                                  wireframe: wireframe)
        
        //Assert
        XCTAssertTrue(composedObserver.invokedWillPresent)
        XCTAssertEqual(composedObserver.invokedWillPresentParameters?.controller, controller)
        AssertThat(composedObserver.invokedWillPresentParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(composedObserver.invokedWillPresentParameters?.routingPresenter, isOfType: MockRoutingPresenter.self, andEquals: routingPresenter)
        AssertThat(composedObserver.invokedWillPresentParameters?.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
    }
    
    func testCallsDidPresentOnComposedRoutingObserver(){
        
        //Arrange
        let composedObserver = MockComposedRoutingObserver()
        
        let delegate = DefaultRoutingDelegate()
        delegate.routingObserver = composedObserver
        
        let routePattern = "/this/is/a/route/pattern"
        
        let controller = UIViewController()
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:], routingOption: MockRoutingOption())
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        //Act
        delegate.didPresent(controller: controller,
                           routeResult: routeResult,
                      routingPresenter: routingPresenter,
                             wireframe: wireframe)
        
        //Assert
        XCTAssertTrue(composedObserver.invokedDidPresent)
        XCTAssertEqual(composedObserver.invokedDidPresentParameters?.controller, controller)
        AssertThat(composedObserver.invokedDidPresentParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(composedObserver.invokedDidPresentParameters?.routingPresenter, isOfType: MockRoutingPresenter.self, andEquals: routingPresenter)
        AssertThat(composedObserver.invokedDidPresentParameters?.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
    }
    
    func testCallsWillRouteOnRoutingAwareController() throws{
        
        //Arrange
        let composedObserver = MockComposedRoutingObserver()
        
        let delegate = DefaultRoutingDelegate()
        delegate.routingObserver = composedObserver
        
        let routePattern = "/this/is/a/route/pattern"
        
        let controller = MockRoutingAwareViewController()
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:], routingOption: MockRoutingOption())
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        //Act
        try delegate.willPresent(controller: controller,
                                 routeResult: routeResult,
                                 routingPresenter: routingPresenter,
                                 wireframe: wireframe)
        
        //Assert
        XCTAssertTrue(controller.invokedWillRoute)
        AssertThat(controller.invokedWillRouteParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(controller.invokedWillRouteParameters?.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
    }
    
    func testCallsDidRouteOnRoutingAwareController() {
        
        //Arrange
        let delegate = DefaultRoutingDelegate()
        
        let routingObserver = MockRoutingObserver()
        let routePattern = "/this/is/a/route/pattern"
        
        delegate.routingObserver = routingObserver
        
        let controller = MockRoutingAwareViewController()
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:], routingOption: MockRoutingOption())
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        //Act
        delegate.didPresent(controller: controller,
                           routeResult: routeResult,
                      routingPresenter: routingPresenter,
                             wireframe: wireframe)
        
        //Assert
        XCTAssertTrue(controller.invokedDidRoute)
        AssertThat(controller.invokedDidRouteParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(controller.invokedDidRouteParameters?.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
    }
    
    func testCallsObjcWillRouteOnController() throws{
        
        //Arrange
        let delegate = DefaultRoutingDelegate()
        
        let routingObserver = MockRoutingObserver()
        let routePattern = "/this/is/a/route/pattern"
        
        delegate.routingObserver = routingObserver
        
        let controller = MockViewController()
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:], routingOption: MockRoutingOption())
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        //Act
        try delegate.willPresent(controller: controller,
                                 routeResult: routeResult,
                                 routingPresenter: routingPresenter,
                                 wireframe: wireframe)
        
        //Assert
        XCTAssertTrue(controller.invokedWillRoute)
        AssertThat(controller.invokedWillRouteParameters?.routeResult.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(controller.invokedWillRouteParameters?.wireframe.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
    }
    
    func testCallsObjcDidRouteController() {
        
        //Arrange
        let delegate = DefaultRoutingDelegate()
        
        let routingObserver = MockRoutingObserver()
        let routePattern = "/this/is/a/route/pattern"
        
        delegate.routingObserver = routingObserver
        
        let controller = MockViewController()
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:], routingOption: MockRoutingOption())
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        //Act
        delegate.didPresent(controller: controller,
                            routeResult: routeResult,
                            routingPresenter: routingPresenter,
                            wireframe: wireframe)
        
        //Assert
        XCTAssertTrue(controller.invokedDidRoute)
        AssertThat(controller.invokedDidRouteParameters?.routeResult.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(controller.invokedDidRouteParameters?.wireframe.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
    }
    
}
