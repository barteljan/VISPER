// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

//
//
// AppState
//
//
extension AppState {

    // stored properties of AppState
    public enum Properties: String {
        case styleState
        case userState
    }

    // init to modify one property value of a AppState
    public init?(state: AppState, property: Properties, value: Any) {
            switch property {
            case .styleState:
                self.init(
                          styleState:  value as! StyleState, 
                          userState: state.userState
                    )
            case .userState:
                self.init(
                          styleState: state.styleState, 
                          userState:  value as! UserState
                    )
            }
    }

    // init to modify the value the property styleState of a AppState
    public init?(state: AppState, styleState: StyleState) {
        self.init(state: state,
               property: .styleState,
                  value: styleState)
    }

    // init to modify the value the property userState of a AppState
    public init?(state: AppState, userState: UserState) {
        self.init(state: state,
               property: .userState,
                  value: userState)
    }

}

//
//
// StyleState
//
//
extension StyleState {

    // stored properties of StyleState
    public enum Properties: String {
        case backgroundColor
        case fontColor
    }

    // init to modify one property value of a StyleState
    public init?(state: StyleState, property: Properties, value: Any) {
            switch property {
            case .backgroundColor:
                self.init(
                          backgroundColor:  value as! UIColor, 
                          fontColor: state.fontColor
                    )
            case .fontColor:
                self.init(
                          backgroundColor: state.backgroundColor, 
                          fontColor:  value as! UIColor
                    )
            }
    }

    // init to modify the value the property backgroundColor of a StyleState
    public init?(state: StyleState, backgroundColor: UIColor) {
        self.init(state: state,
               property: .backgroundColor,
                  value: backgroundColor)
    }

    // init to modify the value the property fontColor of a StyleState
    public init?(state: StyleState, fontColor: UIColor) {
        self.init(state: state,
               property: .fontColor,
                  value: fontColor)
    }

}

//
//
// UserState
//
//
extension UserState {

    // stored properties of UserState
    public enum Properties: String {
        case firstName
        case lastName
        case userName
        case email
    }

    // init to modify one property value of a UserState
    public init?(state: UserState, property: Properties, value: Any) {
            switch property {
            case .firstName:
                self.init(
                          firstName:  value as! String, 
                          lastName: state.lastName, 
                          userName: state.userName, 
                          email: state.email
                    )
            case .lastName:
                self.init(
                          firstName: state.firstName, 
                          lastName:  value as! String, 
                          userName: state.userName, 
                          email: state.email
                    )
            case .userName:
                self.init(
                          firstName: state.firstName, 
                          lastName: state.lastName, 
                          userName:  value as! String, 
                          email: state.email
                    )
            case .email:
                self.init(
                          firstName: state.firstName, 
                          lastName: state.lastName, 
                          userName: state.userName, 
                          email:  value as! String
                    )
            }
    }

    // init to modify the value the property firstName of a UserState
    public init?(state: UserState, firstName: String) {
        self.init(state: state,
               property: .firstName,
                  value: firstName)
    }

    // init to modify the value the property lastName of a UserState
    public init?(state: UserState, lastName: String) {
        self.init(state: state,
               property: .lastName,
                  value: lastName)
    }

    // init to modify the value the property userName of a UserState
    public init?(state: UserState, userName: String) {
        self.init(state: state,
               property: .userName,
                  value: userName)
    }

    // init to modify the value the property email of a UserState
    public init?(state: UserState, email: String) {
        self.init(state: state,
               property: .email,
                  value: email)
    }

}



