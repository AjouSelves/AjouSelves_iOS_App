//
//  ListView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/31.
//

import Foundation
import SwiftUI

struct ListView : View {
    
    var prdData : productData
    
    init(_ prdData : productData) {
        self.prdData = prdData
    }
    
    var body: some View {
        HStack{
            MainImgView(imageUrl: prdData.profileImgUrl)
            Text("\(prdData.description)")
                .fontWeight(.heavy)
                .font(.system(size: 25))
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .minimumScaleFactor(0.5)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding(.vertical)
    }
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(productData.getDummy())
    }
}
