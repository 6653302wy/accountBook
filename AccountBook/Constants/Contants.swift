//
//  Contants.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

// 颜色相关
let redColor = "#d81e06"
let greenColor = "#08af33"
let textTitle = "#101010"
let textGray = "#666"
let textLightGray = "#999"
let textBlue = "5EAAF8"
// 页面背景底色
let bgColor = "#f6f6f6"


// 字号
let defaultTextSize = 14
let nameTextSize = 15
let titleTextSize = 18


/// 分类信息
///
// 分类子分类信息
struct BillSubCategory {
    var name: String
    var icon: String
}
// 分类信息
struct BillCategory {
    var type: BillTypeEnum
    var name: String
    var icon: String
    var subs: [BillSubCategory]
    var sort: Int
}

