//
//  BillsView.swift 首页账单页
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/18.
//

import SwiftUI

// 顶部header bar
struct HeaderNavBarView: View{
    @EnvironmentObject var appData: AppData
    
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


// 月结余模块（点击进入图表页）
struct MonthOverView :View{
    var body: some View {
        VStack{
            HStack{
                VStack.init(alignment: .leading){
                    Text("月结余")
                        .font(.system(size: defaultTextSize))
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
                        .font(.system(size: 14))
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                        .foregroundColor(Color(UIColor.hex(textTitle)))
                        .background(Color.white)
                        .cornerRadius(50)
                }.padding(10)
            }
            
            
            HStack{
                Text("月收入：\("22398.21")")
                    .font(.system(size: defaultTextSize))
                    .foregroundColor(Color.white)
                Spacer()
                Text("月支出：\("1398.21")")
                    .font(.system(size: defaultTextSize))
                    .foregroundColor(Color.white)
            }
            .padding([.leading, .trailing], 20)
        }
        .padding(.bottom, 10)
        .background(Image("billoverviewbg").resizable())
        .cornerRadius(5)
        .frame(width: 350, alignment: Alignment.center)
    }
}

// 预算模块(点击进入预算页)
struct BudgetView: View{
    @State private var pro = 0.3
    
    var body: some View{
        VStack.init(alignment: .leading){
            Text("总预算：\("23412")")
                .font(.system(size: tittleTextSize))
                .padding(.bottom, -5)
            
            ProgressView(value: self.pro)
            
            Text("剩余：\("234.23")  |  剩余日均：\("202.88")")
                .font(.system(size: defaultTextSize))
                .foregroundColor(Color(UIColor.hex(textGray)))
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)
        .frame(width: 350, alignment: Alignment.center)
    }
}



// 账单详细信息
struct BillDetailStruct :View{
    @Binding private var detail:DailyBillStruct
    
    init(info: Binding<DailyBillStruct>){
        self._detail = info
    }
    
    var body: some View{
        VStack{
            HStack{
                Text("04.28 \(self.detail.dateDes)")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.hex(textTitle)))
                
                Spacer()
                
                Text("支：\(Int(self.detail.expend))")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.hex(textTitle)))
            }
            
            Divider()
            
            ForEach(self.detail.bills){ bill in
                HStack{
                   Image("circleGreen")
                    VStack(alignment: .leading){
                        Text(bill.category.name)
                            .font(.system(size: defaultTextSize))
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.hex(textTitle)))
                        Text(bill.desc)
                            .font(.system(size: smallTextSize))
                            .foregroundColor(Color(UIColor.hex(textGray)))
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Text("-23.56")
                            .font(.system(size: defaultTextSize))
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.hex(redColor)))
                        Text("微信")
                            .font(.system(size: smallTextSize))
                            .foregroundColor(Color(UIColor.hex(textGray)))
                    }
                }
            }
            
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)
        .frame(width: 350, alignment: Alignment.center)
    }
}

// 账单模块
struct BillListView: View{
    @State private var list: [DailyBillStruct] = BillList().list
    
    var body: some View{
        ForEach(self.$list){ detail in
            BillDetailStruct(info: detail)
        }
    }
}

struct BillsView: View {
    var body: some View {
        VStack{
            HeaderNavBarView()
            ScrollView{
                LazyVStack{
                    MonthOverView()
                    BudgetView()
                    BillListView()
                }
            }
            .padding([.top, .bottom], 10)
            .background(Color(UIColor.hex(bgColor)))
    //        .background(Color.gray.edgesIgnoringSafeArea(.all))
        }
        
    }
}

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
    }
}
