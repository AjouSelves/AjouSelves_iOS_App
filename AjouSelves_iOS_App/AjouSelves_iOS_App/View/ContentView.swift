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
    
    @ObservedObject var productdataVM: productDataViewModel
    
    //var RegisterView = registerView()
    
    var body: some View {
        NavigationView {
            VStack{
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                Spacer()
                
                HStack{
                    VStack{
                        TextField("ID", text: $userId)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        TextField("PASSWORD", text: $userPassword)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    Button(action: {
                        productdataVM.loginEmail = userId
                        productdataVM.loginPassword = userPassword
                        productdataVM.authLogin(url: productdataVM.authLoginUrl)
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                            if productdataVM.loginisSuccess == true {
//                                print("login!!!")
//                                NavigationLink(destination: testView()){
//                                    Text("메인")
//                                        .navigationTitle("")
//                                        .navigationBarHidden(true)
//                                }
//                            }
//                        }
                    }, label: {
                        Text("확인").frame(minWidth: 80, minHeight: 50).background(.black)
                    }).frame(minWidth: 100, minHeight: 100)
                }
                
//                NavigationLink(destination: registerView(productdataVM: productDataViewModel())) {
//                    Text("회원가입")
//                        .navigationTitle("")
//                        .navigationBarHidden(true)
//                        .navigationBarBackButtonHidden(true)
//                }
                
                NavigationLink(destination: testView()) {
                    Text("회원가입")
                        .navigationTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
                
                // KakaoLoginTestButton
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
                        }
                    else{
                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    print("loginWithKakaoAccount() success.")

                                    //do something
                                    _ = oauthToken
                                }
                            }
                    }
                }){
                    Image("LoginButton")
                        .resizable()
                        .scaledToFit()
                }
            }
            //성공
            .navigationTitle("")
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(productdataVM: productDataViewModel())
    }
}
