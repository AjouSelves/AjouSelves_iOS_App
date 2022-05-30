//
//  mypageView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct mypageView: View {
    
    @ObservedObject var viewrouter: viewRouter
    
    var body: some View {
        VStack{
            NavigationView {
                VStack{
                    NavigationLink(destination: {
                        createProjView()
                    }, label: {
                        Text("내가 생성한 굿즈")
                    })
                    
                    NavigationLink(destination: {
                        joinProjView()
                    }, label: {
                        Text("내가 참여한 굿즈")
                    })
                }
                .navigationBarTitle("마이페이지", displayMode: .inline)
                .navigationBarHidden(true)
                //.navigationBarBackButtonHidden(true)
            }
//            Button(action: {
//                self.viewrouter.currentPage = "ContentView"
//                startView(viewrouter: viewRouter())
//            }, label: {
//                Text("로그아웃 테스트")
//            })
        }
        .setTabBarVisibility(isHidden: false) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
}

struct mypageView_Previews: PreviewProvider {
    static var previews: some View {
        mypageView(viewrouter: viewRouter())
    }
}
