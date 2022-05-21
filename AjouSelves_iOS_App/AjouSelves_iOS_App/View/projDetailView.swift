//
//  projDetailView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/13.
//

import Foundation
import SwiftUI

struct projDetailView: View {
    @ObservedObject var productDataVM = productDataViewModel()
    
    var projDeleteUrl = "http://52.206.105.200:3000/proj/delete/" // 특정 프로젝트 삭제
    
    var prdData: projectAllDataParcing
    
    init(_ prdData : projectAllDataParcing) {
        self.prdData = prdData
    }
    
    var body: some View {
        VStack{
            Button(action: {
                productDataVM.projDelete(url: projDeleteUrl+"\(prdData.description_projid)")
            }, label:{
                Image(systemName: "trash")
            })
            ScrollView{
                ScrollView(.horizontal) {
                    projImgView(imageUrl: prdData.profileImgUrl)
                }
                Divider()
                Spacer()
                VStack{
                    Text("\(prdData.description_title)")
                        .font(.system(size: 30))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                    Text("\(prdData.description_category)")
                        .font(.system(size: 20))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.5)
                }
            }
            Spacer()
            Button(action:{
                print("Clicked 펀딩참여")
            }, label: {
                Text("펀딩참여")
            })
        }
        .setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
}

struct projDetailView_Previews: PreviewProvider {
    static var previews: some View {
        projDetailView(projectAllDataParcing.getDummy())
    }
}
