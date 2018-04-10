//
//  FunctionalEntityStore.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 09.04.18.
//

import Foundation

open class FunctionalEntityStore<EntityType: CanBeIdentified>: EntityStore {
    
    public enum StoreError: Error {
        case functionNotImplementedYet
    }
    
    let persistEntites: (_ entities: [EntityType]) throws -> Void
    let deleteEntites: (_ entities: [EntityType]) throws -> Void
    let getEntities: ()->[EntityType]
    let getEntity: (_ identifier: String) -> EntityType?
    
    public convenience init(persistEntites: @escaping (_ entities: [EntityType]) throws -> Void,
                            deleteEntites: @escaping (_ entities: [EntityType]) throws -> Void,
                            getEntities: @escaping ()->[EntityType]) {
        
        let getEntity = { (aIdentifier) -> EntityType? in
            return getEntities().filter({ return $0.identifier() == aIdentifier }).first
        }
        
        self.init(persistEntites: persistEntites,
                  deleteEntites: deleteEntites,
                  getEntities: getEntities,
                  getEntity: getEntity)
    }
    
    
    public init(persistEntites: @escaping (_ entities: [EntityType]) throws -> Void,
                deleteEntites: @escaping (_ entities: [EntityType]) throws -> Void,
                getEntities: @escaping ()->[EntityType],
                getEntity: @escaping (_ identifier: String) -> EntityType?){
        self.persistEntites = persistEntites
        self.deleteEntites = deleteEntites
        self.getEntities = getEntities
        self.getEntity = getEntity
    }
    
    public func isResponsible<T>(for object: T) -> Bool {
        return object is EntityType
    }
    
    public func isResponsible<T>(forType type: T.Type) -> Bool {
         return type.self is EntityType.Type
    }
    
    public func delete<T>(_ item: T!) throws {
        if let item = item as? EntityType {
            try self.deleteEntites([item])
        }
    }
    
    public func delete<T>(_ items: [T]) throws {
        
        if T.self is EntityType.Type  {
            let convertedItems = items.map({ return $0 as! EntityType})
            try self.deleteEntites(convertedItems)
        }

    }
    
    public func delete<T>(_ item: T!,
                      completion: @escaping () -> ()) throws {
        try self.delete(item)
        completion()
    }
    
    public func get<T>(_ identifier: String) throws -> T? {
        return self.getEntity(identifier) as? T
    }
    
    public func get<T>(_ identifier: String,
                         completion: @escaping (T?) -> Void) throws {
        let item: T? = try self.get(identifier)
        completion(item)
    }
    
    public func persist<T>(_ item: T!) throws {
        if let item = item as? EntityType {
            try self.persistEntites([item])
        }
    }
    
    public func persist<T>(_ item: T!,
                       completion: @escaping () -> ()) throws {
        try self.persist(item)
        completion()
    }
    
    public func persist<T>(_ items: [T]) throws {
        if T.self is EntityType.Type {
            let convertedItems = items.map({ return $0 as! EntityType})
            try self.persistEntites(convertedItems)
        }
    }
    
    public func getAll<T>(_ type: T.Type) throws -> [T] {
        if T.self is EntityType {
            return self.getEntities().map { (entity) -> T in
                return entity as! T
            }
        } else {
            return [T]()
        }
    }
    
    public func getAll<T>(_ type: T.Type,
                      completion: @escaping ([T]) -> Void) throws {
        let items = try self.getAll(type)
        completion(items)
    }
    
    public func getAll<T>(_ viewName: String) throws -> [T] {
        throw StoreError.functionNotImplementedYet
    }
    
    public func getAll<T>(_ viewName: String,
                          completion: @escaping ([T]) -> Void) throws {
        throw StoreError.functionNotImplementedYet
    }
    
    public func getAll<T>(_ viewName: String,
                           groupName: String) throws -> [T] {
        throw StoreError.functionNotImplementedYet
    }
    
    public func getAll<T>(_ viewName: String,
                           groupName: String,
                          completion: @escaping ([T]) -> Void) throws {
        throw StoreError.functionNotImplementedYet
    }
    
    public func exists<T>(_ item: T!) throws -> Bool {
        
        guard T.self is EntityType.Type else {
            return false
        }
        
        if let item = item as? EntityType {
            
            let identifier = item.identifier()
            if let _ : T = try self.get(identifier)  {
                return true
            }
            
        }
        
        return false
    }
    
    public func exists<T>(_ item: T!,
                      completion: @escaping (Bool) -> Void) throws {
        let isExistent = try self.exists(item)
        completion(isExistent)
    }
    
    public func exists<T>(_ identifier: String,
                                  type: T.Type) throws -> Bool {
        
        guard T.self is EntityType.Type else {
            return false
        }
        
        if let _ : T = try self.get(identifier) {
            return true
        }
        
        return false
    }
    
    public func exists<T>(_ identifier: String,
                                  type: T.Type,
                            completion: @escaping (Bool) -> Void) throws {
        let isExistent = try self.exists(identifier, type: type)
        completion(isExistent)
    }
    
    public func filter<T>(_ type: T.Type,
                  includeElement: @escaping (T) -> Bool) throws -> [T] {
        return try self.getAll(type).filter(includeElement)
    }
    
    public func filter<T>(_ type: T.Type,
                  includeElement: @escaping (T) -> Bool,
                      completion: @escaping ([T]) -> Void) throws {
        let items: [T] = try self.filter(type, includeElement: includeElement)
        completion(items)
    }
    
    public func addView<T>(_ viewName: String,
                        groupingBlock: @escaping ((String, String, T) -> String?),
                         sortingBlock: @escaping ((String, String, String, T, String, String, T) -> ComparisonResult)) throws {
        throw StoreError.functionNotImplementedYet
    }
    
    public func transaction(transaction: @escaping (EntityStore) throws -> Void) throws {
        
        let items = self.getEntities()
        
        let transactionStore = try MemoryEntityStore([items])
        
        try transaction(transactionStore)
        
        for item in transactionStore.deletedEntities() {
            if let item = item as? EntityType {
                try self.delete(item)
            }
        }
        
        for item in transactionStore.updatedEntities() {
            if let item = item as? EntityType {
                try self.persist(item)
            }
        }
        
    }
    
    public func toTypedEntityStore() throws  -> TypedEntityStore<EntityType> {
        return try TypedEntityStore(entityStore: self)
    }
    
}
