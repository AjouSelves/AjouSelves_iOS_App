//
//  ProjListView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/04.
//

import Foundation
import SwiftUI

struct ProjListView : View {
    
    var prdData : projectAllDataParcing

    
    init(_ prdData : projectAllDataParcing) {
        self.prdData = prdData
    }
    
    var body: some View {
        HStack{
            thumbnailView(imageUrl: prdData.profileImgUrl)
                .frame(width: 130, height: 130)
                .clipped()
            VStack(alignment: .leading, spacing: 5){
                Text("\(prdData.description_category)")
                    .font(.system(size: 30))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Text("\(prdData.description_title)")
                    .fontWeight(.heavy)
                    .font(.system(size: 30))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Text("\(prdData.description_amount)원")
                    .font(.system(size: 30))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.red)
                //Spacer()
                HStack{
                    Text("\(prdData.cal_joinPer)% 달성!")
                        .foregroundColor(Color.red)
                        .font(.system(size: 30))
                        .minimumScaleFactor(0.5)
                        
                    Text("\(prdData.description_curnum)명 참여!") // 지금까지 몇명이 참여했는지에 대한 데이터 필요
                        //.fontWeight(.heavy)
                        .font(.system(size: 30))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                }
                Text("\(prdData.description_state)")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 25))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
            }
        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .leading).padding(.vertical)
    }
}



struct ProjListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjListView(projectAllDataParcing.getDummy())
    }
}
