//
//  startView.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/13.
//

import SwiftUI

struct startView: View {
    
    @ObservedObject var viewrouter: viewRouter
    
    var body: some View {
        if viewrouter.currentPage == "ContentView"{
            ContentView(productdataVM: productDataViewModel(), viewrouter: viewrouter)
        }
        else if viewrouter.currentPage == "tabView"{
            tabView(viewrouter: viewrouter)
        }
    }
}

struct startView_Previews: PreviewProvider {
    static var previews: some View {
        startView(viewrouter: viewRouter())
    }
}
