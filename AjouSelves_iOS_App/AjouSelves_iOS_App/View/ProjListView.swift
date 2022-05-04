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
            VStack(alignment: .leading, spacing: 5){
                //MainImgView(imageUrl: prdData.profileImgUrl)
                Text("\(prdData.description_title)")
                    .fontWeight(.heavy)
                    .font(.system(size: 50))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Text("\(prdData.description_nickname)")
                    //.fontWeight(.heavy)
                    .font(.system(size: 35))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
                Text("\(prdData.description_category)")
                    //.fontWeight(.heavy)
                    .font(.system(size: 35))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding(.vertical)
    }
}



struct ProjListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjListView(projectAllDataParcing.getDummy())
    }
}
