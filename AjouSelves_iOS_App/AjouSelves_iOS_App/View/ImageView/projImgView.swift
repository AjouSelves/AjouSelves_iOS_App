//
//  projImgView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/16.
//

import Foundation
import SwiftUI
import URLImage

struct projImgView: View {
    var imageUrl: URL
    
    var body: some View {
        
        URLImage(imageUrl) { image in
            image
                .resizable()
                //.aspectRatio(contentMode: .fit)
                .aspectRatio(contentMode: .fill)//.clipped(antialiased: true) // 사진 정방향으로 잘라서 보여줌
        }
        .frame(width: 400, height: 400)
    }
}

struct projImgView_Previews: PreviewProvider {
    static var previews: some View {
        
        let url = URL(string: "https://randomuser.me/api/portraits/women/21.jpg")!
        
        projImgView(imageUrl: url)
    }
}
