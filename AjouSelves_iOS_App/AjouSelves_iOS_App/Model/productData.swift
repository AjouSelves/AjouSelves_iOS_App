//
//  productData.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/31.
//

import Foundation

struct productData: Codable, Identifiable, CustomStringConvertible {
    var id = UUID()
    var name : Name
    var photo : Photo
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case photo = "picture"
    }
    static func getDummy() -> Self {
        print(#fileID, #function, #line, "")
        return productData(name: Name.getDummy(), photo: Photo.getDummy())
    }
    
    var profileImgUrl : URL {
        get {
            URL(string: photo.medium)!
        }
    }
    
    var description: String {
        return name.description
    }
    
}

struct Name: Codable, CustomStringConvertible {
    var title : String
    var first : String
    var last : String
    
    var description: String {
        return "[\(title)] \(last), \(first)"
    }
    
    static func getDummy() -> Self {
        print(#fileID, #function, #line, "")
        return Name(title: "제목", first: "이름", last: "간단설명")
    }
}

struct Photo: Codable {
    var large : String
    var medium : String
    var thumbnail : String
    static func getDummy() -> Self {
        print(#fileID, #function, #line, "")
        return Photo(large: "https://randomuser.me/api/portraits/women/93.jpg",
                     medium: "https://randomuser.me/api/portraits/women/93.jpg",
                     thumbnail: "https://randomuser.me/api/portraits/women/93.jpg")
    }
}

struct Info : Codable {
    var seed : String
    var resultsCount : Int
    var page : Int
    var version : String
    private enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case resultsCount = "results"
        case page = "page"
        case version = "version"
    }
}

//RandomUserResponse
struct productDataResponse: Codable, CustomStringConvertible {
    //var results: [RandomUser]
    var results: [productData]
    var info: Info
    private enum CodingKeys: String, CodingKey {
        case results, info
    }
    var description: String {
        return "results.count: \(results.count) / info : \(info.seed)"
    }
}

struct userResponseData: Codable {
    let userid: Int?
    let email: String?
    let password: String?
    let salt: String?
    let phonenumber: String?
    let nickname: String?
    let status: String?
    let socialtype: String?
    let sex: Int?
    let birth: String?
    let address: String?
    let account: String?
    let create_at: String?
    let profilelink: String?
}

struct postResponseData: Codable {
    var title: String
    var explaiend: String
    var min_num: Int
    var category: String
    var required: [String]
}

// MARK: - 프로젝트 데이터 파싱
// Dictionary타입 때문에 Hashable 프로토콜 채택
struct projectAllDataParcing: Codable, Hashable {
    let title: String?
    let state: Int?
    let category: String?
    let min_num: Int?
    let cur_num: Int?
    let required: String?
    let explained: String?
    let nickname: String?
    let userid: Int?
    let profilelink: String?
    let url: String?
    let projid: Int?
    
    var profileImgUrl : URL { // 연산 프로퍼티
        get {
            URL(string: "http://52.206.105.200:3000\(url ?? "/photo/1650014537158-aa.png")")!
        }
//        get {
//            URL(string: "http://52.206.105.200:3000/photo/1650014537158-aa.png")!
//        }
    }
    
    var description_photos: URL {
        return profileImgUrl
    }
    
    var description_title: String {
        return "\(title!)"
    }
    var description_nickname: String {
        return "\(nickname!)"
    }
    var description_category: String {
        return "\(category!)"
    }
    var description_minnum: String {
        return "\(min_num!)"
    }
    var description_curnum: String {
        return "\(cur_num!)"
    }
    var description_projid: String {
        return "\(projid!)"
    }
    var description_explained: String {
        return "\(explained!)"
    }
    
    static func getDummy() -> Self {
        return projectAllDataParcing(title: "아주대학교 굿즈", state: 1, category: "의류", min_num: 1, cur_num: 1, required: "수량", explained: "1985년 처음 발매 된 에어 조던의 첫번째 모델이자, 나이키와 자회사인 조던 브랜드(Jordan Brand)의 상징이 된 신발. 아름다운 디자인, 거기에 신발의 주인공인 마이클 조던의 엄청난 활약으로 인해 아디다스, 컨버스[3]가 주도하고 있던 농구화 시장을 주도하는 데 성공한다. 이후로도 모두가 갖고 싶어하는 패션화로 거듭 났으며 여기에 나이키의 의도적인 수량 제한 정책과 최고의 셀럽들과 함께하는 콜라보레이션을 통해서 농구화로써의 기능성이 떨어진 지금에도 엄청난 매출을 자랑하는 모델이 되었다. 출시 당시 명칭은 Air Jordan이었으며 1986년에 Air Jordan 2가 공개되면서 숫자 넘버링이 붙기 시작했다.", nickname: "조민현", userid: 1, profilelink: "nil", url: "", projid: 1)
    }
}

struct postAllData: Codable {
    let title: String?
    let explained: String?
    let created_at: String?
    let userid: Int?
    let nickname: String?
    let url: String?
}

struct userCreateDetail: Codable {
    let projid: Int?
    let userid: Int?
    let title: String?
    let state: Int?
    let category: String?
    let min_num: Int?
    let cur_num: Int?
    let required: String?
    let explained: String?
    let paylink: String?
    let created_at: String?
}

struct userJoinDetail: Codable {
    
}
