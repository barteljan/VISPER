//
//  DefaultObservableProperty+RxSwift.swift
//  JLRoutes
//
//  Created by bartel on 25.12.17.
//

import Foundation
import RxSwift
import VISPER_Core

public extension DefaultObservableProperty {
    
    public func asObservable() -> Observable<ValueType> {
        
        let subject = PublishSubject<ValueType>()
        
        self.disposeBag += subscribe { value in
            subject.on(.next(value))
        }
        
        return subject
    }
}


