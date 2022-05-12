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
    @Published var projectAllDataParcings = [projectAllDataParcing]()
    @Published var postAllDatas = [postAllData]()
    @Published var userToken: String = ""
    
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
        print(#fileID, #function, #line, "")
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
    
    func fetchAuthRegisterUrl() {
        let param: Parameters = [
            "email" : "simh3077@gmail.com",
            "password" : "mhmh",
            "phonenumber" : "01099999999",
            "nickname" : "조민현",
            "status" : "재학생",
            "socialtype" : "local",
            "sex" : 1,
            "birth" : "1999-03-03",
            "address" : "서울시 봉천동",
            "account" : "110404",
            "profilelink" : "kakako.com/113355"
        ]
        AF.request(authRegisterUrl, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseString(){ response in
                //print(response)
            }
            .responseJSON(){ response in
                //print(param)
            }
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
        let param: Parameters = [
            "email" : "simh3077@gmail.com",
            "password" : "mhmh"
        ]
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoding: URLEncoding.default,
                   headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON(){ response in
                //print("response!!!",response)
            }
            // response로 날아온 userToken을 string으로 변환 후 잘라서 published 변수에 저장
            .response{ response in
                if let data = response.data, let success = String(data: data, encoding: .utf8) {
                    let testText = success.split(separator: "\"")
                    //print(success)
                    //print("split!!!",testText[9])
                    self.userToken = String(testText[9])
                }
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
}
