//
//  GoManager.swift
//  Parcial
//
//  Created by Anton Tchistiakov on 5/15/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import Foundation
import SwiftGraph
//Estoy usando una libreria de GitHub para manejar grafos
//link: https://github.com/davecom/SwiftGraph

class GoManager {
    
    var graph: UnweightedGraph<Point?>!
    var player: Player!
    var score1 = 0 {
        didSet {
            delegate.changeScore(player: .player, score: score1)
        }
    }
    var score2 = 0 {
        didSet {
            delegate.changeScore(player: .player2, score: score2)
        }
    }
    var delegate: GoGameDelegate!
    
    init(delegate: GoGameDelegate) {
        self.delegate = delegate
        player = .player
        generatePoints()
    }
    
    private func generatePoints() {
        graph = UnweightedGraph()
        for i in 0...80 {
            let point = Point(position: i, player: .none)
            _ = graph.addVertex(point)
            if i - 1 >= 0 {
                graph.addEdge(from: i-1, to: i)
            }
            if i - 9 >= 0 {
                graph.addEdge(from: i - 9, to: i)
            }
        }
    }
    
    func setPoint(_ pos: Int) {
        graph.vertexAtIndex(pos)?.player = player
        print("Clicked: \(pos) ")
        checkIfLocked(pos: pos)
        graph.neighborsForIndex(pos).forEach { (neighbour) in
            if let position = neighbour?.position {
                checkIfLocked(pos: position)
            }
        }
        player = player.getOppositeType(mode: .go)
    }
    
    private func checkIfLocked(pos: Int) {
        var locked = true
        
        print("\n Neighbour check: \(pos) \(graph.vertexAtIndex(pos)!.player) ")
        graph.neighborsForIndex(pos).forEach { (neighbour) in
            print("\(neighbour!.position) \(neighbour!.player)")
            if graph.vertexAtIndex(pos)!.player == Player.none || neighbour!.player == Player.none || neighbour!.player == graph.vertexAtIndex(pos)!.player, locked  {
                locked = false
            }
        }
        if locked {
            delegate.removePoint(pos: pos)
            graph.vertexAtIndex(pos)!.player = Player.none
            switch player! {
            case .player:
                score2 += 1
            case .player2:
                score1 += 1
            default:
                break
            }
        }
        
    }
    
    func reset() {
        graph.forEach { (vertex) in
            vertex!.player = .none
        }
        player = .player
        score1 = 0
        score2 = 0
    }
}

protocol GoGameDelegate {
    func endGame()
    
    func changeScore(player: Player, score: Int)
    
    func removePoint(pos: Int)
}
