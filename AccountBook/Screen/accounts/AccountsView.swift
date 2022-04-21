//
//  AccountsView.swift 资产页
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/18.
//

import SwiftUI

// 顶部header bar
struct HeaderBarView: View{
    var body: some View {
        HStack{
            Image("menu").padding(.leading, 20)
            Spacer()
            Text("资产管理")
                .font(.system(size: 20))
                .fontWeight(.bold)
            Spacer()
            Image("addRect").padding(.trailing, 20)
        }
    }
}

let structSpace: CGFloat = 165

func showAssetsText(_ amount: Double, showAseets: Bool) -> String {
    return showAseets ? moneyFormat(amount) : "*****"
}

// 总资产块
struct AssetsView: View{
    @EnvironmentObject var accountData: AccountViewModel
    @State private var showAseets: Bool = true
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Text("净资产")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor.hex(textGray)))
                        .padding(.leading, 50)
                    Image(showAseets ? "eyeClose" : "eyeOpen")
                        .onTapGesture {
                            showAseets.toggle()
                            self.accountData.showAssetsNumber.toggle()
                            showAseets = self.accountData.showAssetsNumber
                        }
                        .padding(.leading, 20)
                }
                
                Text(showAssetsText(self.accountData.assetsInfo.netAssets, showAseets: showAseets))
                    .font(.system(size: 22))
                    .fontWeight(.bold)
            }
            .padding(10)
            
            HStack{
                VStack{
                    Text("总资产")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor.hex(textGray)))
                        .padding(.top, 10)
                    Text(showAssetsText(self.accountData.assetsInfo.totalAmount, showAseets: self.accountData.showAssetsNumber))
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .frame(width: structSpace)
                }
                
                Spacer()
                
                VStack{
                    Text("总负债")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor.hex(textGray)))
                        .padding(.top, 10)
                    Text(showAssetsText(self.accountData.assetsInfo.totalCreditAmount, showAseets: self.accountData.showAssetsNumber))
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .frame(width: structSpace)

                }
            }
            .frame(width: 350)
        }
        .padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(5)
        .frame(width: 350, alignment: Alignment.center)
    }
}

// 借入 借出模块
struct DebtView: View {
    @EnvironmentObject var accountData: AccountViewModel
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Text("总借入")
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor.hex(textGray)))
                    .frame(width: structSpace)
                    .padding(.top, 10)
                Text(showAssetsText(self.accountData.assetsInfo.DebtAmount, showAseets: self.accountData.showAssetsNumber))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(width: structSpace)
                    .padding(.bottom, 10)
            }
            .background(Color.white)
            .cornerRadius(5)
            
            Spacer()
            
            VStack{
                Text("总借出")
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor.hex(textGray)))
                    .padding(.top, 10)
                
                Text(showAssetsText(self.accountData.assetsInfo.loanAmount, showAseets: self.accountData.showAssetsNumber))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(width: structSpace)
                    .padding(.bottom, 10)
            }
            .background(Color.white)
            .cornerRadius(5)
            
            Spacer()
        }
        .padding(.bottom, 10)
        
    }
}

// 账户大类型列表模块
struct AccountTypeListView: View {
    @Binding private var accountCateInfo: AccountCategoryListStruct
    @State private var opened:Bool = false
    
    init(info: Binding<AccountCategoryListStruct>){
        self._accountCateInfo = info
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("\(AccountCategoryDisplayName(cate: AccountCategoryEnum(rawValue: self.accountCateInfo.category) ??  AccountCategoryEnum.FUND))")
                    .bold()
                    .font(.system(size: 18))
                    .padding(.leading, 10)
                
                Spacer()
                
                Text("\(moneyFormat(accountCateInfo.totalAmount))")
                    .bold()
                    .font(.system(size: 18))
                
                Image(self.opened ? "arrowD" : "arrowR")
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: -1, trailing: 0))
            .onTapGesture {
                self.opened.toggle()
            }
            
            ForEach(accountCateInfo.list) { item in
                Divider()
                
                if item.category == AccountCategoryEnum.CREDIT.rawValue {
                    HStack {
                        Image("bank")
                        VStack {
                            HStack {
                                Text(item.customTittle)
                                Spacer()
                                Text("\(moneyFormat(item.balance))")
                            }
                            ProgressView(value: 0.45)
                            HStack {
                                Text("\(3)天后还款")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(UIColor.lightGray))
                                
                                Spacer()
                                
                                Text("可用\(moneyFormat(item.totalLimit ?? 0 - item.balance))")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(UIColor.lightGray))

                            }
                        }
                    }
                    .frame(width: 330)
                } else {
                    HStack {
                        Image("bank")
                        Text(item.customTittle)
                        Spacer()
                        Text("\(moneyFormat(item.balance))")
                    }
                    .frame(width: 330)
                    .padding([.top, .bottom], 8)
                }
                
            }
        }
        .padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(5)
        .frame(width: 350)
    }
}

// 账户列表
struct AccountListView: View{
    @EnvironmentObject var accountData: AccountViewModel
    
    var body: some View {
        ForEach(self.$accountData.list) { item in
            AccountTypeListView(info: item)
        }
    }
}


struct AccountsView: View {
    private var data = AccountViewModel()
    
    var body: some View {
        VStack{
            HeaderBarView()
            ScrollView{
                VStack{
                    AssetsView()
                    DebtView()
                    AccountListView()
                }
            }
            .padding([.top, .bottom], 10)
            .background(Color(UIColor.hex(bgColor)))
            .environmentObject(data)
        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
            .environmentObject(AccountViewModel())
    }
}
