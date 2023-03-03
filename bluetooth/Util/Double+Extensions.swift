//
//  Double+Extensions.swift
//  bluetooth
//
//  Created by Yutaro on 2023/03/12.
//

import Foundation

extension Double {
    var toRadian: CGFloat {
        CGFloat.pi / 180 * self
    }
}
