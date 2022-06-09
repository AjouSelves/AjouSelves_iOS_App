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
    
    var projAddUrl = "http://goodsbyus.com/api/proj"
    var projAdd_PhotoUrl = "http://goodsbyus.com/api/proj/photo"
    
    @Published var title: String = ""
    @Published var explained: String = ""
    @Published var amount: Int = 0
    @Published var min_num: Int = 0
    @Published var category: String = ""
    @Published var required: [String] = [""]
    @Published var photoData: UIImage = UIImage()
    
    var projAddCheck: Bool = true
    var projAddSuccess: Bool = false
    
    var projEmptyName: String = ""
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
    
    func projAdd_Photo(){
        
        let tokenHeader: HTTPHeaders = [
            "Authorization": "\(UserDefaults.standard.string(forKey: "userToken")!)",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data" ]
        
        let param: [String: Any] = [
            "userid": 30,
            "title" : title,
            "explained" : explained,
            "min_num" : min_num,
            "category" : category,
            "amount" : amount,
            "required" : "test_required",
            "photo" : "null"
        ]
        AF.upload(multipartFormData: { MultipartFormData in
            for (key,value) in param {
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
            //            if let image = imageData?.pngData() {
            //                MultipartFormData.append(image, withName: "photo", fileName: "\(image).png", mimeType: "image/png")
            //            }
            
            if let image = self.photoData.jpegData(compressionQuality: 0.5) {
                MultipartFormData.append(image, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
            }
            
        }, to: projAdd_PhotoUrl, usingThreshold: UInt64.init(),method: .post, headers: tokenHeader)
        //        .responseJSON { response in
        //            print("JSON", response)
        //        }
        .responseString { response in
            let test = response.value?.split(separator: "\"")
            print(response)
            print(test![3])
            if test![3] != "fail" {
                switch response.result {
                case .success(_):
                    print("String", response)
                    print("photo send success")
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func projAddConfirm() {
        print("projAddConfirm clicked")
        self.projAddCheck = true
        self.projAddSuccess = false
        if title.isEmpty == true {
            print("title is Empty")
            self.projAddCheck = false
            self.projEmptyName = "제목"
        }
        else if explained.isEmpty == true {
            print("explained is Empty")
            self.projAddCheck = false
            self.projEmptyName = "설명"
        }
        else if min_num == 0 {
            print("min_num is Empty")
            self.projAddCheck = false
            self.projEmptyName = "펀딩 최소 인원"
        }
        else if amount == 0 {
            print("amount is Empty")
            self.projAddCheck = false
            self.projEmptyName = "가격"
        }
        else if category.isEmpty == true {
            print("category is Empty")
            self.projAddCheck = false
            self.projEmptyName = "카테고리"
        }
        //        else if required.isEmpty == true {
        //            print("required is Empty")
        //            self.projAddCheck = false
        //            self.projEmptyName = "제목"
        //        }
        else if photoData == nil {
            print("photoData is Empty")
            self.projAddCheck = false
            self.projEmptyName = "사진"
        }
        
        if projAddCheck == true {
            projAddSuccess = true
        }
    }
}
