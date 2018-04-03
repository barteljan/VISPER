//
//  ReduxEntityStore.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 29.03.18.
//

import Foundation
import VISPER_Entity


open class ReduxEntityStore<EntityType>: EntityStoreType {

    public typealias PersistableType = EntityType
    
    open func delete<T>(_ item: T!) throws {
        fatalError("not implemented")
    }
    
    open func delete<T>(_ item: T!, completion: @escaping () -> ()) throws {
        fatalError("not implemented")
    }
    
    open func persist<T>(_ item: T!) throws {
        fatalError("not implemented")
    }
    
    open func persist<T>(_ item: T!, completion: @escaping () -> ()) throws {
        fatalError("not implemented")
    }
    
    open func get<T>(_ identifier: String, completion: @escaping (T?) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func get<T>(_ identifier: String) throws -> T? {
        fatalError("not implemented")
    }
    
    open func getAll<T>(_ type: T.Type) throws -> [T] {
        fatalError("not implemented")
    }
    
    open func getAll<T>(_ type: T.Type, completion: @escaping ([T]) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func getAll<T>(_ viewName: String) throws -> [T] {
        fatalError("not implemented")
    }
    
    open func getAll<T>(_ viewName: String, completion: @escaping ([T]) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func getAll<T>(_ viewName: String, groupName: String) throws -> [T] {
        fatalError("not implemented")
    }
    
    open func getAll<T>(_ viewName: String, groupName: String, completion: @escaping ([T]) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func exists(_ item: Any!) throws -> Bool {
        fatalError("not implemented")
    }
    
    open func exists(_ item: Any!, completion: @escaping (Bool) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func exists(_ identifier: String, type: Any.Type) throws -> Bool {
        fatalError("not implemented")
    }
    
    open func exists(_ identifier: String, type: Any.Type, completion: @escaping (Bool) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool) throws -> [T] {
        fatalError("not implemented")
    }
    
    open func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool, completion: @escaping ([T]) -> Void) throws {
        fatalError("not implemented")
    }
    
    open func addView<T>(_ viewName: String, groupingBlock: @escaping ((String, String, T) -> String?), sortingBlock: @escaping ((String, String, String, T, String, String, T) -> ComparisonResult)) throws {
        fatalError("not implemented")
    }
    
    open func transaction(transaction: @escaping (AnyTypedEntityStore<EntityType>) throws -> Void) throws {
        fatalError("not implemented")
    }
}
