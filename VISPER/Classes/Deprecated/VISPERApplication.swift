//
//  VISPERApplication.swift
//  VISPER
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core
import VISPER_CommandBus
import VISPER_Wireframe
import VISPER_Objc
import VISPER_Swift
import VISPER_Redux

open class VISPERApplication: NSObject,IVISPERApplication {
    
    var _navigationController: UINavigationController
    var _wireframe: IVISPERWireframe
    var _commandBus: VISPERCommandBus
    
    let application: AnyApplication<NSMutableDictionary>
    
    public override convenience init() {
        let controller = UINavigationController()
        self.init(navigationController: controller)
    }
    
    public convenience init!(navigationController controller: UINavigationController!) {
        
        let wireframe = DefaultWireframe()
        let wireframeObjc = WireframeObjc(wireframe: wireframe)
        let visperWireframe = VISPERWireframe(wireframe: wireframeObjc)
        
        self.init(navigationController: controller, wireframe: visperWireframe)
    }
    
    public convenience init!(navigationController controller: UINavigationController!, wireframe: VISPERWireframe!) {
        let commandBus = VISPERCommandBus()
        self.init(navigationController: controller, wireframe: wireframe, commandBus: commandBus)
    }
    
    public init!(navigationController controller: UINavigationController!,
                                       wireframe: VISPERWireframe!,
                                      commandBus: VISPERCommandBus!) {
        self._navigationController = controller
        self._wireframe = wireframe
        self._commandBus = commandBus
        
        //VISPERWireframe.addRoutingOptionConverter(converter: DefaultRoutingOptionConverter())
        
        let applicationFactory = ApplicationFactory<NSMutableDictionary>()
        let application = applicationFactory.makeApplication(initialState: NSMutableDictionary(),
                                                               appReducer: { (provider, action, state) -> NSMutableDictionary in
                                                return provider.reduce(action: action, state: state)
                                           },
                                           wireframe: wireframe.wireframe.wireframe)
        self.application = application
        
        let featureObserver = DeprecatedVISPERFeatureObserver<NSMutableDictionary>(wireframe: wireframe.wireframe.wireframe, commandBus: commandBus)
        self.application.add(featureObserver: featureObserver)
        
        self.application.add(controllerToNavigate: controller)
        
    }
    
    open func rootViewController() -> UIViewController! {
        return self._navigationController
    }
    
    open func wireframe() -> IVISPERWireframe! {
        return self._wireframe
    }
    
    open func commandBus() -> VISPERCommandBus! {
        return self._commandBus
    }
    
    open func navigationController() -> UINavigationController! {
        return self._navigationController
    }
    
    open func setNavigationController(_ navigationController: UINavigationController!) {
        self._navigationController = navigationController
        self.application.add(controllerToNavigate: navigationController)
    }
    
    open func add(_ feature: IVISPERFeature!) {
        let wrapper = DeprecatedVISPERFeatureWrapper(visperFeature: feature)
        do {
            try self.application.add(feature: wrapper)
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    open func addCommandHandler(_ handler: Any!) {
        self.commandBus().addHandler(handler as AnyObject)
    }
    
    open func add(_ routingPresenter: IVISPERRoutingPresenter!, withPriority priority: Int) {
        self.wireframe().add(routingPresenter, withPriority: priority)
    }
    
    @discardableResult
    open func routeURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!, options: IVISPERRoutingOption!) -> Bool {
        return self.wireframe().routeURL(URL,
                                         withParameters: parameters,
                                         options: options)
    }
    
    open func canRouteURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> Bool {
        return self.wireframe().canRouteURL(URL, withParameters: parameters)
    }
    
    open func controller(for URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> UIViewController! {
        return self.wireframe().controller(for: URL, withParameters: parameters)
    }
    
    
}
