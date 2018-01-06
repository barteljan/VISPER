//
//  DefaultRoutingOptionConverter.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core
import VISPER_Wireframe

public enum DefaultRoutingOptionConverterError: Error {
    case couldNotConvertIVISPERRoutingOption(option:IVISPERRoutingOption)
    case couldNotConvertRoutingOption(option:RoutingOption)
}

open class DefaultRoutingOptionConverter: RoutingOptionConverter {
    
    public init(){
        
    }
    
    open func routingOption(visperRoutingOption: IVISPERRoutingOption?) throws -> RoutingOption? {
        
        guard let visperRoutingOption = visperRoutingOption else {
            return nil
        }
        
        guard let presentationType = visperRoutingOption.wireframePresentationType() else {
            return nil
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeBackToRoute {
            return DefaultRoutingBackTo(animated: type.animated())
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeModal {
            return DefaultRoutingOptionModal(animated: type.animated(),
                                             presentationStyle: type.presentationStyle(),
                                             transitionStyle: nil)
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypePush {
            return DefaultRoutingOptionPush(animated: type.animated())
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeRootVC {
            return DefaultRoutingOptionRootVC(animated: type.animated())
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeReplaceTopVC {
            return DefaultRoutingOptionReplaceTopVC(animated: type.animated())
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeShow {
            return DefaultRoutingOptionShow(animated: type.animated())
        }
        
        throw DefaultRoutingOptionConverterError.couldNotConvertIVISPERRoutingOption(option: visperRoutingOption)
    }
    
    open func routingOption(routingOption: RoutingOption?) throws -> IVISPERRoutingOption? {
        
        guard let routingOption = routingOption else {
            return nil
        }
        
        var presentationType: IVISPERWireframePresentationType?
        
        if let routingOption = routingOption as? RoutingOptionModal {
            
            let type = VISPERPresentationTypeModal(isAnimated: routingOption.animated)
            
            if let style = routingOption.presentationStyle {
                type?.presentationStyle = style
            }
            
            presentationType = type
        }
        
        if let routingOption = routingOption as? RoutingOptionPush {
            presentationType = VISPERPresentationTypePush(isAnimated: routingOption.animated)
        }
        
        if let routingOption = routingOption as? RoutingOptionRootVC {
            presentationType = VISPERPresentationTypeRootVC(isAnimated: routingOption.animated)
        }
        
        if let routingOption = routingOption as? RoutingOptionReplaceTopVC {
            presentationType = VISPERPresentationTypeReplaceTopVC(isAnimated: routingOption.animated)
        }
        
        if let routingOption = routingOption as? RoutingOptionShow {
            presentationType = VISPERPresentationTypeShow(isAnimated: routingOption.animated)
        }
        
        if let routingOption = routingOption as? RoutingOptionBackTo {
            presentationType = VISPERPresentationTypeBackToRoute(isAnimated: routingOption.animated)
        }

        if let type = presentationType {
            return VISPERRoutingOption(presentationType: type)
        } else {
            throw DefaultRoutingOptionConverterError.couldNotConvertRoutingOption(option: routingOption)
        }
        
    }
    
    
}
