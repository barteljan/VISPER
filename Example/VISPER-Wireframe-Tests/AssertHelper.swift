//
//  AssertHelper.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 23.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

func AssertThat(time1: Date?, isEarlierThan time2: Date?) {
    
    guard let time1 = time1 else {
        XCTFail("time1 should not be nil")
        return
    }
    
    guard let time2 = time2 else {
        XCTFail("time2 should not be nil")
        return
    }
    
    XCTAssert(time1.timeIntervalSince1970 < time2.timeIntervalSince1970)
    
}

func AssertThat<T>(_ instance: Any?, isOfType: T.Type, andEqualsNonNil secondInstance: T?, message: String = "instance has wrong type") where T : Equatable {
    
    guard let secondInstance = secondInstance else {
        XCTFail("\(message), Error: secondInstance should not be nil")
        return
    }
    
    AssertThat(instance, isOfType: T.self, andEquals: secondInstance, message: message)
}



func AssertThat<T>(_ instance: Any?, isOfType: T.Type, andEquals secondInstance: T, message: String = "instance has wrong type") where T : Equatable {
    
    let result = AssertThat(instance, isOfType: T.self, message: message)
    XCTAssertEqual(result, secondInstance)
    
}

@discardableResult
func AssertThat<T>(_ instance: Any?, isOfType: T.Type, message: String = "instance has wrong type") -> T? {
    
    guard let result = instance as? T else {
        XCTFail(message)
        return nil
    }
    
    return result
}
