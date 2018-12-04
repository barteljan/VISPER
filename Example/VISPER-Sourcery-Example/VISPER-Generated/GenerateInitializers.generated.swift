// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import UIKit

//
//
// AppState
//
//
extension AppState {

    // stored properties of AppState
    internal enum Properties: String {
        case styleState
        case userState
    }
    //init with object of same type
    internal init(sourceObject: AppState) {
            self.init(
                      styleState: sourceObject.styleState, 
                      userState: sourceObject.userState
                      )
    }

    // init to modify one property value of a AppState
    internal init?(sourceObject: AppState, property: Properties, value: Any) {
            switch property {
            case .styleState:
                self.init(
                          styleState:  (value as! StyleState), 
                          userState: sourceObject.userState
                    )
            case .userState:
                self.init(
                          styleState: sourceObject.styleState, 
                          userState:  (value as! UserState)
                    )
            }
    }



    // init to modify the value the property styleState of a AppState
    internal init?(sourceObject: AppState, styleState: StyleState) {
        self.init(sourceObject: sourceObject,
               property: .styleState,
                  value: styleState as Any) 
    }

    // init to modify the value the property userState of a AppState
    internal init?(sourceObject: AppState, userState: UserState?) {
        self.init(sourceObject: sourceObject,
               property: .userState,
                  value: userState as Any) 
    }

}

//
//
// StyleState
//
//
extension StyleState {

    // stored properties of StyleState
    internal enum Properties: String {
        case backgroundColor
        case fontColor
    }
    //init with object of same type
    internal init(sourceObject: StyleState) {
            self.init(
                      backgroundColor: sourceObject.backgroundColor, 
                      fontColor: sourceObject.fontColor
                      )
    }

    // init to modify one property value of a StyleState
    internal init?(sourceObject: StyleState, property: Properties, value: Any) {
            switch property {
            case .backgroundColor:
                self.init(
                          backgroundColor:  (value as! UIColor), 
                          fontColor: sourceObject.fontColor
                    )
            case .fontColor:
                self.init(
                          backgroundColor: sourceObject.backgroundColor, 
                          fontColor:  (value as! UIColor)
                    )
            }
    }



    // init to modify the value the property backgroundColor of a StyleState
    internal init?(sourceObject: StyleState, backgroundColor: UIColor) {
        self.init(sourceObject: sourceObject,
               property: .backgroundColor,
                  value: backgroundColor as Any) 
    }

    // init to modify the value the property fontColor of a StyleState
    internal init?(sourceObject: StyleState, fontColor: UIColor) {
        self.init(sourceObject: sourceObject,
               property: .fontColor,
                  value: fontColor as Any) 
    }

}

//
//
// UserState
//
//
extension UserState {

    // stored properties of UserState
    internal enum Properties: String {
        case firstName
        case lastName
        case userName
        case email
    }
    //init with object of same type
    internal init(sourceObject: UserState) {
            self.init(
                      firstName: sourceObject.firstName, 
                      lastName: sourceObject.lastName, 
                      userName: sourceObject.userName, 
                      email: sourceObject.email
                      )
    }

    // init to modify one property value of a UserState
    internal init?(sourceObject: UserState, property: Properties, value: Any) {
            switch property {
            case .firstName:
                self.init(
                          firstName:  (value as! String), 
                          lastName: sourceObject.lastName, 
                          userName: sourceObject.userName, 
                          email: sourceObject.email
                    )
            case .lastName:
                self.init(
                          firstName: sourceObject.firstName, 
                          lastName:  (value as! String), 
                          userName: sourceObject.userName, 
                          email: sourceObject.email
                    )
            case .userName:
                self.init(
                          firstName: sourceObject.firstName, 
                          lastName: sourceObject.lastName, 
                          userName:  (value as! String), 
                          email: sourceObject.email
                    )
            case .email:
                self.init(
                          firstName: sourceObject.firstName, 
                          lastName: sourceObject.lastName, 
                          userName: sourceObject.userName, 
                          email:  (value as! String)
                    )
            }
    }



    // init to modify the value the property firstName of a UserState
    internal init?(sourceObject: UserState, firstName: String?) {
        self.init(sourceObject: sourceObject,
               property: .firstName,
                  value: firstName as Any) 
    }

    // init to modify the value the property lastName of a UserState
    internal init?(sourceObject: UserState, lastName: String?) {
        self.init(sourceObject: sourceObject,
               property: .lastName,
                  value: lastName as Any) 
    }

    // init to modify the value the property userName of a UserState
    internal init?(sourceObject: UserState, userName: String) {
        self.init(sourceObject: sourceObject,
               property: .userName,
                  value: userName as Any) 
    }

    // init to modify the value the property email of a UserState
    internal init?(sourceObject: UserState, email: String?) {
        self.init(sourceObject: sourceObject,
               property: .email,
                  value: email as Any) 
    }

}



