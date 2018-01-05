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
    
    
    override func viewWillAppear(_ animated: Bool, view: UIView!, with viewController: UIViewController!, on event: IVISPERViewEvent!) {
        super.viewWillAppear(animated, view: view, with: viewController, on: event)
    }
    
    override func viewEvent(_ event: IVISPERViewEvent!, with view: UIView!, andController viewController: UIViewController!) {
       super.viewEvent(event, with: view, andController: viewController)
        
        if(event.name()=="shouldCloseViewController"){
            self.closeViewController(viewController)
        }else if(event.name()=="loadDataWithSwift"){
            self.loadData(viewController as! Example3VisperViewController)
        }
    }
    
    
    @objc func closeViewController(_ controller: UIViewController){
        self.wireframe.back(true) {
            print("dissmissed vc")
        }
    }
    
    
    @objc func loadData(_ controller: Example3VisperViewController){
        try! self.commandBus.process("loadDataWithSwift") { (result: Any!, error: Error?) -> Void in
            controller.setText(result as! String)
        }
    }
}
