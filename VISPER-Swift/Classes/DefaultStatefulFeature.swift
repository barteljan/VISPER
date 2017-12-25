//
//  DefaultStatefulFeature.swift
//  VISPER-Swift
//
//  Created by bartel on 11.12.17.
//

import Foundation

// a feature that delivers a state
open class DefaultStatefulFeature<State> : StatefulFeature {
    
    public typealias StateType = State
    
    public let getState: () -> StateType
    
    public init(getState: @escaping () -> StateType) {
        self.getState = getState
    }

}
