//
//  UIViewController+SubscriptionReferenceBag.swift
//  VISPER-Reactive
//
//  Created by bartel on 09.07.18.
//

import Foundation

public extension UIViewController {
    
    private struct AssociatedKeys {
        static var SubscriptionBagName = "visper_SubscriptionBagName"
    }
    
    @objc private class SubscriptionBagWrapper: NSObject {
        let subscriptionBag: SubscriptionReferenceBag
        
        init(subscriptionBag: SubscriptionReferenceBag){
            self.subscriptionBag = subscriptionBag
        }
    }
    
    public var defaultSubscriptionReferenceBag: SubscriptionReferenceBag {
        
        get {
            if let bag = objc_getAssociatedObject(self, &AssociatedKeys.SubscriptionBagName) as? SubscriptionBagWrapper {
                return bag.subscriptionBag
            } else {
                let wrapper = SubscriptionBagWrapper(subscriptionBag: SubscriptionReferenceBag())
                objc_setAssociatedObject(self, &AssociatedKeys.SubscriptionBagName, wrapper, .OBJC_ASSOCIATION_RETAIN)
                return wrapper.subscriptionBag
            }
        }
        
    }
    
}
