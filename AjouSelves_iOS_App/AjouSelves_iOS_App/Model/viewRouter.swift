//
//  viewRouter.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/05/13.
//

import Foundation
import Combine
import SwiftUI

class viewRouter : ObservableObject {
    let objectWillChange = PassthroughSubject<viewRouter,Never>()
    var currentPage: String = "ContentView" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
