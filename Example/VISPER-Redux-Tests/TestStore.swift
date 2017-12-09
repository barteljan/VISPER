//
//  StoreTests.swift
//  VISPER_Redux_Tests
//
//  Created by Jan Bartel on 31.10.17.
//  Copyright © Jan Bartel. This file is distributed under the MIT License
//

import Foundation
import XCTest
@testable import VISPER_Redux

class TestStore: XCTestCase {
    
    func testCreation() {
        
        let ReducerProvider = MockReducerContainer()
        
        let store = Store(appReducer: { (container, action, state) in
                                            return state
                          },
                          observable: ObservableProperty(testState),
                     reducerProvider: ReducerProvider)
        XCTAssertNotNil(store)
        
    }
    
    
    func testComnpleteStoreUsage(){
        
        let reducerProvider = ReducerContainerImpl()
        reducerProvider.addReducer(reducer: newTitleFunctionReducer)
        
        let store = Store(appReducer: { (container, action, state) in
            
                                            let reducers = container.reducers(action: action, state: testState)
            
                                            var newState = state
                                            for reducer in reducers {
                                                newState = reducer.reduce(provider: container, action: action, state: state)
                                            }
            
                                            return newState
                                        },
                          observable: ObservableProperty(testState),
                          reducerProvider: reducerProvider)
        
        store.dispatch(newTitleAction)
        let newState = store.observable.value
        XCTAssert(newState.title == newTitleAction.newTitle)
        
        
    }
    
    func testAppReducerIsCalled() {
        
        let ReducerProvider = MockReducerContainer()
        
        var didCallAppReducer = false
        
        let store = Store(appReducer: { (container, action, state) in
                              didCallAppReducer = true
                              return state
                          },
                       observable: ObservableProperty(testState),
                 reducerProvider: ReducerProvider)
        
        store.dispatch(newTitleAction)
        
        XCTAssertTrue(didCallAppReducer)
        
    }
    
    func testIfCorrectContainerIsCalled() {
        
        let ReducerProvider = MockReducerContainer()
        
        var didCallAppReducer = false
        
        let store = Store(appReducer: { (container, action, state) in
                            didCallAppReducer = true
                            return state
                           },
                          observable: ObservableProperty(testState),
                          reducerProvider: ReducerProvider)
        
        store.dispatch(newTitleAction)
        
        XCTAssertTrue(didCallAppReducer)
        
    }
    
    func testIfStateIsSetCorrectly(){
        
        let ReducerProvider = MockReducerContainer()
        
        let store = Store(appReducer: { (container, action, state) in
                            return TestState(title:"DerStateIstNeu")
                          },
                          observable: ObservableProperty(testState),
                          reducerProvider: ReducerProvider)
        
        store.dispatch(newTitleAction)
        let newState = store.observable.value
        XCTAssert(newState.title == "DerStateIstNeu")
        
        
    }
}
