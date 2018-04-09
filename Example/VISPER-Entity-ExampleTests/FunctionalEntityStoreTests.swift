//
//  FunctionalEntityStoreTests.swift
//  
//
//  Created by bartel on 09.04.18.
//

import XCTest
import VISPER_Entity


class FunctionalEntityStoreTests: XCTestCase {
    
    func testGet() throws {
        
        let expect = self.expectation(description: "callback called")
        
        let store = FunctionalEntityStore<User>(persistEntites: { _ in },
                                                 deleteEntites: { _ in },
                                                 getEntities: {  return [User]()},
                                                     getEntity: { identifier in
                                                        expect.fulfill()
                                                        return User(name:identifier)
        })
        
        let user: User? = try store.get("jan")
        
        self.wait(for: [expect], timeout: 0.5)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.name, "jan")
    }
    
    func testGetWithoutGetEntity() throws {
        
        let expect = self.expectation(description: "callback called")
        
        let store = FunctionalEntityStore<User>(persistEntites: { _ in },
                                                deleteEntites: { _ in },
                                                getEntities: {
                                                    expect.fulfill()
                                                    return [User(name:"jan")]
        })
        
        let user: User? = try store.get("jan")
        
        self.wait(for: [expect], timeout: 0.5)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.name, "jan")
    }
    
    func testPersist() throws {
        let expect = self.expectation(description: "callback called")
        
        let user = User(name:"Jan")
        
        let store = FunctionalEntityStore<User>(persistEntites: { entities in
                                                    expect.fulfill()
                                                    XCTAssertTrue(entities.count == 1)
                                                    if entities.count > 0{
                                                        let entity = entities[0]
                                                        XCTAssertEqual(entity, user)
                                                    }
                                                },
                                                deleteEntites: { _ in },
                                                getEntities: {  return [User]()})
        
         try store.persist(user)
         self.wait(for: [expect], timeout: 0.5)
        
    }
    
    func testPersistMoreThanOneItem() throws {
        let expect = self.expectation(description: "callback called")
        
        let users = [User(name:"Jan"),User(name:"Peter")]
        
        let store = FunctionalEntityStore<User>(persistEntites: { entities in
                                                    expect.fulfill()
                                                    XCTAssertTrue(entities.count == 2)
                                                    if entities.count == 2 {
                                                        var entity = entities[0]
                                                        XCTAssertEqual(entity, users[0])
                                                        
                                                        entity = entities[1]
                                                        XCTAssertEqual(entity, users[1])
                                                    }
                                                },
                                                deleteEntites: { _ in },
                                                getEntities: {  return [User]()})
        
        try store.persist(users)
        self.wait(for: [expect], timeout: 0.5)
        
    }
    
    func testDelete() throws {
        
        let expect = self.expectation(description: "callback called")
        
        let user = User(name:"Jan")
        
        let store = FunctionalEntityStore<User>(persistEntites: { _ in },
                                                    deleteEntites: { entities in
                                                        expect.fulfill()
                                                        XCTAssertTrue(entities.count == 1)
                                                        if entities.count > 0{
                                                            let entity = entities[0]
                                                            XCTAssertEqual(entity, user)
                                                        }
                                                },
                                                getEntities: {  return [User]()})
        
        try store.delete(user)
        self.wait(for: [expect], timeout: 0.5)
        
    }
    
    func testDeleteMoreThanOneItem() throws {
        let expect = self.expectation(description: "callback called")
        
        let users = [User(name:"Jan"),User(name:"Peter")]
        
        let store = FunctionalEntityStore<User>(persistEntites: { _ in },
                                                deleteEntites: { entities in
                                                    expect.fulfill()
                                                    XCTAssertTrue(entities.count == 2)
                                                    if entities.count == 2 {
                                                        var entity = entities[0]
                                                        XCTAssertEqual(entity, users[0])
                                                        
                                                        entity = entities[1]
                                                        XCTAssertEqual(entity, users[1])
                                                    }
                                                },
                                                getEntities: {  return [User]()})
        
        try store.delete(users)
        self.wait(for: [expect], timeout: 0.5)
        
    }
    
    
}
