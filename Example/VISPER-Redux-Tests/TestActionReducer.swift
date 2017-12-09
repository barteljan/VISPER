//
//  TestAnyActionReducer.swift
//  VISPER_Redux_Tests
//
//  Created by Jan Bartel on 31.10.17.
//  Copyright © Jan Bartel. This file is distributed under the MIT License
//

import XCTest
@testable import VISPER_Redux

class TestActionReducer: XCTestCase {
    

    func testReducerCreation() {
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container,action,state in
            return state
        }
        
        let anyReducer = ActionReducer(reducer)
        
        XCTAssertNotNil(anyReducer)
    }
    
    
    func testIsResponsibleForCorrectActionStatePair() {
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container,action,state in
            return state
        }
        
        let anyReducer = ActionReducer(reducer)
        
        let correctState = TestState(title: "startTitle")
        let correctAction = NewTitleAction(newTitle: "newTitle")
        
        XCTAssertTrue(anyReducer.isResponsible(action: correctAction, state: correctState), "reducer should be responsible for TestState and NewTitleAction")
    }
    
    func testIsNotResponsibleForFalseActionStatePair() {
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container,action,state in
            return state
        }
        
        let anyReducer = ActionReducer(reducer)
        
        let correctState = TestState(title: "startTitle")
        let wrongState = "Ein String ist hier gerade der falsche State"
        let correctAction = NewTitleAction(newTitle: "newTitle")
        let wrongAction = DeleteTitleAction()
        
        XCTAssertFalse(anyReducer.isResponsible(action: wrongAction, state: correctState), "reducer should not be responsible for this crap")
        XCTAssertFalse(anyReducer.isResponsible(action: wrongAction, state: wrongState), "reducer should not be responsible for this crap")
        XCTAssertFalse(anyReducer.isResponsible(action: correctAction, state: wrongState), "reducer should not be responsible for this crap")
    }
    
    func testReduceFunctionIsCalled() {
        
        var didCallReduceFunction = false
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container,action,state in
            didCallReduceFunction = true
            return state
        }
        let container = MockReducerContainer()
        let anyReducer = ActionReducer(reducer)
        
        let correctState = TestState(title: "startTitle")
        let correctAction = NewTitleAction(newTitle: "newTitle")
        
        let _ = anyReducer.reduce(provider:container,action: correctAction, state: correctState)
        XCTAssertTrue(didCallReduceFunction)
    }
    
    func testNewStateIsReduced() {
        
        let reducer = newTitleFunctionReducer
        let container = MockReducerContainer()
        let anyReducer = ActionReducer(reducer)
        
        let correctState = TestState(title: "startTitle")
        let correctAction = NewTitleAction(newTitle: "newTitle")
        
        let newState = anyReducer.reduce(provider:container, action: correctAction, state: correctState)
        XCTAssertTrue(correctState.title == "startTitle")
        XCTAssertTrue(newState.title == "newTitle")
    }
    
    
}
