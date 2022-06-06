//
//  productData.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/31.
//

import Foundation

//MARK: - 유저 데이터 파싱
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

// MARK: - 프로젝트 데이터 파싱
struct projectAllDataParcing: Codable, Hashable {
    let title: String?
    let state: Int?
    let category: String?
    let min_num: Int?
    let cur_num: Int?
    let amount: Int?
    let required: String?
    let explained: String?
    let nickname: String?
    let userid: Int?
    let profilelink: String?
    let url: String?
    let projid: Int?
    
    var hangulToUrl: String {
        let encodedStr = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return encodedStr!
    }
    
    var profileImgUrl : URL { // 연산 프로퍼티
        get {
            URL(string: "http://goodsbyus.com\(hangulToUrl ?? "/photo/1653782114124-b1-1_04.png")")!
        }
//        get {
//            URL(string: "http://goodsbyus.com/photo/1653782114124-b1-1_04.png")!
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
    var description_state: String {
        switch state{
        case 1:
            return "모집중"
        case 2:
            return "결제중"
        case 3:
            return "작업중"
        case 4:
            return "프로젝트 끝"
        default:
            return "이스터에그 발견!🥚"
        }
        
    }
    var description_minnum: String {
        return "\(min_num!)"
    }
    var description_amount: Int {
        return amount!
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
    var cal_joinPer: String {
        return String(format: "%.0f",round((Float(cur_num!)/Float(min_num!))*100))
    }
    
    static func getDummy() -> Self {
        return projectAllDataParcing(title: "아주대학교 굿즈를 여기서 등록할 수 있습니다 제목이어디까지가능할까여asdasdasd", state: 2, category: "의류", min_num: 50, cur_num: 13, amount: 0, required: "수량", explained: "1985년 처음 발매 된 에어 조던의 첫번째 모델이자, 나이키와 자회사인 조던 브랜드(Jordan Brand)의 상징이 된 신발. 아름다운 디자인, 거기에 신발의 주인공인 마이클 조던의 엄청난 활약으로 인해 아디다스, 컨버스[3]가 주도하고 있던 농구화 시장을 주도하는 데 성공한다. 이후로도 모두가 갖고 싶어하는 패션화로 거듭 났으며 여기에 나이키의 의도적인 수량 제한 정책과 최고의 셀럽들과 함께하는 콜라보레이션을 통해서 농구화로써의 기능성이 떨어진 지금에도 엄청난 매출을 자랑하는 모델이 되었다. 출시 당시 명칭은 Air Jordan이었으며 1986년에 Air Jordan 2가 공개되면서 숫자 넘버링이 붙기 시작했다.", nickname: "조민현", userid: 1, profilelink: "nil", url: "/photo/1654094009801-soccer.png", projid: 1)
    }
}

//MARK: - 커뮤니티 게시글 파싱
struct postStruct: Codable {
    let status: String
    let data: [postAllData]
    
    struct postAllData: Codable, Hashable {
        let postid: Int?
        let title: String?
        let explained: String?
        let created_at: String?
        let userid: Int?
        let nickname: String?
        let url: String?
        
        var hangulToUrl: String {
            let encodedStr = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! ?? "/photo/1653782114124-b1-1_04.png"
            return encodedStr
        }
        
        var profileImgUrl : URL { // 연산 프로퍼티
            get {
                URL(string: "http://goodsbyus.com\(hangulToUrl ?? "/photo/1653782114124-b1-1_04.png")")!
            }
    //        get {
    //            URL(string: "http://goodsbyus.com/photo/1653782114124-b1-1_04.png")!
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
        var description_userid: String {
            return "\(userid!)"
        }
        var description_created_at: String {
            return "\(created_at!)"
        }
        var description_explained: String {
            return "\(explained!)"
        }
        static func getDummy() -> Self {
//            return postAllData(postid: 1, title: "아주대학교 커뮤니티", explained: "1985년 처음 발매 된 에어 조던의 첫번째 모델이자, 나이키와 자회사인 조던 브랜드(Jordan Brand)의 상징이 된 신발. 아름다운 디자인, 거기에 신발의 주인공인 마이클 조던의 엄청난 활약으로 인해 아디다스, 컨버스[3]가 주도하고 있던 농구화 시장을 주도하는 데 성공한다. 이후로도 모두가 갖고 싶어하는 패션화로 거듭 났으며 여기에 나이키의 의도적인 수량 제한 정책과 최고의 셀럽들과 함께하는 콜라보레이션을 통해서 농구화로써의 기능성이 떨어진 지금에도 엄청난 매출을 자랑하는 모델이 되었다. 출시 당시 명칭은 Air Jordan이었으며 1986년에 Air Jordan 2가 공개되면서 숫자 넘버링이 붙기 시작했다.", created_at: "", userid: 1, nickname: "Minion", url: "")
            return postAllData(postid: 1, title: "김다예 사랑해🤍", explained: "김다예 사랑해🤍", created_at: "", userid: 1, nickname: "김다예 사랑해🤍", url: "")
        }
    }
}

//MARK: - 굿즈 프로젝트 참여 파싱
struct userJoin: Codable {
    let status: String?
    let data: [userJoinDetail]
    
    struct userJoinDetail: Codable, Hashable {
        let projid: Int?
        let title: String?
        let state: Int?
        let category: String?
        //let created_at: String?
        let userid: Int?
        let nickname: String?
        let profilelink: String?
        let min_num: Int?
        let cur_num: Int?
        let explained: String?
        let url: String?
        //let required: String?
        
        var hangulToUrl: String {
            let encodedStr = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return encodedStr!
        }
        
        var profileImgUrl : URL { // 연산 프로퍼티
            get {
                URL(string: "http://goodsbyus.com\(hangulToUrl ?? "/photo/1653782114124-b1-1_04.png")")!
            }
    //        get {
    //            URL(string: "http://goodsbyus.com/photo/1653782114124-b1-1_04.png")!
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
        var cal_joinPer: String {
            return String(format: "%.0f",round((Float(cur_num!)/Float(min_num!))*100))
        }
        
        static func getDummy() -> Self {
            return userJoinDetail(projid: 1, title: "아주대학교 굿즈", state: 1, category: "인형",  userid: 1, nickname: "Minion", profilelink: "kakao.com/1234", min_num: 10, cur_num: 0, explained: "1985년 처음 발매 된 에어 조던의 첫번째 모델이자, 나이키와 자회사인 조던 브랜드(Jordan Brand)의 상징이 된 신발. 아름다운 디자인, 거기에 신발의 주인공인 마이클 조던의 엄청난 활약으로 인해 아디다스, 컨버스[3]가 주도하고 있던 농구화 시장을 주도하는 데 성공한다. 이후로도 모두가 갖고 싶어하는 패션화로 거듭 났으며 여기에 나이키의 의도적인 수량 제한 정책과 최고의 셀럽들과 함께하는 콜라보레이션을 통해서 농구화로써의 기능성이 떨어진 지금에도 엄청난 매출을 자랑하는 모델이 되었다. 출시 당시 명칭은 Air Jordan이었으며 1986년에 Air Jordan 2가 공개되면서 숫자 넘버링이 붙기 시작했다.", url: "/photo/1653665712857-photo.jpeg")
        }
    }
}

//MARK: - 굿즈 프로젝트 참여 해제
struct projJoin_LeaveId: Codable {
    let status: String?
    let text: String?
}

//MARK: - 굿즈 프로젝트 생성
struct userCreate: Codable {
    let status: String?
    let data: [userCreateDetail]
    
    struct userCreateDetail: Codable, Hashable {
        let projid: Int?
        let title: String?
        let state: Int?
        let category: String?
    //    let created_at: Date?
        let userid: Int?
        let nickname: String?
        let profilelink: String?
        let min_num: Int?
        let cur_num: Int?
        let explained: String?
        let url: String?
        //let required: String?
        
        var hangulToUrl: String {
            let encodedStr = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return encodedStr!
        }
        
        var profileImgUrl : URL { // 연산 프로퍼티
            get {
                URL(string: "http://goodsbyus.com\(hangulToUrl ?? "/photo/1653782114124-b1-1_04.png")")!
            }
    //        get {
    //            URL(string: "http://goodsbyus.com/photo/1653782114124-b1-1_04.png")!
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
        var cal_joinPer: String {
            return String(format: "%.0f",round((Float(cur_num!)/Float(min_num!))*100))
        }
        
        static func getDummy() -> Self {
            return userCreateDetail(projid: 1, title: "아주대학교 굿즈", state: 1, category: "인형",  userid: 1, nickname: "Minion", profilelink: "kakao.com/1234", min_num: 10, cur_num: 0, explained: "1985년 처음 발매 된 에어 조던의 첫번째 모델이자, 나이키와 자회사인 조던 브랜드(Jordan Brand)의 상징이 된 신발. 아름다운 디자인, 거기에 신발의 주인공인 마이클 조던의 엄청난 활약으로 인해 아디다스, 컨버스[3]가 주도하고 있던 농구화 시장을 주도하는 데 성공한다. 이후로도 모두가 갖고 싶어하는 패션화로 거듭 났으며 여기에 나이키의 의도적인 수량 제한 정책과 최고의 셀럽들과 함께하는 콜라보레이션을 통해서 농구화로써의 기능성이 떨어진 지금에도 엄청난 매출을 자랑하는 모델이 되었다. 출시 당시 명칭은 Air Jordan이었으며 1986년에 Air Jordan 2가 공개되면서 숫자 넘버링이 붙기 시작했다.", url: "/photo/1653665712857-photo.jpeg")
        }
    }
}

struct userGet: Codable, Hashable{
    let email: String?
    let name: String?
    let phonenumber: String?
    let nickname: String?
    let status: String?
    let birth: String?
    let address: String?
    let account: String?
    let profilelink: String?
    
    var description_email: String {
        return "\(email!)"
    }
    var description_name: String {
        return "\(name!)"
    }
    var description_phonenumber: String {
        return "\(phonenumber!)"
    }
    var description_nickname: String {
        return "\(nickname!)"
    }
    var description_status: String {
        return "\(status!)"
    }
    var description_birth: String {
        return "\(birth!)"
    }
    var description_address: String {
        return "\(address!)"
    }
    var description_account: String {
        return "\(account!)"
    }
    var description_profilelink: String {
        return "\(profilelink!)"
    }
    static func get_Dummy() -> Self {
        return userGet(email: "sisi@naver.com", name: "조민현", phonenumber: "01028567925", nickname: "Minion", status: "재학생", birth: "1999-03-26", address: "서울시 관악구 봉천동", account: "신한 110 404 802076", profilelink: "https://kakao.com/simh3077")
    }
}
