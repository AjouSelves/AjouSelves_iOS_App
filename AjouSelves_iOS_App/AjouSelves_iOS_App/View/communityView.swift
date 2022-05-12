//
//  communityView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct communityView: View {
    
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    
    var body: some View {
        NavigationView {
            List(ProductDataViewModel.projectAllDataParcings, id: \.self) { adata in
                //ProjListView(adata)
                //print(adata)
                NavigationLink(
                    destination: Text("Test"),
                        label: {
                            //Text("Test")
                            ProjListView(adata)
                        })
            }
        }
        
    }
}

struct communityView_Previews: PreviewProvider {
    static var previews: some View {
        communityView()
    }
}
