//
//  StyleState.swift
//  VISPER-Redux-Sourcery-Example
//
//  Created by bartel on 24.03.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Sourcery

public struct StyleState: WithAutoInitializers, WithAutoGeneralInitializer, AutoReducer {
    let backgroundColor: UIColor
    let fontColor: UIColor

// sourcery:inline:auto:StyleState.GenerateInitializers
    // auto generated init function for StyleState
    public init(backgroundColor: UIColor, fontColor: UIColor){
            self.backgroundColor = backgroundColor
            self.fontColor = fontColor
    }
// sourcery:end
}
