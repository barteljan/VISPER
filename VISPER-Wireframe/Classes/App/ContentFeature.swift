//
//  SwiftUIFeature.swift
//  VISPER-Wireframe
//
//  Created by Jan Bartel on 08.07.22.
//

import Foundation
import VISPER_Core
import UIKit
import SwiftUI

open class ContentFeature<Content> : ViewFeature where Content : View {
    
    open func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
    
    open var content: Content
    open var routePattern: String
    open var priority: Int = 0
    
    
    public init(routePattern: String, content: Content) {
        self.content = content
        self.routePattern = routePattern
    }
    
    open func makeController(routeResult: RouteResult) throws -> UIViewController {
        return UIHostingController(rootView: self.content)
    }
}

