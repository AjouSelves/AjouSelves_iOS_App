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

//struct PhotoPicker: UIViewControllerRepresentable {
//  let configuration: PHPickerConfiguration
//  @Binding var isPresented: Bool
//  func makeUIViewController(context: Context) -> PHPickerViewController {
//    let controller = PHPickerViewController(configuration: configuration)
//    controller.delegate = context.coordinator
//    return controller
//  }
//
//  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
//  func makeCoordinator() -> Coordinator {
//    Coordinator(self)
//  }
//
//  // Use a Coordinator to act as your PHPickerViewControllerDelegate
//  class Coordinator: PHPickerViewControllerDelegate {
//    private let parent: PhotoPicker
//
//    init(_ parent: PhotoPicker) {
//      self.parent = parent
//    }
//
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//      print(results)
//      parent.isPresented = false // Set isPresented to false because picking has finished.
//    }
//  }
//}

//MARK: - 텍스트필드, 사진

struct sellingView : View {
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
                    Section(header: Text("Photo_1")) {
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
                                            sellingVM.projAddSingle(imageData: item.photo)
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
                    }
                    
                    Section(header: Text("제목")) {
                        TextField("글 재목" , text: $title)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        //Text("\(title)")
                    }
                    Section(header: Text("내용")) {
                        TextField("게시글 내용을 작성해주세요." , text: $explained)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        //Text("\(text)")
                    }
                    Section(header: Text("최소인원")) {
                        TextField("펀딩 최소인원을 입력해 주세요." , value: $min_num, formatter: numFormatter)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                            .disableAutocorrection(true)
                        //Text("\(price)")
                    }
                    Section(header: Text("카테고리")) {
                        TextField("카테고리를 입력해 주세요. 예) 의류, 다이어리" , text: $category)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        //Text("\(text)")
                    }
                    //                Section(header: Text("조건")) {
                    //                    TextField("조건을 작성해주세요. 예) 수량, 색상" , text: $required)
                    //                        .textFieldStyle(.roundedBorder)
                    //                        .disableAutocorrection(true)
                    //                    //Text("\(text)")
                    //                }
                    
                        Button {
                            print("펀딩(사진x) 등록 버튼 clicked")
                            sellingVM.title = title
                            sellingVM.explained = explained
                            sellingVM.min_num = min_num
                            sellingVM.category = category
                            sellingVM.required = required
                            sellingVM.send()
                        } label: {
                            Text("등록")
                        }
                        
                        Button {
                            print("펀딩(사진1) 등록 버튼 clicked")
                            sellingVM.title = title
                            sellingVM.explained = explained
                            sellingVM.min_num = min_num
                            sellingVM.category = category
                            sellingVM.required = required
                            PhotoPicker(mediaItems: mediaItems) { didSelectItem in
                                // Handle didSelectItems value here...
                            }
//                            sellingVM.send()
                        } label: {
                            Text("사진등록")
                        }
                    
                    
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            .sheet(isPresented: $showSheet, content: {
                PhotoPicker(mediaItems: mediaItems) { didSelectItem in
                    // Handle didSelectItems value here...
                    showSheet = false
                }
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
