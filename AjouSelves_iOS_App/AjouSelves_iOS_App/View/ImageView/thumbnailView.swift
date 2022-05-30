//
//  MainImgView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/31.
//

import Foundation
import SwiftUI
import URLImage

struct thumbnailView: View {
    
    var imageUrl: URL
    
    var body: some View {
        URLImage(imageUrl) { image in
            image
                .resizable()
                //.aspectRatio(contentMode: .fit).clipped(antialiased: true)
                //.aspectRatio(contentMode: .fill).clipped(antialiased: true)
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 130, height: 130)
    }
}

struct MainImgView_Previews: PreviewProvider {
    static var previews: some View {
        
        let url = URL(string: "http://goodsbyus.com/photo/1653782114124-b1-1_04.png")!
        
        thumbnailView(imageUrl: url)
    }
}
