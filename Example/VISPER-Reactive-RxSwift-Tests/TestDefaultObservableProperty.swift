//
//  TestDefaultObservableProperty.swift
//  VISPER-Reactive-RxSwift-Tests
//
//  Created by bartel on 25.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Reactive
import RxSwift

class TestDefaultObservableProperty: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testAsObservable() {
        
        let observableProperty = DefaultObservableProperty("firstValue")
        
        let observable = observableProperty.asObservable()
        
        let expect = self.expectation(description: "on next called")
        
        observable.subscribe(onNext: { (value) in
            XCTAssertEqual(value, "secondValue")
            expect.fulfill()
        }).disposed(by: self.disposeBag)
        
        observableProperty.value = "secondValue"
        
        self.wait(for: [expect], timeout: 1.0)
    }

}
