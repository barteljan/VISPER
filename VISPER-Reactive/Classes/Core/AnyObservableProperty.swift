//
//  AnyObservableProperty.swift
//  Pods
//
//  Created by bartel on 10.12.17.
//

import Foundation
import VISPER_Core

public class AnyObservableProperty<PropertyValueType,PropertyDisposableType : SubscriptionReferenceType> : ObservablePropertyType {
    
    public typealias ValueType = PropertyValueType
    public typealias DisposableType = PropertyDisposableType
    
    private var _value : () -> PropertyValueType
    private var _setValue : (_ value: PropertyValueType) -> Void
    
    private var _subscribe : (_ function: @escaping (PropertyValueType) -> Void) -> PropertyDisposableType?
    
    public var value: PropertyValueType {
        get {
            return self._value()
        }
        set {
            self._setValue(newValue)
        }
    }
    
    public init<O : ObservablePropertyType>(observableProperty: O) where O.ValueType == PropertyValueType, O.DisposableType == PropertyDisposableType {
        
        var property = observableProperty
        
        self._value = { () -> PropertyValueType in
            return property.value
        }
        
        self._setValue = { ( newValue: PropertyValueType) -> Void in
            property.value = newValue
        }
        
        
        self._subscribe = { (_ function: @escaping (PropertyValueType) -> Void) -> PropertyDisposableType? in
           return property.subscribe(function)
        }
        
    }
    
    public func subscribe(_ function: @escaping (PropertyValueType) -> Void) -> PropertyDisposableType? {
        return self._subscribe(function)
    }
    
}
