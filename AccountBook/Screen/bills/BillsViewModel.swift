//
//  BillsViewModel.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

// 账单列表数据
final class BillList {
    var list: [DailyBillStruct] = []
    init() {
        // 临时测试数据
        for _ in 1...12 {
            self.list.append(DailyBillStruct(date: Date(), dateDes: "今天", expend: 299, income: 0, bills: self.createTempBillDetailInfos()))
        }
    }
    
    // 临时测试数据
    func createTempBillDetailInfos() -> [BillStruct] {
        let rcounts = arc4random() % 5 + 1;
        var list:[BillStruct] = []
        for _ in 1...rcounts {
            list.append(BillStruct(type: BillTypeEnum.EXPEND, category: BillCategory(type: BillTypeEnum.EXPEND, name: "三餐", icon: "meal", subs: [], sort: 1), desc: "吃饭花的钱啊", amount: Int(34.99)))
        }
        return list
    }
}
