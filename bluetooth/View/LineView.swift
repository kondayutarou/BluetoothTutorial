//
//  LineView.swift
//  bluetooth
//
//  Created by Yutaro on 2023/03/12.
//

import UIKit

final class LineView: UIView {
    private(set) var length = 5.0
    private(set) var radian = 0.0
    private(set) var startingPoint = CGPoint(x: 0.0, y: 0.0)

    init(frame: CGRect, length: Double, degrees: Double, startingPoint: CGPoint) {
        self.length = length
        self.radian = degrees.toRadian
        self.startingPoint = startingPoint
        super.init(frame: frame)
        self.setTransparentBackground()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setTransparentBackground()
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: CGPoint(x: startingPoint.x + length * cos(radian), y: startingPoint.y + length * sin(radian)))
        path.lineWidth = 1.0
        
        let dashPattern: [CGFloat] = [10, 5, 5, 5]
        path.setLineDash(dashPattern, count: 1, phase: 0)
        path.lineCapStyle = .round
        
        UIColor.green.setStroke()
        path.stroke()
        path.close()
    }
}
