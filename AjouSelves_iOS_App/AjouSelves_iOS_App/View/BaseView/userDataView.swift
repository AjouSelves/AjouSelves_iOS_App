//
//  userDataView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/28.
//

import SwiftUI

struct userDataView: View {
    @ObservedObject var productdataVM = productDataViewModel()
    
    var prdData : userGet

    
    init(_ prdData : userGet) {
        self.prdData = prdData
    }
    
    var body: some View {
        HStack{
            Image(systemName: "user")
            VStack{
                Text("\(prdData.description_nickname)")
                Text("\(prdData.description_email)")
                Text("\(prdData.description_name)")
                Text("\(prdData.description_phonenumber)")
            }
        }
    }
}

struct userDataView_Previews: PreviewProvider {
    static var previews: some View {
        userDataView(userGet.get_Dummy())
    }
}
