// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import VISPER_Redux
import VISPER_Core



//
//
// AppState
//
//

//
// Set AppState styleState
//

// Set AppState styleState Action
public struct AppStateSetStylestateAction: Action {
    let styleState: StyleState
    public init(styleState: StyleState) {
        self.styleState = styleState
    }
}

// Set AppState styleState Action Reducer
public class AppStateSetStylestateReducer: ActionReducerType {
    public typealias ReducerStateType = AppState
    public typealias ReducerActionType = AppStateSetStylestateAction
    public func reduce(provider: ReducerProvider,
                         action: AppStateSetStylestateAction,
                          state: AppState) -> AppState {
        if let newState = AppState(state: state, styleState: action.styleState) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set AppState userState
//

// Set AppState userState Action
public struct AppStateSetUserstateAction: Action {
    let userState: UserState
    public init(userState: UserState) {
        self.userState = userState
    }
}

// Set AppState userState Action Reducer
public class AppStateSetUserstateReducer: ActionReducerType {
    public typealias ReducerStateType = AppState
    public typealias ReducerActionType = AppStateSetUserstateAction
    public func reduce(provider: ReducerProvider,
                         action: AppStateSetUserstateAction,
                          state: AppState) -> AppState {
        if let newState = AppState(state: state, userState: action.userState) {
            return newState
        } else {
            return state
        }
    }
}


//
//
// StyleState
//
//

//
// Set StyleState backgroundColor
//

// Set StyleState backgroundColor Action
public struct StyleStateSetBackgroundcolorAction: Action {
    let backgroundColor: UIColor
    public init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}

// Set StyleState backgroundColor Action Reducer
public class StyleStateSetBackgroundcolorReducer: ActionReducerType {
    public typealias ReducerStateType = StyleState
    public typealias ReducerActionType = StyleStateSetBackgroundcolorAction
    public func reduce(provider: ReducerProvider,
                         action: StyleStateSetBackgroundcolorAction,
                          state: StyleState) -> StyleState {
        if let newState = StyleState(state: state, backgroundColor: action.backgroundColor) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set StyleState fontColor
//

// Set StyleState fontColor Action
public struct StyleStateSetFontcolorAction: Action {
    let fontColor: UIColor
    public init(fontColor: UIColor) {
        self.fontColor = fontColor
    }
}

// Set StyleState fontColor Action Reducer
public class StyleStateSetFontcolorReducer: ActionReducerType {
    public typealias ReducerStateType = StyleState
    public typealias ReducerActionType = StyleStateSetFontcolorAction
    public func reduce(provider: ReducerProvider,
                         action: StyleStateSetFontcolorAction,
                          state: StyleState) -> StyleState {
        if let newState = StyleState(state: state, fontColor: action.fontColor) {
            return newState
        } else {
            return state
        }
    }
}


//
//
// UserState
//
//

//
// Set UserState firstName
//

// Set UserState firstName Action
public struct UserStateSetFirstnameAction: Action {
    let firstName: String
    public init(firstName: String) {
        self.firstName = firstName
    }
}

// Set UserState firstName Action Reducer
public class UserStateSetFirstnameReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetFirstnameAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetFirstnameAction,
                          state: UserState) -> UserState {
        if let newState = UserState(state: state, firstName: action.firstName) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set UserState lastName
//

// Set UserState lastName Action
public struct UserStateSetLastnameAction: Action {
    let lastName: String
    public init(lastName: String) {
        self.lastName = lastName
    }
}

// Set UserState lastName Action Reducer
public class UserStateSetLastnameReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetLastnameAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetLastnameAction,
                          state: UserState) -> UserState {
        if let newState = UserState(state: state, lastName: action.lastName) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set UserState userName
//

// Set UserState userName Action
public struct UserStateSetUsernameAction: Action {
    let userName: String
    public init(userName: String) {
        self.userName = userName
    }
}

// Set UserState userName Action Reducer
public class UserStateSetUsernameReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetUsernameAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetUsernameAction,
                          state: UserState) -> UserState {
        if let newState = UserState(state: state, userName: action.userName) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set UserState email
//

// Set UserState email Action
public struct UserStateSetEmailAction: Action {
    let email: String
    public init(email: String) {
        self.email = email
    }
}

// Set UserState email Action Reducer
public class UserStateSetEmailReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetEmailAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetEmailAction,
                          state: UserState) -> UserState {
        if let newState = UserState(state: state, email: action.email) {
            return newState
        } else {
            return state
        }
    }
}








