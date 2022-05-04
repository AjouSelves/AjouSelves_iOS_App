//
//  BuyingView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/07.
//

import Foundation
import SwiftUI
import Combine // 바인딩

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
    
    @ObservedObject var buyingVM: sellingViewModel
    
    let numFormatter: NumberFormatter = {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter
    }()
    
    //MARK: - mainView
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Photo")) {
                    Button(action: {
                        self.showingImagePicker.toggle()
                    }, label: {
                        Text("Image Picker")
                    }).sheet(isPresented: $showingImagePicker) {
                        ImagePicker(sourceType: .photoLibrary) { (image) in
                            self.pickedImage = Image(uiImage: image)
                            print(image)
                        }
                    }
                    pickedImage?.resizable()
                        .frame(height:300)
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
                    print("펀딩 등록 버튼 clicked")
                    buyingVM.title = title
                    buyingVM.explained = explained
                    buyingVM.min_num = min_num
                    buyingVM.category = category
                    buyingVM.required = required
                    buyingVM.send()
                } label: {
                    Text("등록")
                }
            }
        }
    }
}

struct BuyingView_Previews: PreviewProvider {
    static var previews: some View {
        sellingView(buyingVM: sellingViewModel())
    }
}
