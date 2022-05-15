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
            NavigationView{
                List{
                    Text("데이터데이터데이터데이터데이터데이터데이터")
                    Text("데이터데이터데이터데이터데이터데이터데이터")
                }
                .padding(-15)
            }
            Button(action: {
                self.viewrouter.currentPage = "ContentView"
                startView(viewrouter: viewRouter())
            }, label: {
                Text("로그아웃 테스트")
            })
        }
    }
}

struct mypageView_Previews: PreviewProvider {
    static var previews: some View {
        mypageView(viewrouter: viewRouter())
    }
}
