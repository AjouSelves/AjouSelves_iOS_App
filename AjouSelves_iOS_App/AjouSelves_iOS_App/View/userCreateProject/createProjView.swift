//
//  createProjView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/26.
//

import SwiftUI

struct createProjView: View {
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    
    init( ){
        ProductDataViewModel.refreshCreateProj()
    }
    
    var body: some View {
        
        List(ProductDataViewModel.userCreateDetails, id: \.self) { adata in
            NavigationLink(
                destination: userCreateProjDetailView(adata)
                ,label: {
                    userCreateProjListView(adata)
                })
        }
        .setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
        // iOS 15부터 지원...
        .refreshable {
            ProductDataViewModel.refreshCreateProj()
            //                ProductDataViewModel.refreshProj()
        }
        .navigationBarTitle("리스트", displayMode: .inline)
        .padding(-15)
    }
}

struct createProjView_Previews: PreviewProvider {
    static var previews: some View {
        createProjView()
    }
}
