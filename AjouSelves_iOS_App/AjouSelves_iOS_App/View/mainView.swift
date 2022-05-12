//
//  mainView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI
import URLImage

struct mainView: View {
    
    @ObservedObject var ProductDataViewModel = productDataViewModel()
    @State var isPresent: Bool = false
    
    var body: some View {
        //펀딩 목록 불러오기
        NavigationView{
//            List(ProductDataViewModel.productDatas) { adata in
//                NavigationLink(
//                    destination: URLImage(URL(string: adata.photo.large)!) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .onTapGesture(count: 2, perform: {
//                                self.isPresent = true
//                                //여기에 좋아요 한 항목 추가
//                            })
//                    }, label: {
//                        ListView(adata)
//                    })
//            }
//            .frame(height: 600)
            
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
            // iOS 15부터 지원...
            .refreshable {
                productDataViewModel.init()
                ProductDataViewModel.refreshProj()
            }

//            .alert(isPresented: $isPresent, content: {
//                Alert(title: Text("좋아요"), message: Text("하셨습니다!"), dismissButton: .default(Text("OK")))
//            })
            //.navigationTitle("펀딩 목록")
            //.navigationBarTitleDisplayMode(.automatic)
            .toolbar{
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
                        Text("아주대")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.black)
                        
                    })
                }
            }
            //.frame(height: 700)
            // .border(Color.blue) // Title밑 Tabview밑의 파란 줄Spacer()
            .padding(-15)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
