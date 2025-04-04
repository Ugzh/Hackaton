//
//  MainTabView.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var vm = MainViewModel()
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            Color.black
            TabView(selection: $selectedSideMenuTab) {
                ForEach(vm.listOfConversations.indices, id: \.self){ index in
                    ChatView(showMenu: $presentSideMenu).tag(index)
                }
            }
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu, vm: vm)))
        }
        
    }
}

#Preview {
    MainTabView()
}
