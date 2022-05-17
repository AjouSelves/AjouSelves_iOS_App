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
    
    var profileImgUrl : URL {
        get {
            URL(string: "http://44.202.49.100:3000\(url ?? "/photo/1650014537158-aa.png")")!
        }
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
    
    static func getDummy() -> Self {
        return projectAllDataParcing(title: "아주대학교 굿즈", state: 1, category: "의류", min_num: 1, cur_num: 1, required: "수량", explained: "설명임", nickname: "조민현", userid: 1, profilelink: "nil", url: "")
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
