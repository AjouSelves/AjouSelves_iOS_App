//
//  buyingViewModel.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/13.
//

import Foundation
import Combine
import Alamofire
import BSImagePicker
import Photos

class sellingViewModel: ObservableObject {
    
    var projAddUrl = "http://52.206.105.200:3000/proj/add"
    var projAddSingleUrl = "http://52.206.105.200:3000/proj/add/single"
    var projAddMultiUrl = "http://52.206.105.200:3000/proj/add/multi"
    
    @Published var title: String = ""
    @Published var explained: String = ""
    @Published var min_num: Int = 0
    @Published var category: String = ""
    @Published var required: [String] = [""]
    
    var productdataViewModels = productDataViewModel()
    
    func send() {
        let tokenHeader: HTTPHeaders = [
            "Authorization": "\(productdataViewModels.userToken)",
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        
        let param: Parameters = ["userid": 30, "title" : title, "explained" : explained, "min_num" : min_num, "category" : category, "required" : "test_required"] //dummyData in required
        print("buyingViewModel.send() method : \(title), \(explained), \(min_num), \(category), \(required)")
        AF.request(projAddUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: tokenHeader)
            .responseJSON(){ json in
                print(json)
                // 오류 메시지 변환
                //                if let data = json.data, let success = String(data: data, encoding: .utf8) {
                //                    print(success)
                //                }
            }
    }
}
