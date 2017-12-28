//
//  DataCommandHandler.swift
//  VISPER
//
//  Created by Jan Bartel on 25.02.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

import VISPER

class DataCommandHandler: NSObject,CommandHandlerProtocol {
    
    @objc func isResponsible(_ command: Any!) -> Bool {
        
        if let stringCommand = command as? String{
            if(stringCommand == "loadData"){
                return true
            }
        }
        
        return false
    }
    
    
    @objc func process(_ command: Any!, completion: ((_ result: Any?, _ error: Error?) -> Void)?) throws {
        completion?("Meine Daten sind geladen",nil)
    }
}
