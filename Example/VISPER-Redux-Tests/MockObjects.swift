//
//  MockObjects.swift
//  VISPER_Redux_Tests
//
//  Created by Jan Bartel on 31.10.17.
//  Copyright © Jan Bartel. This file is distributed under the MIT License
//

import Foundation
@testable import VISPER_Redux

struct TestState {
    var title : String
}

let testState = TestState(title: "startingTitle")

struct NewTitleAction : Action{
    let newTitle : String
}

let newTitleAction = NewTitleAction(newTitle: "newTitle")

struct DeleteTitleAction : Action {
    
}

let deleteTitleAction = DeleteTitleAction()

let newTitleReducer = { (provider: ReducerProvider,action: NewTitleAction, state: TestState) -> TestState in
    
    var newState = state
    newState.title = action.newTitle
    return newState

}

let newTitleFunctionReducer = FunctionReducer(reduceFunction: newTitleReducer)

let deleteTitleReducer = { (provider: ReducerProvider,action: DeleteTitleAction, state: TestState) -> TestState in
    
    var newState = state
    newState.title = ""
    return newState
    
}

let deleteTitleFunctionReducer = FunctionReducer(reduceFunction: deleteTitleReducer)

class MockReducerContainer: ReducerContainer {
    
    var invokedAddReducer = false
    var invokedAddReducerCount = 0

    func addReducer<R : ActionReducerType>(reducer: R) {
        invokedAddReducer = true
        invokedAddReducerCount += 1
    }

    var invokedAddReduceFunction = false
    var invokedAddReduceFunctionCount = 0

    func addReduceFunction<StateType, ActionType: Action>(reduceFunction:  @escaping (_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType) {
        invokedAddReduceFunction = true
        invokedAddReduceFunctionCount += 1
    }

    var invokedReducers = false
    var invokedReducersCount = 0
    var invokedReducersParameters: (action: Action, state: Any)?
    var invokedReducersParametersList = [(action: Action, state: Any)]()
    var stubbedReducersResult: [AnyActionReducer]! = []

    func reducers<StateType>(action: Action, state: StateType) -> [AnyActionReducer] {
        invokedReducers = true
        invokedReducersCount += 1
        invokedReducersParameters = (action, state)
        invokedReducersParametersList.append((action, state))
        return stubbedReducersResult
    }
    
    var invokedReduce = false
    var invokedReduceCount = 0
    func reduce<StateType>(action: Action, state: StateType) -> StateType {
        invokedReduce = true
        invokedReduceCount += 1
        return state
    }
}
