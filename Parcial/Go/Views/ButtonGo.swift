//
//  ButtonGo.swift
//  Parcial
//
//  Created by Anton Tchistiakov on 5/15/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class ButtonGo: UILabel {
    
    var point: Point!
    var delegate: GoButtonDelegate?
    var set = false
    
    func initialize(position: Int, delegate: GoButtonDelegate) {
        self.delegate = delegate
        self.isUserInteractionEnabled = true
        point = Point(position: position, player: .none)
        self.numberOfLines = 0
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(jugar(_:)))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    func jugar(_ gestureRecognizer: UIGestureRecognizer? = nil) {
        if let d = delegate, !set {
            d.onTouch(pos: point.position, point: self)
            set = true
        }
    }
    
    func quitar() {
        self.text = ""
    }
    
    func voltear(jugador: Player) {
        switch jugador {
        case .player:
            self.text = "⚫️"
        case .player2:
            self.text = "⚪️"
        default:
            break;
        }
        self.sizeToFit()
    }
}

protocol GoButtonDelegate {
    func onTouch(pos: Int, point: ButtonGo)
}
