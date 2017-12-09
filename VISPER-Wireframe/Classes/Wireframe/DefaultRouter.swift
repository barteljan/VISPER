//
//  DefaultRouter.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 19.11.17.
//

import Foundation
import VISPER_Wireframe_Core

public enum DefautRouterError : Error {
    case wildcardNotAtTheEndOfPattern
}

/// a struct representing the structure of an route pattern string
struct RouteDefinition {
    
    struct Component {
        
        public enum ComponentType {
            case literal
            case variable
            case wildcard
        }
        
        var string: String?
        var type: Component.ComponentType
        var name: String?
    }
    
    //the route pattern
    let routePattern : String
    
    /// path components
    let components: [Component]
    
    init(routePattern : String,components: [Component]) {
        self.routePattern = routePattern
        self.components = components
    }
    
}


public class DefaultRouter : Router {
   
    public static let parametersJLRouteURLKey = "JLRouteURL"
    public static let parametersRouteURLKey = "RouteURL"
    public static let parametersJLRoutePatternKey = "JLRoutePattern"
    public static let parametersRoutePatternKey = "RoutePattern"
    public static let parametersWildcardKey = "*"
    
    var routeDefinitions: [RouteDefinition] = [RouteDefinition]()
    
    public init(){}
    
    /// Add a route pattern to your router
    ///
    /// - Parameter routePattern: a route pattern defining
    /// - Throws: throws errors for wrong formatted patterns
    public func add(routePattern: String) throws {
        
        var newRoutesComponents: [RouteDefinition.Component] = [RouteDefinition.Component]()
        
        let routePatternComponents: [String] = routePattern.split(separator: "/")
            .map { substring -> String in
                return String(substring)
        }
        
        for (index,routePatternComponent) in routePatternComponents.enumerated() {
            
            let firstChar = routePatternComponent[routePatternComponent.startIndex]
            
            var type: RouteDefinition.Component.ComponentType
            var componentString: String?
            
            var name : String?
            
            switch firstChar {
            case ":" :
                type = .variable
                let secondCharIndex = routePatternComponent.index(after: routePatternComponent.startIndex)
                name = String(routePatternComponent[secondCharIndex...])
            case "*" :
                type = .wildcard
                if index != routePatternComponents.count - 1 {
                    throw DefautRouterError.wildcardNotAtTheEndOfPattern
                }
            default:
                type = .literal
                componentString = routePatternComponent
            }
            
            let component = RouteDefinition.Component(string: componentString, type: type, name: name)
            newRoutesComponents.append(component)
        }
        
        let routeDefinition = RouteDefinition(routePattern: routePattern, components: newRoutesComponents)
        self.routeDefinitions.append(routeDefinition)
    }
    
    
    /// Route for an given url
    ///
    /// - Parameter url: a url
    /// - Returns: a RouteResult if the router can resolve the url, nil otherwise
    /// - Throws: throws routing errors if they occour
    public func route(url: URL) throws -> RouteResult? {
        return try self.route(url: url, parameters: nil)
    }
    
    /// Route for an given url
    ///
    /// - Parameter url: a url
    /// - Returns: a RouteResult if the router can resolve the url, nil otherwise
    /// - Throws: throws routing errors if they occour
    public func route(url: URL, parameters: [String: Any]?) throws ->  RouteResult? {
        return try self.route(url: url, parameters: parameters, routingOption: nil)
    }
    
    /// Route for an given url
    ///
    /// - Parameter url: a url
    /// - Returns: a RouteResult if the router can resolve the url, nil otherwise
    /// - Throws: throws routing errors if they occour
    public func route(url: URL, parameters: [String: Any]?, routingOption: RoutingOption?) throws ->  RouteResult? {
        for routeDefinition in self.routeDefinitions.reversed() {
            if let result = try self.match(route: url,
                                 routeDefinition: routeDefinition,
                                          params: parameters,
                                   routingOption:routingOption) {
                return result
            }
        }
        
        return nil
    }
    
    // Check if this routeDefinition matches an url
    func match(route:URL, routeDefinition: RouteDefinition, params: [String: Any]?, routingOption: RoutingOption?) throws -> RouteResult? {
        
        let stringComponents = route.absoluteString.split(separator: "/").map { (substring) -> String in
            return String(substring)
        }
        
        let routeDefinitionComponents = routeDefinition.components
        
        var parameters = [String : Any]()
        //add default parameters
        parameters[DefaultRouter.parametersRouteURLKey] = route
        parameters[DefaultRouter.parametersJLRouteURLKey] = route
        
        var maxIndex = 0
        
        for (index,stringComponent) in stringComponents.enumerated(){
            
            //check for match and get all parameters
            if index < routeDefinitionComponents.count {
                
                let routeDefinitionComponent = routeDefinitionComponents[index]
                
                switch routeDefinitionComponent.type {
                    
                case .literal:
                    if stringComponent != routeDefinitionComponent.string {
                        return nil
                    }
                case .variable:
                    parameters[routeDefinitionComponent.name!] = stringComponent
                case .wildcard:
                    
                    let additionalParams = self.allItems(from: index, array: stringComponents)
                    //add additional wildcard parameters
                    parameters[DefaultRouter.parametersWildcardKey] = additionalParams
                    
                    //add default parameters
                    parameters[DefaultRouter.parametersRoutePatternKey] = routeDefinition.routePattern
                    parameters[DefaultRouter.parametersJLRoutePatternKey] = routeDefinition.routePattern
                    
                    return DefaultRouteResult(routePattern: routeDefinition.routePattern, parameters: parameters)
                }
                
            } else {
                //given url is to long
                return nil
            }
            maxIndex = index
        }
        
        //check if the given url was to short
        if(routeDefinitionComponents.count-1 > maxIndex){
            return nil
        }
        
        parameters[DefaultRouter.parametersRoutePatternKey] = routeDefinition.routePattern
        parameters[DefaultRouter.parametersJLRoutePatternKey] = routeDefinition.routePattern
        
        if let params = params {
            //override the parameters from the routeResult with the given parameters from this function
            params.forEach({ (key,value) in
                parameters[key] = value
            })
        }
        
        return DefaultRouteResult(routePattern: routeDefinition.routePattern, parameters: parameters, routingOption: routingOption)
    }
    
    
    // get all items from an array starting at index x
    // i'm sure we can optimize this method :-P
    private func allItems(from: Int, array: [String]) -> [String] {
        
        var result = [String]()
        for (index,item) in array.enumerated() {
            if(index >= from){
                result.append(item)
            }
        }
        return result
        
    }
}
