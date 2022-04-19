//
//  IndexView.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/17.
//

import SwiftUI


// 顶部header bar
struct HeaderNavBarView: View{
    var body: some View {
        HStack{
            Image("menu").padding(.leading, 20)
            Spacer()
            Image("chart").padding(.trailing, 20)
        }
    }

}

// 底部tab bar
struct BottomTabBarView: View{
    let tabBarBgColor = "#ffffff"
    let tabItemTextColor = "#666666"
    let tabItemTextChoosenColor = "#5EAAF8"

    struct tabBarStruct{
        var icon: String
        var tittle: String
    }
    let tabs = [tabBarStruct(icon: "home", tittle: "账单"),
                               tabBarStruct(icon: "add", tittle: "") ,
                               tabBarStruct(icon: "card", tittle: "资产")]
    // 默认选中第一个tab
    @State private var selection = 0
    
    init(){
        // 更改tabView 背景色
        UITabBar.appearance().backgroundColor = UIColor.colorWithHexString(tabBarBgColor)
        UITabBar.appearance().backgroundImage = UIImage()
        // 更改tabView 未选中颜色
        UITabBar.appearance().unselectedItemTintColor = UIColor.colorWithHexString(tabItemTextColor)

    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $selection){
                BillsView()
                        .tabItem {
                            Image(self.tabs[0].icon)
                            Text(self.tabs[0].tittle).font(.system(size: 30))
                        }
                        .navigationBarHidden(true)
//                        .navigationBarTitle("")
                        .tag(0)
                
                BookingView()
                        .tabItem {
                            Image(self.tabs[1].icon)
                            Text(self.tabs[1].tittle)
                        }
                        .navigationBarHidden(true)
//                        .navigationBarTitle("")
                        .tag(1)
                        
                
                AccountsView()
                        .tabItem {
                            Image(self.tabs[2].icon)
                            Text(self.tabs[2].tittle)
                        }
                        .navigationBarHidden(true)
//                        .navigationBarTitle("")
                        .tag(2)
            }
        }
        // Use .accentColor modifier for changing color of selected tabItem
        .accentColor(Color( UIColor.colorWithHexString(tabItemTextChoosenColor)))
    }
}

struct IndexView: View {
    
    var body: some View {
        VStack{
            HeaderNavBarView()
            BottomTabBarView()
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
