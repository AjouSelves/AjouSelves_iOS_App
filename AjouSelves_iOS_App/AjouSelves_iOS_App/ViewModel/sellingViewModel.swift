//
//  buyingViewModel.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/13.
//

import Foundation
import Combine
import Alamofire
import Photos
import UIKit

class sellingViewModel: ObservableObject {
    
    var projAddUrl = "http://52.206.105.200:3000/proj/add"
    var projAddSingleUrl = "http://52.206.105.200:3000/proj/add/single"
    var projAddMultiUrl = "http://52.206.105.200:3000/proj/add/multi"
    
    @Published var title: String = ""
    @Published var explained: String = ""
    @Published var min_num: Int = 0
    @Published var category: String = ""
    @Published var required: [String] = [""]
    
    //var productdataViewModels = productdataViewModel()
    //var productVM = productDataViewModel()
    
    func send() {
        let token = "userToken"
        if UserDefaults.standard.string(forKey: token) != nil {
            UserDefaults.standard.string(forKey: token)
        } else {
            print("\(token)에 nil")
        }
        let tokenHeader: HTTPHeaders = [
            "Authorization": "\(UserDefaults.standard.string(forKey: token)!)", //UserDefaults에 저장한 토큰 불러오기
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        
        let param: Parameters = ["userid": 30, "title" : title, "explained" : explained, "min_num" : min_num, "category" : category, "required" : "test_required"] //dummyData in required
        print("buyingViewModel.send() method : \(title), \(explained), \(min_num), \(category), \(required)")
        AF.request(projAddUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: tokenHeader)
            .responseString() { response in
                print(response)
            }
    }
    
    func projAddSingle(imageData: UIImage?){
        
        let tokenHeader: HTTPHeaders = [
            "Authorization": "\(UserDefaults.standard.string(forKey: "userToken")!)",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data" ]
        
//        let param: [String: Any] = [
//            "userid": 30,
//            "title" : title,
//            "explained" : explained,
//            "min_num" : min_num,
//            "category" : category,
//            "required" : "test_required"
//        ]
        let param: [String: Any] = [
            "userid": 30,
            "title" : "사진테스트",
            "explained" : "explained",
            "min_num" : 10,
            "category" : "사진테스트",
            "required" : "test_required",
            "photo" : "null"
        ]
        AF.upload(multipartFormData: { MultipartFormData in
            for (key,value) in param {
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
            if let image = imageData?.pngData() {
                MultipartFormData.append(image, withName: "photo", fileName: "\(image).png", mimeType: "image/png")
            }
            
            if let image = imageData?.jpegData(compressionQuality: 0.5) {
                MultipartFormData.append(image, withName: "photo", fileName: "\(image).jpeg", mimeType: "image/jpeg")
            }
            
        }, to: projAddSingleUrl, usingThreshold: UInt64.init(),method: .post, headers: tokenHeader)
            .responseString { response in
            switch response.result {
            case .success(_):
                print(response)
                print("photo send success")
                
            case .failure(let error):
                print(error)
            }
        }
        print("MultipartFormData",param)
        
    }
    
}
