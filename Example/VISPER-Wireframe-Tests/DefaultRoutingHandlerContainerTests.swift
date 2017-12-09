//
//  DefaultRoutingHandlerContainerTests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 30.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
@testable import VISPER_Wireframe_Core

class DefaultRoutingHandlerContainerTests: XCTestCase {
    
    func testAddRoutePatternForHandler() throws{
        
        let handlerExpectation = self.expectation(description: "Handler1 called")
        let handler = { (routeResult: RouteResult) -> Void in
            handlerExpectation.fulfill()
        }
        let pattern = "/test/pattern1"
        let priority = 5
        
        let container = DefaultRoutingHandlerContainer()
        
        try container.add(priority: priority,
                    responsibleFor: { result in return result.routePattern == pattern },
                           handler: handler)
        
        if container.routeHandlers.count == 1 {
            
            let wrapper = container.routeHandlers[0]
            
            let handler = wrapper.handler
            
            XCTAssertEqual(wrapper.priority, priority)
            
            handler(DefaultRouteResult(routePattern: "/some/pattern", parameters: [:]))
            
            self.wait(for: [handlerExpectation], timeout: 5)
            
        } else {
            XCTFail("There should be one Handler Wrapper in there")
        }
    }
    
    func testAddRoutePatternForHandlerPriority() throws {
        
        var didCallLowPriorityHandler = false
        let lowPriorityHandler = { (routeResult: RouteResult) -> Void in
            didCallLowPriorityHandler = true
        }
        let lowPriority = 5
        
        var didCallHighPriorityHandler = false
        let highPriorityHandler = { (routeResult: RouteResult) -> Void in
            didCallHighPriorityHandler = true
        }
        let highPriority = 10
        
        let container = DefaultRoutingHandlerContainer()
        
        
        try container.add(priority: lowPriority,
                          responsibleFor: { result in return false},
                          handler: lowPriorityHandler)
        try container.add(priority: highPriority,
                          responsibleFor: { result in return false },
                          handler: highPriorityHandler)
        
        if container.routeHandlers.count == 2 {
            
            let firstWrapper = container.routeHandlers[0]
            let secondWrapper = container.routeHandlers[1]
            
            XCTAssertEqual(firstWrapper.priority, highPriority)
            XCTAssertEqual(secondWrapper.priority, lowPriority)
            
            XCTAssertFalse(didCallHighPriorityHandler)
            firstWrapper.handler(DefaultRouteResult(routePattern: "/some/pattern", parameters: [:]))
            XCTAssertTrue(didCallHighPriorityHandler)
            
            XCTAssertFalse(didCallLowPriorityHandler)
            secondWrapper.handler(DefaultRouteResult(routePattern: "/some/pattern", parameters: [:]))
            XCTAssertTrue(didCallLowPriorityHandler)
            
        } else {
            XCTFail("There should be two Handler Wrapper in there")
        }
        
    }
    
    func testCallsResponsibleHandler() throws {
        
        let handler = { (routeResult: RouteResult) -> Void in }
        let priority = 5
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let container = DefaultRoutingHandlerContainer()
        
        var didCallResponsibleForHandler = false
        try container.add(priority: priority,
                          responsibleFor: { result in
                                didCallResponsibleForHandler = true
                                return true
                          },
                          handler: handler)
        
        _ = container.handler(routeResult: routeResult)
        
        XCTAssertTrue(didCallResponsibleForHandler)
        
    }
    
    func testReturnsHandlerIfResponsible() throws {
        
        var didCallHandler = false
        let handler = { (routeResult: RouteResult) -> Void in
            didCallHandler = true
        }
        let priority = 5
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let container = DefaultRoutingHandlerContainer()
        
        try container.add(priority: priority,
                          responsibleFor: { result in
                              return true
                          },
                          handler: handler)
        
        guard let resultHandler = container.handler(routeResult: routeResult) else {
            XCTFail("should return handler")
            return
        }
        
        XCTAssertFalse(didCallHandler)
        resultHandler(routeResult)
        XCTAssertTrue(didCallHandler)
        
    }
    
    func testReturnsNilIfNoHandlerIsResponsible() throws {
        
        
        let handler = { (routeResult: RouteResult) -> Void in }
        let priority = 5
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let container = DefaultRoutingHandlerContainer()
        
        try container.add(priority: priority,
                          responsibleFor: { result in
                            return false
        },
                          handler: handler)
        
        let resultHandler = container.handler(routeResult: routeResult)
        XCTAssertNil(resultHandler)
        
    }
    
    func testReturnsHighPriorityHandlerIfMoreThanOneAreResponsible() throws {
        
        var didCallLowPriorityHandler = false
        let lowPriorityHandler = { (routeResult: RouteResult) -> Void in
            didCallLowPriorityHandler = true
        }
        let lowPriority = 5
        
        var didCallHighPriorityHandler = false
        let highPriorityHandler = { (routeResult: RouteResult) -> Void in
            didCallHighPriorityHandler = true
        }
        let highPriority = 10
        
        let container = DefaultRoutingHandlerContainer()
        
        
        try container.add(priority: lowPriority,
                          responsibleFor: { result in return true},
                          handler: lowPriorityHandler)
        try container.add(priority: highPriority,
                          responsibleFor: { result in return true },
                          handler: highPriorityHandler)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        guard let resultHandler = container.handler(routeResult: routeResult) else {
            XCTFail("should return handler")
            return
        }
        
        XCTAssertFalse(didCallHighPriorityHandler)
        resultHandler(routeResult)
        XCTAssertTrue(didCallHighPriorityHandler)
        
        XCTAssertFalse(didCallLowPriorityHandler)
    }
    
    
    func testReturnsLowPriorityHandlerIfIsTheOnlyResponsibleHandler() throws {
        
        var didCallLowPriorityHandler = false
        let lowPriorityHandler = { (routeResult: RouteResult) -> Void in
            didCallLowPriorityHandler = true
        }
        let lowPriority = 5
        
        var didCallHighPriorityHandler = false
        let highPriorityHandler = { (routeResult: RouteResult) -> Void in
            didCallHighPriorityHandler = true
        }
        let highPriority = 10
        
        let container = DefaultRoutingHandlerContainer()
        
        
        try container.add(priority: lowPriority,
                          responsibleFor: { result in return true},
                          handler: lowPriorityHandler)
        try container.add(priority: highPriority,
                          responsibleFor: { result in return false },
                          handler: highPriorityHandler)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        guard let resultHandler = container.handler(routeResult: routeResult) else {
            XCTFail("should return handler")
            return
        }
        
        XCTAssertFalse(didCallLowPriorityHandler)
        resultHandler(routeResult)
        XCTAssertTrue(didCallLowPriorityHandler)
        
        XCTAssertFalse(didCallHighPriorityHandler)
    }
    
    
    func testReturnsHighestPriorityOfResposibleHandler1() throws {
        
        let lowPriorityHandler = { (routeResult: RouteResult) -> Void in }
        let lowPriority = 5
        
        let highPriorityHandler = { (routeResult: RouteResult) -> Void in}
        let highPriority = 10
        
        let container = DefaultRoutingHandlerContainer()
        
        
        try container.add(priority: lowPriority,
                          responsibleFor: { result in return true},
                          handler: lowPriorityHandler)
        try container.add(priority: highPriority,
                          responsibleFor: { result in return true },
                          handler: highPriorityHandler)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let highestResponsiblePriority = container.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        XCTAssertTrue(highestResponsiblePriority == 10)
       
    }
    
    func testReturnsHighestPriorityOfResposibleHandler2() throws {
        
        let lowPriorityHandler = { (routeResult: RouteResult) -> Void in }
        let lowPriority = 5
        
        let highPriorityHandler = { (routeResult: RouteResult) -> Void in}
        let highPriority = 10
        
        let container = DefaultRoutingHandlerContainer()
        
        
        try container.add(priority: lowPriority,
                          responsibleFor: { result in return true},
                          handler: lowPriorityHandler)
        try container.add(priority: highPriority,
                          responsibleFor: { result in return false },
                          handler: highPriorityHandler)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let highestResponsiblePriority = container.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        XCTAssertTrue(highestResponsiblePriority == 5)
        
    }
    
    func testReturnsHighestPriorityNilWithNoResposibleHandler() throws {
        
        let lowPriorityHandler = { (routeResult: RouteResult) -> Void in }
        let lowPriority = 5
        
        let highPriorityHandler = { (routeResult: RouteResult) -> Void in}
        let highPriority = 10
        
        let container = DefaultRoutingHandlerContainer()
        
        
        try container.add(priority: lowPriority,
                          responsibleFor: { result in return false },
                          handler: lowPriorityHandler)
        try container.add(priority: highPriority,
                          responsibleFor: { result in return false },
                          handler: highPriorityHandler)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let highestResponsiblePriority = container.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        XCTAssertNil(highestResponsiblePriority)
        
    }
    
}
