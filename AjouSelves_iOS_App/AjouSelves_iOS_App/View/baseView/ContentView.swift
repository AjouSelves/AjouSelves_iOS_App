//
//  ContentView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/08.
//

import SwiftUI
import KakaoSDKUser
import Combine

struct ContentView: View {
    
    @State var userId: String = ""
    @State var userPassword: String = ""
    @State private var willMoveToNextScreen = false
    @State var isLoginFail: Bool = false
    
    @ObservedObject var productdataVM: productdataViewModel
    @ObservedObject var viewrouter: viewRouter
    
    //var RegisterView = registerView()
    
    var body: some View {
        NavigationView {
            VStack{
                Image("로고_PNG")
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                Divider()
                HStack{
                    VStack{
                        TextField("아이디", text: $userId)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        SecureField("비밀번호", text: $userPassword)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }.padding()
                    Spacer()
                    Button(action: {
                        productdataVM.loginEmail = userId
                        productdataVM.loginPassword = userPassword
                        productdataVM.authLogin()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3) {
                            if productdataVM.loginisSuccess == true {
                                self.viewrouter.currentPage = "tabView"
                            } else {
                                self.isLoginFail = true
                            }
                        }
                    }, label: {
                        Text("확인").frame(minWidth: 80, minHeight: 50).background(.black)
                    }).frame(minWidth: 90, minHeight: 100)
                }
                Spacer()
                HStack{
                    Text("아직 굿즈바이어스 계정이 없으신가요?").foregroundColor(Color.gray)
                    NavigationLink(destination: {
                        registerView(productdataVM: productdataViewModel())
                    }, label: {
                        Text("회원가입")
                    })
                }
                Divider()
                
                //MARK: KakaoLoginTestButton
                Button(action: {
                    if (UserApi.isKakaoTalkLoginAvailable()){
                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                            if let error = error{
                                print(error)
                            }
                            else{
                                print("Success")
                                
                                _ = oauthToken
                            }
                        }
                    } else {
                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                            if let error = error {
                                print(error)
                            } else {
                                print("loginWithKakaoAccount() success.")
                                _ = oauthToken
                            }
                        }
                    }
                }){
                    Image("LoginButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width:150)
                }
                Spacer()
                    .alert(isPresented: $isLoginFail, content: {
                        Alert(title: Text("로그인 실패"), message: Text("다시 시도하여 주십시오."), dismissButton: .default(Text("확인")))
                    })
            }
            //.navigationTitle("메인화면")
            //.navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(productdataVM: productdataViewModel(), viewrouter: viewRouter())
    }
}
