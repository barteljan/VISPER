//
//  StatefulFeature.swift
//  VISPER-Swift
//
//  Created by bartel on 11.12.17.
//

import Foundation

public protocol StatefulFeature: Feature{
    associatedtype StateType
    var getState: () -> StateType {get}
}
