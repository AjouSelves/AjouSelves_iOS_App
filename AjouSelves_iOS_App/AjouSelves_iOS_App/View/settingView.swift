//
//  settingView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/03/29.
//

import SwiftUI
import Combine

var ver: String = "v0.01"
struct settingView: View {
    var body: some View {
        NavigationView{
            VStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "")
                })
                NavigationLink(
                    destination: {
                        Text("약관")
                    }, label: {
                        Text("약관")
                    })
                Text("버전: \(ver)")
            }
        }
    }
}

struct settingView_Previews: PreviewProvider {
    static var previews: some View {
        settingView()
    }
}
