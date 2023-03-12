//
//  DesignViewWrapper.swift
//  bluetooth
//
//  Created by Yutaro on 2023/03/03.
//

import Foundation
import SwiftUI

struct DesignViewWrapper: UIViewRepresentable {
    let centerX: CGFloat
    let superviewWidth: CGFloat
    let circleViewRadius: CGFloat
    let circleSpacing: CGFloat = 48.0
    
    init(centerX: CGFloat, superviewWidth: CGFloat) {
        self.centerX = centerX
        self.superviewWidth = superviewWidth
        self.circleViewRadius = superviewWidth / 8
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        let lineView = LineView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), length: 500.0, degrees: 45)
        let leftCircleView = CircleView(
            frame: CGRect(
                x: centerX - circleViewRadius * 2 - circleSpacing / 2,
                y: 0.0,
                width: circleViewRadius * 2,
                height: circleViewRadius * 2
            )
        )
        let rightCircleView = CircleView(
            frame: CGRect(
                x: centerX + circleSpacing / 2,
                y: 0.0,
                width: circleViewRadius * 2,
                height: circleViewRadius * 2
            )
        )
        let bottomCircleView = CircleView(
            frame: CGRect(
                x: centerX - circleViewRadius,
                y: leftCircleView.bounds.size.height,
                width: circleViewRadius * 2,
                height: circleViewRadius * 2
            )
        )
        rightCircleView.backgroundColor = .blue
        leftCircleView.backgroundColor = .brown
        bottomCircleView.backgroundColor = .green
        view.backgroundColor = .red
        view.addSubview(lineView)
        view.addSubview(bottomCircleView)
        view.addSubview(leftCircleView)
        view.addSubview(rightCircleView)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
