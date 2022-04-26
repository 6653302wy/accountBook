//
//  AddNewAccountView.swift 填写新资产信息弹窗
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/22.
//

import SwiftUI

struct AddNewAccountView: View {
    @EnvironmentObject var accountData: AccountViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @State private var descStr = ""
    @State private var limitStr = ""
    @State private var balanceStr = ""
    @State private var deadTimeStr = ""
    
    let textWidth: CGFloat = 120
        
    var body: some View {
        VStack {
            HStack {
                Text("添加资产")
                    .font(.system(size: pageTitleTextSize))
                    .bold()
                    .padding([.top, .leading], 20)
                
                Spacer()
            }
            
            Divider()
            
            VStack {
                HStack.init(alignment:.center) {
                    Text("账户类型")
                        .font(.system(size: nameTextSize))
                        .foregroundColor(Color(UIColor.hex(textTitle)))
                    
                    Spacer()
                    
                    HStack {
                        Image("\(accountData.curNewAccountInfo.icon)")
                            .resizable()
                            .frame(width: 26, height: 26)
                        Text("\(accountData.curNewAccountInfo.name)")
                            .foregroundColor(Color(UIColor.hex(textBlue)))
                            .font(.system(size: nameTextSize))
                    }
                }
                .frame(width: 330)
                .padding(.top, 5)
                
                Divider()
                
                HStack {
                    Text("账户备注")
                        .font(.system(size: nameTextSize))
                        .foregroundColor(Color(UIColor.hex(textTitle)))
                    
                    Spacer()
                    
                    TextField("例：卡号后四位", text: $descStr)
                        .font(.system(size: nameTextSize))
                        .foregroundColor(Color(UIColor.hex(textTitle)))
                        .frame(width: textWidth)
                        .padding(.trailing, -8)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 330)
                .padding(.top, 5)
                
                Divider()
                
                if accountData.curNewAccountInfo.category == AccountCategoryEnum.CREDIT.rawValue {
                    HStack {
                        Text("总额度")
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                        
                        Spacer()
                        
                        TextField("信用卡总额度", text: $limitStr)
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                            .keyboardType(.numberPad)
                            .frame(width: textWidth)
                            .padding(.trailing, -8)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(width: 330)
                    .padding(.top, 5)
                    
                    Divider()
                    
                    HStack {
                        Text("当前欠款")
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                        
                        Spacer()
                        
                        TextField("0.0", text: $balanceStr)
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                            .keyboardType(.numberPad)
                            .frame(width: textWidth)
                            .padding(.trailing, -8)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(width: 330)
                    .padding(.top, 5)
                    
                    Divider()
                    
                    HStack {
                        Text("还款日期")
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                        
                        Spacer()
                        
                        TextField("01", text: $deadTimeStr)
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                            .keyboardType(.numberPad)
                            .frame(width: textWidth)
                            .padding(.trailing, -8)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(width: 330)
                    .padding(.top, 5)
                }
                else {
                    HStack {
                        Text("账户余额")
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                        
                        Spacer()
                        
                        TextField("0.0", text: $balanceStr)
                            .font(.system(size: nameTextSize))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                            .keyboardType(.numberPad)
                            .frame(width: textWidth)
                            .padding(.trailing, -8)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(width: 330)
                    .padding(.top, 5)
                }
                
                Divider()
                
                Button(action: {
                    // 信用卡的余额为负数
                    let balance = accountData.curNewAccountInfo.category == AccountCategoryEnum.CREDIT.rawValue ? -(Double(balanceStr) ?? 0) : Double(balanceStr)
                    
                    accountData.curNewAccountInfo.balance = balance ?? 0
                    accountData.curNewAccountInfo.desc = descStr
                    accountData.curNewAccountInfo.totalLimit = Double(limitStr) ?? 0
                    accountData.curNewAccountInfo.deadLineDate = Int(deadTimeStr) ?? 0
                    
                    accountData.addNewAccount()
                    
                    presentation.wrappedValue.dismiss()
                    
                }, label: {
                    Text("保存")
                        .font(.system(size: 15))
                        .frame(width: 320, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color(UIColor.hex(textBlue)))
                        .cornerRadius(3)
                })
                .padding([.top, .bottom], 120)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.bottom, .infinity)
    }
}

struct AddNewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccountView()
    }
}
