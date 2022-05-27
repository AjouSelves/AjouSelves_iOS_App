import Foundation
import SwiftUI
import Combine // 바인딩
import Photos
import PhotosUI

//MARK: - 텍스트필드, 사진
struct sellingView_Test : View {
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
        VStack (alignment: .leading){
            NavigationView {
                ScrollView {
                    Text("사진등록")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
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
                                        //sellingVM.projAddSingle(imageData: item.photo)
                                        sellingVM.photoData = item.photo!
                                    }
                            }
                        }
                    }
                    Group{
                        Text("제목")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        TextField("글 재목" , text: $title)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        
                        Text("내용")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        TextEditor(text: $explained)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        
                        Text("최소인원")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        TextField("펀딩 최소인원을 입력해 주세요." , value: $min_num, formatter: numFormatter)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                            .disableAutocorrection(true)
                        
                        Text("카테고리")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                                + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        TextField("카테고리를 입력해 주세요. 예) 의류, 다이어리" , text: $category)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        
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
                            //sellingVM.projAddSingle(imageData: selectedPhoto)
                            sellingVM.projAddSingle()
                        } label: {
                            Text("사진등록")
                        }
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

struct sellingView_Test_Previews: PreviewProvider {
    static var previews: some View {
        sellingView_Test(sellingVM: sellingViewModel())
    }
}
