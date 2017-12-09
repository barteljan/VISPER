//
//  DefaultRouterRoutingTests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 21.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
import VISPER_Wireframe_Core

class DefaultWireframeTests: XCTestCase {
    
    func testAddsRoutePatternToRouter() throws {
        
        //Arrange
        let router = MockRouter()
        let wireframe = DefaultWireframe(router: router)
        
        let pattern = "/das/ist/ein/pattern"
        
        //Act
        try wireframe.add(routePattern:pattern)
       
        //Assert
        XCTAssert(router.invokedAdd)
        XCTAssertEqual(router.invokedAddParameters?.routePattern, pattern)
        
    }
    
    func testAddRoutingOptionProviderCallsComposedOptionProvider() throws {
        
        //Arrange
        let mockProvider = MockRoutingOptionProvider()
        
        let composedRoutingOptionProvider = MockComposedOptionProvider()
        let wireframe = DefaultWireframe(composedOptionProvider: composedRoutingOptionProvider)
        
        let priority = 10
        
        //Act
        wireframe.add(optionProvider: mockProvider, priority: priority)
        
        //Assert
        AssertThat(composedRoutingOptionProvider.invokedAddParameters?.optionProvider, isOfType: MockRoutingOptionProvider.self, andEquals: mockProvider)
        XCTAssertEqual(composedRoutingOptionProvider.invokedAddParameters?.priority, priority)
        
    }
    
    func testAddHandlerCallsHandlerContainer(){
        
        //Arrange
        let container = MockRoutingHandlerContainer()
        let wireframe = DefaultWireframe(routingHandlerContainer: container)
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: [:])
        
        var didCallResponsibleHandler = false
        let responsibleHandler = { (routeResult: RouteResult) -> Bool in
            didCallResponsibleHandler = true
            return true
        }
        
        var didCallHandler = false
        let handler = {  (routeResult: RouteResult) -> Void in
            didCallHandler = true
        }
        
        let priority = 42
        
        //Act
        XCTAssertNoThrow(try wireframe.add(priority: priority, responsibleFor: responsibleHandler, handler: handler))
        
        
        //Assert
        XCTAssertTrue(container.invokedAdd)
        XCTAssertEqual(container.invokedAddParameters?.priority, priority)
        
        guard let responsibleHandlerParam = container.invokedAddResponsibleForParam else {
            XCTFail("responsibleHandler was not forwarded to handler container")
            return
        }
        
        XCTAssertFalse(didCallResponsibleHandler)
        _ = responsibleHandlerParam(routeResult)
        XCTAssertTrue(didCallResponsibleHandler)
        
        guard let handlerParam = container.invokedAddHandlerParam else {
            XCTFail("handler was not forwarded to handler container")
            return
        }
        
        XCTAssertFalse(didCallHandler)
        handlerParam(routeResult)
        XCTAssertTrue(didCallHandler)
        
    }
    
    func testAddControllerProviderCallsComposedControllerProvider() {
        
        //Arrange
        let mockProvider = MockControllerProvider()
        
        let composedControllerProvider = MockComposedControllerProvider()
        let wireframe = DefaultWireframe(composedControllerProvider: composedControllerProvider)
        
        let priority = 10
        
        //Act
        wireframe.add(controllerProvider: mockProvider, priority: priority)
        
        //Assert
        AssertThat(composedControllerProvider.invokedAddParameters?.controllerProvider, isOfType: MockControllerProvider.self, andEquals: mockProvider)
        XCTAssertEqual(composedControllerProvider.invokedAddParameters?.priority, priority)
        
    }
    
    func testAddRoutingObserverCallsRoutingDelegate() {
        
        //Arrange
        let mockObserver = MockRoutingObserver()
        
        let routingDelegate = MockRoutingDelegate()
        let wireframe = DefaultWireframe(routingDelegate: routingDelegate)
        
        let priority = 10
        let routePattern = "/test/pattern"
        
        //Act
        wireframe.add(routingObserver: mockObserver, priority: priority, routePattern: routePattern)
        
        //Assert
        AssertThat(routingDelegate.invokedAddParameters?.routingObserver, isOfType: MockRoutingObserver.self, andEquals: mockObserver)
        XCTAssertEqual(routingDelegate.invokedAddParameters?.routePattern, routePattern)
        XCTAssertEqual(routingDelegate.invokedAddParameters?.priority, priority)
        
    }
    
    func testAddRoutingPresenterCallsComposedRoutingPresenter() {
        
        //Arrange
        let mockPresenter = MockRoutingPresenter()
        
        let composedRoutingPresenter = MockComposedRoutingPresenter()
        let wireframe = DefaultWireframe(composedRoutingPresenter: composedRoutingPresenter)
        
        let priority = 10
        
        //Act
        wireframe.add(routingPresenter: mockPresenter, priority: priority)
        
        //Assert
        AssertThat(composedRoutingPresenter.invokedAddParameters?.routingPresenter, isOfType: MockRoutingPresenter.self, andEquals: mockPresenter)
        XCTAssertEqual(composedRoutingPresenter.invokedAddParameters?.priority, priority)
        
    }
    
    func testCallsRouterOnRoute() {
        
        //Arrange
        let router = MockRouter()
        let wireframe = DefaultWireframe(router: router)
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //Act
        //throws error since mock router does not give a result
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}))
        
        //Assert
        XCTAssertTrue(router.invokedRouteUrlRoutingOptionParameters)
        XCTAssertEqual(router.invokedRouteUrlRoutingOptionParametersParameters?.url, url)
        
        let invokedParams = NSDictionary(dictionary:(router.invokedRouteUrlRoutingOptionParametersParameters?.parameters)!)
        XCTAssertEqual(invokedParams, NSDictionary(dictionary:parameters))
        
        AssertThat(router.invokedRouteUrlRoutingOptionParametersParameters?.routingOption,
                        isOfType: MockRoutingOption.self,
                       andEquals: option)
        
    }
    
    func testCallsRouterOnController() {
        
        //Arrange
        let router = MockRouter()
        let wireframe = DefaultWireframe(router: router)
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        
        //Act
        //throws error since mock router does not give a result
        XCTAssertThrowsError(
            try wireframe.controller(url: url, parameters: parameters)
        )
        
        //Assert
        XCTAssertTrue(router.invokedRouteUrlRoutingOptionParameters)
        XCTAssertEqual(router.invokedRouteUrlRoutingOptionParametersParameters?.url, url)
        
        let invokedParams = NSDictionary(dictionary:(router.invokedRouteUrlRoutingOptionParametersParameters?.parameters)!)
        XCTAssertEqual(invokedParams, NSDictionary(dictionary:parameters))
        
        AssertThat(router.invokedRouteUrlRoutingOptionParametersParameters?.routingOption, isOfType: GetControllerRoutingOption.self)
        
    }
    
    func testCanRouteCallsRouterForRouteResult(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        //let routeResult = DefaultRouteResult(routePattern: url.absoluteURL, parameters: parameters, routingOption: option)
        
        let router = MockRouter()
        let wireframe = DefaultWireframe(router: router)
        
        //Act
        XCTAssertNoThrow(try wireframe.canRoute(url: url, parameters: parameters, option: option))
        
        //Assert
        XCTAssertTrue(router.invokedRouteUrlRoutingOptionParameters)
        XCTAssertEqual(router.invokedRouteUrlRoutingOptionParametersParameters?.url, url)
        
        guard let invokedParams = router.invokedRouteUrlRoutingOptionParametersParameters?.parameters else {
            XCTFail("parameter psrameters should be invoked in routers route function")
            return
        }
        
        let invokedParamsDict = NSDictionary(dictionary: invokedParams)
        let paramsDict = NSDictionary(dictionary: parameters)
        
        XCTAssertEqual(invokedParamsDict, paramsDict)
        AssertThat(router.invokedRouteUrlRoutingOptionParametersParameters?.routingOption, isOfType: MockRoutingOption.self, andEquals: option)
        
    }
    
    func testCanRouteReturnsFalseIfRouterResolvesNoRouteResult(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        let router = MockRouter()
        router.stubbedRouteResult = nil
        
        let wireframe = DefaultWireframe(router: router)
        
        //Act
        var canRoute = false
        XCTAssertNoThrow(canRoute = try wireframe.canRoute(url: url, parameters: parameters, option: option))
        
        //Assert
        XCTAssertFalse(canRoute)
        
    }
    
    func testCanRouteReturnsTrueIfRouterResolvesARouteResult(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        let routeResult = DefaultRouteResult(routePattern: url.absoluteString, parameters: parameters, routingOption: option)
        
        let router = MockRouter()
        router.stubbedRouteUrlRoutingOptionParametersResult = routeResult
        
        let wireframe = DefaultWireframe(router: router)
        
        //Act
        var canRoute = false
        XCTAssertNoThrow(
            canRoute = try wireframe.canRoute(url: url, parameters: parameters, option: option)
        )
        
        //Assert
        XCTAssertTrue(canRoute)
        
    }
    
    func testRouteThrowsErrorWhenNoRoutePatternWasFound() {
        
        //Arrange
        let router = MockRouter()
        let wireframe = DefaultWireframe(router: router)
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //Act + Assert
        //throws error since mock router does not give a result
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}),
                             "should throw DefaultWireframeError.noRoutePatternFoundFor") { error in
                                
                                switch error {
                                case DefaultWireframeError.noRoutePatternFoundFor(let errorUrl, let errorParameters):
                                    XCTAssertEqual(errorUrl, url)
                                    XCTAssertEqual(NSDictionary(dictionary: errorParameters), NSDictionary(dictionary:parameters))
                                default:
                                  XCTFail("should throw DefaultWireframeError.noRoutePatternFoundFor")
                                }
                
        }
        
        
    }
    
    
    func testRouteCallsComposedRoutingOptionProviderWithRoutersRoutingResult() {
        
        //Arrange
        let router = MockRouter()
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                      parameters: parameters,
                                                   routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        let composedOptionProvider = MockComposedOptionProvider()
        
        let wireframe = DefaultWireframe(router: router,composedOptionProvider:composedOptionProvider)
        
        
        //Act
        //throws error since no controller can be provided afterwards, not important for this test
        XCTAssertThrowsError(try wireframe.route(url: url,
                                          parameters: parameters,
                                              option: option,
                                          completion: {}))
        
        //Assert
        XCTAssertTrue(composedOptionProvider.invokedOption)
        AssertThat(composedOptionProvider.invokedOptionParameters?.routeResult, isOfType: DefaultRouteResult.self, andEquals: stubbedRouteResult)
        
    }
    
    func testRouteModifiesOptionByComposedRoutingObserver() {
        
        //Arrange
        let router = MockRouter()
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        let composedOptionProvider = MockComposedOptionProvider()
        let optionProvidersOption = MockRoutingOption()
        composedOptionProvider.stubbedOptionResult = optionProvidersOption
        
        let wireframe = DefaultWireframe(router: router,composedOptionProvider:composedOptionProvider)
        
        
        // Act
        // throws error since no controller can be provided
        // the error should contain our modified routing option,
        // since it is called after modifing the route result by our option providers
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
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
        
        //configure router to return a result
        let router = MockRouter()
        
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: [:],
                                                    routingOption: MockRoutingOption())
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure handler container to return a handler and a priority
        let handlerContainer = MockRoutingHandlerContainer()
        
        var didCallHandler = false
        var handlerResult : RouteResult?
        let handler = {  (routeResult: RouteResult) -> Void in
            handlerResult = routeResult
            didCallHandler = true
        }
        handlerContainer.stubbedHandlerResult = handler
        handlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 42
        
        //create wireframe with mock dependencies
        let wireframe = DefaultWireframe(router: router,routingHandlerContainer: handlerContainer)
        
        //Act
        XCTAssertNoThrow(try wireframe.route(url: URL(string: stubbedRouteResult.routePattern)!,
                                      parameters: stubbedRouteResult.parameters,
                                          option: stubbedRouteResult.routingOption!,
                                          completion: {}))
        
        //Assert
        XCTAssertTrue(didCallHandler)
        XCTAssertTrue(handlerContainer.invokedPriorityOfHighestResponsibleProvider)
        XCTAssertTrue(handlerContainer.invokedHandler)
        
        guard let routeResult = handlerResult else {
            XCTFail("since the handler should be called there should be a result")
            return
        }
        
        XCTAssertTrue(routeResult.isEqual(routeResult: stubbedRouteResult))
        
    }
    
    func testRouteCallsCompletionWhenRoutingToHandler(){
        
        //Arrange
        
        //configure router to return a result
        let router = MockRouter()
        
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: [:],
                                                    routingOption: MockRoutingOption())
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure handler container to return a handler and a priority
        let handlerContainer = MockRoutingHandlerContainer()
        
        handlerContainer.stubbedHandlerResult =  { (routeResult: RouteResult) -> Void in }
        handlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 42
        
        //create wireframe with mock dependencies
        let wireframe = DefaultWireframe(router: router,routingHandlerContainer: handlerContainer)
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        //Act
        XCTAssertNoThrow(try wireframe.route(url: URL(string: stubbedRouteResult.routePattern)!,
                                             parameters: stubbedRouteResult.parameters,
                                             option: stubbedRouteResult.routingOption!,
                                             completion: completion))
        
        //Assert
        XCTAssertTrue(didCallCompletion)
        
    }
    
    func testRouteChecksIfComposedControllerProviderIsResponsible(){
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure composed controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no controller or handler can be provided
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}))
        
        //Assert
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        
    }
    
    func testRouteDoesNotCallComposedControllerProviderIfItIsNotResponsible(){
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = false
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no controller or handler can be provided
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}))
        
        //Assert
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        XCTAssertFalse(composedControllerProvider.invokedMakeController)
        
    }
    
    func testRouteDoesThrowErrorIfComposedControllerProviderIsNotResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = false
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no controller or handler can be provided
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}),
                             "should throw an error") { error in
                                
                                //Assert
                                switch error {
                                case DefaultWireframeError.canNotHandleRoute(let routeResult):
                                    XCTAssertTrue(routeResult.isEqual(routeResult: stubbedRouteResult))
                                default:
                                    XCTFail("should throw a DefaultWireframeError.canNotHandleRoute error")
                                }
        }
        
    }
    
    func testRouteDoesCallComposedControllerProviderIfItIsResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = true
        composedControllerProvider.stubbedMakeControllerResult = UIViewController()
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}))
        
        //Assert
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        XCTAssertTrue(composedControllerProvider.invokedMakeController)
        
    }
    
    func testRouteChecksIfComposedRoutingPresenterIsResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = true
        composedControllerProvider.stubbedMakeControllerResult = UIViewController()
        
        //configure mock routing presenter
        let composedRoutingPresenter = MockComposedRoutingPresenter()
        
        let wireframe = DefaultWireframe(router: router,
                                         composedRoutingPresenter: composedRoutingPresenter, composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}))
        
        //Assert
        XCTAssertTrue(composedRoutingPresenter.invokedIsResponsible)
        
    }
    
    func testRouteThrowsErrorIfComposedRoutingPresenterIsNotResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = true
        composedControllerProvider.stubbedMakeControllerResult = UIViewController()
        
        //configure mock routing presenter
        let composedRoutingPresenter = MockComposedRoutingPresenter()
        composedRoutingPresenter.stubbedIsResponsibleResult = false
        
        let wireframe = DefaultWireframe(router: router,
                                         composedRoutingPresenter: composedRoutingPresenter, composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no routing presenter is responsible
        XCTAssertThrowsError(try wireframe.route(url: url,
                                                 parameters: parameters,
                                                 option: option,
                                                 completion: {}),
                                                "Should throw an DefaultWireframeError.noRoutingPresenterFoundFor error") { error in
                                
                                                    switch error {
                                                    case DefaultWireframeError.noRoutingPresenterFoundFor(let routeResult):
                                                        XCTAssertTrue(routeResult.isEqual(routeResult: stubbedRouteResult))
                                                    default:
                                                        XCTFail("Should throw an DefaultWireframeError.noRoutingPresenterFoundFor error")
                                                    }
        }
        
        //Assert
        XCTAssertTrue(composedRoutingPresenter.invokedIsResponsible)
        
    }
    
    func testRouteCallsComposedRoutingPresenterIfItIsResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = true
        composedControllerProvider.stubbedMakeControllerResult = UIViewController()
        
        //configure mock routing presenter
        let composedRoutingPresenter = MockComposedRoutingPresenter()
        composedRoutingPresenter.stubbedIsResponsibleResult = true
        
        //configure mock routing delegate
        let routingDelegate = MockRoutingDelegate()
        
        let wireframe = DefaultWireframe(router: router,
                       composedRoutingPresenter: composedRoutingPresenter,
                                routingDelegate: routingDelegate,
                     composedControllerProvider: composedControllerProvider)
        
        var didCallCompletion = false
        let completion = {
            didCallCompletion = true
        }
        
        // Act
        XCTAssertNoThrow(try wireframe.route(url: url,
                                      parameters: parameters,
                                          option: option,
                                      completion: completion))
        
        //Assert
        XCTAssertTrue(composedRoutingPresenter.invokedIsResponsible)
        XCTAssertTrue(composedRoutingPresenter.invokedPresent)
        
        //assert params
        XCTAssertEqual(composedRoutingPresenter.invokedPresentParameters?.controller, composedControllerProvider.stubbedMakeControllerResult)
        
        AssertThat(composedRoutingPresenter.invokedPresentParameters?.routeResult,
                   isOfType: DefaultRouteResult.self,
                   andEquals: stubbedRouteResult)
        
        
        guard let wireframeParam = composedRoutingPresenter.invokedPresentParameters?.wireframe as? DefaultWireframe else {
            XCTFail("diden't foward wireframe to presenter")
            return
        }
        
        XCTAssertTrue(wireframe === wireframeParam)
        
        AssertThat(composedRoutingPresenter.invokedPresentParameters?.delegate, isOfType: MockRoutingDelegate.self, andEquals: routingDelegate)
        
        guard let complete = composedRoutingPresenter.invokedPresentParametersCompletion else {
            XCTFail("didn't forward completion to presenter")
            return
        }
        
        XCTAssertFalse(didCallCompletion)
        complete()
        XCTAssertTrue(didCallCompletion)
    }
    
    func testRouteChoosesHandlerIfItHasAHigherPriorityThanTheController(){
        
        //Arrange
        
        //configure router to return a result
        let router = MockRouter()
        
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: [:],
                                                    routingOption: MockRoutingOption())
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure handler container to return a handler and a priority
        let handlerContainer = MockRoutingHandlerContainer()
        
        var didCallHandler = false
        let handler = {  (routeResult: RouteResult) -> Void in
            didCallHandler = true
        }
        handlerContainer.stubbedHandlerResult = handler
        handlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 42
        
        //configure composed controller provider to return a lower priority for the controller
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedPriorityOfHighestResponsibleProviderResult = 21
        
        //create wireframe with mock dependencies
        let wireframe = DefaultWireframe(router: router,routingHandlerContainer: handlerContainer, composedControllerProvider: composedControllerProvider)
        
        //Act
        XCTAssertNoThrow(try wireframe.route(url: URL(string: stubbedRouteResult.routePattern)!,
                                             parameters: stubbedRouteResult.parameters,
                                             option: stubbedRouteResult.routingOption!,
                                             completion: {}))
        
        //Assert
        XCTAssertTrue(didCallHandler)
        XCTAssertFalse(composedControllerProvider.invokedIsResponsible)
        
    }
    
    func testRouteChoosesControllerIfItHasAHigherPriorityThanAHandler(){
        
        //Arrange
        
        //configure router to return a result
        let router = MockRouter()
        
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: [:],
                                                    routingOption: MockRoutingOption())
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure handler container to return a handler and a priority
        let handlerContainer = MockRoutingHandlerContainer()
        
        var didCallHandler = false
        let handler = {  (routeResult: RouteResult) -> Void in
            didCallHandler = true
        }
        handlerContainer.stubbedHandlerResult = handler
        handlerContainer.stubbedPriorityOfHighestResponsibleProviderResult = 21
        
        //configure composed controller provider to return a lower priority for the controller
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedPriorityOfHighestResponsibleProviderResult = 42
        composedControllerProvider.stubbedIsResponsibleResult = true
        composedControllerProvider.stubbedMakeControllerResult = UIViewController()
        
        //create wireframe with mock dependencies
        let wireframe = DefaultWireframe(router: router,routingHandlerContainer: handlerContainer, composedControllerProvider: composedControllerProvider)
        
        //Act
        // throws error since no presenter is available
        XCTAssertThrowsError(try wireframe.route(url: URL(string: stubbedRouteResult.routePattern)!,
                                             parameters: stubbedRouteResult.parameters,
                                             option: stubbedRouteResult.routingOption!,
                                             completion: {}))
        
        //Assert
        XCTAssertFalse(didCallHandler)
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        
    }
    
    
    func testControllerChecksIfComposedControllerProviderIsResponsible() {
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure composed controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        XCTAssertNoThrow(try wireframe.controller(url: url,
                                           parameters: parameters))
        
        //Assert
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        
    }
    
    func testControllerDoesNotCallComposedControllerProviderIfItIsNotResponsible(){
        
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = false
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        
        XCTAssertNoThrow(
            try wireframe.controller(url: url,parameters: parameters)
        )
        
        //Assert
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        XCTAssertFalse(composedControllerProvider.invokedMakeController)
        
    }
    
    func testControllerReturnsNilIfComposedControllerProviderIsNotResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = false
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
        
        // Act
        // throws error since no controller or handler can be provided
        var controller : UIViewController?
        XCTAssertNoThrow(
            controller = try wireframe.controller(url: url,
                                           parameters: parameters)
        )
        
        XCTAssertNil(controller)
        
    }
    
    func testControllerDoesCallComposedControllerProviderIfItIsResponsible(){
        
        //Arrange
        let url = URL(string: "/a/nice/path")!
        let parameters = ["id" : "42"]
        let option = MockRoutingOption()
        
        //configure router to return a result
        let router = MockRouter()
        let stubbedRouteResult = DefaultRouteResult(routePattern: "/a/nice/path",
                                                    parameters: parameters,
                                                    routingOption: option)
        router.stubbedRouteUrlRoutingOptionParametersResult = stubbedRouteResult
        
        //configure mock controller provider
        let composedControllerProvider = MockComposedControllerProvider()
        composedControllerProvider.stubbedIsResponsibleResult = true
        composedControllerProvider.stubbedMakeControllerResult = UIViewController()
        
        let wireframe = DefaultWireframe(router: router,composedControllerProvider:composedControllerProvider)
        
    
        var controller : UIViewController?
        XCTAssertNoThrow(
            controller = try wireframe.controller(url: url,
                                           parameters: parameters)
        )
        
        //Assert
        XCTAssertTrue(composedControllerProvider.invokedIsResponsible)
        XCTAssertTrue(composedControllerProvider.invokedMakeController)
        XCTAssertEqual(controller,composedControllerProvider.stubbedMakeControllerResult)
    }
    
    
    
}

