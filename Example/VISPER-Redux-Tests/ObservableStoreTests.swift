import XCTest
@testable import VISPER_Redux
/*
 The MIT License (MIT)
 Copyright (c) 2016 ReSwift Contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
class ObservableStoreTests: XCTestCase {
    
    /**
     it deinitializes when no reference is held
     */
    func testDeinit() {
        var deInitCount = 0
        
        autoreleasepool {
            let container = MockReducerContainer()
            _ = DeInitStore( appReducer: {container,action,store in return store },
                            observable: ObservableProperty(TestState(title: "test")),
                            reducerProvider: container,
                            deInitAction: { deInitCount += 1 })
        }
        
        XCTAssertEqual(deInitCount, 1)
    }
    
}

// Used for deinitialization test
class DeInitStore<State>: Store<ObservableProperty<State>> {
    var deInitAction: (() -> Void)?
    
    deinit {
        deInitAction?()
    }
    
    
    public required init(appReducer: @escaping StoreReducer,
                         observable: ObservableProperty<State>,
                         reducerProvider: ReducerProvider,
                         middleware: StoreMiddleware = Middleware(),
                         deInitAction: @escaping () -> Void) {
        
        super.init(appReducer: appReducer,
                    observable: observable,
              reducerProvider: reducerProvider)
        self.deInitAction = deInitAction
    }

    
    
}

