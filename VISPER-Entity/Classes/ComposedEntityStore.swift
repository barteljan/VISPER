//
//  ComposedEntityStore.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 31.03.18.
//

import Foundation

open class ComposedEntityStore: EntityStore {
    
    public enum ComposedStoreError: Error {
        case couldNotFoundAStoreFor(type: Any.Type)
    }
    
    var wrappers = [StoreWrapper]()
    var _version: Int
    
    public init(version: Int = 0) {
        self._version = version
    }
    
    public func add<T>(store: TypedEntityStore<T>, priority: Int = 0) where T: Entity{
        let wrapper = StoreWrapper(entityStore: store.entityStore, type: type(of:store).EntityType.self, priority: priority)
        self.wrappers.append(wrapper)
        self.wrappers.sort { (lhs, rhs) -> Bool in
            return lhs.priority > rhs.priority
        }
    }
    
    public func version() -> Int {
        return self._version
    }
    
    public func get<T>(_ identifier: String) throws -> T? {
        let store = try self.responsibleStore(type: T.self)
        return try store.get(identifier, type: T.self)
    }

    public func get<T>(_ identifier: String, completion: @escaping (T?) -> Void) throws {
        let store = try self.responsibleStore(type: T.self)
        try store.get(identifier, type: T.self, completion: completion)
    }
    
    public func delete<T>(_ item: T!) throws {
        let store = try self.responsibleStore(type: type(of: item!))
        try store.delete(item)
    }
    
    public func delete<T>(_ item: T!, completion: @escaping () -> ()) throws {
        let store = try self.responsibleStore(type: type(of: item!))
        try store.delete(item, completion: completion)
    }
    
    public func delete<T>(_ items: [T]) throws {
        guard items.count != 0 else {
            return
        }
        
        let firstItem = items.first
        
        let store = try self.responsibleStore(type: type(of: firstItem!))
        try store.delete(items)
    }
    
    public func persist<T>(_ item: T!) throws {
        let store = try self.responsibleStore(type: type(of: item!))
        try store.persist(item)
    }
    
    public func persist<T>(_ items: [T]) throws {
        
        guard items.count != 0 else {
            return
        }
        
        let firstItem = items.first
        
        let store = try self.responsibleStore(type: type(of: firstItem!))
        try store.persist(items)
    }
    
    public func persist<T>(_ item: T!, completion: @escaping () -> ()) throws {
        let store = try self.responsibleStore(type: type(of: item!))
        try store.persist(item, completion: completion)
    }
    
    public func getAll<T>(_ type: T.Type) throws -> [T] {
        let store = try self.responsibleStore(type: T.self)
        return try store.getAll(T.self)
    }
    
    public func getAll<T>(_ type: T.Type, completion: @escaping ([T]) -> Void) throws {
        let store = try self.responsibleStore(type: T.self)
        try store.getAll(T.self, completion: completion)
    }
    
    public func getAll<T>(_ viewName: String) throws -> [T] {
        let store = try self.responsibleStore(type: T.self)
        return try store.getAll(viewName)
    }
    
    public func getAll<T>(_ viewName: String, completion: @escaping ([T]) -> Void) throws {
        let store = try self.responsibleStore(type: T.self)
        try store.getAll(viewName, completion: completion)
    }
    
    public func getAll<T>(_ viewName: String, groupName: String) throws -> [T] {
        let store = try self.responsibleStore(type: T.self)
        return try store.getAll(viewName, groupName: groupName)
    }
    
    public func getAll<T>(_ viewName: String, groupName: String, completion: @escaping ([T]) -> Void) throws {
        let store = try self.responsibleStore(type: T.self)
        try store.getAll(viewName, groupName: groupName, completion: completion)
    }
    
    
    public func isResponsible<T>(for object: T) -> Bool {
        do {
            let store = try self.responsibleStore(type: type(of:object))
            
            return store.isResponsible(for:object)
        } catch {
            return false
        }

    }
    
    public func isResponsible<T>(forType type: T.Type) -> Bool {
        
        do {
            let _ = try self.responsibleStore(type: type.self)
            return true
        } catch {
            return false
        }

    }
    
    public func exists<T>(_ item: T!) throws -> Bool {
        var store: EntityStore
        do {
            store = try self.responsibleStore(type: type(of: item!))
        } catch {
            return false
        }
        return try store.exists(item)
    }
    
    public func exists<T>(_ item: T!, completion: @escaping (Bool) -> Void) throws {
        
        var store: EntityStore
        do {
            store = try self.responsibleStore(type: type(of: item!))
        } catch {
            completion(false)
            return
        }
        try store.exists(item, completion: completion)
    }
    
    public func exists<T>(_ identifier: String, type: T.Type) throws -> Bool {
        var store: EntityStore
        do {
            store = try self.responsibleStore(type: type.self)
        } catch {
            return false
        }
        return try store.exists(identifier, type: type.self)
    }
    
    public func exists<T>(_ identifier: String, type: T.Type, completion: @escaping (Bool) -> Void) throws {
        var store: EntityStore
        do {
            store = try self.responsibleStore(type: type.self)
        } catch {
            return
        }
        try store.exists(identifier, type: type.self, completion: completion)
    }
    
    public func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool) throws -> [T] {
        let store = try self.responsibleStore(type: T.self)
        return try store.filter(T.self, includeElement: includeElement)
    }
    
    public func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool, completion: @escaping ([T]) -> Void) throws {
        let store = try self.responsibleStore(type: T.self)
        try store.filter(T.self, includeElement: includeElement, completion: completion)
    }
    
    public func addView<T>(_ viewName: String, groupingBlock: @escaping ((String, String, T) -> String?), sortingBlock: @escaping ((String, String, String, T, String, String, T) -> ComparisonResult)) throws {
        let store = try self.responsibleStore(type: T.self)
        try store.addView(viewName, groupingBlock: groupingBlock, sortingBlock: sortingBlock)
    }
    
    public func transaction(transaction: @escaping (EntityStore) throws -> Void) throws {
       
        let allEntities = try self.allEntities()
        let transactionStore = try MemoryEntityStore(allEntities)
        
        try transaction(transactionStore)
        
        for wrapper in wrappers {
            try wrapper.deleteItems(transactionStore, self)
            try wrapper.persistUpdatedItems(transactionStore, self)
        }
       
    }
    
    public func allEntities() throws -> [Any]{
        
        var result = [Any]()
        
        for wrapper in self.wrappers {
            result.append(contentsOf: try wrapper.allEntities())
        }
        
        return result
    }
    
    struct StoreWrapper {
        
        let entityStore: EntityStore
        let type: Any.Type
        let priority: Int
        
        let isResponsible: (Any.Type) -> Bool
        let allEntities: () throws -> [Any]
        let deleteItems: (_ fromStore: MemoryEntityStore, _ inStore: EntityStore) throws -> Void
        let persistUpdatedItems: (_ fromStore: MemoryEntityStore, _ inStore: EntityStore) throws -> Void
        
        init<T>(entityStore: EntityStore,type: T.Type, priority: Int) where T: Entity {
            self.entityStore = entityStore
            self.type = type
            self.priority = priority
            
            
            self.isResponsible = { aType in
                return aType.self is T.Type
            }
            
            self.allEntities = {
                let items: [T] = try entityStore.getAll(T.self)
                return items
            }
            
            self.deleteItems = { (fromStore: MemoryEntityStore, inStore: EntityStore) throws -> Void in
                
                print(T.self)
               
                let items: [T] = fromStore.deletedEntities(type: T.self)
                
                print(items)
                
                try inStore.delete(items)
                
            }
            
            self.persistUpdatedItems = { (fromStore: MemoryEntityStore, inStore: EntityStore) throws -> Void in
                
                let items: [T] = fromStore.updatedEntities(type: T.self)
                try inStore.persist(items)
                
                
            }
        }
    }
    
    func responsibleStore<T>(type: T.Type) throws -> EntityStore {
        for wrapper in self.wrappers {
            if wrapper.isResponsible(type) {
                return wrapper.entityStore
            }
        }
        throw ComposedStoreError.couldNotFoundAStoreFor(type: type)
    }
}
