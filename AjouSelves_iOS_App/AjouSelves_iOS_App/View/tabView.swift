//
//  testView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct tabView: View {
    
    @State var uiTabarController: UITabBarController?
    @ObservedObject var viewrouter: viewRouter
    
    var body: some View {
        ZStack{
            TabView{
                homeView()
                    .tabItem{
                        Label("홈", systemImage: "house")
                    }
                
                communityView()
                    .tabItem{
                        Label("커뮤니티", systemImage: "person.3")
                    }
                
                mypageView(viewrouter: viewRouter())
                    .tabItem{
                        Label("마이페이지", systemImage: "person")
                    }
                
                settingView()
                    .tabItem{
                        Label("설정", systemImage: "gear")
                    }
            }
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        tabView(viewrouter: viewRouter())
    }
}
