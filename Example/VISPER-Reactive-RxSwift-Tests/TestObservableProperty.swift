//
//  VISPER_Reactive_RxSwift_Tests.swift
//  VISPER-Reactive-RxSwift-Tests
//
//  Created by bartel on 10.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
import RxSwift
import VISPER_Core
@testable import VISPER_Reactive

struct TestState {
    var title : String
}

class TestObservableProperty: XCTestCase {
    
   
    
    func testAsObservable() {
        
        let disposeBag = DisposeBag()
        
        let firstState = TestState(title: "startingTitle")
        let stateToChange = TestState(title: "newTitle")
        
        let property = ObservablePropertyRxSwift(firstState)
        
        let observable = property.asObservable()
        
        var count = 0
        observable.subscribe(onNext: { (state) in
            count += 1
            print("\(count) \(state)")
            XCTAssertEqual(state.title, stateToChange.title)
            
        }).disposed(by: disposeBag)
        
        property.value = stateToChange
        XCTAssertEqual(count,1)
    }
    
    
    func testDisposedWithDisposeBag() {
        
        var disposeCalled = false
        let dispose = { () -> Void in
            disposeCalled = true
        }
        
        autoreleasepool {
            
            let disposeBag = DisposeBag()
            
            let firstState = TestState(title: "startingTitle")
            let stateToChange = TestState(title: "newTitle")
            
            let property = ObservablePropertyRxSwift(firstState)
            
            let observable = property.asObservable()
            
            var count = 0
            observable.subscribe(onNext: { (state) in
                count += 1
                print("\(count) \(state)")
                XCTAssertEqual(state.title, stateToChange.title)
                
            }, onDisposed:dispose).disposed(by: disposeBag)
            
            property.value = stateToChange
            XCTAssertEqual(count,1)
        }
        
        XCTAssertTrue(disposeCalled)
    }
    
    
    func testDisposedWithSubscriptionReferenceBag() {
        
        var disposeCalled = false
        let dispose = { () -> Void in
            disposeCalled = true
        }
        
        autoreleasepool {
            
            let disposeBag = SubscriptionReferenceBag()
            
            let firstState = TestState(title: "startingTitle")
            let stateToChange = TestState(title: "newTitle")
            
            let property = ObservablePropertyRxSwift(firstState)
            var count = 0
            let subscription = property.subscribe({ (state) in
                count += 1
                print("\(count) \(state)")
                XCTAssertEqual(state.title, stateToChange.title)
                
            }, onDisposed:dispose)
            
            disposeBag.addReference(reference: subscription)
            
            property.value = stateToChange
            XCTAssertEqual(count,1)
        }
        
        XCTAssertTrue(disposeCalled)
    }
}
