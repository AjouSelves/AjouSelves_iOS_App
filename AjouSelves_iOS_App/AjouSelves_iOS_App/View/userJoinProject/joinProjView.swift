//
//  joinProjView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/26.
//

import SwiftUI

struct joinProjView: View {
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    
    init( ){
        ProductDataViewModel.refreshJoinProj()
    }
    
    var body: some View {
        List(ProductDataViewModel.userJoinDetails, id: \.self) { adata in
            NavigationLink(
                destination: userJoinProjDetailView(adata),
                label: {
                    userJoinProjListView(adata)
                })
        }
        //.setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
        // iOS 15부터 지원...
        .refreshable {
            ProductDataViewModel.refreshJoinProj()
        }
        .padding(-15)
        .navigationBarTitle("리스트", displayMode: .inline)
    }
}

struct joinProjView_Previews: PreviewProvider {
    static var previews: some View {
        joinProjView()
    }
}
