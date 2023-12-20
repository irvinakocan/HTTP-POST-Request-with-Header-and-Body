//
//  ViewController.swift
//  HTTP POST Request with Header and Parameters
//
//  Created by Macbook Air 2017 on 20. 12. 2023..
//

import UIKit

let POST_ENDPOINT = "https://jsonplaceholder.typicode.com/posts"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        postRequest()
    }
    
    func postRequest() {
        
        // Create URL
        guard let url = URL(string: POST_ENDPOINT) else {
            return
        }
        
        // Create URL Request
        var urlRequest = URLRequest(url: url)
        
        // Specify HTTP Method
        urlRequest.httpMethod = "POST"
        
        // Set HTTP Request Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Specify parameters
        let parameters = [
            "username": "@kilo_loco",
            "tweet": "HelloWorld"
        ]
        
        // Turning parameters into JSON
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        
        // Setting HTTP Request httpBody (request message)
        urlRequest.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("Error took place.")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status code: \(response.statusCode)\n")
            }
            
            if let data = data {
                
                // Turning JSON into eye-readable information
                guard let json = try? JSONSerialization.jsonObject(with: data) else {
                    return
                }
                print(json)
            }
        })
        task.resume()
    }
}
