//
//  SideMenuRowView.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI

struct SideMenuRowView: View {
    var historicConversation: HistoricConversation
    
    var body: some View {
        HStack{
            Text(historicConversation.title)
            Spacer()
            Image(systemName: "arrow.right")
        }
        .padding()
        .background(.gray.opacity(0.1))
        .cornerRadius(10)

        .frame(height: 44)
    }
}

struct HistoricConversation{
    let title: String
}

#Preview {
    SideMenuRowView(historicConversation: HistoricConversation(title: "Je suis harcelé"))
}
