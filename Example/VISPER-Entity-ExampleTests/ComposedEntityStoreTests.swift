//
//  ComposedEntityStoreTest.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 06.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_Entity

class ComposedEntityStoreTests: XCTestCase {
    
    func createUntypedStore() -> MockEntityStore {
        let untypedEntityStore = MockEntityStore()
        untypedEntityStore.stubbedIsResponsibleForTypeResult = true
        return untypedEntityStore
    }
    
    func testAddStore() throws {
        
        let mockStore = MockEntityStore()
        mockStore.stubbedIsResponsibleForTypeResult = true
        let typedStore = try TypedEntityStore<User>(entityStore: mockStore)
        
        let composedStore = ComposedEntityStore()
        composedStore.add(store:typedStore)
    }
    
    func testAddStoreSorting() throws {
        
        let mockStore1 = MockEntityStore()
        mockStore1.stubbedIsResponsibleForTypeResult = true
        let typedStore1 = try TypedEntityStore<User>(entityStore: mockStore1)
        
        let mockStore2 = MockEntityStore()
        mockStore2.stubbedIsResponsibleForTypeResult = true
        let typedStore2 = try TypedEntityStore<User>(entityStore: mockStore2)
        
        let mockStore3 = MockEntityStore()
        mockStore3.stubbedIsResponsibleForTypeResult = true
        let typedStore3 = try TypedEntityStore<User>(entityStore: mockStore3)

        let composedStore = ComposedEntityStore()
        composedStore.add(store: typedStore1, priority: 5)
        composedStore.add(store: typedStore2, priority: 0)
        composedStore.add(store: typedStore3, priority: 10)
        
        XCTAssertEqual(composedStore.wrappers[0].priority,10)
        XCTAssertEqual(composedStore.wrappers[1].priority,5)
        XCTAssertEqual(composedStore.wrappers[2].priority,0)
        
        XCTAssertEqual(composedStore.wrappers[0].entityStore as! MockEntityStore,mockStore3)
        XCTAssertEqual(composedStore.wrappers[1].entityStore as! MockEntityStore,mockStore1)
        XCTAssertEqual(composedStore.wrappers[2].entityStore as! MockEntityStore,mockStore2)
        
    }
    
    
    func testIsResponsibleForType() throws{
        
        let mockStore = MockEntityStore()
        mockStore.stubbedIsResponsibleForTypeResult = true
        let typedStore = try TypedEntityStore<User>(entityStore: mockStore)
        
        let composedStore = ComposedEntityStore()
        composedStore.add(store:typedStore)
        
        XCTAssertTrue(composedStore.isResponsible(forType: User.self))
    }
    
    func testIsNotResponsibleForWrongType() throws{
        
        let mockStore = MockEntityStore()
        mockStore.stubbedIsResponsibleForTypeResult = true
        let typedStore = try TypedEntityStore<User>(entityStore: mockStore)
        
        let composedStore = ComposedEntityStore()
        composedStore.add(store:typedStore)
        
        XCTAssertFalse(composedStore.isResponsible(forType: UIViewController.self))
    }
    
    func testIsResponsibleForItem() throws{
        
        let mockStore = MockEntityStore()
        mockStore.stubbedIsResponsibleForResult = true
        mockStore.stubbedIsResponsibleForTypeResult = true
        let typedStore = try TypedEntityStore<User>(entityStore: mockStore)
        
        let composedStore = ComposedEntityStore()
        composedStore.add(store:typedStore)
        
        let user = User(name: "jan")
        
        XCTAssertTrue(composedStore.isResponsible(for: user))
    }
    
    func testIsNotResponsibleForWrongItem() throws{
        
        let mockStore = MockEntityStore()
        mockStore.stubbedIsResponsibleForTypeResult = true
        let typedStore = try TypedEntityStore<User>(entityStore: mockStore)
        
        let composedStore = ComposedEntityStore()
        composedStore.add(store:typedStore)
        
        XCTAssertFalse(composedStore.isResponsible(for: UIViewController()))
    }
    
    
    func testVersion(){
       let store = ComposedEntityStore(version: 5)
       XCTAssertEqual(store.version(), 5)
    }
    
    func testPersistItem() {
        let untypedEntityStore = self.createUntypedStore()
        
        
        do {
            let typedStore : TypedEntityStore<User> = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            let user = User(name: "jan")
            try store.persist(user)
            
            XCTAssertTrue(untypedEntityStore.invokedPersist)
            XCTAssertEqual(user, untypedEntityStore.invokedPersistParameters?.item as! User?)
            
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testPersistItemWithCompletion(){
        let untypedEntityStore = self.createUntypedStore()
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            let expect = self.expectation(description: "completion called")
            
            let user = User(name: "jan")
            try store.persist(user, completion: {
                XCTAssertTrue(untypedEntityStore.invokedPersistCompletion)
                XCTAssertEqual(user, untypedEntityStore.invokedPersistCompletionParameters?.item as! User?)
                expect.fulfill()
            })
            
            self.wait(for: [expect], timeout: 0.5)
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testDeleteItem(){
        
        let untypedEntityStore = self.createUntypedStore()

        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            let user = User(name: "jan")
            try store.delete(user)
            
            XCTAssertTrue(untypedEntityStore.invokedDelete)
            XCTAssertEqual(user, untypedEntityStore.invokedDeleteParameters?.item as! User?)
            
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testDeleteItemWithCompletion() {
        let untypedEntityStore = self.createUntypedStore()
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            let expect = self.expectation(description: "completion called")
            
            let user = User(name: "jan")
            try store.delete(user, completion: {
                XCTAssertTrue(untypedEntityStore.invokedDeleteCompletion)
                XCTAssertEqual(user, untypedEntityStore.invokedDeleteCompletionParameters?.item as! User?)
                expect.fulfill()
            })
            
            self.wait(for: [expect], timeout: 0.5)
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testDeleteItemWithIdentifier(){
       
        let untypedEntityStore = self.createUntypedStore()
        let user = User(name: "Jan")
        untypedEntityStore.stubbedGetResult = user
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.delete(user.name, type: User.self)
            
            XCTAssertTrue(untypedEntityStore.invokedDelete)
            
            if let calledUser = untypedEntityStore.invokedDeleteParameters?.item as? User {
                XCTAssertEqual(user.name, calledUser.name)
            } else {
                XCTFail("User was not delivered to entity store")
            }
            
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testDeleteItemWithIdentifierAndCompletion(){
        let untypedEntityStore = self.createUntypedStore()
        let user = User(name: "Jan")
        untypedEntityStore.stubbedGetCompletionCompletionResult = user
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            let expect = self.expectation(description: "completion called")
            
            try store.delete(user.name, type: User.self, completion: {
                XCTAssertTrue(untypedEntityStore.invokedDeleteCompletion)
                
                if let calledUser = untypedEntityStore.invokedDeleteCompletionParameters?.item as? User {
                    XCTAssertEqual(user.name, calledUser.name)
                } else {
                    XCTFail("User was not delivered to entity store")
                }
                expect.fulfill()
            })
            
            self.wait(for: [expect], timeout: 0.5)
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testGetItem(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetResult = user
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertEqual(try store.get("jan"), user)
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testGetItemWithCompletion(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetCompletionCompletionResult = user
        
        do {
            
            let expect = self.expectation(description: "Did Call completion")
            
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.get(user.name, type: User.self) { (aUser) in
                XCTAssertTrue(untypedEntityStore.invokedGetCompletion)
                XCTAssertEqual(aUser, user)
                expect.fulfill()
            }
            
            self.wait(for: [expect], timeout: 0.5)
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testGetAll(){
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetAllTTypeResult = [user]
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertEqual(try store.getAll(User.self), untypedEntityStore.stubbedGetAllTTypeResult as! [User])
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testGetAllWithCompletion(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetAllTTypeCompletionCompletionResult = [user]
        
        let expect = self.expectation(description: "Did Call completion")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.getAll(User.self) { (users) in
                XCTAssertTrue(untypedEntityStore.invokedGetAllTTypeCompletion)
                XCTAssertEqual(users, untypedEntityStore.stubbedGetAllTTypeCompletionCompletionResult as! [User])
                expect.fulfill()
            }
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        self.wait(for: [expect], timeout: 0.5)
        
    }
    
    
    func testGetAllOfView(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetAllStringResult = [user]
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertEqual(try store.getAll("testView"), untypedEntityStore.stubbedGetAllStringResult as! [User])
            XCTAssertEqual("testView", untypedEntityStore.invokedGetAllStringParameters?.viewName)
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testGetAllOfViewWithCompletion(){
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetAllStringCompletionCompletionResult = [user]
        
        let expect = self.expectation(description: "Did Call completion")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.getAll("testView") { (users: [User]) in
                XCTAssertTrue(untypedEntityStore.invokedGetAllStringCompletion)
                XCTAssertEqual(users, untypedEntityStore.stubbedGetAllStringCompletionCompletionResult as! [User])
                XCTAssertEqual("testView", untypedEntityStore.invokedGetAllStringCompletionParameters?.viewName)
                expect.fulfill()
            }
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        self.wait(for: [expect], timeout: 0.5)
    }
    
    func testGetAllOfViewAndGroup(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetAllGroupNameResult = [user]
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertEqual(try store.getAll("testView", groupName: "testGroup"), untypedEntityStore.stubbedGetAllGroupNameResult as! [User])
            XCTAssertEqual("testView", untypedEntityStore.invokedGetAllGroupNameParameters?.viewName)
            XCTAssertEqual("testGroup", untypedEntityStore.invokedGetAllGroupNameParameters?.groupName)
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testGetAllOfViewAndGroupAndCompletion(){
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedGetAllGroupNameCompletionCompletionResult = [user]
        
        let expect = self.expectation(description: "Did Call completion")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.getAll("testView", groupName: "testGroup") { (users:[User]) in
                XCTAssertTrue(untypedEntityStore.invokedGetAllGroupNameCompletion)
                XCTAssertEqual(users, untypedEntityStore.stubbedGetAllGroupNameCompletionCompletionResult as! [User])
                XCTAssertEqual("testView", untypedEntityStore.invokedGetAllGroupNameCompletionParameters?.viewName)
                XCTAssertEqual("testGroup", untypedEntityStore.invokedGetAllGroupNameCompletionParameters?.groupName)
                expect.fulfill()
            }
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        self.wait(for: [expect], timeout: 0.5)
    }
    
    func testExists() {
        
        let untypedEntityStore = self.createUntypedStore()
        untypedEntityStore.stubbedExistsResult = true
        
        let user = User(name: "jan")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertTrue(try store.exists(user))
            XCTAssertTrue(untypedEntityStore.invokedExists)
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testExistsWithCompletion() {
        let untypedEntityStore = self.createUntypedStore()
        untypedEntityStore.stubbedExistsCompletionCompletionResult = true
        
        let user = User(name: "jan")
        
        let expect = self.expectation(description: "Did Call completion")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.exists(user, completion: { (exists) in
                XCTAssertTrue(untypedEntityStore.invokedExistsCompletion)
                XCTAssertTrue(exists)
                expect.fulfill()
            })
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        self.wait(for: [expect], timeout: 0.5)
    }
    
    func testExistsWithIdentifier() {
        
        let untypedEntityStore = self.createUntypedStore()
        untypedEntityStore.stubbedExistsTypeResult = true
        
        let user = User(name: "jan")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertTrue(try store.exists(user.name,type: User.self))
            XCTAssertTrue(untypedEntityStore.invokedExistsType)
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testExistsWithIdentifierAndCompletion() {
        
        let untypedEntityStore = self.createUntypedStore()
        untypedEntityStore.stubbedExistsTypeCompletionCompletionResult = true
        
        let user = User(name: "jan")
        
        let expect = self.expectation(description: "Did Call completion")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.exists(user.name, type: User.self, completion: { (exists) in
                XCTAssertTrue(untypedEntityStore.invokedExistsTypeCompletion)
                XCTAssertTrue(exists)
                expect.fulfill()
            })
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        self.wait(for: [expect], timeout: 0.5)
    }
    
    func testFilter(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedFilterResult = [user]
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertEqual(
                try store.filter(User.self, includeElement: { (user: User) -> Bool in
                    return true
                }),
                untypedEntityStore.stubbedFilterResult as! [User]
            )
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testFilterWithCompletion() {
        
        let untypedEntityStore = self.createUntypedStore()
        
        let user = User(name: "jan")
        untypedEntityStore.stubbedFilterIncludeElementCompletionResult = [user]
        
        let expect = self.expectation(description: "Did Call completion")
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            try store.filter(User.self, includeElement: { (user) -> Bool in
                return true
            }, completion:  { (users) in
                XCTAssertTrue(untypedEntityStore.invokedFilterIncludeElement)
                XCTAssertEqual(users, untypedEntityStore.stubbedFilterIncludeElementCompletionResult as! [User])
                expect.fulfill()
            })
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        self.wait(for: [expect], timeout: 0.5)
    }
    
    func testTransaction() throws {
        
        let user = User(name: "jan")
        let user2 = User(name: "klaus")
        
        let untypedEntityStore = MemoryEntityStore()
        
        do {
            let typedStore = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            let store = ComposedEntityStore()
            store.add(store: typedStore)
            
            XCTAssertFalse(try store.exists(user))
            
            try store.persist(user)
            
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
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        
    }
    
   
    
}
