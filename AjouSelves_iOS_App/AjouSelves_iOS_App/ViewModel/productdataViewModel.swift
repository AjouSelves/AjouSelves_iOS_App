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
    
    //@Published var postDats
    
    //MARK: - URL -> lowerCamelCase
    var randomUserApi = "https://randomuser.me/api/?results=100"
    var userAllUrl = "http://44.202.49.100:3000/user/all"
    var postUrl = "http://44.202.49.100:3000/post"
    var authRegisterUrl = "http://44.202.49.100:3000/auth/register" // 유저 데이터 삽입
    var projUrl = "http://44.202.49.100:3000/proj/"
    
    //MARK: - For [Testing]
    var baseUrl2 = ["https://s3.marpple.co/files/u_1150555/2021/12/original/31eca686f0dd678adbd12faf5b1d5f693fb405791.jpg", "https://t1.daumcdn.net/cfile/tistory/9997C03E5C616C2720", "https://static.wixstatic.com/media/20259e_6e1bc381681c4f21a2415ea4fc5c2e6e~mv2.png/v1/crop/x_0,y_62,w_3456,h_4608/fill/w_272,h_300,al_c,usm_0.66_1.00_0.01,enc_auto/KakaoTalk_Photo_2021-09-01-17-28-22.png", "https://cdn.imweb.me/upload/S20200830244f269ed848e/656eb6ed91f12.jpg", "https://file.mk.co.kr/meet/neds/2020/11/image_readtop_2020_1174561_16054915004432908.jpg", "https://cdn.econovill.com/news/photo/202106/535189_445017_4134.jpg", "https://cdnweb01.wikitree.co.kr/webdata/editor/202010/24/img_20201024183026_60837f89.webp", "https://www.travelnbike.com/news/photo/202009/89970_176024_4744.jpg"]
    
    var checkProjIndex: Int = 0
    
    init() {
        print(#fileID, #function, #line, "")
        fetchRandomUserApi()
        fetchUserAllUrl()
        fetchAuthRegisterUrl()
        for i in 1...20{
            fetchProjUrl(url:projUrl+"\(i)")
        }
    }
    
//    func fetchRandomUserApi(){
//        print(#fileID, #function, #line, "")
//        AF.request(randomUserApi)
//            .publishDecodable(type: productDataResponse.self)
//            .compactMap{ $0.value }
//            .map{ $0.results }
//            .sink(receiveCompletion: { completion in
//                print("데이터스트림 완료 ")
//            }, receiveValue: { receivedValue in
//                print("받은 값 : \(receivedValue.count)")
//                self.productDatas = receivedValue
//            }).store(in: &subscription)
//    }
    
    func fetchRandomUserApi(){
        print(#fileID, #function, #line, "")
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
    
    func fetchtesting(){
        //AF.request(baseUrl2)
            //.publishDecodable(type:)
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
    
    func fetchProjUrl(url:String){
        AF.request(url,
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
            print("\(self.checkProjIndex)번 째 proj") // checking index
            self.checkProjIndex+=1 // checking index
        }
    }
    
    func fetchAuthRegisterUrl() {
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
        AF.request(authRegisterUrl, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseString(){ response in
                print(response)
            }
            .responseJSON(){ response in
                print(param)
            }
    }
}
