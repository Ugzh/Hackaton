//
//  TestWrapper.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI
final class ContentViewModel: ObservableObject{
    @Published private(set) var messageFetched = ""
    
    func fetchFromAzure(prompt: String = "Que faire contre le harcelmeent.") {
        
        let apiKey = ""
        let endpoint = ""
        
        let requestBody = RequestBody(
            messages: [["role": "user", "content": prompt]]
        )
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONEncoder().encode(requestBody)
        
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if let data = data {
                let responseString = self.extractContent(from: data)
                self.messageFetched = responseString ?? ""
//                print("Réponse JSON : \(responseString ?? "Erreur")")
            }
        }
        task.resume()
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



