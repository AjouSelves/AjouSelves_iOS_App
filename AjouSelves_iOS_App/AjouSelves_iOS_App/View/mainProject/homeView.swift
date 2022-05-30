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
    @State var processImgDisabled: Bool = false
    
    init() {
        ProductDataViewModel.refreshProj()
    }
    
    var body: some View {
        //펀딩 목록 불러오기
        NavigationView{
//            Image("메인배너")
//                .resizable()
//                .scaledToFit()
            
//            TabView {
//                ForEach(1..<4) { i in
//                    ZStack {
//                        Image("프로세스_\(i)").resizable()
//                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
//                }
//                .padding()
//                Button(action: {
//                    processImgDisabled = true
//                }, label: {
//                    Text("확인했습니다!")
//                })
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .disabled(processImgDisabled)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            Image("메인배너")
            //processPopUpView().disabled(processImgDisabled)
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
            .padding(-15)
        }
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
