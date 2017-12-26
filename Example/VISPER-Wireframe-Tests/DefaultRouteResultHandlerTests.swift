//
//  DefaultRouteResultHandlerTests.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 25.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
import VISPER_Core

class DefaultRouteResultHandlerTests: XCTestCase {
    
    var routeResultHandler: DefaultRouteResultHandler = DefaultRouteResultHandler()
    var optionProvider: MockComposedOptionProvider = MockComposedOptionProvider()
    var routingHandlerContainer: MockRoutingHandlerContainer = MockRoutingHandlerContainer()
    var controllerProvider: MockComposedControllerProvider = MockComposedControllerProvider()
    var presenterProvider: MockComposedPresenterProvider = MockComposedPresenterProvider()
    var routingDelegate: MockRoutingDelegate = MockRoutingDelegate()
    var routingObserver: MockRoutingObserver = MockRoutingObserver()
    var routingPresenter: MockComposedRoutingPresenter = MockComposedRoutingPresenter()
    var wireframe: MockWireframe = MockWireframe()
    
    override func setUp() {
        routeResultHandler = DefaultRouteResultHandler()
        optionProvider = MockComposedOptionProvider()
        routingHandlerContainer = MockRoutingHandlerContainer()
        controllerProvider = MockComposedControllerProvider()
        presenterProvider = MockComposedPresenterProvider()
        routingDelegate = MockRoutingDelegate()
        routingObserver = MockRoutingObserver()
        routingPresenter = MockComposedRoutingPresenter()
        wireframe = MockWireframe()
    }
    
    func testRouteCallsComposedRoutingOptionProviderWithRoutersRoutingResult() {
        
        //Arrange
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                               parameters: parameters,
                                            routingOption: option)
        
        //Act
        //throws error since no controller can be provided afterwards, not important for this test
        XCTAssertThrowsError(
            try routeResultHandler.handleRouteResult( routeResult: routeResult,
                                                   optionProvider: optionProvider,
                                          routingHandlerContainer: routingHandlerContainer,
                                               controllerProvider: controllerProvider,
                                                presenterProvider: presenterProvider,
                                                  routingDelegate: routingDelegate,
                                                  routingObserver: routingObserver,
                                                 routingPresenter: routingPresenter,
                                                        wireframe: wireframe,
                                                       completion: {})
        )
        
        
        //Assert
        XCTAssertTrue(optionProvider.invokedOption)
        AssertThat(optionProvider.invokedOptionParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        
    }
    
    func testRouteModifiesOptionByComposedRoutingObserver() {
        
        //Arrange
        let optionProvidersOption = MockRoutingOption()
        optionProvider.stubbedOptionResult = optionProvidersOption
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        
        // Act
        // throws error since no controller can be provided
        // the error should contain our modified routing option,
        // since it is called after modifing the route result by our option providers
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                   optionProvider: optionProvider,
                                                                   routingHandlerContainer: routingHandlerContainer,
                                                                   controllerProvider: controllerProvider,
                                                                   presenterProvider: presenterProvider,
                                                                   routingDelegate: routingDelegate,
                                                                   routingObserver: routingObserver,
                                                                   routingPresenter: routingPresenter,
                                                                   wireframe: wireframe,
                                                                   completion: {}),
                             "should throw DefaultWireframeError.canNotHandleRoute ") { error in
                                
                                switch error {
                                case DefaultWireframeError.canNotHandleRoute(let result):
                                    
                                    //Assert
                                    AssertThat(result.routingOption, isOfType: MockRoutingOption.self, andEquals: optionProvidersOption)
                                default:
                                    XCTFail("should throw DefaultWireframeError.canNotHandleRoute")
                                }
        }
        
    }
    
    func testRouteCallsHandlerFromRoutingHandlerContainer() {
        
        //Arrange
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure handler container to return a handler and a priority
        
        var didCallHandler = false
        var handlerResult : RouteResult?
        let handler = {  (routeResult: RouteResult) -> Void in
            handlerResult = routeResult
            didCallHandler = true
        }
        routingHandlerContainer.stubbedHandlerResult = handler
        routingHandlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 42
        
        //Act
        XCTAssertNoThrow(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                               optionProvider: optionProvider,
                                                      routingHandlerContainer: routingHandlerContainer,
                                                           controllerProvider: controllerProvider,
                                                            presenterProvider: presenterProvider,
                                                              routingDelegate: routingDelegate,
                                                              routingObserver: routingObserver,
                                                             routingPresenter: routingPresenter,
                                                                    wireframe: wireframe,
                                                                   completion: {}))
        
        //Assert
        XCTAssertTrue(didCallHandler)
        XCTAssertTrue(routingHandlerContainer.invokedPriorityOfHighestResponsibleProvider)
        XCTAssertTrue(routingHandlerContainer.invokedHandler)
        
        guard let handlersResult = handlerResult else {
            XCTFail("since the handler should be called there should be a result")
            return
        }
        
        XCTAssertTrue(routeResult.isEqual(routeResult: handlersResult))
        
    }
    
    func testRouteCallsCompletionWhenRoutingToHandler(){
    
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        let handler = {  (routeResult: RouteResult) -> Void in }
        routingHandlerContainer.stubbedHandlerResult = handler
        routingHandlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 42
        
        
        //Act
        XCTAssertNoThrow(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                  optionProvider: optionProvider,
                                                                  routingHandlerContainer: routingHandlerContainer,
                                                                  controllerProvider: controllerProvider,
                                                                  presenterProvider: presenterProvider,
                                                                  routingDelegate: routingDelegate,
                                                                  routingObserver: routingObserver,
                                                                  routingPresenter: routingPresenter,
                                                                  wireframe: wireframe,
                                                                  completion: completion))
        
        //Assert
        XCTAssertTrue(didCallCompletion)
        
    }
    
    func testRouteChecksIfComposedControllerProviderIsResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        // Act
        // throws error since no controller or handler can be provided
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}))
        
        //Assert
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        
    }
    
    func testRouteDoesNotCallComposedControllerProviderIfItIsNotResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        
        controllerProvider.stubbedIsResponsibleResult = false
        
        // Act
        // throws error since no controller or handler can be provided
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}))
        
        //Assert
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        XCTAssertFalse(controllerProvider.invokedMakeController)
        
    }
    
    func testRouteDoesThrowErrorIfComposedControllerProviderIsNotResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = false
        
        
        
        // Act
        // throws error since no controller or handler can be provided
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}),
                             "should throw an error") { error in
                                
                                //Assert
                                switch error {
                                case DefaultWireframeError.canNotHandleRoute(let routeResult):
                                    XCTAssertTrue(routeResult.isEqual(routeResult: routeResult))
                                default:
                                    XCTFail("should throw a DefaultWireframeError.canNotHandleRoute error")
                                }
        }
        
    }
    
    func testRouteDoesCallComposedControllerProviderIfItIsResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}))
        
        //Assert
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        XCTAssertTrue(controllerProvider.invokedMakeController)
        
    }
    
    func testRouteDoesCallComposedPresenterProviderIfItIsResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = true
        let controller = UIViewController()
        controllerProvider.stubbedMakeControllerResult = controller
        
        //configure mock presenter provider
        let mockPresenter = MockPresenter()
        presenterProvider.stubbedMakePresentersResult = [mockPresenter]
        
        
        
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}))
        
        //Assert
        XCTAssertTrue(presenterProvider.invokedMakePresenters)
        AssertThat(presenterProvider.invokedMakePresentersParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        XCTAssertEqual(presenterProvider.invokedMakePresentersParameters?.controller, controller)
    }
    
    func testRouteChecksIfRoutingPresenterIsResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
    
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}))
        
        //Assert
        XCTAssertTrue(routingPresenter.invokedIsResponsible)
        
    }
    
    func testRouteThrowsErrorIfComposedRoutingPresenterIsNotResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
        
        //configure mock routing presenter
        routingPresenter.stubbedIsResponsibleResult = false
        
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}),
                             "Should throw an DefaultWireframeError.noRoutingPresenterFoundFor error") { error in
                                
                                switch error {
                                case DefaultWireframeError.noRoutingPresenterFoundFor(let routeResult):
                                    XCTAssertTrue(routeResult.isEqual(routeResult: routeResult))
                                default:
                                    XCTFail("Should throw an DefaultWireframeError.noRoutingPresenterFoundFor error")
                                }
        }
        
        //Assert
        XCTAssertTrue(routingPresenter.invokedIsResponsible)
        
    }
    
    
    func testRouteCallsComposedRoutingPresenterIfItIsResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
        
        //configure mock routing presenter
        routingPresenter.stubbedIsResponsibleResult = true
        
        //configure mock routing delegate
        
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        // Act
        XCTAssertNoThrow(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                  optionProvider: optionProvider,
                                                                  routingHandlerContainer: routingHandlerContainer,
                                                                  controllerProvider: controllerProvider,
                                                                  presenterProvider: presenterProvider,
                                                                  routingDelegate: routingDelegate,
                                                                  routingObserver: routingObserver,
                                                                  routingPresenter: routingPresenter,
                                                                  wireframe: wireframe,
                                                                  completion: completion))
        
        //Assert
        XCTAssertTrue(routingPresenter.invokedIsResponsible)
        XCTAssertTrue(routingPresenter.invokedPresent)
        
        //assert params
        XCTAssertEqual(routingPresenter.invokedPresentParameters?.controller, controllerProvider.stubbedMakeControllerResult)
        
        AssertThat(routingPresenter.invokedPresentParameters?.routeResult,
                   isOfType: DefaultRouteResult.self,
                   andEquals: routeResult)
        
        
        AssertThat(routingPresenter.invokedPresentParameters?.wireframe, isOfType: MockWireframe.self, andEquals: wireframe)
        
        AssertThat(routingPresenter.invokedPresentParameters?.delegate, isOfType: MockRoutingDelegate.self, andEquals: routingDelegate)
        
        guard let complete = routingPresenter.invokedPresentParametersCompletion else {
            XCTFail("didn't forward completion to presenter")
            return
        }
        
        XCTAssertFalse(didCallCompletion)
        complete()
        XCTAssertTrue(didCallCompletion)
    }
    
    
    func testRouteChoosesHandlerIfItHasAHigherPriorityThanTheController(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure handler container to return a handler and a priority
        var didCallHandler = false
        let handler = {  (routeResult: RouteResult) -> Void in
            didCallHandler = true
        }
        routingHandlerContainer.stubbedHandlerResult = handler
        routingHandlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 42
        
        //configure composed controller provider to return a lower priority for the controller
        controllerProvider.stubbedPriorityOfHighestResponsibleProviderResult = 21
        
        
        //Act
        XCTAssertNoThrow(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                  optionProvider: optionProvider,
                                                                  routingHandlerContainer: routingHandlerContainer,
                                                                  controllerProvider: controllerProvider,
                                                                  presenterProvider: presenterProvider,
                                                                  routingDelegate: routingDelegate,
                                                                  routingObserver: routingObserver,
                                                                  routingPresenter: routingPresenter,
                                                                  wireframe: wireframe,
                                                                  completion: {}))
        
        //Assert
        XCTAssertTrue(didCallHandler)
        XCTAssertFalse(controllerProvider.invokedIsResponsible)
        
    }
    
    func testRouteChoosesControllerIfItHasAHigherPriorityThanAHandler(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure handler container to return a handler and a priority
        var didCallHandler = false
        let handler = {  (routeResult: RouteResult) -> Void in
            didCallHandler = true
        }
        routingHandlerContainer.stubbedHandlerResult = handler
        routingHandlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 21
        
        //configure composed controller provider to return a lower priority for the controller
        controllerProvider.stubbedPriorityOfHighestResponsibleProviderResult = 42
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
        
        
        
        //Act
        // throws error since no presenter is available
        XCTAssertThrowsError(try routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                                      optionProvider: optionProvider,
                                                                      routingHandlerContainer: routingHandlerContainer,
                                                                      controllerProvider: controllerProvider,
                                                                      presenterProvider: presenterProvider,
                                                                      routingDelegate: routingDelegate,
                                                                      routingObserver: routingObserver,
                                                                      routingPresenter: routingPresenter,
                                                                      wireframe: wireframe,
                                                                      completion: {}))
        
        //Assert
        XCTAssertFalse(didCallHandler)
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        
    }
    
    
    func testControllerChecksIfComposedControllerProviderIsResponsible() {
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
      
        
        XCTAssertNoThrow(try routeResultHandler.controller(routeResult: routeResult,
                                                           controllerProvider: controllerProvider,
                                                           presenterProvider: presenterProvider,
                                                           routingDelegate: routingDelegate,
                                                           routingObserver: routingObserver,
                                                           wireframe: wireframe))
        
        //Assert
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        
    }
    
    func testControllerDoesNotCallComposedControllerProviderIfItIsNotResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        controllerProvider.stubbedIsResponsibleResult = false
        
        
        XCTAssertNoThrow(
            try routeResultHandler.controller(routeResult: routeResult,
                                              controllerProvider: controllerProvider,
                                              presenterProvider: presenterProvider,
                                              routingDelegate: routingDelegate,
                                              routingObserver: routingObserver,
                                              wireframe: wireframe)
        )
        
        //Assert
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        XCTAssertFalse(controllerProvider.invokedMakeController)
        
    }
    
    func testControllerReturnsNilIfComposedControllerProviderIsNotResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = false
        
        
        // Act
        // throws error since no controller or handler can be provided
        var controller : UIViewController?
        XCTAssertNoThrow(
            controller = try routeResultHandler.controller(routeResult: routeResult,
                                                           controllerProvider: controllerProvider,
                                                           presenterProvider: presenterProvider,
                                                           routingDelegate: routingDelegate,
                                                           routingObserver: routingObserver,
                                                           wireframe: wireframe)
        )
        
        XCTAssertNil(controller)
        
    }
    
    func testControllerDoesCallComposedControllerProviderIfItIsResponsible(){
        
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        optionProvider.stubbedOptionResult = option
        
        let routeResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                             parameters: parameters,
                                             routingOption: option)
        
        //configure mock controller provider
        controllerProvider.stubbedIsResponsibleResult = true
        controllerProvider.stubbedMakeControllerResult = UIViewController()
        
        var controller : UIViewController?
        XCTAssertNoThrow(
            controller =  try routeResultHandler.controller(routeResult: routeResult,
                                                            controllerProvider: controllerProvider,
                                                            presenterProvider: presenterProvider,
                                                            routingDelegate: routingDelegate,
                                                            routingObserver: routingObserver,
                                                            wireframe: wireframe)
        )
        
        //Assert
        XCTAssertTrue(controllerProvider.invokedIsResponsible)
        XCTAssertTrue(controllerProvider.invokedMakeController)
        XCTAssertEqual(controller,controllerProvider.stubbedMakeControllerResult)
    }
    
    
}
