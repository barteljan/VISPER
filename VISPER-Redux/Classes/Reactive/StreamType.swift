//
//  StreamType.swift
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

/// A protocol that denotes a type that sends values over time.
public protocol StreamType {
    /// The type of the values within the `Stream`.
    associatedtype ValueType
    /** The type of the disposable object returned from a subscription.
     If you can't conform the disposable of your choice FRP library to `SubscriptionReferenceType`,
     you can create a struct to contain the disposable and return that instead.
     If your choice FRP library does not provide a disposable type, you can create an empty struct,
     and simply return nil from `subscribe(_:)`.
     */
    associatedtype DisposableType: SubscriptionReferenceType

    /// Register a callback to be called when new values flow down the stream.
    func subscribe(_ function: @escaping (ValueType) -> Void) -> DisposableType?
}
