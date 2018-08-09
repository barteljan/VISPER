//
//  CallbackPipeline.swift
//  VISPER-Redux
//
//  Created by bartel on 03.08.18.
//

import Foundation

public class DidCallAllClosuresPipeline {
    
    public typealias PipelineCallback = () -> Void
    
    private var callbackWrappers = [ClosureWrapper]()
    private var allCallbacksAreCalled: PipelineCallback
    private var started: Bool = false
    
    public init(allCallbacksAreCalled:@escaping PipelineCallback){
        self.allCallbacksAreCalled = allCallbacksAreCalled
    }
    
    public func chainClosure(callback:@escaping PipelineCallback) -> PipelineCallback {
        let wrapper = ClosureWrapper {
            callback()
            self.checkAllClosures()
        }
        self.callbackWrappers.append(wrapper)
        return wrapper.callback
    }
    
    public func start() {
        self.started = true
        checkAllClosures()
    }
    
    private func checkAllClosures() {
        
        guard self.started == true else {
            return
        }
        
        var someWasNotCalled: Bool = false
        
        for wrapper in self.callbackWrappers {
            if wrapper.alreadyCalled == false {
                someWasNotCalled = true
                break
            }
        }
        
        if someWasNotCalled == false {
            self.allCallbacksAreCalled()
        }
        
    }
    
    private class ClosureWrapper {
        
        internal var callback: PipelineCallback = {  }
        private  var realCallBack: (PipelineCallback)?
        internal var alreadyCalled: Bool = false
        
        init(callback: @escaping PipelineCallback ){
            self.callback = { [weak self] in
                self?.realCallBack = callback
                self?.alreadyCalled = true
                self?.realCallBack?()
              
            }
        }
    }
    
}
