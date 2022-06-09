//
//  communityDetailView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/27.
//

import SwiftUI

struct communityDetailView: View {
    @ObservedObject var productDataVM = productdataViewModel()
    @State var comment: String = ""
    
    var postDeleteUrl = "http://goodsbyus.com/api/post/" // 특정 프로젝트 삭제
    
    var prdData: postStruct.postAllData
    
    init(_ prdData : postStruct.postAllData) {
        self.prdData = prdData
    }
    
    var body: some View {
        VStack{
            ScrollView{
                Spacer(minLength: 100)
                ScrollView(.horizontal) {
                    projImgView(imageUrl: prdData.profileImgUrl)
                }
                Divider()
                Spacer()
                VStack(alignment: .leading){
                    Text("\(prdData.description_nickname)")
                        .font(.system(size: 20))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.gray)
                    Text("\(prdData.description_created_at)")
                        .font(.system(size: 40))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text("\(prdData.description_title)")
                        .font(.system(size: 40))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                }.frame(width: 350, height: 70, alignment: .leading).padding()
                VStack(alignment: .leading){
                    Text("\(prdData.description_explained)")
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.5)
                        .padding()
                }
                VStack(alignment: .leading){
                    Text("댓글🙌")
                    HStack{
                        TextField("우리 모두 깨끗한 커뮤니티를 만들어요", text: $comment)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                        Button(action: {
                            print("전송")
                        }, label: {
                            Text("전송")
                        }).padding()
                    }
                    Divider()
                }.frame(width:350)
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack{
                        Button(action: {
                            productDataVM.postDelete(url: postDeleteUrl+"\(prdData.description_postid)")
                        }, label:{
                            Image(systemName: "trash")
                        })
//                        NavigationLink (destination: {
//                            userCreateProjEditView(userCreate.userCreateDetail.getDummy())
//                        }, label: {
//                            Image(systemName: "pencil")
//                        })
                    }
                }
            }
        }
        .ignoresSafeArea()
        .setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
}

struct communityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        communityDetailView(postStruct.postAllData.getDummy())
    }
}
