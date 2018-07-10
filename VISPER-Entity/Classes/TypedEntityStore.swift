
//
//  AnyTypedPersistenceStore.swift
//  Pods
//
//  Created by Jan Bartel on 09.05.17.
//
//
public struct TypedEntityStore<Type> {
    
    public typealias EntityType = Type
    
    public let entityStore: EntityStore
    
    public enum StoreError: Error {
        case entityStoreIsNotResponsibleForType(store: EntityStore, type: Any.Type)
        case typeShouldBeASubTypeOfType(type: Type.Type, subType: Any.Type)
    }
    
    public init(entityStore: EntityStore) throws {
        if entityStore.isResponsible(forType: Type.self) {
            self.entityStore = entityStore
        } else {
            throw StoreError.entityStoreIsNotResponsibleForType(store: entityStore, type: Type.self)
        }
    }
    
    public func store<T>(forType type: T.Type) throws -> TypedEntityStore<T>{
        if self.entityStore.isResponsible(forType: type) {
            return try TypedEntityStore<T>(entityStore: self.entityStore)
        } else {
            throw StoreError.entityStoreIsNotResponsibleForType(store: self.entityStore, type: type)
        }
    }
    
    public func version() -> Int {
        return self.entityStore.version()
    }
    
    public func persist(_ item: Type) throws {
        try self.entityStore.persist(item)
    }
    
    public func persist(_ item: Type,
                    completion: @escaping () -> ()) throws {
        try self.entityStore.persist(item, completion: completion)
    }
    
    public func delete(_ item: Type) throws {
        try self.entityStore.delete(item)
    }
    
    public func delete(_ item: Type,
                   completion: @escaping () -> ()) throws {
        try self.entityStore.delete(item, completion: completion)
    }
    
    public func delete(_ identifier: String,
                               type: Type.Type = Type.self,
                         completion: @escaping () -> ()) throws {
        try self.entityStore.delete(identifier, type: type, completion: completion)
    }
    
    public func delete(_ identifier: String, type: Type.Type = Type.self) throws {
        try self.entityStore.delete(identifier, type: type)
    }
    
    public func get(_ identifier: String,
                            type: Type.Type = Type.self) throws -> Type? {
        return try self.entityStore.get(identifier, type: type)
    }
    
    public func get(_ identifier: String,
                            type: Type.Type = Type.self,
                      completion: @escaping (_ item: Type?) -> Void ) throws {
        return try self.entityStore.get(identifier, type: type, completion: completion)
    }
    
    public func getAll(type: Type.Type = Type.self) throws -> [Type] {
        return try self.entityStore.getAll(type)
    }
    
    public func getAll(type: Type.Type = Type.self,
                 completion: @escaping (_ items: [Type]) -> Void) throws {
        return try self.entityStore.getAll(type, completion: completion)
    }
    
    public func getAll(_ viewName:String) throws ->[Type] {
        return try self.entityStore.getAll(viewName)
    }
    
    public func getAll(_ viewName: String,
                       completion: @escaping (_ items: [Type]) -> Void) throws {
        return try self.entityStore.getAll(viewName, completion: completion)
    }
    
    public func getAll(_ viewName: String,
                        groupName: String) throws ->[Type] {
        return try self.entityStore.getAll(viewName, groupName: groupName)
    }
    
    public func getAll(_ viewName: String,
                        groupName: String,
                       completion: @escaping (_ items: [Type]) -> Void) throws {
        return try self.entityStore.getAll(viewName, groupName: groupName, completion: completion)
    }
    
    public func exists(_ item: Type) throws -> Bool {
        return try self.entityStore.exists(item)
    }
    
    public func exists(_ item: Type,
                   completion: @escaping (_ exists: Bool) -> Void) throws {
        return try self.entityStore.exists(item, completion: completion)
    }
    
    public func exists<T>(_ identifier: String,
                               type: T.Type) throws -> Bool {
        return try self.entityStore.exists(identifier, type: type)
    }
    
    public func exists<T>(_ identifier: String,
                               type: T.Type,
                         completion: @escaping (_ exists: Bool) -> Void) throws {
        return try self.entityStore.exists(identifier, type: type, completion: completion)
    }
    
    public func filter(type: Type.Type = Type.self,
             includeElement: @escaping (Type) -> Bool) throws -> [Type] {
        return try self.entityStore.filter(type, includeElement: includeElement)
    }
    
    public func filter(type: Type.Type = Type.self,
             includeElement: @escaping (Type) -> Bool,
                 completion: @escaping (_ items: [Type]) -> Void) throws {
        return try self.entityStore.filter(type, includeElement: includeElement, completion: completion)
    }
    
    public func addView(_ viewName: String,
                        groupingBlock: @escaping ((_ collection: String,
                                                          _ key: String,
                                                       _ object: Type)->String?),
                    
                    sortingBlock: @escaping ((     _ group: String,
                                             _ collection1: String,
                                                    _ key1: String,
                                                 _ object1: Type,
                                             _ collection2: String,
                                                    _ key2: String,
                                                 _ object2: Type) -> ComparisonResult)) throws {
        try self.entityStore.addView(viewName,
                                groupingBlock: groupingBlock,
                                 sortingBlock: sortingBlock)
    }
    
    
    func transaction(transaction: @escaping (_ transactionStore: TypedEntityStore<Type>) throws -> Void) throws {
        
        let transactionBlock = { (entityStore:EntityStore) throws -> Void  in
            
            let typedStore = try TypedEntityStore(entityStore: entityStore)
            try transaction(typedStore)
            
        }
        
        
        try self.entityStore.transaction(transaction: transactionBlock)
    }
    
}
