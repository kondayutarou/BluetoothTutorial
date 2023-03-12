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
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        UIColor.yellow.setFill()
        path.fill()
        path.close()
    }
}
