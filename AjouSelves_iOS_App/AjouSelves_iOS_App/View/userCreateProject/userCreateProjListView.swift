//
//  userCreateProjListView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/26.
//

import SwiftUI

struct userCreateProjListView: View {
    var prdData : userCreate.userCreateDetail

    init(_ prdData : userCreate.userCreateDetail) {
        self.prdData = prdData
    }
    
    var body: some View {
        HStack{
            thumbnailView(imageUrl: prdData.profileImgUrl)
                .frame(width: 130, height: 130)
                .clipped()
            VStack(alignment: .leading, spacing: 5){
                Text("\(prdData.description_category)")
                    //.fontWeight(.heavy)
                    .font(.system(size: 15))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Text("\(prdData.description_title)")
                    .fontWeight(.heavy)
                    .font(.system(size: 20))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Spacer()
//                Text("\(prdData.description_nickname)")
//                    //.fontWeight(.heavy)
//                    .font(.system(size: 15))
//                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
//                    .minimumScaleFactor(0.5)
                HStack{
                    Text("\(prdData.cal_joinPer)% 달성!")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                        
                    Text("\(prdData.description_curnum)명 참여!") // 지금까지 몇명이 참여했는지에 대한 데이터 필요
                        //.fontWeight(.heavy)
                        .font(.system(size: 15))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                }
            }
        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .leading).padding(.vertical)
    }
}

struct userCreateProjListView_Previews: PreviewProvider {
    static var previews: some View {
        userCreateProjListView(userCreate.userCreateDetail.getDummy())
    }
}
