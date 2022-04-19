//
//  UIColorTools.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/18.
//

import Foundation
import UIKit


extension UIColor{
    
    //MARK: - RGB
    class func RGBColor(red : CGFloat, green : CGFloat, blue :CGFloat ) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha:1)
    }
    
    class func RGBColor(_ RGB:CGFloat) -> UIColor {
        return RGBColor(red: RGB, green: RGB, blue: RGB)
    }
    
    //MARK: - 16进制字符串转UIColor
    class func hex(_ hex:String) ->UIColor {
        return hexAlpha(hex, alpha:1)
    }
    
    // 使用： xx.backgroundColor = UIColor.hex("#f2f2f2")
    class func hexAlpha(_ hex:String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from:1)
        } else if (cString.hasPrefix("0X") || cString.hasPrefix("0x")) {
            cString = (cString as NSString).substring(to: 2)
        }
        if ((cString as NSString).length != 6) {
            return gray
        }
        let rString = (cString as NSString).substring(to:2)
        let gString = ((cString as NSString).substring(from:2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from:4) as NSString).substring(to: 2)
        var r:UInt64 = 0, g:UInt64 = 0, b:UInt64 = 0;
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

}
