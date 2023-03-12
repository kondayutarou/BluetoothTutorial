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
    
    init(centerX: CGFloat) {
        self.centerX = centerX
    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        let lineView = LineView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), length: 500.0, degrees: 45)
        let circleView = CircleView(frame: CGRect(x: centerX, y: 50, width: 100, height: 100))
        view.backgroundColor = .red
        view.addSubview(lineView)
        view.addSubview(circleView)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct DesignViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        DesignViewWrapper(centerX: 50.0)
    }
}
