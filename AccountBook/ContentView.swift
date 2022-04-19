//
//  ContentView.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/14.
//

import SwiftUI

struct TittleView :View{
    @Binding var lableStr:String
    
    init(lable: Binding<String>){
        self._lableStr = lable
    }
    
    var body: some View{
        let extractedExpr = Text("这是一个组件：" + self.lableStr)
        extractedExpr
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var schemeMode
    @State private var titleStr = "这里显示最终内容"
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            TittleView(lable: self.$titleStr)
            TextField("输入备注。。。", text: self.$inputText)
                .frame(width: 200, height: 50, alignment: .center)
            Button (action: {
                self.titleStr = self.inputText
            }) {
                Text("确定")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
