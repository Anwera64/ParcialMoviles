//
//  PlayerEnum.swift
//  Parcial
//
//  Created by Anton Tchistiakov on 5/15/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation

enum Player: String {
    case player = "Jugador"
    case house = "Casa"
    case player2 = "Jugador 2"
    case none = ""
    
    func getOppositeValue(mode: gameMode) -> String {
        switch self {
        case .player:
            switch mode {
            case .blackJack:
                return Player.house.rawValue
            case .go, .michi:
                return Player.player2.rawValue
            }
        case .house, .player2:
            return Player.player.rawValue
        default:
            return Player.none.rawValue
        }
    }
    
    func getOppositeType(mode: gameMode) -> Player {
        switch self {
        case .player:
            switch mode {
            case .blackJack:
                return Player.house
            case .go, .michi:
                return Player.player2
            }
        case .house, .player2:
            return Player.player
        default:
            return Player.none
        }
    }
}
