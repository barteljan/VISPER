//
//  EntityStoreTests.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 03.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest
import VISPER_Entity



class TypedEntityStoreTests: XCTestCase {
    
    func createUntypedStore() -> MockEntityStore {
        let untypedEntityStore = MockEntityStore()
        untypedEntityStore.stubbedIsResponsibleForTypeResult = true
        return untypedEntityStore
    }
    
    func testInitTypedStoreWithCorrectEntityStore(){
        let untypedEntityStore = self.createUntypedStore()
        XCTAssertNoThrow(try TypedEntityStore<User>(entityStore: untypedEntityStore))
    }
    
    func testInitTypedStoreWithWrongEntityStore() {
        let untypedEntityStore = MockEntityStore()
        untypedEntityStore.stubbedIsResponsibleForTypeResult = false
        
        XCTAssertThrowsError(try TypedEntityStore<User>(entityStore: untypedEntityStore), "Should throw an error") { (error) in
            
                                switch error {
                                case TypedEntityStore<User>.StoreError.entityStoreIsNotResponsibleForType(let store, _):
                                    
                                    if let store = store as? MockEntityStore {
                                        XCTAssertEqual(store, untypedEntityStore)
                                    } else {
                                        XCTFail("throws correct error: \(error) with wrong store: \(store)")
                                    }
                                    
                                    
                                default:
                                    XCTFail("throws wrong error: \(error)")
                                }
                                
        }
        
    }
    
   
    
    func testGetStore() {
        
        let untypedEntityStore = self.createUntypedStore()
        
        do {
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let _ : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
        
    }
    
    func testVersion(){
        let untypedEntityStore = self.createUntypedStore()
        untypedEntityStore.stubbedVersionResult = 1
        
        do {
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            let  version = typedStore.version()
            XCTAssertTrue(untypedEntityStore.invokedVersion)
            XCTAssertEqual(version, untypedEntityStore.version())
            
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
    }
    
    func testPersistItem() {
        
        let untypedEntityStore = self.createUntypedStore()
        
        
        do {
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            
            let user = User(name: "jan")
            try typedStore.persist(user)
            
            XCTAssertTrue(untypedEntityStore.invokedPersist)
            XCTAssertEqual(user, untypedEntityStore.invokedPersistParameters?.item as! User?)
            
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testPersistItemWithCompletion(){
        
        let untypedEntityStore = self.createUntypedStore()
        
        do {
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            
            let expect = self.expectation(description: "completion called")
            
            let user = User(name: "jan")
            try typedStore.persist(user, completion: {
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
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            
            let user = User(name: "jan")
            try typedStore.delete(user)
            
            XCTAssertTrue(untypedEntityStore.invokedDelete)
            XCTAssertEqual(user, untypedEntityStore.invokedDeleteParameters?.item as! User?)
            
            
        } catch let error {
            XCTFail("failes with error: \(error)")
        }
        
    }
    
    func testDeleteItemWithCompletion() {
        let untypedEntityStore = self.createUntypedStore()
        
        do {
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            
            let expect = self.expectation(description: "completion called")
            
            let user = User(name: "jan")
            try typedStore.delete(user, completion: {
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
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            
            try typedStore.delete(user.name)
            
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
            let nsCodingStore = try TypedEntityStore<NSCoding>(entityStore: untypedEntityStore)
            let typedStore : TypedEntityStore<UserProtocol> = try nsCodingStore.store(forType: UserProtocol.self)
            
            let expect = self.expectation(description: "completion called")
            
            try typedStore.delete(user.name,completion: {
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
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
            
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            try store.get(user.name) { (aUser) in
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            XCTAssertEqual(try store.getAll(), untypedEntityStore.stubbedGetAllTTypeResult as! [User])
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            try store.getAll() { (users) in
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            try store.getAll( "testView") { (users) in
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            try store.getAll("testView", groupName: "testGroup") { (users) in
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            try store.exists(user.name,type: User.self, completion: { (exists) in
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            
            XCTAssertEqual(
                try store.filter(includeElement: { (user) -> Bool in
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
            let store = try TypedEntityStore<User>(entityStore: untypedEntityStore)
            try store.filter(includeElement: { (user) -> Bool in
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
    
}
