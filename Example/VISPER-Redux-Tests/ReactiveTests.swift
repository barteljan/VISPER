//
//  RxTests.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//


import XCTest
@testable import VISPER_Redux
/*
 The MIT License (MIT)
 Copyright (c) 2016 ReSwift Contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
class ReactiveTests: XCTestCase {

    func testObservablePropertySendsNewValues() {
        let values = (10, 20, 30)
        var receivedValue: Int?
        let property = ObservableProperty(values.0)
        property.subscribe {
            receivedValue = $0
        }
        XCTAssertEqual(receivedValue, values.0)
        property.value = values.1
        XCTAssertEqual(receivedValue, values.1)
        property.value = values.2
        XCTAssertEqual(receivedValue, values.2)
    }

    func testObservablePropertyMapsValues() {
        let values = (10, 20, 30)
        var receivedValue: Int?
        let property = ObservableProperty(values.0)
        property.map { $0 * 10 }.subscribe {
            receivedValue = $0
        }
        XCTAssertEqual(receivedValue, values.0 * 10)
        property.value = values.1
        XCTAssertEqual(receivedValue, values.1 * 10)
        property.value = values.2
        XCTAssertEqual(receivedValue, values.2 * 10)
    }

    func testObservablePropertyFiltersValues() {
        let values = [10, 10, 20, 20, 30, 30, 30]
        var lastReceivedValue: Int?
        var receivedValues: [Int] = []
        let property = ObservableProperty(10)
        property.distinct().subscribe {
            XCTAssertNotEqual(lastReceivedValue, $0)
            lastReceivedValue = $0
            receivedValues += [$0]
        }
        values.forEach { property.value = $0 }
        XCTAssertEqual(receivedValues, [10, 20, 30])
    }

    func testObservablePropertyDisposesOfReferences() {
        let property = ObservableProperty(())
        let reference = property.subscribe({})
        XCTAssertEqual(property.subscriptions.count, 1)
        reference?.dispose()
        XCTAssertEqual(property.subscriptions.count, 0)
    }

    func testSubscriptionBagDisposesOfReferences() {
        let property = ObservableProperty(()).deliveredOn(DispatchQueue.global())
        let bag = SubscriptionReferenceBag(property.subscribe({}))
        bag += property.subscribe({})
        XCTAssertEqual(property.subscriptions.count, 2)
        bag.dispose()
        XCTAssertEqual(property.subscriptions.count, 0)
    }

    func testThatDisposingOfAReferenceTwiceIsOkay() {
        let property = ObservableProperty(())
        let reference = property.subscribe({})
        reference?.dispose()
        reference?.dispose()
    }
}
