//
//  DefaultApplication.swift
//  JLRoutes
//
//  Created by bartel on 25.12.17.
//

import Foundation
import VISPER_Reactive

public typealias DefaultApplication<AppState> = AnyApplication<DefaultObservableProperty<AppState>>
