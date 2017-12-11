//
//  Redux.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation
import VISPER_Reactive
import VISPER_Core

public typealias DefaultRedux<AppState> = Redux<DefaultObservableProperty<AppState>>
