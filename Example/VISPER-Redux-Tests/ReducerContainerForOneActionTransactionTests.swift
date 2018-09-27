//
//  ReducerContainerForOneActionTransactionTests.swift
//  VISPER-Redux-Tests
//
//  Created by bartel on 27.09.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Redux

class ReducerContainerForOneActionTransactionTests: XCTestCase {
    
    func testAddActionReducerCallsSubReducerContainer() {
        
        let subReducerContainer = MockReducerContainer()
        
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        let actionReducer = MockActionReducer()
        
        container.addReducer(reducer: actionReducer)
        
        XCTAssertNotNil(subReducerContainer.invokedAddReducerReducerRParameters?.reducer as? MockActionReducer)
        XCTAssert((subReducerContainer.invokedAddReducerReducerRParameters?.reducer as? MockActionReducer) == actionReducer)
    }
    
    
    
    func testAddAsyncReducerCallsSubReducerContainer() {
        
        let subReducerContainer = MockReducerContainer()
        
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        let actionReducer = MockAsyncReducerCallingTheCompletion()
        
        container.addReducer(reducer: actionReducer)
        
        XCTAssertNotNil(subReducerContainer.invokedAddReducerReducerRAsyncParameters?.reducer as? MockAsyncReducerCallingTheCompletion)
        XCTAssert((subReducerContainer.invokedAddReducerReducerRAsyncParameters?.reducer as? MockAsyncReducerCallingTheCompletion) == actionReducer)
    }
    
    
    func testAddReduceFunctionCallsSubReducerContainer() {
        
        let subReducerContainer = MockReducerContainer()
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        XCTAssertFalse(subReducerContainer.invokedAddReduceFunction)
        
        container.addReduceFunction { (provider:ReducerProvider, action: NewTitleAction, state: TestState) -> TestState in
            return TestState(title: action.newTitle)
        }
        
        XCTAssertTrue(subReducerContainer.invokedAddReduceFunction)
        
    }
    
    func testReducersReturnsActionReducersFromSubReducerContainer() {
        
        let subReducerContainer = MockReducerContainer()
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        let actionReducer1 = AnyActionReducer(MockActionReducer())
        let actionReducer2 = AnyActionReducer(MockActionReducer())
        let actionReducer3 = AnyActionReducer(MockActionReducer())
        let actionReducer4 = AnyActionReducer(MockActionReducer())
        
        subReducerContainer.stubbedReducersActionActionStateStateTypeResult = [actionReducer1,actionReducer2,actionReducer3,actionReducer4]
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        let reducers: [AnyActionReducer] = container.reducers(action: action, state: state)
        
        XCTAssert(reducers.count == 4)
        
    }
    
    func testReducersReturnsAsyncReducersFromSubReducerContainer() {
        
        let subReducerContainer = MockReducerContainer()
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        let actionReducer1 = AnyAsyncActionReducer(MockAsyncReducerCallingTheCompletion())
        let actionReducer2 = AnyAsyncActionReducer(MockAsyncReducerCallingTheCompletion())
        let actionReducer3 = AnyAsyncActionReducer(MockAsyncReducerCallingTheCompletion())
        let actionReducer4 = AnyAsyncActionReducer(MockAsyncReducerCallingTheCompletion())
        
        subReducerContainer.stubbedReducersActionActionStateStateTypeAsyncResult = [actionReducer1,actionReducer2,actionReducer3,actionReducer4]
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        let reducers: [AnyAsyncActionReducer] = container.reducers(action: action, state: state)
        
        XCTAssert(reducers.count == 4)
        
    }
    
    func testReduceCallsSubReducerContainerReduce() {
        
        let subReducerContainer = MockReducerContainer()
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        let stubbedNewState = TestState(title: "newTitle")
        subReducerContainer.stubbedReduceActionResult = stubbedNewState
        
        let newState = container.reduce(action: action, state: state, completion: completion)
        
        XCTAssertEqual(stubbedNewState, newState)
        XCTAssertTrue(subReducerContainer.invokedReduceAction)
        XCTAssertEqual(subReducerContainer.invokedReduceActionParameters?.action as? NewTitleAction, action)
        XCTAssertEqual(subReducerContainer.invokedReduceActionParameters?.state as? TestState, state)
        XCTAssertTrue(didCallCompletion)
        
    }
    
    func testReduceCallsSubReducerContainerReduce2() {
        
        let subReducerContainer = MockReducerContainer()
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
      
        let stubbedNewState = TestState(title: "newTitle")
        subReducerContainer.stubbedReduceActionResult = stubbedNewState
        
        let newState = container.reduce(action: action, state: state)
        
        XCTAssertEqual(stubbedNewState, newState)
        XCTAssertTrue(subReducerContainer.invokedReduceAction)
        XCTAssertEqual(subReducerContainer.invokedReduceActionParameters?.action as? NewTitleAction, action)
        XCTAssertEqual(subReducerContainer.invokedReduceActionParameters?.state as? TestState, state)
        
    }
    
    func testCallsCompletionIfSubReducersCallTheirCompletions() {
        
        let subReducerContainer = ReducerContainerImpl()
        
        subReducerContainer.dispatchStateChangeActionCallback = { action in
            
        }
        
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        container.addReducer(reducer: MockActionReducer())
        container.addReducer(reducer: MockAsyncReducerCallingTheCompletion())
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        _ = container.reduce(action: action, state: state, completion: completion)
        
        XCTAssertTrue(didCallCompletion)
        
    }
    
    func testCallsCompletionIfSubReducersCallTheirCompletions2() {
        
        let subReducerContainer = ReducerContainerImpl()
        
        subReducerContainer.dispatchStateChangeActionCallback = { action in
            
        }
        
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        container.addReducer(reducer: MockActionReducer())
        container.addReducer(reducer: MockAsyncReducerCallingTheCompletion())
        container.addReducer(reducer: MockAsyncReducerCallingTheCompletion())
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        _ = container.reduce(action: action, state: state, completion: completion)
        
        XCTAssertTrue(didCallCompletion)
        
    }
    
    
    func testDoesNotCallCompletionIfOneSubReducersDoesNotCallCompletion() {
        
        let subReducerContainer = ReducerContainerImpl()
        
        subReducerContainer.dispatchStateChangeActionCallback = { action in
            
        }
        
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        container.addReducer(reducer: MockActionReducer())
        container.addReducer(reducer: MockAsyncReducerNotCallingTheCompletion())
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        _ = container.reduce(action: action, state: state, completion: completion)
        
        XCTAssertFalse(didCallCompletion)
        
    }
    
    func testDoesNotCallCompletionIfOneSubReducersDoesNotCallCompletion2() {
        
        let subReducerContainer = ReducerContainerImpl()
        
        subReducerContainer.dispatchStateChangeActionCallback = { action in
            
        }
        
        let container = ReducerContainerForOneActionTransaction(reducerContainer: subReducerContainer, completion: {})
        
        container.addReducer(reducer: MockActionReducer())
        container.addReducer(reducer: MockAsyncReducerCallingTheCompletion())
        container.addReducer(reducer: MockAsyncReducerNotCallingTheCompletion())
        
        let action = NewTitleAction(newTitle: "title")
        let state = TestState(title: "oldTitle")
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        _ = container.reduce(action: action, state: state, completion: completion)
        
        XCTAssertFalse(didCallCompletion)
        
    }


    
}
