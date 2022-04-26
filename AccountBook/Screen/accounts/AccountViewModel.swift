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
        getAccountList()
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
        
//        print("添加一个新账户 \(self.curNewAccountInfo)" )
        
        showAddCountSheet.toggle()
    }
    
    func clearDatas() {
        assetsInfo.totalAmount = 0
        assetsInfo.totalCreditAmount = 0
        
        self.list = []
    }
    
    func parseAssetsInfo(){
        assetsInfo.netAssets = assetsInfo.totalAmount - assetsInfo.totalCreditAmount
    }
    
    // 解析账户列表
    func getAccountList(){
        // 获取所有账户数据
                
        // 将所有账户列表分类成按类型分类的数据
        parseCategoryList()
    }
    
    func parseCategoryList(){
        clearDatas()
        
        var categoryList: [Int] = []
        var cateListInfo: AccountCategoryListStruct? = nil
        for item in self.allAccountList {
            if categoryList.contains(item.category) {
                let index = getCategoryListStructIndex(cate: item.category)
                cateListInfo = self.list[index]
                cateListInfo?.totalAmount += item.balance
                cateListInfo?.list.append(item)
                cateListInfo?.isSplitList = curNewAccountInfo.category == item.category
                self.list[index] = cateListInfo ?? self.list[index]
            } else {
                categoryList.append(item.category)
                cateListInfo = AccountCategoryListStruct(category: item.category, totalAmount: item.balance, isSplitList: curNewAccountInfo.category == item.category,list: [item])
                self.list.append(cateListInfo!)
            }
            
            // 计算资产信息
            let amount = abs(cateListInfo?.totalAmount ?? 0)
            // 信用卡账户，计算欠债总额
            if cateListInfo?.category == AccountCategoryEnum.CREDIT.rawValue {
                assetsInfo.totalCreditAmount += amount
            } else {
                // 计算总资产信息
                assetsInfo.totalAmount += amount
            }
        }
        
        // 账户分类排序
        self.list = self.list.sorted{$0.category < $1.category}
        
//        // 计算总资产信息
//        // 净资产
//        // 总资产，总负债
        parseAssetsInfo()
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
