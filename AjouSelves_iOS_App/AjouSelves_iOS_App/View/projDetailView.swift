//
//  projDetailView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/13.
//

import SwiftUI

struct projDetailView: View {
    var prdData: projectAllDataParcing
    
    var body: some View {
        VStack{
            Text("\(prdData.description_title)")
            Text("Test2")
        }
    }
}

struct projDetailView_Previews: PreviewProvider {
    static var previews: some View {
        projDetailView(prdData: projectAllDataParcing.getDummy())
    }
}
