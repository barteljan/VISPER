//
//  StoreTests.swift
//  VISPER_Redux_Tests
//
//  Created by Jan Bartel on 31.10.17.
//  Copyright © Jan Bartel. This file is distributed under the MIT License
//

import Foundation
import XCTest
import VISPER_Reactive
@testable import VISPER_Redux
import VISPER_Core

class TestStore: XCTestCase {
    
    func testCreation() {
        
        let ReducerProvider = MockReducerContainer()
        
        let store = Store(appReducer: { (container, action, state) in
                                            return state
                          },
                          intialState: testState,
                          reducerContainer: ReducerProvider)
        XCTAssertNotNil(store)
        
    }
    
    
    func testComnpleteStoreUsage(){
        
        let reducerProvider = ReducerContainerImpl()
        reducerProvider.addReducer(reducer: newTitleFunctionReducer)
        
        let store = Store(appReducer: { (container: ReducerProvider, action: Action, state: TestState) in
            
                                            let reducers: [AnyActionReducer] = container.reducers(action: action, state: testState)
            
                                            var newState = state
                                            for reducer in reducers {
                                                newState = reducer.reduce(provider: container, action: action, state: state)
                                            }
            
                                            return newState
                                        },
                              intialState: testState,
                              reducerContainer: reducerProvider)
        
        let expect = self.expectation(description: "didCallSubscription")
        
        var secondCall = false
        store.observableState.subscribe { (newState) in
            if secondCall {
                XCTAssert(newState.title == newTitleAction.newTitle)
                expect.fulfill()
            }
            secondCall = true
        }
        
        store.dispatch(newTitleAction)
        
        self.wait(for: [expect], timeout: 1.0)
        
        
    }
    
    func testAppReducerIsCalled() {
        
        let ReducerProvider = MockReducerContainer()
        
        var didCallAppReducer = false
        
        let store = Store(appReducer: { (container, action, state) in
                              didCallAppReducer = true
                              return state
                          },
                         intialState: testState,
                         reducerContainer: ReducerProvider)
        
        
        
        let expect = self.expectation(description: "didCallSubscription")
        
        var secondCall = false
        store.observableState.subscribe { (newState) in
            if secondCall {
                XCTAssertTrue(didCallAppReducer)
                expect.fulfill()
            }
            secondCall = true
        }
        
        store.dispatch(newTitleAction)
        
        self.wait(for: [expect], timeout: 1.0)
    }
    
    func testIfCorrectContainerIsCalled() {
        
        let ReducerProvider = MockReducerContainer()
        
        var didCallAppReducer = false
        
        let store = Store(appReducer: { (container, action, state) in
                            didCallAppReducer = true
                            return state
                           },
                        intialState: testState,
                        reducerContainer: ReducerProvider)
        
        let expect = self.expectation(description: "didCallSubscription")
        
        var secondCall = false
        store.observableState.subscribe { (newState) in
            if secondCall {
                XCTAssertTrue(didCallAppReducer)
                expect.fulfill()
            }
            secondCall = true
        }
        
        store.dispatch(newTitleAction)
        
        self.wait(for: [expect], timeout: 1.0)
        
    }
    
    func testIfStateIsSetCorrectly(){
        
        let ReducerProvider = MockReducerContainer()
        
        let store = Store(appReducer: { (container, action, state) in
                            return TestState(title:"DerStateIstNeu")
                          },
                           intialState: testState,
                           reducerContainer: ReducerProvider)
        
        let expect = self.expectation(description: "didCallSubscription")
        
        var secondCall = false
        store.observableState.subscribe { (newState) in
            if secondCall {
                XCTAssert(newState.title == "DerStateIstNeu")
                expect.fulfill()
            }
            secondCall = true
        }
        
        store.dispatch(newTitleAction)
        
        self.wait(for: [expect], timeout: 1.0)
        
    }
}
