//
//  userCreateProjEditView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/06/07.
//

import SwiftUI

struct userCreateProjEditView: View {
    @State var stateOfProjList = ["모집중", "결제중","작업중","프로젝트 종료","프로젝트 중단"]
    @State var stateOfProjName: String = ""
    @State var stateOfProj: Int = 0
    @ObservedObject var productVM = productdataViewModel()
    var projStateUrl = "http://goodsbyus.com/api/proj/state/"
    
    var prdData: userCreate.userCreateDetail
    
    init(_ prdData : userCreate.userCreateDetail) {
        self.prdData = prdData
    }
    
    var body: some View {
        Form{
            Section(header: Text("프로젝트 진행")
                .bold()
                .foregroundColor(Color.black)
                .font(.system(size: 20))
            ){
                Picker("프로젝트 진행 상태 수정", selection:$stateOfProjName) {
                    ForEach(stateOfProjList, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                Text("휠을 굴려 선택해주세요👆")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 13))
            }
            Button(action: {
                if stateOfProjName == "모집중"{
                    stateOfProj = 1
                }
                else if stateOfProjName == "결제중"{
                    stateOfProj = 2
                }
                else if stateOfProjName == "작업중"{
                    stateOfProj = 3
                }
                else if stateOfProjName == "프로젝트 종료"{
                    stateOfProj = 4
                }
                else if stateOfProjName == "프로젝트 중단"{
                    stateOfProj = 5
                }
                productVM.stateNum = stateOfProj
                productVM.projState(url: projStateUrl + "\(prdData.description_projid)")
                print("이름: ", stateOfProjName)
                print("번호: ", stateOfProj)
            }, label: {
                Text("변경 완료")
            })
        }
    }
}

struct userCreateProjEditView_Previews: PreviewProvider {
    static var previews: some View {
        userCreateProjEditView(userCreate.userCreateDetail.getDummy())
    }
}
