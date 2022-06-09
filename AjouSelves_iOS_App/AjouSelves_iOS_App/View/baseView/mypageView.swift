//
//  mypageView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct mypageView: View {
    @State var logoutCheck: Bool = false
    @State var logdeleteCheck: Bool = false
    let logoutPrimaryButton = Alert.Button.default(Text("확인")){
        print("확인 클릭")
    }
    let logoutSecondaryButton = Alert.Button.cancel(Text("취소").foregroundColor(Color.red)){
        print("취소 클릭")
    }
    let logDeletePrimaryButton = Alert.Button.default(Text("확인")){
        print("확인 클릭")
    }
    let logDeleteSecondaryButton = Alert.Button.cancel(Text("취소").foregroundColor(Color.red)){
        print("취소 클릭")
    }
    var body: some View {
        VStack{
            NavigationView {
                VStack{
                    Form{
                        Section(header: Text("내 정보")){
                            Text("ID: ")
                        }
                        Section(header: Text("굿즈🧸")){
                            NavigationLink(destination: {
                                createProjView()
                            }, label: {
                                Text("내가 생성한 굿즈 확인하기")
                            })
                            
                            NavigationLink(destination: {
                                joinProjView()
                            }, label: {
                                Text("내가 참여한 굿즈 확인하기")
                            })
                        }
                        Section(header: Text("게시글📝")){
                            NavigationLink(destination: {
                                //createProjView()
                            }, label: {
                                Text("내가 작성한 게시글 확인하기")
                            })
                        }
                        
//                        Button(action: {
//                            print("로그아웃")
//                            self.logoutCheck = true
//                        }, label: {
//                            Text("로그아웃")
//                        })
                        
                        Button(action: {
                            print("회원정보 수정 Clicked")
                        }, label: {
                            Text("회원정보 수정")
                        })
                        
                        Button(action: {
                            print("회원 탈퇴 Clicked")
                            self.logdeleteCheck = true
                        }, label: {
                            Text("회원 탈퇴")
                                .foregroundColor(Color.red)
                        })
                    }
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
            .background(Color.white)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            })
//            .alert(isPresented: $logoutCheck){
//                Alert(title: Text("확인"), message: Text("정말 로그아웃 하시겠습니까?"), primaryButton: logoutPrimaryButton, secondaryButton: logoutSecondaryButton)
//            }
            .alert(isPresented: $logdeleteCheck){
                Alert(title: Text("확인"), message: Text("정말 탈퇴 하시겠습니까?"), primaryButton: logDeletePrimaryButton, secondaryButton: logDeleteSecondaryButton)
            }
        }
    }
}

struct mypageView_Previews: PreviewProvider {
    static var previews: some View {
        mypageView()
    }
}
