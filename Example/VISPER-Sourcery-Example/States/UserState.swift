//
//  UserState.swift
//  VISPER-Redux-Sourcery-Example
//
//  Created by bartel on 24.03.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Sourcery

public struct UserState: WithAutoStateInitializers, WithAutoGeneralInitializer, AutoReducer  {
    
    var firstName: String
    var lastName: String
    var userName: String
    var email: String
    
// sourcery:inline:auto:UserState.GenerateInitializers
    // auto generated init function for UserState
    public init(firstName: String, lastName: String, userName: String, email: String){
            self.firstName = firstName
            self.lastName = lastName
            self.userName = userName
            self.email = email
    }
// sourcery:end
}


