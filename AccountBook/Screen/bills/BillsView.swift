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
                        .padding([.leading,.trailing], 10)
                        .foregroundColor(Color.white)
                        .background(Color.gray)
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
                .font(.system(size: 19))
                .padding(.bottom, -5)
            
            ProgressView(value: self.pro)
            
            Text("剩余：\("234.23") | 剩余日均：\("202.88")")
                .foregroundColor(Color(UIColor.colorWithHexString(textGray)))
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
                    .foregroundColor(Color(UIColor.colorWithHexString(textTitle)))
                
                Spacer()
                
                Text("支：\(Int(self.detail.expend))")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.colorWithHexString(textTitle)))
            }
            
            Divider()
            
            ForEach(self.detail.bills){ bill in
                HStack{
                   Image("circleGreen")
                    VStack(alignment: .leading){
                        Text(bill.category.name)
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.colorWithHexString(textTitle)))
                        Text(bill.desc)
                            .font(.system(size: 16))
                            .foregroundColor(Color(UIColor.colorWithHexString(textGray)))
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Text("-23.56")
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.colorWithHexString(redColor)))
                        Text("微信")
                            .font(.system(size: 16))
                            .foregroundColor(Color(UIColor.colorWithHexString(textGray)))
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


// 账单列表数据类
class BillList {
    var list: [DailyBillStruct] = []
    init() {
        // 临时测试数据
        for _ in 1...12 {
            self.list.append(DailyBillStruct(date: Date(), dateDes: "今天", expend: 299, income: 0, bills: self.createTempBillDetailInfos()))
        }
    }
    
    // 临时测试数据
    func createTempBillDetailInfos() -> [BillStruct] {
        let rcounts = arc4random() % 5 + 1;
        var list:[BillStruct] = []
        for _ in 1...rcounts {
            list.append(BillStruct(type: BillTypeEnum.EXPEND, category: BillCategory(type: BillTypeEnum.EXPEND, name: "三餐", icon: "meal", subs: [], sort: 1), desc: "吃饭花的钱啊", amount: Int(34.99)))
        }
        return list
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
        ScrollView{
            LazyVStack{
                MonthOverView()
                BudgetView()
                BillListView()
            }
        }
        .padding(.top, 10)
        .background(Color(UIColor.colorWithHexString(bgColor)))
//        .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
    }
}
