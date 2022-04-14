//
//  productdataViewModel.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/31.
//

import Foundation
import Combine
import Alamofire

//class RandomUserViewModel: ObservableObject
class productDataViewModel: ObservableObject {
    
    //MARK: - Properties
    var subscription = Set<AnyCancellable>() // 메모리 관리
    
    @Published var productDatas = [productData]()
    @Published var userDatas = [userResponseData]()
    
    //@Published var postDats
    
    //MARK: - URL
    var baseUrl = "https://randomuser.me/api/?results=100"
    var ASUserUrl = "http://44.202.49.100:3000/user"
    var ASPostUrl = "http://44.202.49.100:3000/post"
    var userRegisterUrl = "http://44.202.49.100:3000/auth/register" // 유저 데이터 삽입
    // var userAll = "http://44.202.49.100:3000/user/all" // 모든 유저 데이터 가져오기
    
    
    init() {
        print(#fileID, #function, #line, "")
        fetchRandomUsers()
        fetchUserData()
        addPostData()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl)
            .publishDecodable(type: productDataResponse.self)
            .compactMap{ $0.value }
            .map{ $0.results }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료 ")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.productDatas = receivedValue
            }).store(in: &subscription)
    }
    
//    func fetchUserData(){
//        //print(#fileID, #function, #line, "")
//        AF.request(testUrl)
//            .publishDecodable(type: userResponseData.self)
//            //.compactMap{ $0.value }
//            //.map{ $0.results }
//            .sink(receiveCompletion: { completion in
//                print("데이터스트림 완료 ")
//                print(completion)
//            }, receiveValue: { receivedValue in
//                //print("받은 값 : \(receivedValue.count)")
//                //self.productDatas = receivedValue
//            }).store(in: &subscription)
//    }
    
    func fetchUserData(){
        AF.request(ASUserUrl,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [userResponseData].self) { response in
                //.map{ $0.id }
            //print(response)
            //self.userDatas =
        }
        .responseJSON(){ response in
            print(response)
        }
    }
    
    func addPostData() {
        let param: Parameters = [
            "email" : "sisi@gmail.com",
            "password" : "mhmh",
            "phonenumber" : "01099999999",
            "nickname" : "sisi",
            "status" : "재학생",
            "socialtype" : "local",
            "sex" : 1,
            "birth" : "1999-03-03",
            "address" : "서울시 봉천동",
            "account" : "110404",
            "profilelink" : "kakako.com/113355"
        ]
        AF.request(userRegisterUrl, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseString(){ response in
                print(response)
            }
            .responseJSON(){ response in
                print(param)
            }
    }
}

