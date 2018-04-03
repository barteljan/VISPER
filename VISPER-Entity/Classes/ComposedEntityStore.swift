//
//  ComposedEntityStore.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 31.03.18.
//

import Foundation

public protocol ComposedEntityStoreType: EntityStoreType {
    
   
}

open class ComposedEntityStore<Type>: ComposedEntityStoreType {
    
    public typealias PersistableType = Type
    
    var storeWrappers = [StoreWrapper]()
    
    struct StoreWrapper {
        
        let store: Any
        let priority: Int
        let entitiyType: Any.Type?
        
        init<T>(store: AnyTypedEntityStore<T>, priority: Int, entitiyType: Any.Type? = nil) {
            self.store = store
            self.priority = priority
            self.entitiyType = entitiyType
        }
        
        func getStore<T>(type: T.Type) -> AnyTypedEntityStore<T>?{
            if let entityType = self.entitiyType {
                if type == entityType {
                    if let store = self.store as? AnyTypedEntityStore<T> {
                        return store
                    }
                }
            } 
            return nil
        }
        
    }
    
    func addStore<T>(store: AnyTypedEntityStore<T>, priority: Int, entityType: Any.Type? = nil) {
        
    }
    
    
    open func add<T>(store: AnyTypedEntityStore<T>, priority: Int = 0) {
        
    }
    
    open func add<T>(store: AnyTypedEntityStore<T>, entityType: Any.Type, priority: Int = 0) {
        
    }
    
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
    
    open func transaction(transaction: @escaping (AnyTypedEntityStore<PersistableType>) throws -> Void) throws {
        fatalError("not implemented")
    }
    
    
    
}
