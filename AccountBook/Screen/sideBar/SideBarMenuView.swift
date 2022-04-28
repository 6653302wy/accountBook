//
//  SideBarMenuView.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/28.
//

import SwiftUI

struct SideBarMenuView: View {
    @State var showSidebar: Bool = false

    var body: some View {
        VStack.init(alignment: .leading) {
            
            VStack.init(alignment: .center) {
                Image("default-head")
                    .resizable()
                    .frame(width: 56, height: 56)
                Text("用户昵称")
                    .bold()
                    .font(.system(size: tittleTextSize))
                    .foregroundColor(Color(UIColor.hex(textTitle)))
            }
            .padding(.bottom, 30)
            
            
            Group {
                HStack {
                    Image("budget")
                        .resizable()
                        .frame(width: 26, height: 26)
                    Text("预算")
                        .bold()
                        .font(.system(size: defaultTextSize))
                        .foregroundColor(Color(UIColor.hex(textGray)))
                }
                .padding(.bottom, 10)
                
                HStack {
                    Image("fenlei")
                        .resizable()
                        .frame(width: 26, height: 26)
                    Text("分类管理")
                        .bold()
                        .font(.system(size: defaultTextSize))
                        .foregroundColor(Color(UIColor.hex(textGray)))
                }
                .padding(.bottom, 10)
                
                HStack {
                    Image("setting")
                        .resizable()
                        .frame(width: 26, height: 26)
                    Text("设置")
                        .bold()
                        .font(.system(size: defaultTextSize))
                        .foregroundColor(Color(UIColor.hex(textGray)))
                }
                .padding(.bottom, 10)
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 80)
        
    }
}

struct SideBarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarMenuView()
    }
}
