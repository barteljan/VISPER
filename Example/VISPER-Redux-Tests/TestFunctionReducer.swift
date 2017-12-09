import XCTest
@testable import VISPER_Redux

class TestFunctionReducer: XCTestCase {

    func testReducerCreation() {
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container,action,state in
            return state
        }
        
        let actionReducer = ActionReducer(reducer)
        
        XCTAssertNotNil(actionReducer)
    }
    
    func testIsResponsibleForCorrectActionStatePair() {
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container,action,state in
            return state
        }
        
        let correctState = TestState(title: "startTitle")
        let correctAction = NewTitleAction(newTitle: "newTitle")
        
        XCTAssertTrue(reducer.isResponsible(action: correctAction, state: correctState), "reducer should be responsible for TestState and NewTitleAction")
    }
    
    func testIsNotResponsibleForFalseActionStatePair() {
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container, action, state in
            return state
        }
        
        let correctState = TestState(title: "startTitle")
        let wrongState = "Ein String ist hier gerade der falsche State"
        let correctAction = NewTitleAction(newTitle: "newTitle")
        let wrongAction = DeleteTitleAction()
        
        XCTAssertFalse(reducer.isResponsible(action: wrongAction, state: correctState), "reducer should not be responsible for this crap")
        XCTAssertFalse(reducer.isResponsible(action: wrongAction, state: wrongState), "reducer should not be responsible for this crap")
        XCTAssertFalse(reducer.isResponsible(action: correctAction, state: wrongState), "reducer should not be responsible for this crap")
    }
    
    func testReduceFuntionIsCalled() {
        
        var didCallReduceFunction = false
        let container = MockReducerContainer()
        
        let reducer = FunctionReducer<TestState,NewTitleAction> { container, action, state in
            didCallReduceFunction = true
            return state
        }
        
        let correctState = TestState(title: "startTitle")
        let correctAction = NewTitleAction(newTitle: "newTitle")
        
        let _ = reducer.reduce(provider: container,action: correctAction, state: correctState)
        XCTAssertTrue(didCallReduceFunction)
    }
    
    func testNewStateIsReduced() {
        
        let reducer = newTitleFunctionReducer
        
        let container = MockReducerContainer()
        let correctState = TestState(title: "startTitle")
        let correctAction = NewTitleAction(newTitle: "newTitle")
        
        let newState = reducer.reduce(provider: container, action: correctAction, state: correctState)
        XCTAssertTrue(correctState.title == "startTitle")
        XCTAssertTrue(newState.title == "newTitle")
    }
    
}
