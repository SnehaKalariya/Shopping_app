//
//  WebServiceHandler.swift
//  FlickerApp
//
//  Created by Greek1 on 1/27/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class WebServiceHandler {
    
    static func getApiCall_CodableRES(url:String,completion:@escaping (_ result : Data?)-> Void,failure:@escaping ((_ getError: Error) -> Void)) {
       
        guard let serviceUrl = URL(string: "https://stark-spire-93433.herokuapp.com/json") else { return }
        
        URLSession.shared.dataTask(with: serviceUrl) { (data, response, err) in
            
            guard let data = data else {
                return
            }
            
            let strResponse = String(data: data, encoding: .utf8)
            let jsonData: Data? = strResponse?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue ))
            
            completion(jsonData)
            
            }.resume()
    }
    
}

