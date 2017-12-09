//
//  TestReducerProvider.swift
//  VISPER_Redux_Tests
//
//  Created by Jan Bartel on 31.10.17.
//  Copyright © Jan Bartel. This file is distributed under the MIT License
//

import XCTest
@testable import VISPER_Redux

class TestReducerProvider: XCTestCase {
    
    
    func testCreation() {
        
        let container = ReducerContainerImpl()
        XCTAssertNotNil(container)
        
    }
    
    func testAddReducer() {
        
        let container = ReducerContainerImpl()
        container.addReducer(reducer: newTitleFunctionReducer)
        
        let reducers = container.reducers(action: newTitleAction, state: testState)
        XCTAssert(reducers.count == 1)
        
    }
    
    func testAddMoreThanOneReducer() {
        
        let container = ReducerContainerImpl()
        container.addReducer(reducer: newTitleFunctionReducer)
        container.addReducer(reducer: deleteTitleFunctionReducer)
        
        let reducers = container.reducers(action: newTitleAction, state: testState)
        XCTAssert(reducers.count == 1)
        
    }
    
    func testAddReducingFunction() {
        
        let container = ReducerContainerImpl()
        container.addReduceFunction(reduceFunction: newTitleReducer)
        
        let reducers = container.reducers(action: newTitleAction, state: testState)
        XCTAssert(reducers.count == 1)
        
    }
    
    func testAddMoreThanOneReducingFunction() {
        
        let container = ReducerContainerImpl()
        container.addReduceFunction(reduceFunction: newTitleReducer)
        container.addReduceFunction(reduceFunction: deleteTitleReducer)
        
        let reducers = container.reducers(action: newTitleAction, state: testState)
        XCTAssert(reducers.count == 1)
        
    }

    
}
