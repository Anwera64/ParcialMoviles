//
//  Point.swift
//  Parcial
//
//  Created by Anton Tchistiakov on 5/16/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

class Point: Equatable {

    var position: Int!
    var player: Player!
    
    init(position: Int, player: Player) {
        self.position = position
        self.player = player
    }
    
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        if lhs.position == rhs.position {
            return true
        } else {
            return false
        }
    }
}
