//
//  MockRoutingOption.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 21.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe_Core

class MockRoutingOption : NSObject, RoutingOption {
    
    func isEqual(otherOption: RoutingOption?) -> Bool {
        return otherOption is MockRoutingOption
    }
    
    
}
