//
//  AddNewAccountView.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/22.
//

import SwiftUI

let normalAccountInfo = ["账户余额"]
let creditAccountInfo = ["总额度", "当前欠款"]


struct AddNewAccountView: View {
    @Binding var isActive: Bool
    @Binding var category: Int
    
    var body: some View {
        VStack {
            HStack.init(alignment: .center, spacing: 0) {
                Image("arrowL")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .onTapGesture {
                        self.isActive = false
                    }

                Text("添加资产")
                    .font(.system(size: 20))
                
            }
            
            VStack {
                Text("输入账户信息")
                    .font(.system(size: 15))
                    .bold()
                
                HStack {
                    Text("账户类型")
                        .font(.system(size: 14))
                        .foregroundColor(Color(UIColor.hex(textTitle)))
                    
                    Spacer()
                    
                    HStack {
                        Image("")
                    }
                }
                
            }
            .padding(.bottom, 10)
            .background(Color.white)
            .cornerRadius(5)
            .frame(width: 350, alignment: Alignment.center)
        }
        
        
    }
}

struct AddNewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccountView(isActive: .constant(true), category: .constant(1))
    }
}
