//
//  GoViewController.swift
//  Parcial
//
//  Created by Anton Tchistiakov on 5/15/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class GoViewController: UIViewController, GoGameDelegate, GoViewProtocol {
  
    @IBOutlet weak var mainView: GoView!
    var gameManager: GoManager!
    @IBOutlet weak var labelBlack: UILabel!
    @IBOutlet weak var labelWhite: UILabel!
    var points: [ButtonGo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.delegate = self
        self.gameManager = GoManager(delegate: self)
    }
    
    func endGame() {
        
    }
    
    func onTouch(pos: Int, point: ButtonGo) {
        point.point.player = gameManager.player
        gameManager.setPoint(pos)
        point.voltear(jugador: gameManager.player)
    }
    
    func addPoint(_ point: ButtonGo) {
        if points == nil { points = Array() }
        points!.append(point)
    }

    @IBAction func reset(_ sender: UIButton) {
        mainView.deleteAllViews()
        mainView.setNeedsDisplay()
        labelBlack.text = "Puntaje ⚫️: 0"
        labelWhite.text = "Puntaje ⚪️: 0"
        points?.removeAll()
    }
    
    func removePoint(pos: Int) {
        points![pos].quitar()
    }
    
    func changeScore(player: Player, score: Int) {
        switch player {
        case .player:
            labelBlack.text = "Puntaje ⚫️: \(score)"
        case .player2:
            labelWhite.text = "Puntaje ⚪️: \(score)"
        default:
            break
        }
    }
}
