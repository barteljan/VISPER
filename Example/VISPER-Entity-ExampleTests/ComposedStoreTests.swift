//
//  ComposedStoreTests.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 03.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_Entity

class ComposedStoreTests: XCTestCase {
    

    func testAddStore() {
        
        let nsCodingStore = MockNSCodingEntityStore()
        let anyNSCodingStore = AnyTypedEntityStore(nsCodingStore)
        
        let userStore = MockUserEntityStore()
        let anyUserStore = AnyTypedEntityStore(userStore)
        
        
        let composedStore = ComposedEntityStore<NSCoding>()
        
        composedStore.add(store: anyNSCodingStore)
        composedStore.add(store: anyUserStore)
        
        composedStore.add(store: anyUserStore, entityType: User.self)
        
        
    }
    
 
    
}
