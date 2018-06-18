//
//  UpdateStateWithSubstateAction.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 15.06.18.
//

import Foundation
import VISPER_Core

public struct UpdateStateWithSubStateAction<SubStateType>: Action{
    
    public let subState: SubStateType
    
    public init(subState: SubStateType) {
        self.subState = subState
    }
}
