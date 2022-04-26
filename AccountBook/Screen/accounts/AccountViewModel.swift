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
    // 当前选择的创建的账户数据
    @Published var curNewAccountInfo: AccountDetailStruct
    
    // 是否显示添加账户弹窗
    @Published var showAddCountSheet: Bool
    
    
    // 账户分类静态数据
    @Published var accountStaticList: [AccountJsonModel]
    // 可选择的银行列表
    @Published var bankStaticList: BankListJsonModel
    
    // 所有账户列表
    private var allAccountList: [AccountDetailStruct]
    
    init() {
        // 属性需要先初始化才能使用
        self.assetsInfo = AssetsStruct(totalAmount:0, totalCreditAmount: 0, netAssets: 0, DebtAmount: 0, loanAmount: 0, isDebtLoanCounting: false)
        self.showAssetsNumber = true
        self.list = []
        self.allAccountList = []
        self.accountStaticList = []
        self.bankStaticList = BankListJsonModel(list: [])
        self.curNewAccountInfo = AccountDetailStruct(category: 0, type: 0, icon: "", name: "", desc: "", balance: 0)
        self.showAddCountSheet = false
        
        parseLocalData()
        parseAssetsInfo()
        parseAccountList()
    }
    
    func setCurChoosenAccount(category: Int = AccountCategoryEnum.UNDEFINED.rawValue, type: Int = 0, icon: String = "", name: String = "") {
        if category != AccountCategoryEnum.UNDEFINED.rawValue {
            self.curNewAccountInfo.category = category
        }
        if type != 0 {
            self.curNewAccountInfo.type = type
        }
        if icon != "" {
            self.curNewAccountInfo.icon = icon
        }
        if name != "" {
            self.curNewAccountInfo.name = name
        }

//        print("当前想要添加新账户的信息 \(self.curNewAccountInfo)" )
    }
    
    func addNewAccount() {
        self.curNewAccountInfo.id = UUID()
        self.allAccountList.append(self.curNewAccountInfo)
        parseCategoryList()
        
        print("添加一个新账户 \(self.curNewAccountInfo)" )
        
        showAddCountSheet = false
    }
    
    func parseAssetsInfo(){
        // 临时测试数据
        self.assetsInfo = AssetsStruct(totalAmount: 29898.23, totalCreditAmount: 8989.34, netAssets: 22342.02, DebtAmount: 8000, loanAmount: 10000, isDebtLoanCounting: false)
    }
    
    // 解析账户列表
    func parseAccountList(){
        // 获取所有账户数据  创建测试数据
        for i in 1...1 {
            self.allAccountList.append(AccountDetailStruct(category: Int(arc4random()) % 4 + 1, type: Int(arc4random()) % 4 + 1, icon: "bank", name: "账户\(i)", desc: "描述", balance: Double(arc4random() % 20000) + 1,  deadLineDate: 28))
        }
                
        // 将所有账户列表分类成按类型分类的数据
        parseCategoryList()
    }
    
    func parseCategoryList(){
        self.list = []
        
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
    

    // 解析本地json文件
    func parseLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "accountsCategory", withExtension: "json")
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([AccountJsonModel].self, from: jsonData)
            self.accountStaticList = modules
//            print("parse local data \(self.accountStaticList)")
        }
        catch {
            print("Couldn't parse local data")
        }
        
        let bankUrl = Bundle.main.url(forResource: "bank", withExtension: "json")
        do {
            let jsonData = try Data(contentsOf: bankUrl!)
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode(BankListJsonModel.self, from: jsonData)
            self.bankStaticList = modules
//            print("parse local data \(self.bankStaticList)")
        }
        catch {
            print("Couldn't parse local data")
        }
    }
    
}
