//
//  BuyingView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/07.
//

import Foundation
import SwiftUI
import Combine // 바인딩
import Photos
import PhotosUI

//MARK: - 텍스트필드, 사진
struct sellingView : View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // 창 자동 종료를 위한 Environment
    
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    @State var isChecked: Bool = false
    
    //MARK: - [proj] pjor/add
    @State var title: String = ""
    @State var explained: String = ""
    @State var min_num: Int = 0
    @State var category: String = ""
    @State var required: [String] = [""]
    
    @ObservedObject var sellingVM: sellingViewModel
    
    //MARK: - [Testing] 사진추가
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    
    @State var placeholderText: String = "여기를 눌러 내용을 입력해주세요!👈"
    
    let numFormatter: NumberFormatter = {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter
    }()
    
    //MARK: - homeView
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("사진등록")
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
                                            //sellingVM.projAdd_Photo(imageData: item.photo)
                                            sellingVM.photoData = item.photo!
                                        }
                                }
                                //                                else if item.mediaType == .video {
                                //                                    if let url = item.url {
                                //                                        VideoPlayer(player: AVPlayer(url: url))
                                //                                            .frame(minHeight: 200)
                                //                                    } else { EmptyView() }
                                //                                }
                                
                                //                                Image(systemName: getMediaImageName(using: item)) // 상단 사진아이콘 추가
                                //                                    .resizable()
                                //                                    .aspectRatio(contentMode: .fit)
                                //                                    .frame(width: 24, height: 24)
                                //                                    .padding(4)
                                //                                    .background(Color.black.opacity(0.5))
                                //                                    .foregroundColor(.white)
                            }
                        }
                        //                        .navigationBarItems(leading: Button(action: {
                        //                            mediaItems.deleteAll()
                        //                        }, label: {
                        //                            Image(systemName: "trash")
                        //                                .foregroundColor(.red)
                        //                        }), trailing: Button(action: {
                        //                            showSheet = true
                        //                        }, label: {
                        //                            Image(systemName: "plus")
                        //                        }))
                        Text("굿즈의 사진을 등록해 주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }//.listRowBackground(Color.clear)
                    Group{
                        Section(header: Text("제목")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        ){
                            TextField("클릭하고 입력" , text: $title)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                            Text("굿즈의 제목을 입력해 주세요👆")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 13))
                        }
                        Section(header: Text("내용")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        ){
                            ZStack {
                                if self.explained.isEmpty {
                                    TextEditor(text: $placeholderText)
                                        .font(.body)
                                        .foregroundColor(.gray)
                                        .disabled(true)
                                }
                                TextEditor(text: $explained)
                                    .font(.body)
                                    .opacity(self.explained.isEmpty ? 0.25 : 1)
                                    .disableAutocorrection(true)
                            }
                        }
                        Section(header: Text("최소인원")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        ){
                            TextField("펀딩 최소인원을 입력해 주세요." , value: $min_num, formatter: numFormatter)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .disableAutocorrection(true)
                                .background(Color.clear)
                            Text("굿즈의 최소 모집인원 입력해 주세요👆")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 13))
                        }
                        Section(header: Text("카테고리")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        ){
                            TextField("클릭하고 입력" , text: $category)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                            Text("굿즈의 카테고리를 입력해 주세요👆예) 의류, 다이어리")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 13))
                        }
                    }
//                    Button {
//                        print("펀딩(사진x) 등록 버튼 clicked")
//                        sellingVM.title = title
//                        sellingVM.explained = explained
//                        sellingVM.min_num = min_num
//                        sellingVM.category = category
//                        sellingVM.required = required
//                        sellingVM.send()
//                    } label: {
//                        Text("등록")
//                    }
//
                    Button {
                        print("펀딩(사진1) 등록 버튼 clicked")
                        sellingVM.title = title
                        sellingVM.explained = explained
                        sellingVM.min_num = min_num
                        sellingVM.category = category
                        sellingVM.required = required
                        sellingVM.projAddConfirm()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            if sellingVM.projAddSuccess == true {
                                sellingVM.projAdd_Photo()
                                self.isChecked = true
                            }
                        }
                    } label: {
                        Text("굿즈 등록🤙").bold()
                    }
                }
                .background(Color.white)
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                })
                .navigationBarTitle("굿즈", displayMode: .inline)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            .sheet(isPresented: $showSheet, content: {
                PhotoPicker(mediaItems: mediaItems) { didSelectItem in
                    // Handle didSelectItems value here...
                    showSheet = false
                }
            })
            .alert(isPresented: $isChecked, content: {
                Alert(title: Text("등록 완료!"), message: Text("펀딩이 정상적으로 등록되었습니다!"), dismissButton: .default(Text("확인")){
                    self.presentationMode.wrappedValue.dismiss() // 확인 버튼을 누르면 창 자동 종료
                })
            })
        }
        .setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar비활성화
    }
    
    fileprivate func getMediaImageName(using item: PhotoPickerModel) -> String {
        switch item.mediaType {
        case .photo: return "photo"
        case .video: return "video"
        case .livePhoto: return "livephoto"
        }
    }
}

struct BuyingView_Previews: PreviewProvider {
    static var previews: some View {
        sellingView(sellingVM: sellingViewModel())
    }
}
