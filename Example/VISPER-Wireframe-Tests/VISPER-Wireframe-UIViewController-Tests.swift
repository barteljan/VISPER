//
//  VISPER-Wireframe-UIViewController-Tests.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 09.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import VISPER_Wireframe
import VISPER_Wireframe_Core
import VISPER_Wireframe_Objc

class VISPER_Wireframe_UIViewController_Tests: XCTestCase {
    
    func testRouteResultIsSet(){
        
        let controller = MockViewController()
        let wireframe = MockWireframe()
        let wireframeObjc = WireframeObjc(wireframe: wireframe)
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: ["id":"42"])
        let routeResultObjc = RouteResultObjc(routeResult: routeResult)
        
        controller.willRoute(wireframeObjc, routeResult: routeResultObjc)
        
        AssertThat(controller.routeResultObjc?.routeResult, isOfType: DefaultRouteResult.self, andEquals: routeResult)
        
    }
    
    func testRoutePatternIsSet(){
        
        let controller = MockViewController()
        let wireframe = MockWireframe()
        let wireframeObjc = WireframeObjc(wireframe: wireframe)
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: ["id":"42"])
        let routeResultObjc = RouteResultObjc(routeResult: routeResult)
        
        controller.willRoute(wireframeObjc, routeResult: routeResultObjc)
        
        XCTAssertEqual(controller.routePattern, routeResult.routePattern)
        
    }
    
    func testRouteParametersAreSet(){
        
        let controller = MockViewController()
        let wireframe = MockWireframe()
        let wireframeObjc = WireframeObjc(wireframe: wireframe)
        let routeResult = DefaultRouteResult(routePattern: "/some/pattern", parameters: ["id":"42"])
        let routeResultObjc = RouteResultObjc(routeResult: routeResult)
        
        controller.willRoute(wireframeObjc, routeResult: routeResultObjc)
        
        XCTAssertNotNil(controller.routeParameters)
        
        AssertThat(controller.routeParameters,
                    isOfType: NSDictionary.self, andEquals: NSDictionary(dictionary: routeResult.parameters))
        
    }
    
}
