//
//  WireframeAppFactory.swift
//  VISPER-Wireframe
//
//  Created by bartel on 16.07.18.
//

import Foundation
import VISPER_Core

public protocol WireframeAppFactory{
    func makeApp(wireframe: Wireframe?,controllerContainer: ControllerContainer) -> WireframeApp
}

