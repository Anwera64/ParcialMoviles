//
//  GoView.swift
//  Parcial
//
//  Created by Anton Tchistiakov on 5/15/18.
//  Copyright © 2018 Anton Tchistiakov. All rights reserved.
//

import UIKit

class GoView: UIView, GoButtonDelegate {
    
    var delegate: GoViewProtocol?

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        for i in 0...8 {
            let viewVertical = UIView(frame: CGRect(x: self.bounds.origin.x + CGFloat(i)*self.bounds.width/8, y: self.bounds.origin.y, width: 7, height: self.bounds.height + 7))
            viewVertical.backgroundColor = UIColor.brown
            
            let viewHorizontal = UIView(frame: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y + CGFloat(i)*self.bounds.height/8, width: self.bounds.width + 7, height: 7))
            viewHorizontal.backgroundColor = UIColor.brown
            
            self.addSubview(viewVertical)
            self.addSubview(viewHorizontal)
        }
        
        for i in 0...8 {
            for k in 0...8 {
                let point = ButtonGo(frame: CGRect(x: self.bounds.origin.x + CGFloat(i)*self.bounds.width/8 - 7, y: self.bounds.origin.y + CGFloat(k)*self.bounds.height/8 - 7, width: 20, height: 20))
                point.initialize(position: i*9+k, delegate: self)
                delegate?.addPoint(point)
                self.addSubview(point)
            }
        }
    }

    func onTouch(pos: Int, point: ButtonGo) {
        delegate?.onTouch(pos: pos, point: point)
    }
    
    func deleteAllViews() {
        subviews.forEach({$0.removeFromSuperview()})
    }
}

protocol GoViewProtocol {
    
    func addPoint(_ point: ButtonGo)
    
    func onTouch(pos: Int, point: ButtonGo)
}
