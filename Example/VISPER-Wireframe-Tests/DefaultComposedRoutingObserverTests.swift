//
//  DefaultComposedRoutingObserverTests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 22.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe

class DefaultComposedRoutingObserverTests: XCTestCase {
    
    func testAddRoutingObserver() throws {
    
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let routePattern = "/testpattern"
        let priority = 10
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: routePattern)
        
        if composedObserver.routingObservers.count == 1 {
            
            let wrapper = composedObserver.routingObservers[0]
            
            guard let observer = wrapper.routingObserver as? MockRoutingObserver else {
                XCTFail("wrapper should contain our routing observer")
                return
            }
            
            XCTAssertEqual(wrapper.priority, priority)
            XCTAssertEqual(wrapper.routePattern, routePattern)
            XCTAssertEqual(observer, mockObserver1)
            
        } else {
            XCTFail("There should be one RoutingObserverWrapper in there")
        }
        
    }
    
    func testAddRoutingObserverPriority() throws {
        
        let mockObserver1 = MockRoutingObserver()
        let priority1 = 5
        
        let mockObserver2 = MockRoutingObserver()
        let priority2 = 10
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        composedObserver.add(routingObserver: mockObserver1, priority: priority1, routePattern: nil)
        composedObserver.add(routingObserver: mockObserver2, priority: priority2, routePattern: nil)
        
        if composedObserver.routingObservers.count == 2 {
            
            let wrapper1 = composedObserver.routingObservers[0]
            guard let observer1 = wrapper1.routingObserver as? MockRoutingObserver else {
                XCTFail("wrapper should contain our routing observer")
                return
            }
            
            let wrapper2 = composedObserver.routingObservers[1]
            guard let observer2 = wrapper2.routingObserver as? MockRoutingObserver else {
                XCTFail("wrapper should contain our routing observer")
                return
            }
            
            XCTAssertEqual(wrapper1.priority, priority2)
            XCTAssertEqual(observer1, mockObserver2)
            XCTAssertNil(wrapper1.routePattern)
            
            XCTAssertEqual(wrapper2.priority, priority1)
            XCTAssertEqual(observer2, mockObserver1)
            XCTAssertNil(wrapper2.routePattern)
        } else {
            XCTFail("There should be two RoutingObserverWrapper in there")
        }
        
    }
    
    func testCallsWillPresentOfChild() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: nil)
        
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        try composedObserver.willPresent(controller: viewController,
                                        routeResult: routeResult,
                                   routingPresenter: routingPresenter,
                                          wireframe: wireframe)

        guard mockObserver1.invokedWillPresent else {
            XCTFail()
            return
        }
        
        guard let paramRouteResult = mockObserver1.invokedWillPresentParameters?.routeResult as? DefaultRouteResult else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramRouteResult, routeResult)
        
        guard let paramViewController = mockObserver1.invokedWillPresentParameters?.controller else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramViewController, viewController)
        
        guard let paramRoutingPresenter = mockObserver1.invokedWillPresentParameters?.routingPresenter as? MockRoutingPresenter else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramRoutingPresenter, routingPresenter)
        
        guard let paramWireframe = mockObserver1.invokedWillPresentParameters?.wireframe as? MockWireframe else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramWireframe, wireframe)
    }
    
    
    func testCallsWillPresentOfChildWithCorrectRoutePattern() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        let routePattern = "/this/is/a/route"
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: routePattern)
        
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        try composedObserver.willPresent(controller: viewController,
                                         routeResult: routeResult,
                                         routingPresenter: routingPresenter,
                                         wireframe: wireframe)
        
        XCTAssert(mockObserver1.invokedWillPresent)
    }
    
    func testCallsWillPresentOfChildWithNoRoutePattern() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        let routePattern = "/this/is/a/route"
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: nil)
        
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        try composedObserver.willPresent(controller: viewController,
                                         routeResult: routeResult,
                                         routingPresenter: routingPresenter,
                                         wireframe: wireframe)
        
        XCTAssert(mockObserver1.invokedWillPresent)
    }
    
    func testDoNotCallWillPresentOfChildWithWrongRoutePattern() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        
        composedObserver.add(routingObserver: mockObserver1,
                                    priority: priority,
                                routePattern:  "/this/is/a/route")
        
        let routeResult = DefaultRouteResult(routePattern:"WRONG/ROUTE", parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        try composedObserver.willPresent(controller: viewController,
                                         routeResult: routeResult,
                                         routingPresenter: routingPresenter,
                                         wireframe: wireframe)
        
        XCTAssertFalse(mockObserver1.invokedWillPresent)
    }
    
    
    func testCallsDidPresentOfChild() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: nil)
        
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        composedObserver.didPresent(controller: viewController,
                                   routeResult: routeResult,
                              routingPresenter: routingPresenter,
                                     wireframe: wireframe)
        
        guard mockObserver1.invokedDidPresent else {
            XCTFail()
            return
        }
        
        guard let paramRouteResult = mockObserver1.invokedDidPresentParameters?.routeResult as? DefaultRouteResult else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramRouteResult, routeResult)
        
        guard let paramViewController = mockObserver1.invokedDidPresentParameters?.controller else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramViewController, viewController)
        
        
        guard let paramRoutingPresenter = mockObserver1.invokedDidPresentParameters?.routingPresenter as? MockRoutingPresenter else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramRoutingPresenter, routingPresenter)
        
        guard let paramWireframe = mockObserver1.invokedDidPresentParameters?.wireframe as? MockWireframe else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramWireframe, wireframe)
    }
    
    func testCallsDidPresentOfChildWithCorrectRoutePattern() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        let routePattern = "/this/is/a/route"
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: routePattern)
        
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        composedObserver.didPresent( controller: viewController,
                                     routeResult: routeResult,
                                     routingPresenter: routingPresenter,
                                     wireframe: wireframe)
        
        XCTAssert(mockObserver1.invokedDidPresent)
    }
    
    func testCallsDidPresentOfChildWithNoRoutePattern() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        let routePattern = "/this/is/a/route"
        composedObserver.add(routingObserver: mockObserver1, priority: priority, routePattern: nil)
        
        let routeResult = DefaultRouteResult(routePattern: routePattern, parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        composedObserver.didPresent( controller: viewController,
                                     routeResult: routeResult,
                                     routingPresenter: routingPresenter,
                                     wireframe: wireframe)
        
        XCTAssert(mockObserver1.invokedDidPresent)
    }
    
    func testDoNotCallDidPresentOfChildWithWrongRoutePattern() throws{
        
        let mockObserver1 = MockRoutingObserver()
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        let priority = 10
        
        composedObserver.add(routingObserver: mockObserver1,
                             priority: priority,
                             routePattern:  "/this/is/a/route")
        
        let routeResult = DefaultRouteResult(routePattern:"WRONG/ROUTE", parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        composedObserver.didPresent( controller: viewController,
                                     routeResult: routeResult,
                                     routingPresenter: routingPresenter,
                                     wireframe: wireframe)
        
        XCTAssertFalse(mockObserver1.invokedDidPresent)
    }
    
    func testCallsRouterWithHighPriorityFirst() throws{
        
        let firstCalledObserver = MockRoutingObserver()
        let firstCalledPriority = 20
        
        let secondCalledObserver = MockRoutingObserver()
        let secondCalledPriority = 10
        
        let thirdCalledObserver = MockRoutingObserver()
        let thirdCalledPriority = 5
        
        
        let composedObserver = DefaultComposedRoutingObserver()
        
        composedObserver.add(routingObserver: secondCalledObserver,
                             priority: secondCalledPriority,
                             routePattern:  nil)
        
        composedObserver.add(routingObserver: firstCalledObserver,
                             priority: firstCalledPriority,
                             routePattern:  nil)
        
        composedObserver.add(routingObserver: thirdCalledObserver,
                             priority: thirdCalledPriority,
                             routePattern:  nil)
        
        let routeResult = DefaultRouteResult(routePattern:"a/cool/route", parameters: [:])
        let viewController = UIViewController()
        let routingPresenter = MockRoutingPresenter()
        let wireframe = MockWireframe()
        
        try composedObserver.willPresent( controller: viewController,
                                     routeResult: routeResult,
                                routingPresenter: routingPresenter,
                                       wireframe: wireframe)
        
        
        composedObserver.didPresent( controller: viewController,
                                     routeResult: routeResult,
                                     routingPresenter: routingPresenter,
                                     wireframe: wireframe)
        
        XCTAssertNotNil(secondCalledObserver.invokedWillPresentTime)
        XCTAssertNotNil(secondCalledObserver.invokedDidPresentTime)
        XCTAssertNotNil(firstCalledObserver.invokedWillPresentTime)
        XCTAssertNotNil(firstCalledObserver.invokedDidPresentTime)
        XCTAssertNotNil(firstCalledObserver.invokedWillPresentTime)
        XCTAssertNotNil(firstCalledObserver.invokedDidPresentTime)
        
        
        AssertThat(time1: firstCalledObserver.invokedWillPresentTime, isEarlierThan: secondCalledObserver.invokedWillPresentTime)
        AssertThat(time1: firstCalledObserver.invokedDidPresentTime, isEarlierThan: secondCalledObserver.invokedDidPresentTime)
        
        AssertThat(time1: firstCalledObserver.invokedWillPresentTime, isEarlierThan: thirdCalledObserver.invokedWillPresentTime)
        AssertThat(time1: firstCalledObserver.invokedDidPresentTime, isEarlierThan: thirdCalledObserver.invokedDidPresentTime)
        
        AssertThat(time1: secondCalledObserver.invokedWillPresentTime, isEarlierThan: thirdCalledObserver.invokedWillPresentTime)
        AssertThat(time1: secondCalledObserver.invokedDidPresentTime, isEarlierThan: thirdCalledObserver.invokedDidPresentTime)
        
    }
    
    
    
}
