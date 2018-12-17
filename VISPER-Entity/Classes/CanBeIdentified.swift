//
//  CanBeIdentifiedProtocol.swift
//  Pods
//
//  Created by Jan Bartel on 06.05.16.
//
//

import Foundation

public protocol CanBeIdentified: Entity{
    func identifier()->String
}


public extension Array where Element: CanBeIdentified {
    func index(identifieable: CanBeIdentified) -> Int? {
        var currentIndex: Int?
        
        for (index, element) in self.enumerated() {
            if identifieable.identifier() == element.identifier() {
                currentIndex = index
                break
            }
        }
        
        return currentIndex
    }
}
