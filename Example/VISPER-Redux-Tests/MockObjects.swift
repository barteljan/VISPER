//
//  MockObjects.swift
//  VISPER_Redux_Tests
//
//  Created by Jan Bartel on 31.10.17.
//  Copyright © Jan Bartel. This file is distributed under the MIT License
//

import Foundation
import VISPER_Core
@testable import VISPER_Redux

struct TestState: Equatable{
    var title : String
}

let testState = TestState(title: "startingTitle")

struct NewTitleAction : Action, Equatable{
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

let newTitleFunctionReducer = FunctionalReducer(reduceFunction: newTitleReducer)

let deleteTitleReducer = { (provider: ReducerProvider,action: DeleteTitleAction, state: TestState) -> TestState in
    
    var newState = state
    newState.title = ""
    return newState
    
}

class MockActionReducer: NSObject, ActionReducerType {

    typealias ReducerStateType = TestState
    typealias ReducerActionType = NewTitleAction
    
    func reduce(provider: ReducerProvider, action: NewTitleAction, state: TestState) -> TestState {
        return TestState(title: action.newTitle)
    }
}

class MockAsyncReducerCallingTheCompletion: NSObject, AsyncActionReducerType {
    
    typealias ReducerStateType = TestState
    typealias ReducerActionType = NewTitleAction
    
    func reduce(provider: ReducerProvider, action: NewTitleAction, completion: @escaping (TestState) -> Void) {
        completion(TestState(title: action.newTitle))
    }
}

class MockAsyncReducerNotCallingTheCompletion: NSObject, AsyncActionReducerType {
    
    typealias ReducerStateType = TestState
    typealias ReducerActionType = NewTitleAction
    
    func reduce(provider: ReducerProvider, action: NewTitleAction, completion: @escaping (TestState) -> Void) {
        
    }
}


let deleteTitleFunctionReducer = FunctionalReducer(reduceFunction: deleteTitleReducer)

class MockReducerContainer: ReducerContainer, StateChangingReducerContainer {
    
    var dispatchStateChangeActionCallback: ((Action) -> Void)?

    var invokedAddReducerReducerR = false
    var invokedAddReducerReducerRCount = 0
    var invokedAddReducerReducerRParameters: (reducer: Any, Void)?
    var invokedAddReducerReducerRParametersList = [(reducer: Any, Void)]()

    func addReducer<R: ActionReducerType>(reducer: R) {
        invokedAddReducerReducerR = true
        invokedAddReducerReducerRCount += 1
        invokedAddReducerReducerRParameters = (reducer, ())
        invokedAddReducerReducerRParametersList.append((reducer, ()))
    }

    var invokedAddReducerReducerRAsync = false
    var invokedAddReducerReducerRAsyncCount = 0
    var invokedAddReducerReducerRAsyncParameters: (reducer: Any, Void)?
    var invokedAddReducerReducerRAsyncParametersList = [(reducer: Any, Void)]()

    func addReducer<R: AsyncActionReducerType>(reducer: R) {
        invokedAddReducerReducerRAsync = true
        invokedAddReducerReducerRAsyncCount += 1
        invokedAddReducerReducerRAsyncParameters = (reducer, ())
        invokedAddReducerReducerRAsyncParametersList.append((reducer, ()))
    }

    var invokedAddReduceFunction = false
    var invokedAddReduceFunctionCount = 0
    func addReduceFunction<StateType, ActionType: Action>(reduceFunction: @escaping (_ provider: ReducerProvider, _ action: ActionType, _ state: StateType) -> StateType) {
        invokedAddReduceFunction = true
        invokedAddReduceFunctionCount += 1
    }

    var invokedReducersActionActionStateStateType = false
    var invokedReducersActionActionStateStateTypeCount = 0
    var invokedReducersActionActionStateStateTypeParameters: (action: Action, state: Any)?
    var invokedReducersActionActionStateStateTypeParametersList = [(action: Action, state: Any)]()
    var stubbedReducersActionActionStateStateTypeResult: [AnyActionReducer]! = []

    func reducers<StateType>(action: Action, state: StateType) -> [AnyActionReducer] {
        invokedReducersActionActionStateStateType = true
        invokedReducersActionActionStateStateTypeCount += 1
        invokedReducersActionActionStateStateTypeParameters = (action, state)
        invokedReducersActionActionStateStateTypeParametersList.append((action, state))
        return stubbedReducersActionActionStateStateTypeResult
    }

    var invokedReducersActionActionStateStateTypeAsync = false
    var invokedReducersActionActionStateStateTypeAsyncCount = 0
    var invokedReducersActionActionStateStateTypeAsyncParameters: (action: Action, state: Any)?
    var invokedReducersActionActionStateStateTypeAsyncParametersList = [(action: Action, state: Any)]()
    var stubbedReducersActionActionStateStateTypeAsyncResult: [AnyAsyncActionReducer]! = []

    func reducers<StateType>(action: Action, state: StateType) -> [AnyAsyncActionReducer] {
        invokedReducersActionActionStateStateTypeAsync = true
        invokedReducersActionActionStateStateTypeAsyncCount += 1
        invokedReducersActionActionStateStateTypeAsyncParameters = (action, state)
        invokedReducersActionActionStateStateTypeAsyncParametersList.append((action, state))
        return stubbedReducersActionActionStateStateTypeAsyncResult
    }

    var invokedReduce = false
    var invokedReduceCount = 0
    var invokedReduceParameters: (action: Action, state: Any)?
    var invokedReduceParametersList = [(action: Action, state: Any)]()
    var stubbedReduceResult: Any!

    func reduce<StateType>(action: Action, state: StateType) -> StateType {
        invokedReduce = true
        invokedReduceCount += 1
        invokedReduceParameters = (action, state)
        invokedReduceParametersList.append((action, state))
        return stubbedReduceResult as! StateType
    }

    var invokedReduceAction = false
    var invokedReduceActionCount = 0
    var invokedReduceActionParameters: (action: Action, state: Any)?
    var invokedReduceActionParametersList = [(action: Action, state: Any)]()
    var stubbedReduceActionResult: Any!

    func reduce<StateType>(action: Action, state: StateType, completion: @escaping () -> Void) -> StateType {
        invokedReduceAction = true
        invokedReduceActionCount += 1
        invokedReduceActionParameters = (action, state)
        invokedReduceActionParametersList.append((action, state))
        completion()
        return stubbedReduceActionResult as! StateType
    }
}


