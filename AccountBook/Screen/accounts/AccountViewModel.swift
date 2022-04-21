//
//  AccountViewModel.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/19.
//

import Foundation

class AccountViewModel: ObservableObject {
    // 资产信息
    @Published var assetsInfo: AssetsStruct
    // 是否显示资产数据
    @Published var showAssetsNumber: Bool
    // 按分类的账户列表数据
    @Published var list: [AccountCategoryListStruct]
    
    
    // 所有账户列表
    private var allAccountList: [AccountDetailStruct]
    // 账户分类静态数据
    private var accountStaticList: [AccountStruct]

    
    init() {
        // 属性需要先初始化才能使用
        self.assetsInfo = AssetsStruct(totalAmount:0, totalCreditAmount: 0, netAssets: 0, DebtAmount: 0, loanAmount: 0, isDebtLoanCounting: false)
        self.showAssetsNumber = true
        self.list = []
        self.allAccountList = []
        self.accountStaticList = []
        
        loadData()
        parseAssetsInfo()
        parseAccountList()
    }
    
    func parseAssetsInfo(){
        // 临时测试数据
        self.assetsInfo = AssetsStruct(totalAmount: 29898.23, totalCreditAmount: 8989.34, netAssets: 22342.02, DebtAmount: 8000, loanAmount: 10000, isDebtLoanCounting: false)
    }
    
    // 解析账户列表
    func parseAccountList(){
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
                cateListInfo = self.list[index]
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
        var index: Int = -1
        for i in 0..<self.list.count {
            let item = self.list[i]
            if item.category == cate {
                index = i
                break
            }
        }
        return index

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
