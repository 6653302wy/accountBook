//
//  AccountViewModel.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

class AccountViewModel: ObservableObject {
    // 按分类的账户列表数据
    @Published var list: [AccountCategoryListStruct] = []
    
    // 所有账户列表
    private var allAccountList: [AccountDetailStruct] = []
    // 账户分类静态数据
    private var accountStaticList: [AccountStruct] = []

    
    init() {
        loadData()
        // 获取所有账户数据  创建测试数据
        for i in 1...12 {
            self.allAccountList.append(AccountDetailStruct(category: Int(arc4random()) % 4 + 1, type: Int(arc4random()) % 4 + 1, customTittle: "账户\(i)", balance: Double(arc4random() % 20000) + 1,  deadLineDate: 28))
        }
                
        // 将所有账户列表分类成按类型分类的数据
        var categoryList: [Int] = []
        var cateListInfo: AccountCategoryListStruct? = nil
        for item in self.allAccountList {
            if categoryList.contains(item.category) {
                let index = getCategoryListStructIndex(cate: item.category)
                cateListInfo = self.list[index]//getCategoryListStructByCate(cate: item.category)
                cateListInfo?.totalAmount += item.balance
                cateListInfo?.list.append(item)
                self.list[index] = cateListInfo ?? self.list[index]
            } else {
                categoryList.append(item.category)
                cateListInfo = AccountCategoryListStruct(category: item.category, totalAmount: item.balance, list: [item])
                self.list.append(cateListInfo!)
            }
        }
        
        // 账户分类排序
        self.list = self.list.sorted{$0.category < $1.category}
    }
    
    func getCategoryListStructIndex(cate: Int) -> Int {
        var data: Int = -1
        for i in 0..<self.list.count {
            let item = self.list[i]
            if item.category == cate {
                data = i
                break
            }
        }
        return data

    }
    
    func getCategoryListStructByCate(cate: Int) -> AccountCategoryListStruct {
        var data: AccountCategoryListStruct? = nil
        for item in self.list {
            if item.category == cate {
                data = item
                break
            }
        }
        return data!
    }
    
    func getLocalAccountInfo(cate: Int, type: Int) -> AccountStruct {
        var targetItem:AccountStruct? = nil
        
        for item in self.accountStaticList {
            if item.category == cate && item.type == type{
                targetItem = item
                break
            }
        }
        
        return targetItem!
    }
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "AccountType", ofType: "json") else { return }
        let localData = NSData.init(contentsOfFile: path)! as Data
        do {
            let list = try JSONDecoder().decode(AccountJsonModel.self, from: localData)
            self.accountStaticList = list.list
            print("json 数据： \(self.accountStaticList)")
          } catch {
              debugPrint("banner===ERROR")
        }
    }
}
