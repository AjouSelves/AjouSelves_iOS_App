//
//  homeView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI
import URLImage

struct homeView: View {
    @ObservedObject var ProductDataViewModel = productdataViewModel()
    @State var isPresent: Bool = false
    @State var showmodal = true
    
    init() {
        ProductDataViewModel.refreshProj()
    }
    
    var body: some View {
        NavigationView{
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
                ProductDataViewModel.refreshProj()
            }
            .padding(-15)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: searchView(),
                        label: {
                            Image(systemName: "magnifyingglass")
                        })
                    NavigationLink(
                        destination: sellingView(sellingVM: sellingViewModel()),
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
            .sheet(isPresented: self.$showmodal){
                processPopUpView()
            }
        }
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
