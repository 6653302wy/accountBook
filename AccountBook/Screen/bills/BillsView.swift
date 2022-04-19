//
//  BillsView.swift 首页账单页
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/18.
//

import SwiftUI

// 月结余模块（点击进入图表页）
struct MonthOverView :View{
    var body: some View {
        VStack{
            HStack{
                VStack.init(alignment: .leading){
                    Text("月结余")
                        .foregroundColor(Color.white)
                    
                    Text("19893.09")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .padding(20)
                
                Spacer()
                
                Button(action: {
                    // 点击进入选择账本页
                }) {
                    Text("账本1")
                        .foregroundColor(Color.white)
                        .background(Color.gray)
                        .frame(width: 82, height: 30, alignment: Alignment.center)
                        .cornerRadius(50)
                }
            }
            
            
            HStack{
                Text("月收入：\("22398.21")").foregroundColor(Color.white)
                Spacer()
                Text("月支出：\("1398.21")").foregroundColor(Color.white)
            }
            .padding([.leading, .trailing, .bottom], 20)
        }
        .background(Image("billoverviewbg").resizable())
        .cornerRadius(5)
        .frame(width: 350, height: 113, alignment: Alignment.center)
    }
}

// 预算模块(点击进入预算页)
struct BudgetView: View{
    @State private var pro = 0.3
    
    
    var body: some View{
        VStack.init(alignment: .leading){
            Text("总预算：\("23412")")
                .font(.system(size: 19))
                .padding(.bottom, -5)
            
            ProgressView(value: self.pro)
            
            Text("剩余：\("234.23") | 剩余日均：\("202.88")")
                .foregroundColor(Color(UIColor.colorWithHexString("#666")))
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)
        .frame(width: 350, alignment: Alignment.center)
    }
}

struct BillsView: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                MonthOverView()
                Spacer()
                BudgetView()
            }
        }
        .background(Color(UIColor.colorWithHexString("#f6f6f6")))
//        .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
    }
}
