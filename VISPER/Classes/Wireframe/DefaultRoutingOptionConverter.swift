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
        
        if let _ = presentationType as? IVISPERWireframePresentationTypeBackToRoute {
            throw DefaultRoutingOptionConverterError.couldNotConvertIVISPERRoutingOption(option: visperRoutingOption)
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeModal {
            return DefaultModalRoutingOption(animated: type.animated(),
                                             presentationStyle: type.presentationStyle(),
                                             transitionStyle: nil)
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypePush {
            return DefaultPushRoutingOption(animated: type.animated())
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeRootVC {
            return DefaultRootVCRoutingOption(animated: type.animated())
        }
        
        if let type = presentationType as? IVISPERWireframePresentationTypeReplaceTopVC {
            return DefaultReplaceTopVCRoutingOption(animated: type.animated())
        }
        
        if let _ = presentationType as? IVISPERWireframePresentationTypeShow {
            throw DefaultRoutingOptionConverterError.couldNotConvertIVISPERRoutingOption(option: visperRoutingOption)
        }
        
        throw DefaultRoutingOptionConverterError.couldNotConvertIVISPERRoutingOption(option: visperRoutingOption)
    }
    
    open func routingOption(routingOption: RoutingOption?) throws -> IVISPERRoutingOption? {
        
        guard let routingOption = routingOption else {
            return nil
        }
        
        var presentationType: IVISPERWireframePresentationType?
        
        if let routingOption = routingOption as? ModalRoutingOption {
            
            let type = VISPERPresentationTypeModal(isAnimated: routingOption.animated)
            
            if let style = routingOption.presentationStyle {
                type?.presentationStyle = style
            }
            
            presentationType = type
        }
        
        if let routingOption = routingOption as? PushRoutingOption {
            presentationType = VISPERPresentationTypePush(isAnimated: routingOption.animated)
        }
        
        if let routingOption = routingOption as? RootVCRoutingOption {
            presentationType = VISPERPresentationTypeRootVC(isAnimated: routingOption.animated)
        }
        
        if let routingOption = routingOption as? ReplaceTopVCRoutingOption {
            presentationType = VISPERPresentationTypeReplaceTopVC(isAnimated: routingOption.animated)
        }
        
        if let type = presentationType {
            return VISPERRoutingOption(presentationType: type)
        } else {
            throw DefaultRoutingOptionConverterError.couldNotConvertRoutingOption(option: routingOption)
        }
        
    }
    
    
}
