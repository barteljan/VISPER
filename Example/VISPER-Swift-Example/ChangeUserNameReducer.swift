//
//  SetUserNameReducer.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Swift

struct ChangeUserNameAction: Action {
    let username: String?
}


struct ChangeUserNameReducer: ActionReducerType {

    typealias ReducerStateType = UserState
    typealias ReducerActionType = ChangeUserNameAction
    
    func reduce(provider: ReducerProvider, action: ChangeUserNameAction, state: UserState) -> UserState {
        return UserState(userName: action.username)
    }
}
