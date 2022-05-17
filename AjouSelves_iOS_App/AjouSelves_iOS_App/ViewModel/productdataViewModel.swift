//
//  productdataViewModel.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/31.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

//class RandomUserViewModel: ObservableObject
class productDataViewModel: ObservableObject {
    
    //MARK: - Properties
    var subscription = Set<AnyCancellable>() // 메모리 관리
    
    @Published var productDatas = [productData]()
    @Published var projectAllDataParcings = [projectAllDataParcing]()
    @Published var postAllDatas = [postAllData]()
    @Published var userToken: String = ""
    
    //MARK: for register
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var sex: Int  = 0
    @Published var phonenumber: String = ""
    @Published var nickname: String = ""
    @Published var status: String = "재학생"
    @Published var socialtype: String = ""
    @Published var birth: String = ""
    @Published var address: String = "dummy"
    @Published var profilelink: String = "https://kakao.com/abcd"
    @Published var bank: String = ""
    @Published var account: String = ""
    @Published var loginEmail: String = ""
    @Published var loginPassword: String = ""
    @Published var wakeUp = Date()
    
    //MARK: - 상태저장형재들
    var registerCheck: Bool = false // 회원의 입력 항목중 빈 항목이 있다면 true로 체크
    var registerisSuccess: Bool = false // 회원가입이 성공적으로 이루어져 success를 받으면 true
    var registerFinish: Bool = false // 회원가입이 끝난 후 창이 꺼지면 안내 메시지 출력
    var loginisSuccess: Bool = false // 로그인을 성공하면 true
    
    //MARK: - URL -> lowerCamelCase
    var randomUserApi = "https://randomuser.me/api/?results=100" // RamdomUserApi를 불러옴
    
    var userAllUrl = "http://44.202.49.100:3000/user/all" // 전체 유저 데이터 불러옴
    
    var postAllUrl = "http://44.202.49.100:3000/post/all" // 커뮤니티 게시글 전체 조회
    
    var postAddUrl = "http://44.202.49.100:3000/post/add" // 커뮤니티 게시글 추가
    
    var authRegisterUrl = "http://44.202.49.100:3000/auth/register" // 유저 데이터 삽입
    
    var projUrl = "http://44.202.49.100:3000/proj/" // 프로젝트 목록
    
    var checkProjIndex: Int = 0
    
    var projDeleteUrl = "http://44.202.49.100:3000/proj/delete/41" // 특정 프로젝트 삭제
    
    var authLoginUrl = "http://44.202.49.100:3000/auth/login" // 로그인 토큰 발급
    
    init() {
        print("init productdataViewModel")
        authLogin(url: authLoginUrl) // 유저 로그인 -> 토큰 반환
        //fetchRandomUserApi() // 랜덤유저api
        //fetchUserAllUrl() // 전체 유저 데이터 불러오기
        //fetchAuthRegisterUrl() // 회원가입
        fetchProjUrl(url: projUrl) // 전체 프로젝트 데이터 불러오기
        //projDelete(url: projDeleteUrl) // 특정 프로젝트 삭제
        //fetchPostAll(url: postAllUrl) // 전체 커뮤니티 데이터 불러오기
    }
    
    func refreshProj(){
        fetchProjUrl(url: projUrl)
    }
    
    func fetchRandomUserApi(){
        AF.request(randomUserApi)
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
    
    func fetchUserAllUrl(){
        AF.request(userAllUrl,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [userResponseData].self) { response in
            //print(response)
        }
        .responseJSON(){ response in
            //print(response)
        }
    }
    
    // URL/proj/
    func fetchProjUrl(url:String){
        print("authLogin Activated")
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
        //.compactMap { $0.value }
        .responseJSON{ response in
            //print(response)
        }
        .responseDecodable(of: [projectAllDataParcing].self) { response in
            switch response.result {
            case .success(let value):
                //print("value!!!", value)
                self.projectAllDataParcings = value
                //print(self.projectAllDataParcings)
            case .failure(let error):
                print(error)
            }
        }
//        .responseJSON(){ response in
//            //print(response)
//            //print("\(self.checkProjIndex)번 째 proj") // checking index
//            //self.checkProjIndex+=1 // checking index
//        }
    }
    
    func projDelete(url: String){
        let tokenHeader: HTTPHeaders = [
            "Authorization": "\(userToken)",
                    "Accept": "application/json",
                    "Content-Type": "application/json" ]
        AF.request(url, method: .delete, parameters: nil, headers: tokenHeader).validate(statusCode: 200..<300)
            .responseJSON { response in
                //print("delete!!!", response)
            }
    }
    
    func authLogin(url: String){
        print("authLogin Activated")
        
        let param: Parameters = [
            "email" : "\(loginEmail)",
            "password" : "\(loginPassword)"
        ]
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: URLEncoding.default,
                   headers: nil)
            .validate(statusCode: 200..<300)
//            .responseJSON(){ response in
//                print("response!!!",response)
//            }
            // response로 날아온 userToken을 string으로 변환 후 잘라서 published 변수에 저장
            .response{ response in
                switch response.result {
                case .success(_):
                    print("login success")
                    self.loginisSuccess = true
                    if let data = response.data, let success = String(data: data, encoding: .utf8) {
                        let testText = success.split(separator: "\"")
                        self.userToken = String(testText[9])
                        print(self.userToken)
                    }
                    
                case .failure(let error):
                    print(error)
                }
//                if let data = response.data, let success = String(data: data, encoding: .utf8) {
//                    let testText = success.split(separator: "\"")
//                    //print(success)
//                    //print("split!!!",testText[9])
//                    print(response)
//                    //self.userToken = String(testText[9])
//                }
            }
    }
    
    func fetchPostAll(url: String){
        AF.request(url, method: .get, parameters: nil, headers: nil)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [postAllData].self) { response in
                switch response.result {
                case .success(let value):
                    self.postAllDatas = value
                    print("postAllDatas!!!", self.postAllDatas)
                case .failure(let error):
                    print("postAllDatas!!!", error)
                }
            }
    }
    
    func emailConfirm(){
        
    }
    
    func registConfirm(){
        // year, month, day
        self.registerCheck = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateParser = dateFormatter.string(from: wakeUp)
        birth = dateParser
        
        if email.isEmpty == true {
            print("email is Empty")
            self.registerCheck = true
        }
        else if password.isEmpty == true {
            print("password is Empty")
            self.registerCheck = true
        }
        else if name.isEmpty == true {
            print("name is Empty")
            self.registerCheck = true
        }
        else if phonenumber.isEmpty == true {
            print("phonenumber is Empty")
            self.registerCheck = true
        }
        else if nickname.isEmpty == true {
            print("nickname is Empty")
            self.registerCheck = true
        }
        else if birth.isEmpty == true {
            print("birth is Empty")
            self.registerCheck = true
        }
        else if bank.isEmpty == true {
            print("bank is Empty")
            self.registerCheck = true
        }
        else if account.isEmpty == true {
            print("account is Empty")
            self.registerCheck = true
        }
        
        let param: Parameters = [
            "email" : "\(email)",
            "password" : "\(password)",
            "name" : "\(name)",
            "phonenumber" : "\(phonenumber)",
            "nickname" : "\(nickname)",
            "status" : "\(status)",
            "socialtype" : "\(socialtype)",
            "sex" : 0,
            "birth" : "\(birth)",
            "address" : "\(address)",
            "account" : "\(account)",
            "profilelink" : "\(profilelink)"
        ]
        
        if registerCheck == false {
            AF.request(authRegisterUrl, method: .post, parameters: param, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON{ response in
                    switch response.result {
                    case .success(let value):
                        self.registerisSuccess = true
                        self.registerFinish = true
                        print("success")
                    case .failure(let error):
                        print("fail", error)
                    }
                }
        }
    }
}
