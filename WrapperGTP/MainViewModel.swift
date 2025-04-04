//
//  MainViewModel.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI
import Alamofire


final class MainViewModel: ObservableObject{
    @Published private(set) var listOfConversations : [GetConversationsDto] = []
    
    init(){
        fetchAllConversationsByUser()
    }
    
    func fetchAllConversationsByUser(){
        let endpoint = "https://hackathon2025bully.thierryleung.fr/api/conversations"
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3NDM3NTUzOTAsImV4cCI6MTc0Mzc1ODk5MCwicm9sZXMiOlsiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiZW1haWwzQGVtYWlsLmNvbSJ9.GmLzCypyxuLq7i0EJ1AkYVEdZc4Szgzyxjz5UVr9-8g4lUAFtMo-BTkDXDZWzQAeqxV0gCWD8LdhEPjA3XwFmf2j0_cSMlmWElFm-zxV3wnBSVo7mAKz3CqZ-qlXS6LybmAhJRnajoTSc-FOLSRD5PWgc_xZbRcAwCI3R8F2_hjmD8PggSNgXIrlHV3RfwhdoJr9oxK0GKkcx8KQ5sVhDINGZz62qSIoPbWcArvq4WVhY2x9xLSusNk-8IM3c_ZDFm5tLsVh_hQ13VxZE4kLyzmege33b3stqRTGk4SeGs3XA1cyMf4xnE-CnP_pp5kXPhrh7GghOCT_oeCGn2phjA" 
//        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3NDM3NTU0NDAsImV4cCI6MTc0Mzc1OTA0MCwicm9sZXMiOlsiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiZW1haWxAZW1haWwuY29tIn0.E4aitAV-TjRwA9PTaXgsX_YuGeBK8yUr68JJcu2J7Ai66nHI-him4jMkPWQc0EvapjcMiH75e6egWTJem4bNB3z6Ef7P22UpRvtRSktmdRBafdsssbA_gn4C8JJ96n9iaANMzb01Ndlpd6170sAsDUfLf2aCOMMjG9Jn2Smz-aGaicrya_cd_fDUfH9B9ADpHva5pWm_vOlrytQPsLAuGZyaEd2TaNb9cRz9fRY1mAjyXllNSYOmkVj1oYI0TFFLLYNaxXVSrKipq6ucPT0GzgArjsKV3UJvwJnFX_XVSOA39xI7w4Q3cfu_OoVp3MnPOpeHTM7eN4BpIEP4tSbPEw"
//        
        AF.request(endpoint, method: .get, headers: ["Authorization":"Bearer \(token)"])
            .validate()
                .responseDecodable(of: [GetConversationsDto].self) { response in
                    switch response.result {
                    case .success(let conversations):
                        self.listOfConversations = conversations
                        self.listOfConversations.forEach{ title in
                            print(title.title)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    
}
