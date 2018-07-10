//
//  UIViewController+DisposeBag.swift
//  VISPER-Reactive
//
//  Created by bartel on 09.07.18.
//

import Foundation
import RxSwift

public extension UIViewController {
    
    private struct AssociatedKeys {
        static var DisposeBagName = "visper_DisposeBagName"
    }
    
    @objc private class DisposeBagWrapper: NSObject {
        let disposeBag: DisposeBag
        
        init(disposeBag: DisposeBag){
            self.disposeBag = disposeBag
        }
    }
    
    public var defaultDisposeBag: DisposeBag {
        
        get {
            if let bag = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBagName) as? DisposeBagWrapper {
                return bag.disposeBag
            } else {
                let wrapper = DisposeBagWrapper(disposeBag: DisposeBag())
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBagName, wrapper, .OBJC_ASSOCIATION_RETAIN)
                return wrapper.disposeBag
            }
        }
        
    }
    
}
