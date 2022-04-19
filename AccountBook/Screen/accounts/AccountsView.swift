//
//  AccountsView.swift 资产页
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/18.
//

import SwiftUI

struct AccountsView: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                Text("资产页")
                    .font(.title)
            }
        }
        .background(Color(UIColor.colorWithHexString(bgColor)))
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
    }
}
