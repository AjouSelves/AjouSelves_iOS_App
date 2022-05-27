//
//  processPopUpView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/26.
//

import SwiftUI

struct processPopUpView: View {
    var body: some View {
        TabView {
            ForEach(1..<4) { i in
                ZStack {
                    Image("프로세스_\(i)").resizable()
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding()
            Button(action: {
                homeView().processImgDisabled = true
                print(homeView().processImgDisabled)
            }, label: {
                Text("확인했습니다!")
            })
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct processPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        processPopUpView()
    }
}
