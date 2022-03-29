//
//  mainView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        //펀딩 목록 불러오기
        NavigationView{
            //test List
            List(1...10, id: \.self) { index in
                NavigationLink(
                    destination: Text("아이템 \(index) 번 의 세부사항"),
                        label: {
                            Text("아이템 \(index)")
                    })
            }
            //test code exit
            .navigationTitle("홈화면")
        }
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
