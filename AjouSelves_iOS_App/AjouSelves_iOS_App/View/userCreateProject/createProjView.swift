//
//  createProjView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/26.
//

import SwiftUI

struct createProjView: View {
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    
    var body: some View {
//        NavigationView{
//            List(ProductDataViewModel.userCreateDetails, id: \.self) { adata in
//                NavigationLink(
//                    destination: userCreateProjDetailView(adata),
//                        label: {
//                            userCreateProjListView(adata)
//                        })
//            }
//            .setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
//            // iOS 15부터 지원...
//            .refreshable {
//                //productDataViewModel.init()
//                ProductDataViewModel.refreshCreateProj()
//            }
//        }
        NavigationView {
            List(ProductDataViewModel.projectAllDataParcings, id: \.self) { adata in
                //ProjListView(adata)
                //print(adata)
                NavigationLink(
                    destination: projDetailView(adata),
                        label: {
                            //Text("Test")
                            ProjListView(adata)
                        })
            }
            .padding(-15)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct createProjView_Previews: PreviewProvider {
    static var previews: some View {
        createProjView()
    }
}
