//
//  communityDetailView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/27.
//

import SwiftUI

struct communityDetailView: View {
    @ObservedObject var productDataVM = productdataViewModel()
    
    var prdData: postStruct.postAllData
    
    init(_ prdData : postStruct.postAllData) {
        self.prdData = prdData
    }
    
    var body: some View {
        VStack{
            ScrollView{
                Divider()
                ScrollView(.horizontal) {
                    projImgView(imageUrl: prdData.profileImgUrl)
                }
                Divider()
                Spacer()
                VStack(alignment: .leading){
                    Text("\(prdData.description_nickname)")
                        .font(.system(size: 20))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.gray)
                    Text("\(prdData.description_created_at)")
                        .font(.system(size: 40))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("\(prdData.description_title)")
                        .font(.system(size: 40))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                }.frame(width: 350, height: 70, alignment: .leading).padding()
                VStack(alignment: .leading){
                    Text("\(prdData.description_explained)")
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.5)
                        .padding()
                }
            }
        }
        //.setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
}

struct communityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        communityDetailView(postStruct.postAllData.getDummy())
    }
}
