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
    @ObservedObject var ProductDataViewModel = productdataViewModel()
    
    init() {
        ProductDataViewModel.refreshPostAll()
    }
    
    var body: some View {
        List(ProductDataViewModel.postAllDatas, id: \.self) { adata in
            NavigationLink(
                destination: communityDetailView(adata),
                label: {
                    communityListView(adata)
                })
        }
        //.setTabBarVisibility(isHidden: false) // 다시 뷰로 돌아오면 TabBar활성화
        // iOS 15부터 지원...
        .refreshable {
            //productDataViewModel.init()
            ProductDataViewModel.refreshPostAll()
        }
        .padding(-15)
    }
}

struct communityView_Previews: PreviewProvider {
    static var previews: some View {
        communityView()
    }
}
