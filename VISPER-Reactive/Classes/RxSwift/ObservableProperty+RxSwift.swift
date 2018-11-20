//
//  ObservableProperty+RxSwift.swift
//
//  Created by bartel on 25.12.17.
//

import Foundation
import RxSwift

public extension ObservableProperty {
    
    public func asObservable() -> Observable<ValueType> {
        
        let subject = BehaviorSubject<ValueType>(value: self.value)
        
        self.disposeBag += subscribe { value in
            subject.on(.next(value))
        }
        
        return subject
    }
}


