//
//  mainView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        //펀딩 목록 불러오기
        NavigationView{
            //test List
            List(1...30, id: \.self) { index in
                NavigationLink(
                    destination: Text("아이템 \(index) 번 의 세부사항"),
                        label: {
                            Text("아이템 \(index)")
                        })
            }
            //test code exit
            
            //.navigationTitle("펀딩 목록")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: Text("test"),
                            label: {
                                Image(systemName: "magnifyingglass")
                    })
                    NavigationLink(
                        destination: Text("test"),
                            label: {
                                Image(systemName: "line.3.horizontal.circle")
                    })
                    NavigationLink(
                        destination: Text("test"),
                            label: {
                                Image(systemName: "bell")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        print("Clicked4")
                    }, label: {
                        Text("아주대")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.black)
                        
                    })
                }
            }
            .frame(height: 700)
            // .border(Color.blue) // Title밑 Tabview밑의 파란 줄
            .padding(-15)
        }
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
