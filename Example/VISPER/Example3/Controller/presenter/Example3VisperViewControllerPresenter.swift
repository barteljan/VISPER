//
//  Example3VisperViewControllerPresenter.swift
//  VISPER
//
//  Created by Jan Bartel on 09.03.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER

class Example3VisperViewControllerPresenter: VISPERViewControllerPresenter {

    let commandBus : CommandBusProtocol
    
    init!(wireframe: IVISPERWireframe!,commandBus:CommandBusProtocol!) {
        self.commandBus = commandBus
        super.init(wireframe: wireframe)
    }
    
    
    override func viewEvent(event: IVISPERViewEvent!, withView view: UIView!, andController viewController: UIViewController!) {
       super.viewEvent(event, withView: view, andController: viewController)
        
        if(event.name()=="shouldCloseViewController"){
            self.closeViewController(viewController)
        }else if(event.name()=="loadDataWithSwift"){
            self.loadData(viewController as! Example3VisperViewController)
        }
    }
    
    
    func closeViewController(controller: UIViewController){
        controller.dismissThisViewControllerAnimated(true) { () -> Void in
            print("dissmissed vc")
        }
    }
    
    
    func loadData(controller: Example3VisperViewController){
        try! self.commandBus.process("loadDataWithSwift") { (result: Any!, error: ErrorType?) -> Void in
            let myResult = result
            
            controller.setText(result as! String)
        }
    }
}
