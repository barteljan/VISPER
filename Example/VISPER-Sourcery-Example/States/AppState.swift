//
//  AppState.swift
//  VISPER-Redux-Sourcery-Example
//
//  Created by bartel on 24.03.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Sourcery

public struct AppState: WithAutoInitializers, WithAutoGeneralInitializer,AutoAppReducer,AutoReducer {
    let styleState: StyleState
    let userState: UserState?

// sourcery:inline:auto:AppState.GenerateInitializers
    // auto generated init function for AppState
    public init(styleState: StyleState, userState: UserState?){
            self.styleState = styleState
            self.userState = userState
    }
// sourcery:end
}


