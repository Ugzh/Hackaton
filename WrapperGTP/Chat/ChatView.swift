//
//  ChatView.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI

struct ChatView: View {
    @State var userMessage = ""
    @State private var textHeight: CGFloat = 40
    @Binding var showMenu: Bool
    @StateObject private var vm = ChatViewModel()
    private let maxLines = 3
    
    //var listConversation: [GetConversationsDto]?
//    init(){
//        if let listConversation = listConversation {
//            vm.
//        }
//    }
    var body: some View {
        VStack{
            HStack{
                Button{
                    print(showMenu)
                    showMenu.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .tint(.black)
                        .frame(width: 20, height: 20)
                        .padding()
                }
                Spacer()
            }
            Spacer()
            VStack(alignment: .leading ,spacing: 10) {
                ScrollView{
                    ForEach(vm.listOfMessage) {chatMessage in
                        MessageItemView(chatMessage: chatMessage)
                    }
                }
                
                HStack{
                    TextEditor(text: $userMessage)
                    .frame(height: min(textHeight, CGFloat(maxLines) * 24))
                    .background(Color.gray.opacity(0.2))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                    )
                    .onChange(of: userMessage) {                    updateTextHeight()
                    }
                        
                    Button("envoyer"){
                        vm.fetchAPI(prompt: userMessage)
                        userMessage = ""
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func updateTextHeight() {
            let textSize = userMessage.boundingRect(
                with: CGSize(width: UIScreen.main.bounds.width - 40, height: .infinity),
                options: .usesLineFragmentOrigin,
                attributes: [.font: UIFont.systemFont(ofSize: 17)],
                context: nil
            )
            textHeight = max(40, textSize.height + 20)
        }
}

#Preview {
    @Previewable @State var showMenu: Bool = false
    @StateObject var vm = ChatViewModel()
    ChatView(showMenu: $showMenu)
}
