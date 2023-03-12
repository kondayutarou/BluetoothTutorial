//
//  CircleView.swift
//  bluetooth
//
//  Created by Yutaro on 2023/03/12.
//

import UIKit

final class CircleView: UIView {
    private(set) var width = 100.0
    private(set) var height = 100.0
    private(set) var startingPoint = CGPoint(x: 0.0, y: 0.0)

    init(frame: CGRect, width: Double, height: Double, startingPoint: CGPoint) {
        self.width = width
        self.height = height
        self.startingPoint = startingPoint
        super.init(frame: frame)
        self.setTransparentBackground()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setTransparentBackground()
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: startingPoint.x, y: startingPoint.y, width: width, height: height))
        UIColor.yellow.setFill()
        path.fill()
        path.close()
    }
}
