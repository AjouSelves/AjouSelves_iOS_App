//
//  homeView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI
import URLImage

struct homeView: View {
    
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    @State var isPresent: Bool = false
    
    var body: some View {
        //펀딩 목록 불러오기
        NavigationView{
//            Image("메인배너")
//                .resizable()
//                .scaledToFit()
            List(ProductDataViewModel.projectAllDataParcings, id: \.self) { adata in
                NavigationLink(
                    destination: projDetailView(adata),
                        label: {
                            ProjListView(adata)
                        })
            }
            .setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
            // iOS 15부터 지원...
            .refreshable {
                //productDataViewModel.init()
                ProductDataViewModel.refreshProj()
            }.toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: Text("검색"),
                            label: {
                                Image(systemName: "magnifyingglass")
                    })
                    NavigationLink(
                        destination: sellingView(sellingVM: sellingViewModel()),
                            label: {
                                Image(systemName: "plus")
                    })
                    NavigationLink(
                        destination: Text("알림센터"),
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
            .padding(-15)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
