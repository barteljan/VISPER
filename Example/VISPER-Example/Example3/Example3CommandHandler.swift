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

    func isResponsible(_ command: Any!) -> Bool {
        if(command is String && (command as! String)=="loadDataWithSwift"){
            return true
        }
        return false
    }
    
    func process<T>(_ command: Any!, completion: ((_ result: T?, _ error: Error?) -> Void)?) throws {
        completion?(("Data loaded by swift" as! T),nil)
    }
    
}
