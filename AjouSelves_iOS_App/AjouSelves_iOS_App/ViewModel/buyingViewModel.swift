//
//  buyingViewModel.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/13.
//

import Foundation
import Combine
import Alamofire

class buyingViewModel: ObservableObject {
    
    var projAddUrl = "http://44.202.49.100:3000/proj/add"
    
    @Published var title: String = ""
    @Published var explained: String = ""
    @Published var min_num: Int = 0
    @Published var category: String = ""
    @Published var required: [String] = [""]
    
    func send() {
        let param: Parameters = ["userid": 3, "title" : title, "explained" : explained, "min_num" : min_num, "category" : category, "required" : ["asd" : "asd", "fgh": "fgh"]] //dummyData in required
        print("buyingViewModel.send() method : \(title), \(explained), \(min_num), \(category), \(required)")
        print(param)
        AF.request(projAddUrl, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON(){ json in
                print(json)
                print(param)
            }
    }
}
