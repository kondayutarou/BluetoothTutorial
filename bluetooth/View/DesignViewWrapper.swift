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
        
        let leftCircleView = CircleView(
            frame: CGRect(
                x: centerX - circleViewRadius * 2 - circleSpacing / 2,
                y: 0.0,
                width: circleViewRadius * 2,
                height: circleViewRadius * 2
            ),
            circleFillColor: .gray
        )
        let rightCircleView = CircleView(
            frame: CGRect(
                x: centerX + circleSpacing / 2,
                y: 0.0,
                width: circleViewRadius * 2,
                height: circleViewRadius * 2
            ),
            circleFillColor: .gray
        )

        let distance = rightCircleView.center.x - leftCircleView.center.x
        
        let horizontalLine = LineView(
            frame: CGRect(origin: leftCircleView.center, size: CGSize(width: distance, height: circleViewRadius)),
            length: distance,
            degrees: 0.0,
            startingPoint: CGPoint(x: 0.0, y: 0.0)
        )
        let leftLine = LineView(
            frame: CGRect(
                origin: leftCircleView.center,
                size: CGSize(width: distance / 2, height: (pow(distance, 2) - pow(distance / 2, 2)).squareRoot() )
            ),
            length: distance,
            degrees: 60.0,
            startingPoint: CGPoint(x: 0.0, y: 0.0)
        )
        let rightLine = LineView(
            frame: CGRect(origin: CGPoint(x: centerX, y: leftCircleView.center.y), size: CGSize(width: distance / 2, height: leftLine.bounds.height)),
            length: distance,
            degrees: 300.0,
            startingPoint: CGPoint(x: 0.0, y: leftLine.bounds.height)
        )
        let bottomCircleView = CircleView(
            frame: CGRect(
                x: centerX - circleViewRadius,
                y: leftLine.bounds.maxY,
                width: circleViewRadius * 2,
                height: circleViewRadius * 2
            ),
            circleFillColor: .gray
        )

        view.addSubview(leftLine)
        view.addSubview(rightLine)
        view.addSubview(horizontalLine)
        view.addSubview(leftCircleView)
        view.addSubview(rightCircleView)
        view.addSubview(bottomCircleView)

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
