//
//  ObservablePropertySubscriptionReference.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//
/*
 The MIT License (MIT)
 Copyright (c) 2016 ReSwift Contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/// The subscription reference type of `ObservableProperty`.
public struct ObservablePropertySubscriptionReference<T> {
    internal let key: String
    internal weak var stream: ObservableProperty<T>?

    internal init(key: String, stream: ObservableProperty<T>) {
        self.key = key
        self.stream = stream
    }
}

extension ObservablePropertySubscriptionReference: SubscriptionReferenceType {
    /// Dispose of the referenced subscription.
    public func dispose() {
        stream?.unsubscribe(reference: self)
    }
}

extension ObservablePropertySubscriptionReference: Equatable, Hashable {
    /// The hash of the subscription.
    public var hashValue: Int {
        return key.hash
    }

    /// Compare two `ObservablePropertySubscriptionReference`s.
    public static func == <T>(lhs: ObservablePropertySubscriptionReference<T>, rhs: ObservablePropertySubscriptionReference<T>) -> Bool {
        return lhs.key == rhs.key
    }
}
