//
//  DataCommandHandler.swift
//  VISPER
//
//  Created by Jan Bartel on 25.02.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

import VISPER

class DataCommandHandler: NSObject,CommandHandlerProtocol {
    
    func isResponsible(command: Any!) -> Bool {
        
        if let stringCommand = command as? String{
            if(stringCommand == "loadData"){
                return true
            }
        }
        
        return false
    }
    
    
    func process(command: Any!, completion: ((result: Any?, error: ErrorType?) -> Void)?) throws {
        completion?(result:"Meine Daten sind geladen",error: nil)
    }
}
