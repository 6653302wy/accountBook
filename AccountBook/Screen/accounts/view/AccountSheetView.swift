//
//  AccountSheetView.swift 添加资产账户弹窗
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/21.
//

import SwiftUI

struct AccountSheetView: View {
    @EnvironmentObject var accountData: AccountViewModel
    @State private var clickedCate: Bool = false
    @State private var isChooseBankType = false
    
    var body: some View {
            ScrollView {
                VStack.init(alignment: .leading) {
                    Text("选择资产类型")
                        .font(.system(size: 18))
                        .bold()
                        .padding([.top, .leading], 20)
                    
                    Divider()
                    
                    ForEach(self.accountData.accountStaticList) { item in
                        Text(item.tittle)
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(Color(UIColor.hex(textGray)))
                            .padding(.top, 5)
                        
                            ForEach(item.list) { cate in
                                HStack {
                                    Image(cate.icon)
                                    Text(cate.name)
                                        .font(.system(size: 15))
                                        .foregroundColor(Color(UIColor.hex(textTitle)))
                                }
                                .onTapGesture {
                                    // 银行卡类型， 弹出选择银行弹出
                                    self.isChooseBankType = isBankType(category: cate.category, type: cate.type)
                                    self.accountData.setCurChoosenAccount(category: cate.category, type:cate.type, icon: isChooseBankType ? "" : cate.icon, name: isChooseBankType ? "" : cate.name)
                                    
                                    self.clickedCate.toggle()
                                }
                        }
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                }
                
            }
            .sheet(isPresented: $clickedCate, content: {
                if self.isChooseBankType {
                    ChooseBankSheetView()
                    // 撑满全屏
                    .frame(minWidth: 0, idealWidth:100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .background(Color.white)
                } else {
                    AddNewAccountView()
                    // 撑满全屏
                    .frame(minWidth: 0, idealWidth:100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .background(Color.white)
                }
            })
        }
}

//struct AccountSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSheetView(data: .constant(AccountJsonModel(from: Decoder)))
//    }
//}
