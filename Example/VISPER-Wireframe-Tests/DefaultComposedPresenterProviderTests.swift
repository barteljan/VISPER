//
//  DefaultComposedPresenterProviderTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 11.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
import VISPER_Core

class DefaultComposedPresenterProviderTests: XCTestCase {
    
    func testAddProvider() throws {
        
        let mockProvider = MockPresenterProvider()
        
        let composedProvider = DefaultComposedPresenterProvider()
        
        let priority = 10
        composedProvider.add(provider: mockProvider, priority: priority)
        
        if composedProvider.providers.count == 1 {
            
            let wrapper = composedProvider.providers[0]
            
            AssertThat(wrapper.presenterProvider, isOfType: MockPresenterProvider.self, andEquals: mockProvider)
            XCTAssertEqual(wrapper.priority, priority)
            
        } else {
            XCTFail("There should be one PresenterProvider Wrapper in there")
        }
        
    }
    
    func testAddProviderPriority() throws {
        
        let mockProvider1 = MockPresenterProvider()
        let priority1 = 5
        
        let mockProvider2 = MockPresenterProvider()
        let priority2 = 10
        
        let composedProvider = DefaultComposedPresenterProvider()
        
        composedProvider.add(provider: mockProvider1, priority: priority1)
        composedProvider.add(provider: mockProvider2, priority: priority2)
        
        if composedProvider.providers.count == 2 {
            
            let wrapper1 = composedProvider.providers[0]
            
            let presenterProvider1 = wrapper1.presenterProvider
            
            let wrapper2 = composedProvider.providers[1]
            let presenterProvider2 = wrapper2.presenterProvider
            
            XCTAssertEqual(wrapper1.priority, priority2)
            AssertThat(presenterProvider1, isOfType: MockPresenterProvider.self, andEqualsNonNil: mockProvider2)
            
            XCTAssertEqual(wrapper2.priority, priority1)
            AssertThat(presenterProvider2, isOfType: MockPresenterProvider.self, andEqualsNonNil: mockProvider1)
            
        } else {
            XCTFail("There should be two ControllerProvider Wrapper in there")
        }
        
    }
    
    func testCallsIsResponsibleOfChild() throws{
        
        let presenterProvider = MockPresenterProvider()
        presenterProvider.stubbedIsResponsibleResult = true
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        
        let controller = UIViewController()
        
        let priority = 10
        composedPresenterProvider.add(provider: presenterProvider, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/this/is/a/path", parameters: [:])
        
        let isResponsible = composedPresenterProvider.isResponsible(routeResult: routeResult, controller: controller)
        
        XCTAssert(presenterProvider.invokedIsResponsible)
        XCTAssert(isResponsible)
    
        AssertThat(presenterProvider.invokedIsResponsibleParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        AssertThat(presenterProvider.invokedIsResponsibleParameters?.controller, isOfType: UIViewController.self, andEquals: controller)
        
    }
    
    func testCallsIsResponsibleOfEachChildUntilAResponsibleWasFound() throws{
        
        
        let firstPresenterProvider = MockPresenterProvider()
        firstPresenterProvider.stubbedIsResponsibleResult = false
        let firstPriority = 20
        
        let secondPresenterProvider = MockPresenterProvider()
        secondPresenterProvider.stubbedIsResponsibleResult = true
        let secondPriority = 10
        
        let thirdPresenterProvider = MockPresenterProvider()
        thirdPresenterProvider.stubbedIsResponsibleResult = true
        let thirdPriority = 0
        
        let controller = UIViewController()
        
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        
        composedPresenterProvider.add(provider: secondPresenterProvider, priority: secondPriority)
        composedPresenterProvider.add(provider: thirdPresenterProvider, priority: thirdPriority)
        composedPresenterProvider.add(provider: firstPresenterProvider, priority: firstPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/this/is/a/path", parameters: [:])
        
        let isResponsible = composedPresenterProvider.isResponsible(routeResult: routeResult, controller: controller)
        
        XCTAssertTrue(firstPresenterProvider.invokedIsResponsible)
        XCTAssertTrue(secondPresenterProvider.invokedIsResponsible)
        XCTAssertFalse(thirdPresenterProvider.invokedIsResponsible)
        
        XCTAssertTrue(isResponsible)
        
    }
    
    func testCallsIsResponsibleOfEachChildWhenAllReturnFalse() throws {
        
        let firstPresenterProvider = MockPresenterProvider()
        firstPresenterProvider.stubbedIsResponsibleResult = false
        let firstPriority = 20
        
        let secondPresenterProvider = MockPresenterProvider()
        secondPresenterProvider.stubbedIsResponsibleResult = false
        let secondPriority = 10
        
        let thirdPresenterProvider = MockPresenterProvider()
        thirdPresenterProvider.stubbedIsResponsibleResult = false
        let thirdPriority = 0
        
        let controller = UIViewController()
        
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        
        composedPresenterProvider.add(provider: secondPresenterProvider, priority: secondPriority)
        composedPresenterProvider.add(provider: thirdPresenterProvider, priority: thirdPriority)
        composedPresenterProvider.add(provider: firstPresenterProvider, priority: firstPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/this/is/a/path", parameters: [:])
        
        let isResponsible = composedPresenterProvider.isResponsible(routeResult: routeResult, controller:  controller)
        
        XCTAssert(firstPresenterProvider.invokedIsResponsible)
        XCTAssert(secondPresenterProvider.invokedIsResponsible)
        XCTAssert(thirdPresenterProvider.invokedIsResponsible)
        
        XCTAssertFalse(isResponsible)
    }
    
    func testCallsMakePresentersOnChildIfItIsResponsible() throws {
        
        let presenterProvider = MockPresenterProvider()
        presenterProvider.stubbedIsResponsibleResult = true
        presenterProvider.stubbedMakePresentersResult = [MockPresenter()]
        
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        let controller = UIViewController()
        
        let priority = 10
        composedPresenterProvider.add(provider: presenterProvider, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/thats/a/pattern", parameters: ["id" : "55"])
        
        let presenters = try composedPresenterProvider.makePresenters(routeResult: routeResult, controller: controller)
        
        AssertThat(presenters[0], isOfType: MockPresenter.self, andEqualsNonNil: presenterProvider.stubbedMakePresentersResult.first as? MockPresenter)
        
        XCTAssertTrue(presenterProvider.invokedIsResponsible)
        XCTAssertTrue(presenterProvider.invokedMakePresenters)
        
        AssertThat(presenterProvider.invokedMakePresentersParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        
    }
    
    
    func testDoesNotCallMakePresentersOnChildIfItIsINotResponsible() throws {
        
        let presenterProvider = MockPresenterProvider()
        presenterProvider.stubbedIsResponsibleResult = false
        
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        
        let priority = 10
        composedPresenterProvider.add(provider: presenterProvider, priority: priority)
        
        let routeResult = DefaultRouteResult(routePattern: "/thats/a/pattern", parameters: ["id" : "55"])
        
        let controller = UIViewController()
        
        
        XCTAssertNoThrow(try composedPresenterProvider.makePresenters(routeResult: routeResult,controller: controller))
        
        XCTAssertTrue(presenterProvider.invokedIsResponsible)
        XCTAssertFalse(presenterProvider.invokedMakePresenters)
        
    }
    
    func testCallHighPriorizedControllerProvidersFirst() throws {
        
        let firstPresenterProvider = MockPresenterProvider()
        firstPresenterProvider.stubbedIsResponsibleResult = false
        let heighestPriority = 100
        
        let secondPresenterProvider = MockPresenterProvider()
        secondPresenterProvider.stubbedIsResponsibleResult = false
        let secondHeighestPriority = 50
        
        let thirdPresenterProvider = MockPresenterProvider()
        thirdPresenterProvider.stubbedIsResponsibleResult = false
        let lowestPriority = 10
        
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        
        composedPresenterProvider.add(provider: thirdPresenterProvider, priority: lowestPriority)
        composedPresenterProvider.add(provider: firstPresenterProvider, priority: heighestPriority)
        composedPresenterProvider.add(provider: secondPresenterProvider, priority: secondHeighestPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/thats/a/pattern", parameters: ["id" : "55"])
        let controller = UIViewController()
        XCTAssertNoThrow(try composedPresenterProvider.makePresenters(routeResult: routeResult, controller: controller))
        
        XCTAssertNotNil(firstPresenterProvider.invokedIsResponsibleTime)
        XCTAssertNotNil(secondPresenterProvider.invokedIsResponsibleTime)
        XCTAssertNotNil(thirdPresenterProvider.invokedIsResponsibleTime)
        
        AssertThat(time1: firstPresenterProvider.invokedIsResponsibleTime, isEarlierThan: secondPresenterProvider.invokedIsResponsibleTime)
        AssertThat(time1: firstPresenterProvider.invokedIsResponsibleTime, isEarlierThan: thirdPresenterProvider.invokedIsResponsibleTime)
        AssertThat(time1: secondPresenterProvider.invokedIsResponsibleTime, isEarlierThan: thirdPresenterProvider.invokedIsResponsibleTime)
        
    }

    
    func testReturnsEmptyArrayWithNoResposibleProvider() throws {
        
        let lowPriorityPresenterProvider = MockPresenterProvider()
        lowPriorityPresenterProvider.stubbedIsResponsibleResult = false
        let lowPriority = 5
        
        let highPriorityPresenterProvider = MockPresenterProvider()
        lowPriorityPresenterProvider.stubbedIsResponsibleResult = false
        let highPriority = 10
        
        let composedPresenterProvider = DefaultComposedPresenterProvider()
        
        composedPresenterProvider.add(provider: lowPriorityPresenterProvider, priority: lowPriority)
        composedPresenterProvider.add(provider: highPriorityPresenterProvider, priority: highPriority)
        
        let routeResult = DefaultRouteResult(routePattern: "/test/pattern1", parameters: [:])
        let controller = UIViewController()
        
        var result = [Presenter]()
        XCTAssertNoThrow(result = try composedPresenterProvider.makePresenters(routeResult: routeResult,controller: controller))
        XCTAssertTrue(result.count == 0)
    }
    
}
