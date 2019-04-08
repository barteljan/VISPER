//
//  WriteMemoryEntityStore.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 08.04.19.
//

import Foundation

public enum WriteOnlyMemoryEntityStoreError: Error {
    case readingIsNotallowedInWriteOnlyMemoryEntityStore
}


open class WriteOnlyMemoryEntityStore: MemoryEntityStore {
    
    public override init() {
        try! super.init([])
    }
    
    public override init(_ items: [Any]) throws {
        try super.init(items)
    }
    
    open override func get<T>(_ identifier: String) throws -> T? {
        throw WriteOnlyMemoryEntityStoreError.readingIsNotallowedInWriteOnlyMemoryEntityStore
    }
    
    open override func getAll<T>(_ type: T.Type) throws -> [T] {
        throw WriteOnlyMemoryEntityStoreError.readingIsNotallowedInWriteOnlyMemoryEntityStore
    }
}
