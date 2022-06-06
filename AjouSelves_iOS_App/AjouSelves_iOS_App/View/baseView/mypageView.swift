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
            //NavigationView {
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
                    
//                    Button(action: {
//                        self.viewrouter.currentPage1 = "ContentView"
//                        self.viewrouter.currentPage = "ContentView"
//                    }, label: {
//                        Text("로그아웃 테스트")
//                    })
                    
                    Button(action: {
                        print("회원정보 수정 Clicked")
                    }, label: {
                        Text("회원정보 수정")
                    })
                    
                    Button(action: {
                        print("회원 탈퇴 Clicked")
                    }, label: {
                        Text("회원 탈퇴")
                    })
                }
//                .navigationBarTitle("마이페이지")
//                .navigationBarHidden(true)
            //}
        }
        //.setTabBarVisibility(isHidden: false)
    }
}

struct mypageView_Previews: PreviewProvider {
    static var previews: some View {
        mypageView(viewrouter: viewRouter())
    }
}
