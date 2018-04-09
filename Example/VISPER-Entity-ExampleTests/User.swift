//
//  User.swift
//  VISPER-Entity-ExampleTests
//
//  Created by bartel on 03.04.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Entity

protocol BaseProtocol{}

protocol UserProtocol: NSCoding,BaseProtocol {
    var name: String {get}
}

class User: NSObject,NSCoding, UserProtocol,Entity, CanBeIdentified {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: "name") as? String{
            self.init(name: name)
        }
        return nil
    }
    
    func identifier() -> String {
        return name
    }
    
    
}


