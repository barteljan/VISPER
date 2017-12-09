//
//  DefaultComposedControllerProviderTests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 30.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
import VISPER_Wireframe_Core

class DefaultComposedControllerProviderTests: XCTestCase {
    
    func testAddControllerProvider() throws {
        
        let mockProvider = MockControllerProvider()
        
        let composedProvider = DefaultComposedControllerProvider()
        
        let priority = 10
        composedProvider.add(controllerProvider: mockProvider, priority: priority)
        
        if composedProvider.routingProviders.count == 1 {
            
            let wrapper = composedProvider.routingProviders[0]
            
            guard let controllerProvider = wrapper.controllerProvider as? MockControllerProvider else {
                XCTFail("wrapper should contain our controller provider")
                return
            }
            
            XCTAssertEqual(wrapper.priority, priority)
            XCTAssertEqual(controllerProvider, mockProvider)
            
        } else {
            XCTFail("There should be one ControllerProvider Wrapper in there")
        }
        
    }
    
    func testAddControllerProviderPriority() throws {
        
        
        let mockProvider1 = MockControllerProvider()
        let priority1 = 5
        
        let mockProvider2 = MockControllerProvider()
        let priority2 = 10
        
        let composedProvider = DefaultComposedControllerProvider()
        
        composedProvider.add(controllerProvider: mockProvider1, priority: priority1)
        composedProvider.add(controllerProvider: mockProvider2, priority: priority2)
        
        if composedProvider.routingProviders.count == 2 {
            
            let wrapper1 = composedProvider.routingProviders[0]
            guard let controllerProvider1 = wrapper1.controllerProvider as? MockControllerProvider else {
                XCTFail("wrapper should contain our controller provider")
                return
            }
            
            let wrapper2 = composedProvider.routingProviders[1]
            guard let controllerProvider2 = wrapper2.controllerProvider as? MockControllerProvider else {
                XCTFail("wrapper should contain our controller provider")
                return
            }
            
            XCTAssertEqual(wrapper1.priority, priority2)
            XCTAssertEqual(controllerProvider1, mockProvider2)
            
            XCTAssertEqual(wrapper2.priority, priority1)
            XCTAssertEqual(controllerProvider2, mockProvider1)
            
        } else {
            XCTFail("There should be two ControllerProvider Wrapper in there")
        }
        
    }
    
    func testCallsIsResponsibleOfChild() throws{
        
        let controllerProvider = MockControllerProvider()
        controllerProvider.stubbedIsResponsibleResult = true
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        let priority = 10
        composedControllerProvider.add(controllerProvider: controllerProvider, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/this/is/a/path", parameters: [:])
        
        let isResponsible = composedControllerProvider.isResponsible(routeResult: routeResult)
        
        XCTAssert(controllerProvider.invokedIsResponsible)
        XCTAssert(isResponsible)
        
        guard let paramRouteResult = controllerProvider.invokedIsResponsibleParameters?.routeResult as? DefaultRouteResult else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(paramRouteResult, routeResult)
        
    }
    
    func testCallsIsResponsibleOfEachChildUntilAResponsibleChildIsFound() throws{
        
        let firstControllerProvider = MockControllerProvider()
        firstControllerProvider.stubbedIsResponsibleResult = false
        let firstPriority = 20
        
        let secondControllerProvider = MockControllerProvider()
        secondControllerProvider.stubbedIsResponsibleResult = true
        let secondPriority = 10
        
        let thirdControllerProvider = MockControllerProvider()
        thirdControllerProvider.stubbedIsResponsibleResult = true
        let thirdPriority = 0
        
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        composedControllerProvider.add(controllerProvider: secondControllerProvider, priority: secondPriority)
        composedControllerProvider.add(controllerProvider: thirdControllerProvider, priority: thirdPriority)
        composedControllerProvider.add(controllerProvider: firstControllerProvider, priority: firstPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/this/is/a/path", parameters: [:])
        
        let isResponsible = composedControllerProvider.isResponsible(routeResult: routeResult)
        
        XCTAssert(firstControllerProvider.invokedIsResponsible)
        XCTAssert(secondControllerProvider.invokedIsResponsible)
        XCTAssertFalse(thirdControllerProvider.invokedIsResponsible)
        
        XCTAssert(isResponsible)
        
    }
    
    func testCallsIsResponsibleOfEachChildWhenAllReturnFalse() throws {
        
        let firstControllerProvider = MockControllerProvider()
        firstControllerProvider.stubbedIsResponsibleResult = false
        let firstPriority = 20
        
        let secondControllerProvider = MockControllerProvider()
        secondControllerProvider.stubbedIsResponsibleResult = false
        let secondPriority = 10
        
        let thirdControllerProvider = MockControllerProvider()
        thirdControllerProvider.stubbedIsResponsibleResult = false
        let thirdPriority = 0
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        composedControllerProvider.add(controllerProvider: secondControllerProvider, priority: secondPriority)
        composedControllerProvider.add(controllerProvider: thirdControllerProvider, priority: thirdPriority)
        composedControllerProvider.add(controllerProvider: firstControllerProvider, priority: firstPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/this/is/a/path", parameters: [:])
        
        let isResponsible = composedControllerProvider.isResponsible(routeResult: routeResult)
        
        XCTAssert(firstControllerProvider.invokedIsResponsible)
        XCTAssert(secondControllerProvider.invokedIsResponsible)
        XCTAssert(thirdControllerProvider.invokedIsResponsible)
        
        XCTAssertFalse(isResponsible)
    }
    
    func testCallsMakeControllerOnChildIfItIsResponsible() throws {
        
        let controllerProvider = MockControllerProvider()
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        let priority = 10
        composedControllerProvider.add(controllerProvider: controllerProvider, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/thats/a/pattern", parameters: ["id" : "55"])
        
        let controller = try composedControllerProvider.makeController(routeResult: routeResult)
        
        XCTAssertEqual(controllerProvider.stubbedMakeControllerResult, controller)
        
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        XCTAssertTrue(controllerProvider.invokedMakeController)
        
        guard let paramRouteResult = controllerProvider.invokedMakeControllerParameters?.routeResult as? DefaultRouteResult else {
            XCTFail()
            return
        }
        XCTAssertEqual(paramRouteResult, routeResult)
    
    }
    
    
    func testDoesNotCallMakeControllerOnChildIfItIsINotResponsible() throws {
        
        let controllerProvider = MockControllerProvider()
        controllerProvider.stubbedIsResponsibleResult = false
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        let priority = 10
        composedControllerProvider.add(controllerProvider: controllerProvider, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/thats/a/pattern", parameters: ["id" : "55"])
        
        XCTAssertThrowsError(try composedControllerProvider.makeController(routeResult: routeResult),
                             "Should throw  error") { error in
            switch error {
            case DefaultComposedControllerProviderError.noControllerFoundFor(let result):
                AssertThat(result, isOfType: DefaultRouteResult.self, andEquals: routeResult)
            default:
                XCTFail("should throw an DefaultComposedControllerProviderError.noControllerFoundFor error")
            }
            
            XCTAssert(error is DefaultComposedControllerProviderError)
        }
        
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        XCTAssertFalse(controllerProvider.invokedMakeController)
        
    }
    
    func testCallHighPriorizedControllerProvidersFirst() throws {
        
        let firstControllerProvider = MockControllerProvider()
        firstControllerProvider.stubbedIsResponsibleResult = false
        let heighestPriority = 100
        
        let secondControllerProvider = MockControllerProvider()
        secondControllerProvider.stubbedIsResponsibleResult = false
        let secondHeighestPriority = 50
        
        let thirdControllerProvider = MockControllerProvider()
        thirdControllerProvider.stubbedIsResponsibleResult = false
        let lowestPriority = 10
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        composedControllerProvider.add(controllerProvider: thirdControllerProvider, priority: lowestPriority)
        composedControllerProvider.add(controllerProvider: firstControllerProvider, priority: heighestPriority)
        composedControllerProvider.add(controllerProvider: secondControllerProvider, priority: secondHeighestPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/thats/a/pattern", parameters: ["id" : "55"])
        
        XCTAssertThrowsError(try composedControllerProvider.makeController(routeResult: routeResult))

        XCTAssertNotNil(firstControllerProvider.invokedIsResponsibleTime)
        XCTAssertNotNil(secondControllerProvider.invokedIsResponsibleTime)
        XCTAssertNotNil(thirdControllerProvider.invokedIsResponsibleTime)
        
        AssertThat(time1: firstControllerProvider.invokedIsResponsibleTime, isEarlierThan: secondControllerProvider.invokedIsResponsibleTime)
        AssertThat(time1: firstControllerProvider.invokedIsResponsibleTime, isEarlierThan: thirdControllerProvider.invokedIsResponsibleTime)
        AssertThat(time1: secondControllerProvider.invokedIsResponsibleTime, isEarlierThan: thirdControllerProvider.invokedIsResponsibleTime)
        
    }
    
    
    func testReturnsHighestPriorityOfResposibleHandler1() throws {
        
        let lowPriorityControllerProvider = MockControllerProvider()
        lowPriorityControllerProvider.stubbedIsResponsibleResult = true
        let lowPriority = 5
        
        let highPriorityControllerProvider = MockControllerProvider()
        highPriorityControllerProvider.stubbedIsResponsibleResult = true
        let highPriority = 10
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        composedControllerProvider.add(controllerProvider: lowPriorityControllerProvider, priority: lowPriority)
        composedControllerProvider.add(controllerProvider: highPriorityControllerProvider, priority: highPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let highestResponsiblePriority = composedControllerProvider.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        
        XCTAssertTrue(highestResponsiblePriority == 10)
        
    }
    
    func testReturnsHighestPriorityOfResposibleHandler2() throws {
        
        let lowPriorityControllerProvider = MockControllerProvider()
        lowPriorityControllerProvider.stubbedIsResponsibleResult = true
        let lowPriority = 5
        
        let highPriorityControllerProvider = MockControllerProvider()
        highPriorityControllerProvider.stubbedIsResponsibleResult = false
        let highPriority = 10
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        composedControllerProvider.add(controllerProvider: lowPriorityControllerProvider, priority: lowPriority)
        composedControllerProvider.add(controllerProvider: highPriorityControllerProvider, priority: highPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let highestResponsiblePriority = composedControllerProvider.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        
        XCTAssertTrue(highestResponsiblePriority == 5)
        
    }
    
    func testReturnsNilWithNoResposibleProvider() throws {
        
        let lowPriorityControllerProvider = MockControllerProvider()
        lowPriorityControllerProvider.stubbedIsResponsibleResult = false
        let lowPriority = 5
        
        let highPriorityControllerProvider = MockControllerProvider()
        lowPriorityControllerProvider.stubbedIsResponsibleResult = false
        let highPriority = 10
        
        let composedControllerProvider = DefaultComposedControllerProvider()
        
        composedControllerProvider.add(controllerProvider: lowPriorityControllerProvider, priority: lowPriority)
        composedControllerProvider.add(controllerProvider: highPriorityControllerProvider, priority: highPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        
        let highestResponsiblePriority = composedControllerProvider.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        XCTAssertNil(highestResponsiblePriority)
        
    }
    
    
}
