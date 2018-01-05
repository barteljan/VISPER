//
//  LifecycleEvent.swift
//  VISPER-Core
//
//  Created by bartel on 13.12.17.
//

import Foundation

@objc open class LifecycleEvent: NSObject {
    
    @objc open var name: String
    @objc open var sender: AnyObject
    
    @objc public init(name: String, sender: AnyObject) {
        self.name = name
        self.sender = sender
    }
}

@objc open class LoadViewEvent: LifecycleEvent {
    @objc public init(sender: UIViewController) {
        super.init(name: "LoadViewEvent", sender: sender)
    }
}

@objc open class ViewDidLoadEvent: LifecycleEvent {
    @objc public init(sender: UIViewController) {
        super.init(name: "ViewDidLoadEvent", sender: sender)
    }
}

@objc open class ViewWillAppearEvent: LifecycleEvent {
    @objc open let animated: Bool
    
    @objc public init(sender: UIViewController,animated: Bool) {
        self.animated = animated
        super.init(name: "ViewWillAppearEvent", sender: sender)
    }
}

@objc open class ViewDidAppearEvent: LifecycleEvent {
    @objc open let animated: Bool
    
    @objc public init(sender: UIViewController,animated: Bool) {
        self.animated = animated
        super.init(name: "ViewDidAppearEvent", sender: sender)
    }
}

@objc open class ViewWillDisappearEvent: LifecycleEvent {
    @objc open let animated: Bool
    
    @objc public init(sender: UIViewController,animated: Bool) {
        self.animated = animated
        super.init(name: "ViewWillDisappearEvent", sender: sender)
    }
}

@objc open class ViewDidDisappearEvent: LifecycleEvent {
    @objc open let animated: Bool
    
    @objc public init(sender: UIViewController,animated: Bool) {
        self.animated = animated
        super.init(name: "ViewDidDisappearEvent", sender: sender)
    }
}
