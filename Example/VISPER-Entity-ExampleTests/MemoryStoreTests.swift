//
//  MemoryStoreTests.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 06.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_Entity

class MemoryStoreTests: XCTestCase {
    
    func createStore<T>(models: [T]) throws -> MemoryEntityStore {
        let store = try MemoryEntityStore(models)
        return store
    }
    
    func testPersist() throws {
        
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [User]())
        
        try store.persist(user)
    
        let storedUser: User? = try store.get(identifier)
        XCTAssertEqual(user, storedUser)
    }
    
    func testGet() throws {
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [user])
        
        let storedUser: User? = try store.get(identifier)
        XCTAssertEqual(user, storedUser)
    }
    
    func testDelete() throws {
        
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [User]())
        
        try store.persist(user)
        
        let storedUser: User? = try store.get(identifier)
        XCTAssertEqual(user, storedUser)
        
        try store.delete(user)
        let storedUserAfterDeletion: User? = try store.get(identifier)
        XCTAssertNil(storedUserAfterDeletion)
        
    }
    
    func testDeletedEntities() throws {
        
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [user])
        try store.delete(user)
        
        let deletedItems = store.deletedEntities()
        XCTAssertTrue(deletedItems.count == 1)
        XCTAssertEqual(deletedItems[0] as? User, user)
    }
    
    func testDeletedEntitiesEmptyWithoutDelete() throws {
        
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [user])
        
        let deletedItems = store.deletedEntities()
        XCTAssertTrue(deletedItems.count == 0)
    }
    
    func testUpdatedEntites() throws {
        
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [user])
        try store.persist(user)
        
        let updatedEntities = store.updatedEntities()
        XCTAssertTrue(updatedEntities.count == 1)
        XCTAssertEqual(updatedEntities[0] as? User, user)
    }
    
    func testUpdatedEntitiesEmptyWithoutPersist() throws {
        
        let identifier = "jan"
        let user = User(name: identifier)
        
        let store = try self.createStore(models: [user])
        
        let updatedEntities = store.updatedEntities()
        XCTAssertTrue(updatedEntities.count == 0)
    }
    
    
    func testAllEntites() throws {
        
        let user = User(name: "jan")
        let user2 = User(name: "klaus")
        
        let store = try self.createStore(models: [user,user2])
        try store.delete(user2)
        
        let allEntites = store.allEntities()
        XCTAssertTrue(allEntites.count == 1)
        XCTAssertEqual(allEntites[0] as? User, user)
    }
    
    
    func testTransaction() throws {
        
        let user = User(name: "jan")
        let user2 = User(name: "klaus")
        
        let store = try self.createStore(models: [user])
        XCTAssertTrue(try store.exists(user))
        XCTAssertFalse(try store.exists(user2))
        
        let expect = self.expectation(description: "transaction called")
        
        try store.transaction { (transactionStore) in
            
            try transactionStore.persist(user2)
            try transactionStore.delete(user)
            
            XCTAssertTrue(try store.exists(user))
            XCTAssertFalse(try store.exists(user2))
            
            XCTAssertFalse(try transactionStore.exists(user))
            XCTAssertTrue(try transactionStore.exists(user2))
            
            expect.fulfill()
        }
        
        self.wait(for: [expect], timeout: 0.5)
        XCTAssertFalse(try store.exists(user))
        XCTAssertTrue(try store.exists(user2))
    }
}
