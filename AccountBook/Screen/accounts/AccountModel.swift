//
//  AccountModel.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

// 资产大类型
enum AccountCategoryEnum: Int {
    case UNDEFINED = 0
    // 资金账户
    case FUND = 1
    // 信用账户
    case CREDIT = 2
    // 充值账户
    case RECHARGE = 3
    // 投资账户
    case INVEST = 4
}

func AccountCategoryDisplayName(cate: AccountCategoryEnum) -> String{
    switch cate {
    case AccountCategoryEnum.FUND:
        return "资金账户"
    case AccountCategoryEnum.CREDIT:
        return "信用卡账户"
    case AccountCategoryEnum.RECHARGE:
        return "充值账户"
    case AccountCategoryEnum.INVEST:
        return "投资账户"
    default:
        return "错误账户类型"
    }
}


// 账户基本信息
struct AccountStruct: Codable{
    // 账户分类
    var category: Int
    // 账户类型
    var type: Int
    // 名称
    var name: String
    // 图标
    var icon: String
}

struct AccountJsonModel: Codable {
    var list: [AccountStruct]
}


// 账户信息
struct AccountDetailStruct: Identifiable{
    // 账户分类
    var category: Int
    var type: Int
    var customTittle: String
    // 余额 | 欠款(信用卡账户)
    var balance: Double
    // 信用卡账户，总额度
    var totalLimit: Double?
    // 信用卡账户，还款日期
    var deadLineDate: Int?
    
    var id = UUID()
}


// 账户单个分类下账户列表
struct AccountCategoryListStruct: Identifiable {
    var id = UUID()
    // 账户分类
    var category: Int
    // 所有账户总金额
    var totalAmount: Double
    // 账户列表
    var list: [AccountDetailStruct]
}
