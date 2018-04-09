//
//  StringTests.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 07.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import XCTest





class StringTests: XCTestCase {
    
    struct TestStruct {
        
    }
    
    class TestClass {
        
    }
   
    func key(item: Any) -> String{
        return String(reflecting: item)
    }
    
    func aKey<T>(item: T) -> String{
        return String(reflecting: item)
    }
    
    func typeKey(type: Any.Type) -> String {
        return String(reflecting: type)
    }
    
    func aTypeKey<T>(type: T.Type) -> String {
        return String(reflecting: type)
    }

    
    func testExample() {
        
        let testStruct = TestStruct()
        let testClass = TestClass()
        var arr : [Any] = [Any]()
        arr.append(testStruct)
        arr.append(testClass)
        
        print(key(item: testStruct))
        print(key(item: testClass))
        arr.forEach { (item) in
            print(key(item: item))
        }
        print("------------------------------------------------------")
        print(aKey(item: testStruct))
        print(aKey(item: testClass))
        arr.forEach { (item) in
            print(aKey(item: item))
        }
        print("------------------------------------------------------")
        print(typeKey(type: type(of:testStruct)))
        print(typeKey(type: type(of:testClass)))
        arr.forEach { (item) in
            print(typeKey(type: type(of: item)))
        }
        
    }
    
    
    
}
