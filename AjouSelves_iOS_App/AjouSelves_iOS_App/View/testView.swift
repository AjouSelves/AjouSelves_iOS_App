//
//  testView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct testView: View {
    var body: some View {
        ZStack{
            TabView{
                mainView()
                    .tabItem{
                        Label("홈", systemImage: "house")
                    }
                
                communityView()
                    .tabItem{
                        Label("커뮤니티", systemImage: "person.3")
                    }
                
                mypageView()
                    .tabItem{
                        Label("마이페이지", systemImage: "person")
                    }
                
                settingView()
                    .tabItem{
                        Label("설정", systemImage: "gear")
                    }
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        BuyingView()
                        print("Testing Plus Button")
                    }, label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    
                }
            }
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
