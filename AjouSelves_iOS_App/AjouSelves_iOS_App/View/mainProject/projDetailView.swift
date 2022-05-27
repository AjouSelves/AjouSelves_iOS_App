//
//  projDetailView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/13.
//

import Foundation
import SwiftUI

struct projDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var productDataVM = productDataViewModel()
    @State var fundingClicked: Bool = false
    
    var prdData: projectAllDataParcing
    
    init(_ prdData : projectAllDataParcing) {
        self.prdData = prdData
    }
    
    var body: some View {
        //        return GeometryReader { proxy in
        //                    ScrollView(.horizontal) {
        //                        HStack(spacing: 0) {
        //                            projImgView(imageUrl: prdData.profileImgUrl)
        //                            .frame(width: proxy.size.width, height: proxy.size.height)
        //                        }
        //                    }
        //        }
        ////                    }.onAppear {
        ////                        UIScrollView.appearance().isPagingEnabled = true
        ////                    }
        
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
                Button(action: {
                    print("Clicked 펀딩참여")
                    self.fundingClicked = true
                    productDataVM.projJoin(id: prdData.description_projid)
                }, label: {
                    Text("이 펀딩에 참여하기")
                }).alert(isPresented: $fundingClicked, content: {
                    Alert(title: Text("축하합니다🎉"), message: Text("펀딩에 성공하셨습니다!"), dismissButton: .default(Text("확인"), action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }))
                })
            }
            
//            .toolbar{
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        productDataVM.projDelete(url: projDeleteUrl+"\(prdData.description_projid)")
//                    }, label:{
//                        Image(systemName: "trash")
//                    })
//                }
//            }
        }
        .setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
}

struct projDetailView_Previews: PreviewProvider {
    static var previews: some View {
        projDetailView(projectAllDataParcing.getDummy())
    }
}
