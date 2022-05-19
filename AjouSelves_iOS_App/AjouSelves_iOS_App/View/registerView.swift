//
//  registerView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/12.
//

import SwiftUI

struct registerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var productdataVM: productDataViewModel
    
    //숫자 입력 formatter
    let numFormatter: NumberFormatter = {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter
    }()
    
    //MARK: - [proj] pjor/add
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var sex: Int  = 0
    @State var phonenumber: String = ""
    @State var nickname: String = ""
    @State var status: String = "재학생"
    @State var socialtype: String = "local"
    @State var birth: String = ""
    @State var address: String = "dummy"
    @State var profilelink: String = "https://kakao.com/abcd"
    @State var bank: String = ""
    @State var account: String = ""
    @State var wakeUp = Date()
    
    
    
    var body: some View {
        VStack {
            Text("이메일").frame(alignment:.leading)
            TextField("이메일 주소를 입력해주세요.", text: $email)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Text("비밀번호").frame(alignment:.leading)
            TextField("사용하실 비밀번호를 입력해주세요.", text: $password)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .autocapitalization(.none)

            
            
//            TextField("성별", value: $sex, formatter: numFormatter)
//                .textFieldStyle(.roundedBorder)
//                .disableAutocorrection(true)
            
            TextField("휴대폰번호 - 빼고 입력해주세요", text: $phonenumber)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            TextField("닉네임", text: $nickname)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
//            HStack{
//                Button(action: {
//                    print("재학생")
//                }, label: {
//                    Text("재학생")
//                })
//                Button(action: {
//                    print("졸업생")
//                }, label: {
//                    Text("휴학생")
//                })
//                Button(action: {
//                    print("")
//                }, label: {
//                    Text("확인")
//                })
//            }
            
//            TextField("재학상태", text: $status)
//                .textFieldStyle(.roundedBorder)
//                .disableAutocorrection(true)
            
//            TextField("socialtype", text: $socialtype)
//                .textFieldStyle(.roundedBorder)
//                .disableAutocorrection(true)
            
            // 생년월일 입력
            DatePicker("Please enter a date", selection: $wakeUp,
                               displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
            
            HStack{
                TextField("은행명", text: $bank)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                TextField("계좌번호", text: $account)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
//            TextField("profilelink", text: $profilelink)
//                .textFieldStyle(.roundedBorder)
//                .disableAutocorrection(true)
            
            Button(action: {
                productdataVM.email = email
                productdataVM.password = password
                productdataVM.name = name
                productdataVM.phonenumber = phonenumber
                productdataVM.nickname = nickname
                productdataVM.status = status
                productdataVM.sex = sex
                productdataVM.socialtype = socialtype
                productdataVM.profilelink = profilelink
                productdataVM.birth = birth
                productdataVM.address = address
                productdataVM.bank = bank
                productdataVM.account = account
                productdataVM.wakeUp = wakeUp
                productdataVM.registConfirm()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    if productdataVM.registerisSuccess == true {
                        print("dismiss")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
                
            }, label: {
                Text("등록").bold()
            }).alert(isPresented: $productdataVM.registerCheck, content: {
                Alert(title: Text("경고"), message: Text("입력을 다시 확인하여 주십시오"), dismissButton: .default(Text("확인")))
            }).alert(isPresented: $productdataVM.registerFinish, content: {
                Alert(title: Text("축하합니다"), message: Text("회원가입에 성공하셨습니다"), dismissButton: .default(Text("로그인하러 가기")))
            })
            
        }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView(productdataVM: productDataViewModel())
    }
}
