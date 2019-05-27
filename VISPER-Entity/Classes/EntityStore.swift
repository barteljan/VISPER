//
//  TypedPersistenceStoreProtocol.swift
//  Pods
//
//  Created by Jan Bartel on 09.05.17.
//
//

import Foundation

public protocol EntityStore {

    func version() -> Int
    
    func isResponsible<T>(for object: T) -> Bool
    func isResponsible<T>(forType type: T.Type) -> Bool

    func persist<T>(_ item: T!) throws
    func persist<T>(_ items: [T]) throws
    func persist<T>(_ item: T!,completion: @escaping () -> ()) throws
    
    func delete<T>(_ item: T!) throws
    func delete<T>(_ items: [T]) throws
    func delete<T>(_ item: T!, completion: @escaping () -> ()) throws
    func delete<T>(_ identifier: String, type: T.Type) throws 
    
    func get<T>(_ identifier: String) throws -> T?
    func get<T>(_ identifier: String, completion: @escaping (_ item: T?) -> Void ) throws
    
    func getAll<T>(_ type: T.Type) throws -> [T]
    func getAll<T>(_ type: T.Type, completion: @escaping (_ items: [T]) -> Void) throws
    
    func getAll<T>(_ viewName:String) throws ->[T]
    func getAll<T>(_ viewName:String, completion: @escaping (_ items: [T]) -> Void) throws
    
    func getAll<T>(_ viewName:String,groupName:String) throws ->[T]
    func getAll<T>(_ viewName:String,groupName:String, completion: @escaping (_ items: [T]) -> Void) throws
    
    func exists<T>(_ item : T!) throws -> Bool
    func exists<T>(_ item : T!, completion: @escaping (_ exists: Bool) -> Void) throws
    
    
    func exists<T>(_ identifier : String,type : T.Type) throws -> Bool
    func exists<T>(_ identifier : String,type : T.Type,  completion: @escaping (_ exists: Bool) -> Void) throws
    
    func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool) throws -> [T]
    func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool, completion: @escaping (_ items: [T]) -> Void) throws
    
    func addView<T>(_ viewName: String,
                 groupingBlock: @escaping ((_ collection: String,
        _ key: String,
        _ object: T)->String?),
                 
                 sortingBlock: @escaping ((     _ group: String,
        _ collection1: String,
        _ key1: String,
        _ object1: T,
        _ collection2: String,
        _ key2: String,
        _ object2: T) -> ComparisonResult)) throws
    
    
    func transaction(transaction: @escaping (_ transactionStore: EntityStore) throws -> Void) throws
    
}

public extension EntityStore {
    
    public func version() -> Int {
        return 0;
    }
    
    public func persist<T>(_ items: [T]) throws {
        for item in items {
            try self.persist(item)
        }
    }

    
    func delete<T>(_ items: [T]) throws {
        for item in items {
            try self.delete(item)
        }
    }
    
    public func delete<T>(_ identifier: String, type: T.Type, completion: @escaping () -> ())  throws {
        try self.get(identifier) { (item: T?) in
            
            if let item = item {
                try? self.delete(item, completion: completion)
            } else {
                completion()
            }
        }
    }
    
    public func delete<T>(_ identifier: String, type: T.Type) throws {
        if let item: T = try self.get(identifier){
            try self.delete(item)
        }
    }
 
    public func get<T>(_ identifier: String, type: T.Type) throws -> T? {
        let item: T? = try self.get(identifier)
        return item
    }
    
    
    public func get<T>(_ identifier: String, type: T.Type, completion: @escaping (_ item: T?) -> Void ) throws {
        try self.get(identifier, completion: { (item: T?) in
            completion(item)
        })
    }
    
}
