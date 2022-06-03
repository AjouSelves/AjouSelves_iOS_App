//
//  userCreateProjDetailView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/26.
//

import SwiftUI

struct userCreateProjDetailView: View {
    @ObservedObject var productDataVM = productDataViewModel()
    
    var projDeleteUrl = "http://goodsbyus.com/api/proj/" // 특정 프로젝트 삭제
    
    var prdData: userCreate.userCreateDetail
    
    init(_ prdData : userCreate.userCreateDetail) {
        self.prdData = prdData
    }
    var body: some View {
        VStack{
            ScrollView{
                ScrollView(.horizontal) {
                    projImgView(imageUrl: prdData.profileImgUrl)
                }
                Divider()
                Spacer()
                VStack(alignment: .leading){
                    Text("\(prdData.description_category)")
                        .font(.system(size: 20))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.gray)
                    
                    Text("\(prdData.description_title)")
                        .font(.system(size: 40))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("모인 인원")
                        .font(.system(size: 20))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.gray)
                    Text("\(prdData.description_curnum)명")
                        .font(.system(size: 35))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                }.frame(width: 350, height: 70, alignment: .leading).padding()
                Divider()
                VStack(alignment: .leading){
                    Text("펀딩완료 최소 인원")
                        .font(.system(size: 20))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.gray)
                    Text("\(prdData.description_minnum)명")
                        .font(.system(size: 35))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                }.frame(width: 350, height:30, alignment: .leading).padding()
                Divider()
                VStack(alignment: .leading){
                    Text("\(prdData.description_explained)")
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.5)
                        .padding()
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack{
                        Button(action: {
                            productDataVM.projDelete(url: projDeleteUrl+"\(prdData.description_projid)")
                        }, label:{
                            Image(systemName: "trash")
                        })
                        NavigationLink (destination: {
                            QRAddView()
                        }, label: {
                            Image(systemName: "pencil")
                        })
                    }
                }
                
            }
        }
        //.navigationBarTitle("")
        //.setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
}

struct userCreateProjDetailView_Previews: PreviewProvider {
    static var previews: some View {
        userCreateProjDetailView(userCreate.userCreateDetail.getDummy())
    }
}
