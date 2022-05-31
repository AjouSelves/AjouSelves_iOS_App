//
//  registerView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/12.
//

import Foundation
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
    @State var email: String = "" //필수
    @State var password: String = "" //필수
    @State var name: String = "" //필수
    @State var phonenumber: String = "" //필수
    @State var nickname: String = "" //필수
    @State var status: String = "" //필수
    var statusList = ["재학생","휴학생","졸업생", "일반인"]
    @State var sex: Int  = 0
    @State var socialtype: String = "local"
    @State var birth: String = ""
    @State var address: String = "dummy"
    @State var profilelink: String = "https://kakao.com/abcd"
    @State var bank: String = ""
    var bankList = ["신한은행", "국민은행", "농협은행", "우리은행", "하나은행"]
    @State var account: String = ""
    @State var wakeUp = Date()
    
    //등록 확인 성공 / 실패
    @State var isChecked: ActiveAlert = .fail
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Form{
                Group{
                    Section(){
                        Text("필수정보")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                        + Text("*")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        + Text(" 모두 입력해주세요👇")
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                    }
                    Section(header: Text("성명")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                    ){
                        TextField("클릭하고 입력" , text: $name)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Text("성명을 입력해주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                    
                    Section(header: Text("이메일")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                    ){
                        TextField("클릭하고 입력" , text: $email)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Text("이메일 주소를 입력해주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                    
                    Section(header: Text("비밀번호")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                    ){
                        SecureField("클릭하고 입력" , text: $password)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Text("사용하실 비밀번호를 입력해주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                    
                    Section(header: Text("재학상태")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                    ){
                        Picker("재학상태 선택", selection: $status) {
                            ForEach(statusList, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("휠을 굴려 선택해주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                    
                    Section(header: Text("휴대폰 번호")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                    ){
                        TextField("클릭하고 입력" , text: $phonenumber)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Text("휴대폰번호 - 빼고 입력해주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                    
                    Section(header: Text("닉네임")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                            + Text("*")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                    ){
                        TextField("클릭하고 입력" , text: $nickname)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Text("사용하실 닉네임을 입력해주세요👆")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                }
                Section(){
                    Text("꼭 입력할 필요 없어요👇")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                }
                Section(header: Text("생년월일")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
                        //                        + Text("*")
                        //                    .foregroundColor(Color.red)
                        //                    .font(.system(size: 20))
                ){
                    DatePicker("Please enter a date", selection: $wakeUp,
                               displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    Text("생년월일을 입력해주세요👆")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                }
                
                Section(header: Text("은행명")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
                        //                        + Text("*")
                        //                    .foregroundColor(Color.red)
                        //                    .font(.system(size: 20))
                ){
                    Picker("은행 선택", selection: $bank) {
                        ForEach(bankList, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("휠을 굴려 선택해주세요👆")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                }
                
                Section(header: Text("계좌번호")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
                        //                        + Text("*")
                        //                    .foregroundColor(Color.red)
                        //                    .font(.system(size: 20))
                ){
                    TextField("클릭하고 입력" , text: $account)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Text("위에 입력하신 은행의 계좌번호를 입력해주세요👆")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                }
            }
            .background(Color.white)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            })
            Button(action: {
                productdataVM.name = name
                productdataVM.email = email
                productdataVM.password = password
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
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    if productdataVM.registerisSuccess == true {
                        productdataVM.authRegister()
                        self.isChecked = .success
                    } else {
                        self.isChecked = .fail
                    }
                    self.showAlert = true
                }
            }, label: {
                Text("등록").bold()
            })

            .alert(isPresented: $showAlert) {
                switch isChecked {
                case .success:
                    return Alert(title: Text("축하합니다"), message: Text("회원가입에 성공하셨습니다"), dismissButton: .default(Text("로그인하러 가기")){
                        self.presentationMode.wrappedValue.dismiss()
                    })
                case .fail:
                    return Alert(title: Text("등록 실패"), message: Text("\(productdataVM.registerEmpty)의 입력을 확인하여 주십시오"), dismissButton: .default(Text("확인")){
                        //self.presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView(productdataVM: productDataViewModel())
    }
}
