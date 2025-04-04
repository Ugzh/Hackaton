//
//  SideMenuView.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    @ObservedObject var vm: MainViewModel
    var body: some View {
        HStack {
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
//                    ForEach(SideMenuOption.allCases, id: \.self){ row in
//                        RowView(isSelected: selectedSideMenuTab == row.rawValue, title: row.title) {
//                            selectedSideMenuTab = row.rawValue
//                            presentSideMenu.toggle()
//                        }
//                    }
                    ForEach(vm.listOfConversations.indices, id: \.self){ index in
                        RowView(isSelected: selectedSideMenuTab == index,title: vm.listOfConversations[index].title){
                            selectedSideMenuTab = index
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            Spacer()
        }
        .background(.clear)
//        ZStack{
//            if isShowing {
//                Rectangle()
//                    .opacity(0.3)
//                    .ignoresSafeArea()
//                    .onTapGesture{
//                        isShowing.toggle()
//                    }
//                
//                HStack{
//                    VStack(alignment: .leading, spacing: 32){
//                        ForEach(SideMenuOption.allCases, id: \.self){ row in
//                            SideMenuRowView(historicConversation: HistoricConversation(title: "ugo"))
//                        }
//                        
//                        Spacer()
//                    }
//                    .padding(.top, 80)
//                    .padding().frame(width: 270, alignment: .leading)
//                    .background(.white)
//                    Spacer()
//                }
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//        .ignoresSafeArea()
//        .animation(.easeInOut, value: isShowing)
    
    }
    func RowView(isSelected: Bool, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .blue : .white)
                        .frame(width: 5)
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .blue.opacity(0.3) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

#Preview {
    @Previewable @State var selectedSideMenuTab: Int = 1
    @Previewable @State var presentSideMenu: Bool = false
    SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu, vm: MainViewModel())
}
