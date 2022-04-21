//
//  BillsModel.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

// 记账类型
enum BillTypeEnum: Int {
    // 支出
    case EXPEND = 1
    // 收入
    case INCOME = 2
    // 转账
    case TRANSFER = 3
    // 还款
    case REPAYMENT = 4
}

func BillTypeDisplayName(type: BillTypeEnum) -> String{
    switch type {
    case BillTypeEnum.EXPEND:
        return "支出"
    case BillTypeEnum.INCOME:
        return "收入"
    case BillTypeEnum.TRANSFER:
        return "转账"
    case BillTypeEnum.REPAYMENT:
        return "还款"
    }
}

// 账单明细
struct BillStruct: Identifiable{
    // 记账类型
    var type: BillTypeEnum
    // 记账分类
    var category: BillCategory
    // 描述
    var desc: String
    // 金额
    var amount: Int
    
    var id = UUID()
}

// 日账单信息
struct DailyBillStruct: Identifiable{
    var date: Double
    // 日期描述: 今天 | 昨天 | 前天 | 星期x
    var dateDes: String
    var expend: Int
    var income: Int
    var bills: [BillStruct]
    var id = UUID()
}
