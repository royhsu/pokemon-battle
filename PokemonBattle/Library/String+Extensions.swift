//
//  String+Extensions.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 12/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Sequence

// Reference: https://stackoverflow.com/questions/39592563/split-string-in-swift-by-their-capital-letters
public extension Sequence {
    
    public func splitBefore(
        separator isSeparator: (Iterator.Element) throws -> Bool
    )
    rethrows -> [AnySequence<Iterator.Element>] {
        
        var result: [AnySequence<Iterator.Element>] = []
        
        var subSequence: [Iterator.Element] = []
        
        var iterator = makeIterator()
        
        while let element = iterator.next() {
            
            if try isSeparator(element) {
                
                if !subSequence.isEmpty {
                    
                    result.append(
                        AnySequence(subSequence)
                    )
                    
                }
                
                subSequence = [element]
                
            }
            else { subSequence.append(element) }
            
        }
        
        result.append(
            AnySequence(subSequence)
        )
        
        return result
        
    }
}

// MARK: - Character

public extension Character {
    
    public var isUpperCase: Bool {
        
        return String(self) == String(self).uppercased()
        
    }
    
}
