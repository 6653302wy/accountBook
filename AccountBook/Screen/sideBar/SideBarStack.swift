//
//  SideBarView.swift
//  AccountBook
//
//  Created by 万萍萍 on 2022/4/28.
//

import SwiftUI

struct SideBarStack<SidebarContent: View, Content: View>: View {
    
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(sidebarWidth: CGFloat, showSidebar: Binding<Bool>, @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .frame(width: sidebarWidth, alignment: .center)
                .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
                .animation(Animation.easeInOut.speed(2),value: showSidebar)
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.black
                                .opacity(showSidebar ? 0.1 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }
                        } else {
                            Color.clear
                            .opacity(showSidebar ? 0 : 0)
                            .onTapGesture {
                                self.showSidebar = false
                            }
                        }
                    }
                )
                .offset(x: showSidebar ? sidebarWidth : 0, y: 0)
                .animation(Animation.easeInOut.speed(2), value: showSidebar)
                
        }
    }
}

//struct SideBarStack_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBarStack()
//    }
//}
