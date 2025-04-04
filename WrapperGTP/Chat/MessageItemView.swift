//
//  MessageItemView.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI
import MarkdownUI

struct MessageItemView: View {
    let chatMessage: ChatMessage
    private var message = ""
    private var bgColor: Color {
        switch chatMessage.isUserMessage{
            case true:
                Color.red
            case false:
                Color.blue
            }
    }
    init(chatMessage: ChatMessage){
        self.chatMessage = chatMessage
        if let prompt = self.chatMessage.prompt {
            message = prompt
            
        } else {
            message = self.chatMessage.response!
        }
    }
    
    var body: some View {
        HStack{
            if chatMessage.isUserMessage {
                Spacer()
            }
                Markdown(message)
                    .padding(15)
                    .background(bgColor.opacity(0.8))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16)).frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.8, alignment: chatMessage.isUserMessage ? .trailing : .leading)
                    .padding(chatMessage.isUserMessage ? .leading : .trailing, 40)
                    .markdownTextStyle(\.text) {
                            ForegroundColor(.white)
                        }
            if !chatMessage.isUserMessage {
                Spacer()
            }
        }.padding(.horizontal)
    }
}

#Preview {
    //MessageItemView(chatMessage: ChatMessage(message: "Qui est le plus beau", isUserMessage: true))
}
