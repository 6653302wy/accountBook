//
//  HeaderNaviBarView.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/28.
//

import SwiftUI

struct HeaderNaviBarView<Content: View>: View {
    @EnvironmentObject var appData: AppData
    
    let customerBar: Content
    
    init(router: AppRouter, @ViewBuilder content: ()->Content) {
        customerBar = content()
    }
    
    var body: some View {
        HStack{
            Image("menu").padding(.leading, 20)
                .onTapGesture {
                    appData.showSidebarMenu.toggle()
                }
            Spacer()
            Image("chart").padding(.trailing, 20)
        }
    }
}

//struct HeaderNaviBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderNaviBarView()
//    }
//}
