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
    //@Published var userDatas = [userResponseData]()
    @Published var projectAllDataParcings = [projectAllDataParcing]()
    
    //@Published var postDats
    
    //MARK: - URL -> lowerCamelCase
    var randomUserApi = "https://randomuser.me/api/?results=100"
    // RamdomUserApi를 불러옴
    var userAllUrl = "http://44.202.49.100:3000/user/all"
    // 전체 유저 데이터 불러옴
    var postUrl = "http://44.202.49.100:3000/post"
    //
    var authRegisterUrl = "http://44.202.49.100:3000/auth/register"
    // 유저 데이터 삽입
    var projUrl = "http://44.202.49.100:3000/proj/"
    // 프로젝트의 목록, 전체 불러오기X
    var checkProjIndex: Int = 0
    
    init() {
        print(#fileID, #function, #line, "")
        //fetchRandomUserApi()
        //fetchUserAllUrl()
        //fetchAuthRegisterUrl()
//        for i in 1...20{
//            fetchProjUrl(url:projUrl+"\(i)")
//        }
        fetchProjUrl(url: projUrl)
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
            print(response)
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
        .responseDecodable(of: [projectAllDataParcing].self) { response in
            switch response.result {
            case .success(let value):
                //print(value)
                self.projectAllDataParcings = value
                print(self.projectAllDataParcings)
            case .failure(let error):
                print(error)
            }
        }
        .responseJSON(){ response in
            //print(response)
            //print("\(self.checkProjIndex)번 째 proj") // checking index
            //self.checkProjIndex+=1 // checking index
        }
    }
    
//    func fetchProjUrl(url: String){
//        let alamo = AF.request(url, method: .get).validate(statusCode: 200..<300)
//
//        alamo.responseJSON(completionHandler: { response in
//            switch response.result{
//            case .success:
//                guard let result = response.data else { return }
//
//                do{
//                    let decoder = JSONDecoder()
//                    let json = try decoder.decode(projectAllDataParcing.self, from: result)
//                    print(json)
//                } catch {
//                    print("error code: \(error)")
//                }
//            default:
//                return
//            }
//        })
//    }
    
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
                print(response)
            }
            .responseJSON(){ response in
                print(param)
            }
    }
}
