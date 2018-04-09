//
//  MemoryEntityStore.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 06.04.18.
//

import Foundation

open class MemoryEntityStore: EntityStore {
   
    public enum StoreError: Error {
        case cannotExtractIdentifierFrom(item: Any)
        case functionNotImplementedYet
    }
    
    struct PersistenceItem {
        let identifier: String
        let updated: Bool
        let value: Any
        let deleted: Bool
        let type: Any.Type
    }
    
    var store = [String: [String: PersistenceItem]]()
    
    public init(){}
    
    public init(_ items: [Any]) throws {
        for item in items {
            try self.persist(item, markAsUpdated: false)
        }
    }
    
    public func isResponsible<T>(for object: T) -> Bool {
        return true
    }
    
    public func isResponsible<T>(forType type: T.Type) -> Bool {
        return true
    }
    
    public func get<T>(_ identifier: String) throws -> T? {
        
        let typeString = self.typeToKey(type: T.self)
        
        guard let typesDict = self.store[typeString] else {
            return nil
        }
        
        guard let persistenceItem = typesDict[identifier] else {
            return nil
        }
        
        guard persistenceItem.deleted == false else {
            return nil
        }
        
        return persistenceItem.value as? T
    }
    
    public func get<T>(_ identifier: String, completion: @escaping (T?) -> Void) throws {
        let item: T? = try self.get(identifier)
        completion(item)
    }
    
    public func delete<T>(_ item: T!) throws {
        
        guard let item = item else {
            return
        }
        
        let typeString = self.itemToKey(item: item)
        
        var typesDict: [String: PersistenceItem]
        
        if let dict = self.store[typeString] {
            typesDict = dict
        } else {
            typesDict = [String: PersistenceItem]()
        }
        
        let identifier = try self.identifierForItem(item: item)
        
        let persistenceItem = PersistenceItem(identifier: identifier,
                                              updated: false,
                                                value: item,
                                              deleted: true,
                                                 type: T.self)
        
        typesDict[identifier] = persistenceItem
        
        self.store[typeString] = typesDict
    }
    
    public func delete<T>(_ item: T!, completion: @escaping () -> ()) throws {
        try self.delete(item)
        completion()
    }
    
    public func persist<T>(_ item: T!) throws {
        try self.persist(item, markAsUpdated: true)
    }
    
    func persist<T>(_ item: T!, markAsUpdated: Bool) throws {
        
        guard let item = item else {
            return
        }
        
        let typeString = self.itemToKey(item: item)
        
        var typesDict: [String: PersistenceItem]
        
        if let dict = self.store[typeString] {
            typesDict = dict
        } else {
            typesDict = [String: PersistenceItem]()
        }
        
        let identifier = try self.identifierForItem(item: item)
        
        let persistenceItem = PersistenceItem(identifier: identifier,
                                                 updated: markAsUpdated,
                                                   value: item,
                                                 deleted: false,
                                                    type: T.self)
        
        typesDict[identifier] = persistenceItem
        
        self.store[typeString] = typesDict
    }
    
    public func persist<T>(_ item: T!, completion: @escaping () -> ()) throws {
        try self.persist(item)
        completion()
    }
    
    public func getAll<T>(_ type: T.Type) throws -> [T] {
        
        let typeString = self.typeToKey(type: T.self)
        
        guard let typesDict = self.store[typeString] else {
            return [T]()
        }
        
        var result = [T]()
        
        for (_,item) in typesDict.enumerated() {
            if item.value.deleted == false {
                if let value = item.value.value as? T{
                    result.append(value)
                }
            }
        }
        
        return result
    }
    
    public func getAll<T>(_ type: T.Type, completion: @escaping ([T]) -> Void) throws {
        let items: [T] = try self.getAll(T.self)
        completion(items)
    }
    
    public func getAll<T>(_ viewName: String) throws -> [T] {
        throw StoreError.functionNotImplementedYet
    }
    
    public func getAll<T>(_ viewName: String, completion: @escaping ([T]) -> Void) throws {
        throw StoreError.functionNotImplementedYet
    }
    
    public func getAll<T>(_ viewName: String, groupName: String) throws -> [T] {
        throw StoreError.functionNotImplementedYet
    }
    
    public func getAll<T>(_ viewName: String, groupName: String, completion: @escaping ([T]) -> Void) throws {
        throw StoreError.functionNotImplementedYet
    }
    
    public func exists<T>(_ item: T!) throws -> Bool {
        
        let typeString = self.itemToKey(item: item!)
        
        guard let typesDict = self.store[typeString] else {
            return false
        }
        
        let identifier = try self.identifierForItem(item: item)
        
        if let item = typesDict[identifier] {
            if item.deleted == false {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
        
    }
    
    public func exists<T>(_ item: T!, completion: @escaping (Bool) -> Void) throws {
        let doesExist = try self.exists(item)
        completion(doesExist)
    }
    
    public func exists<T>(_ identifier: String, type: T.Type) throws -> Bool {
        
        let typeString = self.typeToKey(type: T.self)
        
        guard let typesDict = self.store[typeString] else {
            return false
        }
        
        if let item = typesDict[identifier] {
            if item.deleted == false {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    public func exists<T>(_ identifier: String, type: T.Type, completion: @escaping (Bool) -> Void) throws {
        let doesExist = try self.exists(identifier, type: type)
        completion(doesExist)
    }
    
    public func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool) throws -> [T] {
        return try self.getAll(type).filter(includeElement)
    }
    
    public func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool, completion: @escaping ([T]) -> Void) throws {
        let items = try self.filter(type, includeElement: includeElement)
        completion(items)
    }
    
    public func addView<T>(_ viewName: String,
                        groupingBlock: @escaping ((String, String, T) -> String?),
                         sortingBlock: @escaping ((String, String, String, T, String, String, T) -> ComparisonResult)) throws {
        throw StoreError.functionNotImplementedYet
    }
    
    public func transaction(transaction: @escaping (EntityStore) throws -> Void) throws {
        
        let allEntities = self.allEntities()
        let transactionStore = try MemoryEntityStore(allEntities)
        
        try transaction(transactionStore)
        
        for entity in transactionStore.deletedEntities() {
            try self.delete(entity)
        }
      
        for entity in transactionStore.updatedEntities() {
           try self.persist(entity)
        }
        
    }
    
    public func allEntities() -> [Any] {
        var result = [Any]()
        
        for persistenceItemDict in self.store.enumerated() {
            for entry in persistenceItemDict.element.value.enumerated() {
                let item = entry.element.value
                if item.deleted == false {
                    result.append(item.value)
                }
            }
        }
        
        return result
    }
    
    public func updatedEntities() -> [Any] {
        var result = [Any]()
        
        for persistenceItemDict in self.store.enumerated() {
            for entry in persistenceItemDict.element.value.enumerated() {
                let item = entry.element.value
                if item.updated {
                    result.append(item.value)
                }
            }
        }
        
        return result
    }
    
    public func updatedEntities<T>(type: T.Type) -> [T] {
        let typeString = self.typeToKey(type: T.self)
        
        guard let typesDict = self.store[typeString] else {
            return [T]()
        }
        
        var result = [T]()
        
        for (_,item) in typesDict.enumerated() {
            if item.value.updated == true {
                if let value = item.value.value as? T{
                    result.append(value)
                }
            }
        }
        
        return result
        
    }
    
    public func deletedEntities<T>(type: T.Type) -> [T] {
        let typeString = self.typeToKey(type: T.self)
        
        guard let typesDict = self.store[typeString] else {
            return [T]()
        }
        
        var result = [T]()
        
        for (_,item) in typesDict.enumerated() {
            if item.value.deleted == true {
                if let value = item.value.value as? T{
                    result.append(value)
                }
            }
        }
        
        return result
        
    }
    
    public func deletedEntities() -> [Any] {
        var result = [Any]()
        
        for persistenceItemDict in self.store.enumerated() {
            for entry in persistenceItemDict.element.value.enumerated() {
                let item = entry.element.value
                if item.deleted {
                    result.append(item.value)
                }
            }
        }
        
        return result
    }
    
    public func cleanDeletedEntitesFromMemory() {
        var tempStore = [String: [String: PersistenceItem]]()
        
        for type in self.store.enumerated() {
            
            var typeDict = [String: PersistenceItem]()
            
            for item in type.element.value.enumerated() {
                if item.element.value.deleted == false {
                    typeDict[item.element.key] = item.element.value
                }
            }
            
            tempStore[type.element.key] = typeDict
        }
        
        self.store = tempStore
    }
    
    func identifierForItem<T>(item: T) throws -> String {
        
        if let item = item as? CanBeIdentified {
            return item.identifier()
        }
        
        if let item = item as? CustomStringConvertible {
            return item.description
        }
        
        throw StoreError.cannotExtractIdentifierFrom(item: item)
    }
    
    func typeToKey<T>(type aType: T.Type) -> String {
        return String(reflecting: aType)
    }
    
    func itemToKey(item: Any) -> String {
        return String(reflecting: type(of:item))
    }
    
}
