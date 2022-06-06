//
//  testView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

enum toolbarState {
    case home, community, mypage, setting
}

struct tabView: View {
    @State var uiTabarController: UITabBarController?
    @State var toolBarConttoller: UIToolbar?
    @State var stateOfMemu: toolbarState = .home
    @ObservedObject var viewrouter: viewRouter
    
    //    init() {
    //        UIToolbar.appearance().barTintColor = .white
    //    }
    
    var body: some View {
        //toolBarConttoller?.backgroundColor = .white
        
            TabView{
                homeView()
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
            .ignoresSafeArea()
            .background(Color.white)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            })
        
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        tabView(viewrouter: viewRouter())
    }
}
