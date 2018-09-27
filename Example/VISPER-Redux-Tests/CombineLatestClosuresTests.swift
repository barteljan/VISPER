//
//  CallbackPipelineTests.swift
//  VISPER-Redux-Tests
//
//  Created by bartel on 03.08.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_Redux

class CombineLatestClosuresTests: XCTestCase {
    
   
    func testDidNotCallCompletionIfCombineLatestClosuresWasNotStarted() {
        
        var callbackCalled = false
        let testCallback = {
            callbackCalled = true
        }
        
        var completionedCalled = false
        
        let pipeline = CombineLatestClosures(allCallbacksAreCalled: {
            completionedCalled = true
        })
        
        let callback = pipeline.chainClosure(callback: testCallback)
        
        callback()
        
        XCTAssertTrue(callbackCalled)
        XCTAssertFalse(completionedCalled)
        
    }
    
    func testDidCallCompletionIfCombineLatestClosuresWasStarted() {
        
        var callbackCalled = false
        let testCallback = {
            callbackCalled = true
        }
        
        var completionedCalled = false
        
        let pipeline = CombineLatestClosures(allCallbacksAreCalled: {
            completionedCalled = true
        })
        
        let callback = pipeline.chainClosure(callback: testCallback)
        
        pipeline.combineLatest()
        
        callback()
        
        XCTAssertTrue(callbackCalled)
        XCTAssertTrue(completionedCalled)
        
    }
    
    func testDidNotCallCompletionIfSecondCallbackWasNotCalled() {
        
        var callbackCalled1 = false
        let testCallback1 = {
            callbackCalled1 = true
        }
        
        var callbackCalled2 = false
        let testCallback2 = {
            callbackCalled2 = true
        }
        
        var completionedCalled = false
        
        let pipeline = CombineLatestClosures(allCallbacksAreCalled: {
            completionedCalled = true
        })
        
        let callback1 = pipeline.chainClosure(callback: testCallback1)
        let _ = pipeline.chainClosure(callback: testCallback2)
        
        pipeline.combineLatest()
        
        callback1()
        
        XCTAssertTrue(callbackCalled1)
        XCTAssertFalse(callbackCalled2)
        XCTAssertFalse(completionedCalled)
        
    }
    
    func testDidCallCompletionIfBothCallbacksWereCalled() {
        
        var callbackCalled1 = false
        let testCallback1 = {
            callbackCalled1 = true
        }
        
        var callbackCalled2 = false
        let testCallback2 = {
            callbackCalled2 = true
        }
        
        var completionedCalled = false
        
        let pipeline = CombineLatestClosures(allCallbacksAreCalled: {
            completionedCalled = true
        })
        
        let callback1 = pipeline.chainClosure(callback: testCallback1)
        let callback2 = pipeline.chainClosure(callback: testCallback2)
        
        pipeline.combineLatest()
        
        callback1()
        callback2()
        
        XCTAssertTrue(callbackCalled1)
        XCTAssertTrue(callbackCalled2)
        XCTAssertTrue(completionedCalled)
        
    }
    
    
}
