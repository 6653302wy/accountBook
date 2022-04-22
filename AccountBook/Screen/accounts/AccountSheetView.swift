//
//  AccountSheetView.swift 添加资产账户弹窗
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/21.
//

import SwiftUI


struct AccountSheetView: View {
    @Binding var accountCategoryList: [AccountJsonModel]
    
    @State private var activeLink: Bool = false
    @State private var clickedCate: Int = 1
    
    init(data: Binding<[AccountJsonModel]>) {
        self._accountCategoryList = data
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack.init(alignment: .leading) {
                    Text("选择资产类型")
                        .font(.system(size: 18))
                        .bold()
                        .padding([.top, .leading], 20)
                    
                    Divider()
                    
                    ForEach(self.accountCategoryList) { item in
                        Text(item.tittle)
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(Color(UIColor.hex(textGray)))
                            .padding(.top, 5)
                        
                            ForEach(item.list) { cate in
                                NavigationLink(destination: AddNewAccountView(isActive: self.$activeLink, category: self.$clickedCate),
                                               isActive: self.$activeLink,
                                               label: {
                                    HStack {
                                        Image(cate.icon)
                                        Text(cate.name)
                                            .font(.system(size: 15))
                                            .foregroundColor(Color(UIColor.hex(textTitle)))
                                    }
                            })
                        }
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                }
                
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
}

//struct AccountSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSheetView(data: .constant(AccountJsonModel(from: Decoder)))
//    }
//}
