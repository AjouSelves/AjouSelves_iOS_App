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

struct BuyingView : View {
    
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    @State var isChecked: Bool = false
    
    //MARK: - [Testing] String input Data
    @State var title: String = "" //타이틀 State_Testing
    @State var price: String = "" //가격 State_Testing
    @State var text: String = "" //설명 State_Testing
    
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
                    //Text("\(title)")
                }
                Section(header: Text("가격")) {
                    TextField("가격" , text: $price)
                        .textFieldStyle(.roundedBorder)
                    //Text("\(price)")
                }
                Section(header: Text("내용")) {
                    TextField("게시글 내용을 작성해주세요." , text: $text)
                        .textFieldStyle(.roundedBorder)
                    //Text("\(text)")
                }
                Button {
                    print("펀딩 등록 버튼 clicked")
                } label: {
                    Text("등록")
                }

            }
        }
    }
}

struct BuyingView_Previews: PreviewProvider {
    static var previews: some View {
        BuyingView()
    }
}
