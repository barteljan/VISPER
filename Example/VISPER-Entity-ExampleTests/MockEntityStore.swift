//
//  MockEntityStore.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 03.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Entity

class MockEntityStore: NSObject, EntityStore {
    
    override init(){}

    var invokedVersion = false
    var invokedVersionCount = 0
    var stubbedVersionResult: Int! = 0

    func version() -> Int {
        invokedVersion = true
        invokedVersionCount += 1
        return stubbedVersionResult
    }

    var invokedIsResponsibleFor = false
    var invokedIsResponsibleForCount = 0
    var invokedIsResponsibleForParameters: (object: Any, Void)?
    var invokedIsResponsibleForParametersList = [(object: Any, Void)]()
    var stubbedIsResponsibleForResult: Bool! = false

    func isResponsible<T>(for object: T) -> Bool {
        invokedIsResponsibleFor = true
        invokedIsResponsibleForCount += 1
        invokedIsResponsibleForParameters = (object, ())
        invokedIsResponsibleForParametersList.append((object, ()))
        return stubbedIsResponsibleForResult
    }

    var invokedIsResponsibleForType = false
    var invokedIsResponsibleForTypeCount = 0
    var invokedIsResponsibleForTypeParameters: (type: Any.Type, Void)?
    var invokedIsResponsibleForTypeParametersList = [(type: Any.Type, Void)]()
    var stubbedIsResponsibleForTypeResult: Bool! = false

    func isResponsible<T>(forType type: T.Type) -> Bool {
        invokedIsResponsibleForType = true
        invokedIsResponsibleForTypeCount += 1
        invokedIsResponsibleForTypeParameters = (type, ())
        invokedIsResponsibleForTypeParametersList.append((type, ()))
        return stubbedIsResponsibleForTypeResult
    }

    var invokedPersist = false
    var invokedPersistCount = 0
    var invokedPersistParameters: (item: Any?, Void)?
    var invokedPersistParametersList = [(item: Any?, Void)]()
    var stubbedPersistError: Error?

    func persist<T>(_ item: T!) throws {
        invokedPersist = true
        invokedPersistCount += 1
        invokedPersistParameters = (item, ())
        invokedPersistParametersList.append((item, ()))
        if let error = stubbedPersistError {
            throw error
        }
    }

    var invokedPersistCompletion = false
    var invokedPersistCompletionCount = 0
    var invokedPersistCompletionParameters: (item: Any?, Void)?
    var invokedPersistCompletionParametersList = [(item: Any?, Void)]()
    var stubbedPersistCompletionError: Error?

    func persist<T>(_ item: T!, completion: @escaping () -> ()) throws {
        invokedPersistCompletion = true
        invokedPersistCompletionCount += 1
        invokedPersistCompletionParameters = (item, ())
        invokedPersistCompletionParametersList.append((item, ()))
        completion()
        if let error = stubbedPersistCompletionError {
            throw error
        }
    }

    var invokedDelete = false
    var invokedDeleteCount = 0
    var invokedDeleteParameters: (item: Any?, Void)?
    var invokedDeleteParametersList = [(item: Any?, Void)]()
    var stubbedDeleteError: Error?

    func delete<T>(_ item: T!) throws {
        invokedDelete = true
        invokedDeleteCount += 1
        invokedDeleteParameters = (item, ())
        invokedDeleteParametersList.append((item, ()))
        if let error = stubbedDeleteError {
            throw error
        }
    }

    var invokedDeleteCompletion = false
    var invokedDeleteCompletionCount = 0
    var invokedDeleteCompletionParameters: (item: Any?, Void)?
    var invokedDeleteCompletionParametersList = [(item: Any?, Void)]()
    var stubbedDeleteCompletionError: Error?

    func delete<T>(_ item: T!, completion: @escaping () -> ()) throws {
        invokedDeleteCompletion = true
        invokedDeleteCompletionCount += 1
        invokedDeleteCompletionParameters = (item, ())
        invokedDeleteCompletionParametersList.append((item, ()))
        completion()
        if let error = stubbedDeleteCompletionError {
            throw error
        }
    }

    var invokedGet = false
    var invokedGetCount = 0
    var invokedGetParameters: (identifier: String, Void)?
    var invokedGetParametersList = [(identifier: String, Void)]()
    var stubbedGetError: Error?
    var stubbedGetResult: Any!

    func get<T>(_ identifier: String) throws -> T? {
        invokedGet = true
        invokedGetCount += 1
        invokedGetParameters = (identifier, ())
        invokedGetParametersList.append((identifier, ()))
        if let error = stubbedGetError {
            throw error
        }
        return stubbedGetResult as? T
    }

    var invokedGetCompletion = false
    var invokedGetCompletionCount = 0
    var invokedGetCompletionParameters: (identifier: String, completion: Any)?
    var invokedGetCompletionParametersList = [(identifier: String, completion: Any)]()
    var stubbedGetCompletionCompletionResult: Any?
    var stubbedGetCompletionError: Error?

    func get<T>(_ identifier: String, completion: @escaping (_ item: T?) -> Void) throws {
        invokedGetCompletion = true
        invokedGetCompletionCount += 1
        invokedGetCompletionParameters = (identifier, completion)
        invokedGetCompletionParametersList.append((identifier, completion))
        if let result = stubbedGetCompletionCompletionResult {
            completion(result as? T)
        }
        if let error = stubbedGetCompletionError {
            throw error
        }
    }

    var invokedGetAllTType = false
    var invokedGetAllTTypeCount = 0
    var invokedGetAllTTypeParameters: (type: Any, Void)?
    var invokedGetAllTTypeParametersList = [(type: Any, Void)]()
    var stubbedGetAllTTypeError: Error?
    var stubbedGetAllTTypeResult: Any! = []

    func getAll<T>(_ type: T.Type) throws -> [T] {
        invokedGetAllTType = true
        invokedGetAllTTypeCount += 1
        invokedGetAllTTypeParameters = (type, ())
        invokedGetAllTTypeParametersList.append((type, ()))
        if let error = stubbedGetAllTTypeError {
            throw error
        }
        return stubbedGetAllTTypeResult as! [T]
    }

    var invokedGetAllTTypeCompletion = false
    var invokedGetAllTTypeCompletionCount = 0
    var invokedGetAllTTypeCompletionParameters: (type: Any, completion: Any)?
    var invokedGetAllTTypeCompletionParametersList = [(type: Any, completion: Any)]()
    var stubbedGetAllTTypeCompletionCompletionResult: [Any]?
    var stubbedGetAllTTypeCompletionError: Error?

    func getAll<T>(_ type: T.Type, completion: @escaping (_ items: [T]) -> Void) throws {
        invokedGetAllTTypeCompletion = true
        invokedGetAllTTypeCompletionCount += 1
        invokedGetAllTTypeCompletionParameters = (type, completion)
        invokedGetAllTTypeCompletionParametersList.append((type, completion))
        if let result = stubbedGetAllTTypeCompletionCompletionResult {
            
            if let mappedItems = result as? [T]{
                completion(mappedItems)
            }else {
                completion([T]())
            }
            
            
        }
        if let error = stubbedGetAllTTypeCompletionError {
            throw error
        }
    }

    var invokedGetAllString = false
    var invokedGetAllStringCount = 0
    var invokedGetAllStringParameters: (viewName: String, Void)?
    var invokedGetAllStringParametersList = [(viewName: String, Void)]()
    var stubbedGetAllStringError: Error?
    var stubbedGetAllStringResult: Any! = []

    func getAll<T>(_ viewName: String) throws -> [T] {
        invokedGetAllString = true
        invokedGetAllStringCount += 1
        invokedGetAllStringParameters = (viewName, ())
        invokedGetAllStringParametersList.append((viewName, ()))
        if let error = stubbedGetAllStringError {
            throw error
        }
        return stubbedGetAllStringResult as! [T]
    }

    var invokedGetAllStringCompletion = false
    var invokedGetAllStringCompletionCount = 0
    var invokedGetAllStringCompletionParameters: (viewName: String, completion: Any)?
    var invokedGetAllStringCompletionParametersList = [(viewName: String, completion: Any)]()
    var stubbedGetAllStringCompletionCompletionResult: [Any]?
    var stubbedGetAllStringCompletionError: Error?

    func getAll<T>(_ viewName: String, completion: @escaping (_ items: [T]) -> Void) throws {
        invokedGetAllStringCompletion = true
        invokedGetAllStringCompletionCount += 1
        invokedGetAllStringCompletionParameters = (viewName, completion)
        invokedGetAllStringCompletionParametersList.append((viewName, completion))
        if let result = stubbedGetAllStringCompletionCompletionResult {
            
            if let mappedItems = result as? [T]{
                completion(mappedItems)
            }else {
                completion([T]())
            }

        }
        if let error = stubbedGetAllStringCompletionError {
            throw error
        }
    }

    var invokedGetAllGroupName = false
    var invokedGetAllGroupNameCount = 0
    var invokedGetAllGroupNameParameters: (viewName: String, groupName: String)?
    var invokedGetAllGroupNameParametersList = [(viewName: String, groupName: String)]()
    var stubbedGetAllGroupNameError: Error?
    var stubbedGetAllGroupNameResult: Any! = []

    func getAll<T>(_ viewName: String, groupName: String) throws -> [T] {
        invokedGetAllGroupName = true
        invokedGetAllGroupNameCount += 1
        invokedGetAllGroupNameParameters = (viewName, groupName)
        invokedGetAllGroupNameParametersList.append((viewName, groupName))
        if let error = stubbedGetAllGroupNameError {
            throw error
        }
        return stubbedGetAllGroupNameResult as! [T]
    }

    var invokedGetAllGroupNameCompletion = false
    var invokedGetAllGroupNameCompletionCount = 0
    var invokedGetAllGroupNameCompletionParameters: (viewName: String, groupName: String, completion: Any)?
    var invokedGetAllGroupNameCompletionParametersList = [(viewName: String, groupName: String, completion: Any)]()
    var stubbedGetAllGroupNameCompletionCompletionResult: [Any]?
    var stubbedGetAllGroupNameCompletionError: Error?

    func getAll<T>(_ viewName: String, groupName: String, completion: @escaping (_ items: [T]) -> Void) throws {
        invokedGetAllGroupNameCompletion = true
        invokedGetAllGroupNameCompletionCount += 1
        invokedGetAllGroupNameCompletionParameters = (viewName, groupName, completion)
        invokedGetAllGroupNameCompletionParametersList.append((viewName, groupName, completion))
        if let result = stubbedGetAllGroupNameCompletionCompletionResult {
            
            if let mappedItems = result as? [T]{
                completion(mappedItems)
            }else {
                completion([T]())
            }
    
        }
        if let error = stubbedGetAllGroupNameCompletionError {
            throw error
        }
    }

    var invokedExists = false
    var invokedExistsCount = 0
    var invokedExistsParameters: (item: Any?, Void)?
    var invokedExistsParametersList = [(item: Any?, Void)]()
    var stubbedExistsError: Error?
    var stubbedExistsResult: Bool! = false

    func exists<T>(_ item: T!) throws -> Bool {
        invokedExists = true
        invokedExistsCount += 1
        invokedExistsParameters = (item, ())
        invokedExistsParametersList.append((item, ()))
        if let error = stubbedExistsError {
            throw error
        }
        return stubbedExistsResult
    }

    var invokedExistsCompletion = false
    var invokedExistsCompletionCount = 0
    var invokedExistsCompletionParameters: (item: Any?, Void)?
    var invokedExistsCompletionParametersList = [(item: Any?, Void)]()
    var stubbedExistsCompletionCompletionResult: Bool?
    var stubbedExistsCompletionError: Error?

    func exists<T>(_ item: T!, completion: @escaping (_ exists: Bool) -> Void) throws {
        invokedExistsCompletion = true
        invokedExistsCompletionCount += 1
        invokedExistsCompletionParameters = (item, ())
        invokedExistsCompletionParametersList.append((item, ()))
        if let result = stubbedExistsCompletionCompletionResult {
            completion(result)
        }
        if let error = stubbedExistsCompletionError {
            throw error
        }
    }

    var invokedExistsType = false
    var invokedExistsTypeCount = 0
    var invokedExistsTypeParameters: (identifier: String, type: Any.Type)?
    var invokedExistsTypeParametersList = [(identifier: String, type: Any.Type)]()
    var stubbedExistsTypeError: Error?
    var stubbedExistsTypeResult: Bool! = false

    func exists<T>(_ identifier: String, type: T.Type) throws -> Bool {
        invokedExistsType = true
        invokedExistsTypeCount += 1
        invokedExistsTypeParameters = (identifier, type)
        invokedExistsTypeParametersList.append((identifier, type))
        if let error = stubbedExistsTypeError {
            throw error
        }
        return stubbedExistsTypeResult
    }

    var invokedExistsTypeCompletion = false
    var invokedExistsTypeCompletionCount = 0
    var invokedExistsTypeCompletionParameters: (identifier: String, type: Any.Type)?
    var invokedExistsTypeCompletionParametersList = [(identifier: String, type: Any.Type)]()
    var stubbedExistsTypeCompletionCompletionResult: Bool?
    var stubbedExistsTypeCompletionError: Error?

    func exists<T>(_ identifier: String, type: T.Type, completion: @escaping (_ exists: Bool) -> Void) throws {
        invokedExistsTypeCompletion = true
        invokedExistsTypeCompletionCount += 1
        invokedExistsTypeCompletionParameters = (identifier, type)
        invokedExistsTypeCompletionParametersList.append((identifier, type))
        if let result = stubbedExistsTypeCompletionCompletionResult {
            completion(result)
        }
        if let error = stubbedExistsTypeCompletionError {
            throw error
        }
    }

    var invokedFilter = false
    var invokedFilterCount = 0
    var invokedFilterParameters: (type: Any, includeElement: Any)?
    var invokedFilterParametersList = [(type: Any, includeElement: Any)]()
    var stubbedFilterError: Error?
    var stubbedFilterResult: [Any] = []

    func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool) throws -> [T] {
        invokedFilter = true
        invokedFilterCount += 1
        invokedFilterParameters = (type, includeElement)
        invokedFilterParametersList.append((type, includeElement))
        
        if let error = stubbedFilterError {
            throw error
        }
        
        
        
        return stubbedFilterResult.map({ (item) -> T in
            return item as! T
        }).filter(includeElement)
    }

    var invokedFilterIncludeElement = false
    var invokedFilterIncludeElementCount = 0
    var invokedFilterIncludeElementParameters: (type: Any, includeElement: Any, completion: Any)?
    var invokedFilterIncludeElementParametersList = [(type: Any, includeElement: Any, completion: Any)]()
    var stubbedFilterIncludeElementCompletionResult: [Any]?
    var stubbedFilterIncludeElementError: Error?

    func filter<T>(_ type: T.Type, includeElement: @escaping (T) -> Bool, completion: @escaping (_ items: [T]) -> Void) throws {
        invokedFilterIncludeElement = true
        invokedFilterIncludeElementCount += 1
        invokedFilterIncludeElementParameters = (type, includeElement, completion)
        invokedFilterIncludeElementParametersList.append((type, includeElement, completion))
        
        if let result = stubbedFilterIncludeElementCompletionResult {
            completion(result.map({ (item) -> T in
                return item as! T
            }).filter(includeElement))
        }
        if let error = stubbedFilterIncludeElementError {
            throw error
        }
    }

    var invokedAddView = false
    var invokedAddViewCount = 0
    var invokedAddViewParameter: String!
    var invokedAddViewParametersList = [String]()
    var stubbedAddViewError: Error?

    func addView<T>(_ viewName: String,
                    groupingBlock: @escaping ((_ collection: String,
                                               _ key: String,
                                               _ object: T) -> String?),

                    sortingBlock: @escaping ((_ group: String,
                                              _ collection1: String,
                                              _ key1: String,
                                              _ object1: T,
                                              _ collection2: String,
                                              _ key2: String,
                                              _ object2: T) -> ComparisonResult)) throws {
        invokedAddView = true
        invokedAddViewCount += 1
        invokedAddViewParameter = viewName
        invokedAddViewParametersList.append(viewName)
        if let error = stubbedAddViewError {
            throw error
        }
    }

    var invokedTransaction = false
    var invokedTransactionCount = 0
    var stubbedTransactionTransactionResult: (EntityStore, Void)?
    var stubbedTransactionError: Error?

    func transaction(transaction: @escaping (_ transactionStore: EntityStore) throws -> Void) throws {
        invokedTransaction = true
        invokedTransactionCount += 1
        if let result = stubbedTransactionTransactionResult {
            try? transaction(result.0)
        }
        if let error = stubbedTransactionError {
            throw error
        }
    }
}
