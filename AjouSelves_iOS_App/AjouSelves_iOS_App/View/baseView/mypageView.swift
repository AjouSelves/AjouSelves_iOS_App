//
//  mypageView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct mypageView: View {
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
                .padding(-15)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        NavigationLink(
                            destination: Text("아직 알림이 없군요🔔"),
                            label: {
                                Image(systemName: "bell")
                            })
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            print("Clicked4")
                        }, label: {
                            Image("로고_PNG2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 170, height: 170, alignment: .leading)
                        })
                    }
                }
                .setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
            }
        }
    }
}

struct mypageView_Previews: PreviewProvider {
    static var previews: some View {
        mypageView()
    }
}
