//
//  ChooseBankSheetView.swift 选择银行弹窗
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/23.
//

import SwiftUI


struct ChooseBankSheetView: View {
    @EnvironmentObject var accountData: AccountViewModel
    @State private var showAddAccountSheet: Bool = false
    @State private var curCategory: Int = AccountCategoryEnum.FUND.rawValue
    
    
    var body: some View {
        ScrollView {
            VStack.init(alignment: .leading) {
                Text("选择银行")
                    .font(.system(size: 18))
                    .bold()
                    .padding([.top, .leading], 20)
                
                Divider()
                
                ForEach(self.accountData.bankStaticList.list) { item in
                    HStack {
                        Image(item.icon)
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text(item.name)
                            .font(.system(size: 15))
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                    }
                    .onTapGesture {
                        self.accountData.setCurChoosenAccount(icon: item.icon, name: item.name)
                        self.showAddAccountSheet.toggle()
                    }
                    
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
            }
            
        }
        .sheet(isPresented: $showAddAccountSheet, content: {
            AddNewAccountView()
            // 撑满全屏
            .frame(minWidth: 0, idealWidth:100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        })
    }
}


//struct ChooseBankSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseBankSheetView()
//    }
//}
