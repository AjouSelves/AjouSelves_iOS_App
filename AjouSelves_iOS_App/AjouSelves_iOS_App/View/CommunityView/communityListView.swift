//
//  communityListView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/27.
//

import SwiftUI

struct communityListView: View {
    
    var prdData : postStruct.postAllData

    init(_ prdData : postStruct.postAllData) {
        self.prdData = prdData
    }
    
    var body: some View {
        HStack{
            thumbnailView(imageUrl: prdData.profileImgUrl)
                .frame(width: 130, height: 130)
                .clipped()
            VStack(alignment: .leading, spacing: 5){
                Text("\(prdData.description_title)")
                    .fontWeight(.heavy)
                    .font(.system(size: 20))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Text("\(prdData.description_explained)")
                    //.fontWeight(.heavy)
                    .font(.system(size: 25))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                HStack {
                    Text("\(prdData.description_created_at)")
                        //.fontWeight(.heavy)
                        .font(.system(size: 15))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                    Text("\(prdData.description_nickname)")
                        //.fontWeight(.heavy)
                        .font(.system(size: 15))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                }
            }
        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .leading).padding(.vertical)
    }
}

struct communityListView_Previews: PreviewProvider {
    static var previews: some View {
        communityListView(postStruct.postAllData.getDummy())
    }
}
