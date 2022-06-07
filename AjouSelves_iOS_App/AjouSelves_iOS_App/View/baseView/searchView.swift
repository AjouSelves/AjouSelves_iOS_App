//
//  searchView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/30.
//

import SwiftUI

struct searchView: View {
    @State var searchText: String = ""
    @State var userSearchList = UserDefaults.standard.array(forKey: "search") as? [String]
    
    var body: some View {
        Form {
            Spacer(minLength: 100)
            Section(header: Text("검색")
                .bold()
                .foregroundColor(Color.black)
                .font(.system(size: 20))
                    + Text("*")
                .foregroundColor(Color.red)
                .font(.system(size: 20))
            ){
                HStack{
                    TextField("클릭하고 입력" , text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action: {
                        if var searchArr = UserDefaults.standard.array(forKey: "search") as? [String] {
                            searchArr.insert("\(searchText)", at: 0)
                            if (searchArr.count > 5) {
                                searchArr.remove(at: 5)
                            }
                            UserDefaults.standard.set(searchArr, forKey: "search")
                        }
                        else {
                            var newList = [String]()
                            
                            newList.append("\(searchText)")
                            
                            UserDefaults.standard.set(newList, forKey: "search")
                        }
                        userSearchList = UserDefaults.standard.array(forKey: "search") as? [String]
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                }
                Text("검색어를 입력해 주세요👆")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 13))
            }
            Section(header: Text("이전 검색어")
                .bold()
                .foregroundColor(Color.black)
                .font(.system(size: 20))
                    + Text("*")
                .foregroundColor(Color.red)
                .font(.system(size: 20))
            ){
                Text("이전 검색어👇")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 13))
                List(userSearchList!, id: \.self){ adata in
                    Text("\(adata)")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                }
            }
        }
        .background(Color.white)
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
            userSearchList = UserDefaults.standard.array(forKey: "search") as? [String]
        })
        .ignoresSafeArea()
        .setTabBarVisibility(isHidden: true) // 프로젝트 디테일 뷰로 들어가면 TabBar활성화
    }
}

struct searchView_Previews: PreviewProvider {
    static var previews: some View {
        searchView()
    }
}
