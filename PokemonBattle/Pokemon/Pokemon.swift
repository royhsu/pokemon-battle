//
//  Pokemon.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Pokemon

import UIKit

public protocol Pokemon {
    
    var attackPoint: Double { get }
    
    var healthPoint: Double { get }
    
}

// MARK: Image

public extension Pokemon {
    
    public static var name: String { return String(describing: self) }
    
    public static var image: UIImage { return UIImage(named: name)! }
    
}
