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
        NavigationView{
            TabView{
                homeView()
                    //.tag(toolbarState.home)
                    .tabItem{
                        Label("홈", systemImage: "house")
                    }
                
                communityView()
                    //.tag(toolbarState.community)
                    .tabItem{
                        Label("커뮤니티", systemImage: "person.3")
                    }
                
                mypageView()
                    //.tag(toolbarState.mypage)
                    .tabItem{
                        Label("마이페이지", systemImage: "person")
                    }
                
                settingView()
                    //.tag(toolbarState.setting)
                    .tabItem{
                        Label("설정", systemImage: "gear")
                    }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: searchView(),
                        label: {
                            Image(systemName: "magnifyingglass")
                        })
                    
//                    Menu{
//
//                    } label: {
//                        Image(systemName: "plus")
//                    }
                    NavigationLink(
                        destination: sellingView(sellingVM: sellingViewModel()),
                        label: {
                            //Image(systemName: "plus")
                            Text("굿즈")
                        })
                    NavigationLink(
                        destination: communityAddView(productdataVM: productdataViewModel()),
                        label: {
                            //Image(systemName: "plus")
                            Text("커뮤니티")
                        })
                    
                    //                    Button(action: {}, label: {
                    //                        if self.stateOfMemu == .home {
                    //                            NavigationLink(
                    //                                destination: sellingView(sellingVM: sellingViewModel()),
                    //                                label: {
                    //                                    Image(systemName: "plus")
                    //                                })
                    //                        } else {
                    //                            NavigationLink(
                    //                                destination: communityAddView(productdataVM: productDataViewModel()),
                    //                                label: {
                    //                                    Image(systemName: "plus")
                    //                                })
                    //                        }
                    //                    })
                    
                    //                    NavigationLink(
                    //                        destination: sellingView(sellingVM: sellingViewModel()),
                    //                        label: {
                    //                            Image(systemName: "plus")
                    //                        })
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
            .navigationBarTitle("메인")
            .navigationTitle("메인2")
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        tabView(viewrouter: viewRouter())
    }
}
