//
//  QRAddView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/31.
//

import Foundation
import SwiftUI
import Combine
import Photos
import PhotosUI

struct QRAddView: View {
    
    @State private var showSheet = false
    @State var link: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
    
    @ObservedObject var productVM = productdataViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("결제QR 등록")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
                        + Text("*")
                    .foregroundColor(Color.red)
                    .font(.system(size: 20))
                ){
                    Button(action: {
                        showSheet = true
                    }, label: {
                        Label("사진 추가", systemImage: "plus")
                    })
                    List(mediaItems.items, id: \.id) { item in
                        ZStack(alignment: .topLeading) {
                            if item.mediaType == .photo {
                                Image(uiImage: item.photo ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onAppear() {
                                        productVM.QRPhoto = item.photo!
                                    }
                            }
                        }
                    }
                }
                Text("결제 QR을 등록해 주세요👆")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 13))
                Section(header: Text("결제링크 등록")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
                        + Text("*")
                    .foregroundColor(Color.red)
                    .font(.system(size: 20))
                ){
                    TextField("클릭하고 입력", text: $link)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                    Text("결제 링크를 입력해 주세요👆")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                }
                Button {
                    print("펀딩(사진1) 등록 버튼 clicked")
                    productVM.QRlink = link
                    productVM.projPayQr()
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
//
//                    }
                } label: {
                    Text("결제 등록🤙").bold()
                }
                //            .alert(isPresented: $showAlert) {
                //                switch isChecked {
                //                case .success:
                //                    return Alert(title: Text("등록 완료!"), message: Text("펀딩이 정상적으로 등록되었습니다!"), dismissButton: .default(Text("확인")){
                //                        self.presentationMode.wrappedValue.dismiss() // 확인 버튼을 누르면 창 자동 종료
                //                    })
                //                case .fail:
                //                    return Alert(title: Text("등록 실패"), message: Text("펀딩 등록에 실패하였습니다"), dismissButton: .default(Text("확인")))
                //                }
                //            }
            }
            //.setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
        }
        .background(Color.white)
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        })
        .sheet(isPresented: $showSheet, content: {
            PhotoPicker(mediaItems: mediaItems) { didSelectItem in
                // Handle didSelectItems value here...
                showSheet = false
            }
        })
    }
}

struct QRAddView_Previews: PreviewProvider {
    static var previews: some View {
        QRAddView()
    }
}
