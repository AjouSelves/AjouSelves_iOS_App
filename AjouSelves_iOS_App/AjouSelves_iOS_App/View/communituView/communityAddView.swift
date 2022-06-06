//
//  communityAddView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/28.
//

import SwiftUI

struct communityAddView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // 창 자동 종료를 위한 Environment
    
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    @State var isChecked: Bool = false
    @State var isPhotoIn: Bool = false
    
    //MARK: - [post] post/add
    @State var title: String = ""
    @State var explained: String = ""
    @State var min_num: Int = 0
    @State var category: String = ""
    @State var required: [String] = [""]
    
    @ObservedObject var productdataVM: productdataViewModel
    
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
                                            productdataVM.photoData = item.photo!
                                            self.isPhotoIn = true
                                            print("사진 추가 완료", self.isPhotoIn)
                                        }
                                }
                            }
                        }
                        Text("게시글에 등록할 사진을 추가해 주세요👆")
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
                            Text("게시글의 제목을 입력해 주세요👆")
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
                    }
                    Button {
                        print("펀딩(사진1) 등록 버튼 clicked")
                        productdataVM.title = title
                        productdataVM.explained = explained
                        productdataVM.postAddWithPhoto()
                        productdataVM.postAddConfirm()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            if productdataVM.postAddSuccess && self.isPhotoIn == true {
                                productdataVM.postAddWithPhoto()
                                self.isChecked = true
                                print("사진O등록")
                            }
                            else if productdataVM.postAddSuccess && self.isPhotoIn == false {
                                productdataVM.postAddWithoutPhoto()
                                self.isChecked = true
                                print("사진X등록")
                            } else {
                                print("error")
                            }
                        }
                    } label: {
                        Text("게시글 등록🤙").bold()
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
                Alert(title: Text("등록 완료!"), message: Text("게시글이 정상적으로 등록되었습니다!"), dismissButton: .default(Text("확인")){
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

struct communityAddView_Previews: PreviewProvider {
    static var previews: some View {
        communityAddView(productdataVM: productdataViewModel())
    }
}
