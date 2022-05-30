//
//  communityView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI
import URLImage

struct communityView: View {
    
    //MARK: 테스팅
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    
    init() {
        ProductDataViewModel.refreshPostAll()
    }
    
    var body: some View {
        NavigationView {
            List(ProductDataViewModel.postAllDatas, id: \.self) { adata in
                NavigationLink(
                    destination: communityDetailView(adata),
                        label: {
                            communityListView(adata)
                        })
            }
            .setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
            // iOS 15부터 지원...
            .refreshable {
                //productDataViewModel.init()
                ProductDataViewModel.refreshPostAll()
            }.toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: Text("검색"),
                            label: {
                                Image(systemName: "magnifyingglass")
                    })
                    NavigationLink(
                        destination: communityAddView(productdataVM: productDataViewModel()),
                            label: {
                                Image(systemName: "plus")
                    })
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
            .padding(-15)
        }
    }
}

struct communityView_Previews: PreviewProvider {
    static var previews: some View {
        communityView()
    }
}
