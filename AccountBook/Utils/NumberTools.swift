//
//  NumberTools.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/20.
//

import Foundation

// 不起作用
extension Float {
    func fixed(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))

        return (self * divisor).rounded() / divisor

    }

}
// 不起作用
extension Double {
    func fixed(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))

        return (self * divisor).rounded() / divisor

    }

}
