//
//  DefaultComposedRoutingPresenterTests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 22.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe

class DefaultComposedRoutingPresenterTests: XCTestCase {
    
    func testAddRoutingPresenter() throws {
        
        let mockPresenter1 = MockRoutingPresenter()
        
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        let priority = 10
        composedPresenter.add(routingPresenter: mockPresenter1, priority: priority)
        
        if composedPresenter.routingPresenters.count == 1 {
            
            let wrapper = composedPresenter.routingPresenters[0]
            
            guard let presenter = wrapper.routingPresenter as? MockRoutingPresenter else {
                XCTFail("wrapper should contain our routing observer")
                return
            }
            
            XCTAssertEqual(wrapper.priority, priority)
            XCTAssertEqual(presenter, mockPresenter1)
            
        } else {
            XCTFail("There should be one RoutingObserverWrapper in there")
        }
        
    }
    
    func testAddRoutingPresenterPriority() throws {
        
        let mockPresenter1 = MockRoutingPresenter()
        let priority1 = 5
        
        let mockPresenter2 = MockRoutingPresenter()
        let priority2 = 10
        
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        composedPresenter.add(routingPresenter: mockPresenter1, priority: priority1)
        composedPresenter.add(routingPresenter: mockPresenter2, priority: priority2)
        
        if composedPresenter.routingPresenters.count == 2 {
            
            let wrapper1 = composedPresenter.routingPresenters[0]
            guard let presenter1 = wrapper1.routingPresenter as? MockRoutingPresenter else {
                XCTFail("wrapper should contain our routing observer")
                return
            }
            
            let wrapper2 = composedPresenter.routingPresenters[1]
            guard let presenter2 = wrapper2.routingPresenter as? MockRoutingPresenter else {
                XCTFail("wrapper should contain our routing observer")
                return
            }
            
            XCTAssertEqual(wrapper1.priority, priority2)
            XCTAssertEqual(presenter1, mockPresenter2)
            
            XCTAssertEqual(wrapper2.priority, priority1)
            XCTAssertEqual(presenter2, mockPresenter1)
            
        } else {
            XCTFail("There should be two RoutingObserverWrapper in there")
        }
        
    }
    
    func testCallsIsResponsibleOfChild() throws{
        
        let mockPresenter = MockRoutingPresenter()
        mockPresenter.stubbedIsResponsibleResult = true
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        let priority = 10
        composedPresenter.add(routingPresenter: mockPresenter, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:], routingOption: MockRoutingOption())
        
        let isResponsible = composedPresenter.isResponsible(routeResult: routeResult)
        
        XCTAssert(mockPresenter.invokedIsResponsible)
        XCTAssert(isResponsible)
        
        guard let paramRoutingResult = mockPresenter.invokedIsResponsibleParameters?.routeResult as? DefaultRouteResult else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramRoutingResult, routeResult)
        
    }
    
    func testCallsIsResponsibleOfEachChildUntilAResponsibleChildIsFound() throws{
        
        let firstPresenter = MockRoutingPresenter()
        firstPresenter.stubbedIsResponsibleResult = false
        let firstPriority = 20
        
        let secondPresenter = MockRoutingPresenter()
        secondPresenter.stubbedIsResponsibleResult = true
        let secondPriority = 10
        
        let thirdPresenter = MockRoutingPresenter()
        thirdPresenter.stubbedIsResponsibleResult = true
        let thirdPriority = 0
        
        
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        composedPresenter.add(routingPresenter: secondPresenter, priority: secondPriority)
        composedPresenter.add(routingPresenter: thirdPresenter, priority: thirdPriority)
        composedPresenter.add(routingPresenter: firstPresenter, priority: firstPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:], routingOption: MockRoutingOption())
        
        let isResponsible = composedPresenter.isResponsible(routeResult: routeResult)
        
        XCTAssert(firstPresenter.invokedIsResponsible)
        XCTAssert(secondPresenter.invokedIsResponsible)
        XCTAssertFalse(thirdPresenter.invokedIsResponsible)
        
        XCTAssert(isResponsible)
        
    }
    
    func testCallsIsResponsibleOfEachChildWhenAllReturnFalse() throws {
        
        let firstPresenter = MockRoutingPresenter()
        firstPresenter.stubbedIsResponsibleResult = false
        let firstPriority = 20
        
        let secondPresenter = MockRoutingPresenter()
        secondPresenter.stubbedIsResponsibleResult = false
        let secondPriority = 10
        
        let thirdPresenter = MockRoutingPresenter()
        thirdPresenter.stubbedIsResponsibleResult = false
        let thirdPriority = 0
        
        
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        composedPresenter.add(routingPresenter: secondPresenter, priority: secondPriority)
        composedPresenter.add(routingPresenter: thirdPresenter, priority: thirdPriority)
        composedPresenter.add(routingPresenter: firstPresenter, priority: firstPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:], routingOption: MockRoutingOption())
        
        let isResponsible = composedPresenter.isResponsible(routeResult: routeResult)
        
        XCTAssert(firstPresenter.invokedIsResponsible)
        XCTAssert(secondPresenter.invokedIsResponsible)
        XCTAssert(thirdPresenter.invokedIsResponsible)
        
        XCTAssertFalse(isResponsible)
    }
    

    func testCallsPresentOnChildIfItIsResponsible() throws {
        
        let mockPresenter = MockRoutingPresenter()
        mockPresenter.stubbedIsResponsibleResult = true
        
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        let priority = 10
        composedPresenter.add(routingPresenter: mockPresenter, priority: priority)
        
        let viewController = UIViewController()
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:], routingOption: MockRoutingOption())
        let wireframe = MockWireframe()
        let delegate = MockRoutingDelegate()
        
        var didCallCompletion = false
        try composedPresenter.present(controller: viewController,
                                     routeResult: routeResult,
                                       wireframe: wireframe,
                                        delegate: delegate) {
                                    didCallCompletion = true
        }
        
        XCTAssertTrue(mockPresenter.invokedIsResponsible)
        XCTAssertTrue(mockPresenter.invokedPresent)
        
        XCTAssertNotNil(mockPresenter.invokedPresentParameters?.controller)
        XCTAssertEqual(mockPresenter.invokedPresentParameters?.controller,viewController)
        
        guard let paramRouteResult = mockPresenter.invokedPresentParameters?.routeResult as? DefaultRouteResult else {
            XCTFail()
            return
        }
        XCTAssertEqual(paramRouteResult, routeResult)
        
        guard let paramWireframe = mockPresenter.invokedPresentParameters?.wireframe as? MockWireframe else {
            XCTFail()
            return
        }
        XCTAssertEqual(paramWireframe, wireframe)
        
        guard let paramDelegate = mockPresenter.invokedPresentParameters?.delegate as? MockRoutingDelegate else {
            XCTFail()
            return
        }
        XCTAssertEqual(paramDelegate, delegate)
        
        XCTAssert(didCallCompletion)
    }
    
    
    func testDoesNotCallPresentOnChildIfItIsINotResponsible() throws {
        
        let mockPresenter = MockRoutingPresenter()
        mockPresenter.stubbedIsResponsibleResult = false
        
        let composedPresenter = DefaultComposedRoutingPresenter()
        
        let priority = 10
        composedPresenter.add(routingPresenter: mockPresenter, priority: priority)
        
        let viewController = UIViewController()
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:], routingOption: MockRoutingOption())
        let wireframe = MockWireframe()
        let delegate = MockRoutingDelegate()
        
        var didCallCompletion = false
        try composedPresenter.present(controller: viewController,
                                      routeResult: routeResult,
                                      wireframe: wireframe,
                                      delegate: delegate) {
                                        didCallCompletion = true
        }
        
        XCTAssertTrue(mockPresenter.invokedIsResponsible)
        XCTAssertFalse(mockPresenter.invokedPresent)
        XCTAssertFalse(didCallCompletion)
        
    }
    
    
    func testCallHighPriorizedPresentersFirst() throws {
        
        let firstPresenter = MockRoutingPresenter()
        firstPresenter.stubbedIsResponsibleResult = false
        let heighestPriority = 100
        
        let secondPresenter = MockRoutingPresenter()
        secondPresenter.stubbedIsResponsibleResult = false
        let secondHeighestPriority = 50
        
        let thirdPresenter = MockRoutingPresenter()
        thirdPresenter.stubbedIsResponsibleResult = false
        let lowestPriority = 10
        
        let composedPresenter = DefaultComposedRoutingPresenter()
    
        composedPresenter.add(routingPresenter: thirdPresenter, priority: lowestPriority)
        composedPresenter.add(routingPresenter: firstPresenter, priority: heighestPriority)
        composedPresenter.add(routingPresenter: secondPresenter, priority: secondHeighestPriority)
        
        let viewController = UIViewController()
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:], routingOption: MockRoutingOption())
        let wireframe = MockWireframe()
        let delegate = MockRoutingDelegate()
        
        
        try composedPresenter.present(controller: viewController,
                                      routeResult: routeResult,
                                      wireframe: wireframe,
                                      delegate: delegate) {
                                        
        }
        
        XCTAssertNotNil(firstPresenter.invokedIsResponsibleTime)
        XCTAssertNotNil(secondPresenter.invokedIsResponsibleTime)
        XCTAssertNotNil(thirdPresenter.invokedIsResponsibleTime)
        
        AssertThat(time1: firstPresenter.invokedIsResponsibleTime, isEarlierThan: secondPresenter.invokedIsResponsibleTime)
        AssertThat(time1: firstPresenter.invokedIsResponsibleTime, isEarlierThan: thirdPresenter.invokedIsResponsibleTime)
        AssertThat(time1: secondPresenter.invokedIsResponsibleTime, isEarlierThan: thirdPresenter.invokedIsResponsibleTime)
        
    }
  
    
}
