//
//  DefaultComposedPresenterProvider.swift
//  VISPER-Wireframe
//
//  Created by bartel on 11.12.17.
//

import Foundation
import VISPER_Core

open class DefaultComposedPresenterProvider : ComposedPresenterProvider{
    
    var providers: [ProviderWrapper]
    
    public init(){
        self.providers = [ProviderWrapper]()
    }
    
    public func add(provider: PresenterProvider, priority: Int) {
        let wrapper = ProviderWrapper(priority: priority, presenterProvider: provider)
        self.addProviderWrapper(wrapper: wrapper)
    }
    
    public func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool{
        for wrapper in self.providers {
            if wrapper.presenterProvider.isResponsible(routeResult: routeResult, controller: controller) {
                return true
            }
        }
        return false
    }
    
    public func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        
        var presenters = [Presenter]()
        
        for wrapper in self.providers {
            
            let provider = wrapper.presenterProvider
            
            if provider.isResponsible(routeResult: routeResult, controller: controller) {
                let providerPresenters = try provider.makePresenters(routeResult: routeResult, controller: controller)
                presenters.append(contentsOf: providerPresenters)
            }
            
        }
        
        return presenters
    }
    
    
    //MARK: some helper structs
    struct ProviderWrapper {
        let priority : Int
        let presenterProvider : PresenterProvider
    }
    
    //MARK: some helper functions
    func addProviderWrapper(wrapper: ProviderWrapper) {
        self.providers.append(wrapper)
        self.providers.sort { (wrapper1, wrapper2) -> Bool in
            return wrapper1.priority > wrapper2.priority
        }
    }
}
