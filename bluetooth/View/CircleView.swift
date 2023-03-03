//
//  CircleView.swift
//  bluetooth
//
//  Created by Yutaro on 2023/03/12.
//

import UIKit

final class CircleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTransparentBackground()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setTransparentBackground()
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
        UIColor.yellow.setStroke()
        UIColor.yellow.setFill()
        path.lineWidth = 0.0
        path.stroke()
        path.fill()
        path.close()
    }
}
