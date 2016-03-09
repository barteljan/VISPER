//
//  Example3CommandHandler.swift
//  VISPER
//
//  Created by Jan Bartel on 09.03.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER

class Example3CommandHandler: CommandHandlerProtocol {

    func isResponsible(command: Any!) -> Bool {
        if(command is String && (command as! String)=="loadDataWithSwift"){
            return true
        }
        return false
    }
    
    func process<T>(command: Any!, completion: ((result: T?, error: ErrorType?) -> Void)?) throws {
        completion?(result:("Data loaded by swift" as! T),error:nil)
    }
    
}
