//
//  ContentView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/08.
//

import SwiftUI
import KakaoSDKUser

struct ContentView: View {
    var body: some View {
        VStack{
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
            }, label: {
                Text("KakaoLogin")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
