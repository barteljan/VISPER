import UIKit
import XCTest
@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe

class DefaultRouterTests: XCTestCase {
    
    func testAddLiteralRoute() throws{
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/test/"
        try router.add(routePattern: pattern)
        
        guard router.routeDefinitions.count == 1 else {
            XCTFail("There should be exactly one route definition")
            return
        }
        
        let routeDefinition = router.routeDefinitions[0]
        
        guard routeDefinition.components.count == 4 else {
            XCTFail("There should be 4 route components")
            return
        }
        
        XCTAssertEqual(pattern, routeDefinition.routePattern)
        
        XCTAssertNil(routeDefinition.components[0].name)
        XCTAssertEqual(routeDefinition.components[0].string,"das")
        XCTAssertEqual(routeDefinition.components[0].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[1].name)
        XCTAssertEqual(routeDefinition.components[1].string,"ist")
        XCTAssertEqual(routeDefinition.components[1].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[2].name)
        XCTAssertEqual(routeDefinition.components[2].string,"ein")
        XCTAssertEqual(routeDefinition.components[2].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[3].name)
        XCTAssertEqual(routeDefinition.components[3].string,"test")
        XCTAssertEqual(routeDefinition.components[3].type,RouteDefinition.Component.ComponentType.literal)
        
    }
    
    func testAddVariableRoute() throws {
        
        let router = DefaultRouter()
        
        let pattern =  "/das/ist/:var1/test/"
        try router.add(routePattern:pattern)
        
        guard router.routeDefinitions.count == 1 else {
            XCTFail("There should be exactly one route definition")
            return
        }
        
        let routeDefinition = router.routeDefinitions[0]
        
        guard routeDefinition.components.count == 4 else {
            XCTFail("There should be 4 route components")
            return
        }
        
        XCTAssertEqual(pattern, routeDefinition.routePattern)
        
        XCTAssertNil(routeDefinition.components[0].name)
        XCTAssertEqual(routeDefinition.components[0].string,"das")
        XCTAssertEqual(routeDefinition.components[0].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[1].name)
        XCTAssertEqual(routeDefinition.components[1].string,"ist")
        XCTAssertEqual(routeDefinition.components[1].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertEqual(routeDefinition.components[2].name,"var1")
        XCTAssertNil(routeDefinition.components[2].string)
        XCTAssertEqual(routeDefinition.components[2].type,RouteDefinition.Component.ComponentType.variable)
        
        XCTAssertNil(routeDefinition.components[3].name)
        XCTAssertEqual(routeDefinition.components[3].string,"test")
        XCTAssertEqual(routeDefinition.components[3].type,RouteDefinition.Component.ComponentType.literal)
        
    }
    
    func testAddWildcardRoute() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/*"
        try router.add(routePattern: pattern)
        
        guard router.routeDefinitions.count == 1 else {
            XCTFail("There should be exactly one route definition")
            return
        }
        
        let routeDefinition = router.routeDefinitions[0]
        
        guard routeDefinition.components.count == 4 else {
            XCTFail("There should be 4 route components")
            return
        }
        
        XCTAssertEqual(pattern, routeDefinition.routePattern)
        
        XCTAssertNil(routeDefinition.components[0].name)
        XCTAssertEqual(routeDefinition.components[0].string,"das")
        XCTAssertEqual(routeDefinition.components[0].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[1].name)
        XCTAssertEqual(routeDefinition.components[1].string,"ist")
        XCTAssertEqual(routeDefinition.components[1].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[2].name)
        XCTAssertEqual(routeDefinition.components[2].string,"ein")
        XCTAssertEqual(routeDefinition.components[2].type,RouteDefinition.Component.ComponentType.literal)
        
        XCTAssertNil(routeDefinition.components[3].name)
        XCTAssertNil(routeDefinition.components[3].string)
        XCTAssertEqual(routeDefinition.components[3].type,RouteDefinition.Component.ComponentType.wildcard)
        
    }
    
    func testAddWrongWildcardRoute() throws {
        
        let router = DefaultRouter()
        
        do {
            try router.add(routePattern: "/das/ist/*/Test")
            XCTFail("Add Route should throw an exception in that case")
        } catch DefautRouterError.wildcardNotAtTheEndOfPattern {
            XCTAssert(true)
        }
        
    }
    
    func testCorrectRouteWithLiteral() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: pattern)!
        
        if let result = try router.route(url:url) {
            XCTAssertEqual(result.routePattern, pattern)
            XCTAssert(result.parameters.count == 4)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
        } else {
            XCTFail("router should give an result")
        }
        
    }
    
    func testWrongRouteWithLiteral() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/hier/ist/falsch")!
        
        let result = try router.route(url:url)
        XCTAssertNil(result)
        
    }
    
    func testWrongRouteWithToLongLiteral() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein/test/aber/einer/der/zu/Lang/ist")!
        
        let result = try router.route(url:url)
        XCTAssertNil(result)
        
    }
    
    func testWrongRouteWithToShortLiteral() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein")!
        
        let result = try router.route(url:url)
        XCTAssertNil(result)
        
    }
    
    func testCorrectRouteWithVar() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/:var1/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein/test/")!
        
        if let result = try router.route(url:url) {
            XCTAssertEqual(result.routePattern, pattern)
            XCTAssert(result.parameters.count == 5)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters["var1"] as! String?, "ein")
        } else {
            XCTFail("router should give an result")
        }
        
    }
    
    func testWrongRouteWithToLongVar() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/:var1/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein/test/aber/einer/der/zu/Lang/ist")!
        
        let result = try router.route(url:url)
        XCTAssertNil(result)
        
    }
    
    func testWrongRouteWithToShortVar() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/:var1/test/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein")!
        
        let result = try router.route(url:url)
        XCTAssertNil(result)
    }
    
    func testCorrectRouteWithWildcard() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/*"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein/test")!
        
        if let result = try router.route(url:url) {
            XCTAssertEqual(result.routePattern, pattern)
            XCTAssert(result.parameters.count == 5)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
            
            if let wildcardParams = result.parameters[DefaultRouter.parametersWildcardKey] as? [String]{
                
                if wildcardParams.count == 1 {
                    XCTAssertEqual(wildcardParams[0], "test")
                } else {
                    XCTFail("wildcard parameter shoult be an array of count 1")
                }
                
            } else {
                XCTFail("parameters do not contain wildcard key")
            }
            
            //XCTAssertEqual(result.parameters["*"] as! [String : String]?, "ein")
        } else {
            XCTFail("router should give an result")
        }
        
    }
    
    func testCorrectRouteWithLongWildcard() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/*"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein/test/der/lang/ist")!
        
        if let result = try router.route(url:url) {
            XCTAssertEqual(result.routePattern, pattern)
            XCTAssert(result.parameters.count == 5)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
            
            if let wildcardParams = result.parameters[DefaultRouter.parametersWildcardKey] as? [String]{
                
                if wildcardParams.count == 4 {
                    XCTAssertEqual(wildcardParams[0], "test")
                    XCTAssertEqual(wildcardParams[1], "der")
                    XCTAssertEqual(wildcardParams[2], "lang")
                    XCTAssertEqual(wildcardParams[3], "ist")
                } else {
                    XCTFail("wildcard parameter shoult be an array of count 4")
                }
                
            } else {
                XCTFail("parameters do not contain wildcard key")
            }
            
            //XCTAssertEqual(result.parameters["*"] as! [String : String]?, "ein")
        } else {
            XCTFail("router should give an result")
        }
        
    }
    
    
    
    func testWrongToShortRouteWithWildcard() throws {
        
        let router = DefaultRouter()
        let pattern = "/das/ist/ein/*/"
        try router.add(routePattern: pattern)
        
        let url = URL(string: "/das/ist/ein")!
        
        let result = try router.route(url:url)
        XCTAssertNil(result)
        
    }
    
    func testResolveLastAddedRouteFirst() throws {
        
        let router = DefaultRouter()
        
        let pattern1 =  "/das/ist/ein/:var1"
        try router.add(routePattern:pattern1)
        
        let pattern2 =  "/das/ist/ein/:var2"
        try router.add(routePattern:pattern2)
        
        let url = URL(string: "/das/ist/ein/test/")!
        
        if let result = try router.route(url:url) {
            XCTAssertEqual(result.routePattern, pattern2)
            XCTAssert(result.parameters.count == 5)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern2)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern2)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters["var2"] as! String?, "test")
        } else {
            XCTFail("router should give an result")
        }
        
        
    }
    
    func testParamsAreMerged() throws {
        
        let router = DefaultRouter()
        
        let pattern1 =  "/das/ist/ein/:var1"
        try router.add(routePattern:pattern1)
        
        let url = URL(string: "/das/ist/ein/test/")!
        
        if let result = try router.route(url:url, parameters: ["id" : "55"]) {
            XCTAssertEqual(result.routePattern, pattern1)
            XCTAssert(result.parameters.count == 6)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern1)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern1)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters["var1"] as? String, "test")
            XCTAssertEqual(result.parameters["id"] as? String, "55")
            
        } else {
            XCTFail("router should give an result")
        }
        
        
    }
    
    func testExternalParamsOverwriteParamsExtractedFromTheRouteMerged() throws {
        
        let router = DefaultRouter()
        
        let pattern1 =  "/das/ist/ein/:var1"
        try router.add(routePattern:pattern1)
        
        let url = URL(string: "/das/ist/ein/test/")!
        
        if let result = try router.route(url:url, parameters: ["var1" : "55"]) {
            XCTAssertEqual(result.routePattern, pattern1)
            XCTAssert(result.parameters.count == 5)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRoutePatternKey] as! String?, pattern1)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRoutePatternKey] as! String?, pattern1)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters[DefaultRouter.parametersJLRouteURLKey] as! URL?, url)
            XCTAssertEqual(result.parameters["var1"] as? String, "55")
        } else {
            XCTFail("router should give an result")
        }
        
        
    }
    
    
}
