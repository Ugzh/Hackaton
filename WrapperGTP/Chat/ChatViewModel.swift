//
//  ChatViewModel.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI
import Alamofire

final class ChatViewModel: ObservableObject {
    @Published private(set) var listOfMessage : [ChatMessage] = []
    private let env = ProcessInfo.processInfo.environment
    
    func fetchAPI(prompt: String) {
        //self.listOfMessage.append(ChatMessage(prompt: prompt, response: nil))
        
        let apiKey = env["API_KEY"] ?? ""
        let endpoint = env["ENDPOINT"] ?? ""
        
        let requestBody = RequestBody(
            messages: [["role": "user", "content": "\(prompt) en me faisant une réponse courte"]]
        )
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONEncoder().encode(requestBody)
        
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let data = data {
                let responseString = self.extractContent(from: data)
                self.listOfMessage.append(ChatMessage(prompt:nil, response: responseString))
//                print("Réponse JSON : \(responseString ?? "Erreur")")
            }
        }
        task.resume()
    }
    
    func sendPromptToOurAPI(sendMessageDto : SendMessageDto){
        let endpoint = ""
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3NDM3MTU3MjYsImV4cCI6MTc0MzcxOTMyNiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiZW1haWwzQGVtYWlsLmNvbSJ9.TAVqnmZyvEAqlACkaBk557Xf0XLyMoBQlver5iwSpkkHM53tv2RpBrimte7GefNNYm-kLsvL496xHpuTLavosSI0BLxL9IG322nsAwrji3UBWh-t8aAnhwHAWM1sjSk89EvUs-rMyr_3VSIu199q1ma7VycqWGZF9Ik6uNiGJBDPt28bhxZOlC88VdIvOm_6M5JeV_exnZBKpM87kuR_0apnL_M4XAxwuSCvyfONY20p3OQlJipoms-gNFuRaG1Ba-YDQv7-Y_QHqkR3DBOGCpLM1FV4SZrAXQfPFGiE80n5QwqsAssDhSB231ZdvI8sFHnAAZ1pTZtSvWEbrdELcQ"
        
//        AF.request(endpoint, method: .get, headers: ["Authorization":"Bearer \(token)"])
//            .validate()
//                .responseDecodable(of: [Send].self) { response in
//                    switch response.result {
//                    case .success(let conversations):
//                        //self.listOfConversations = conversations
//                        //print(self.listOfConversations.first?.title.description ?? "rien" )
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
    }

    func extractContent(from jsonData: Data) -> String? {
        do {
            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: jsonData)
            return decodedResponse.choices.first?.message.content
        } catch {
            print("Erreur lors du décodage JSON : \(error)")
            return nil
        }
    }
    
    
    func setUserHistoric(listConversations: [GetConversationsDto]){
        listConversations.forEach{ conv in
            conv.messages.forEach{ message in
                listOfMessage.append(ChatMessage(prompt: message.promptUser.content, response: message.promptUser.response.content))
            }
        }
    }
}

struct RequestBody: Codable {
    let messages: [[String: String]]
}


struct APIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content: String
}

struct ChatMessage: Hashable, Identifiable{
    let id = UUID()
    //let id: Int64
    //let idConversation: Int64
    let prompt: String?
    let response: String?
    var isUserMessage: Bool {
        (response != nil) ? false : true
    }
}



