//
//  StateObservingFeature.swift
//  VISPER-Swift
//
//  Created by bartel on 23.04.18.
//
import Foundation
import VISPER_Reactive

public enum StateObservingFeatureError: Error {
    case methodNotImplemented
}

open class StateObservingFeature<ObservedStateType>: Feature {
    
    public init() {
        
    }
    
    open func observe(state: ObservableProperty<ObservedStateType>) throws{
        throw StateObservingFeatureError.methodNotImplemented
    }
}


