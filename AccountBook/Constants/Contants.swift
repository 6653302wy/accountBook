//
//  Contants.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

let redColor = "#d81e06"
let greenColor = "#08af33"
let textTitle = "#101010"
let textGray = "#666"
let textLightGray = "#999"
let bgColor = "#f6f6f6"

// 记账类型
enum BillTypeEnum: String {
    // 支出
    case EXPEND = "支出"
    // 收入
    case INCOME = "收入"
    // 转账
    case TRANSFER = "转账"
    // 还款
    case REPAYMENT = "还款"
}


// 账单分类子分类信息
struct BillSubCategory {
    var name: String
    var icon: String
}
// 账单分类信息
struct BillCategory {
    var type: BillTypeEnum
    var name: String
    var icon: String
    var subs: [BillSubCategory]
    var sort: Int
}

