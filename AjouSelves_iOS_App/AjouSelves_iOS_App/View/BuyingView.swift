//
//  BuyingView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/07.
//

import Foundation
import SwiftUI
import Combine // 바인딩

//MARK:- 텍스트필드, 사진

struct BuyingView : View {
    var body: some View {
        NavigationView{
            NavigationLink {
                Text("Testing")
            } label: {
                Text("Testing")
            }
            .navigationTitle("구매")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarHidden(false)
        }
    }
}

struct BuyingView_Previews: PreviewProvider {
    static var previews: some View {
        BuyingView()
    }
}

