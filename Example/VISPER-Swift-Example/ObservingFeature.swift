//
//  ObservingFeature.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 23.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER

class ObservingFeature: StateObservingFeature<AppState> {
    
    let disposeBag = SubscriptionReferenceBag()
    
    override init(){
        super.init()
    }
    
    override func observe(state: ObservableProperty<AppState>) throws{
        
        let subscription = state.subscribe { (nextState) in
            print("state:\(nextState)")
        }
        self.disposeBag.addReference(reference: subscription)
    }
}
