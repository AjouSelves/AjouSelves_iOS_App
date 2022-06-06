////
////  TabBarAccessor.swift
////  AjouSelves_iOS_App
////
////  Created by Minhyun Cho on 2022/05/18.
////
//
//import SwiftUI
//
//struct TabBarAccessor: UIViewControllerRepresentable {
//    var callback: (UITabBar) -> Void
//    private let proxyController = ViewController()
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
//                              UIViewController {
//        proxyController.callback = callback
//        return proxyController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
//    }
//
//    typealias UIViewControllerType = UIViewController
//
//    // viewWillAppear 가 탈때 가지고 있는 탭바를 클로저 콜백으로 넘겨준다.
//    private class ViewController: UIViewController {
//        var callback: (UITabBar) -> Void = { _ in }
//
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            if let tabBar = self.tabBarController {
//                self.callback(tabBar.tabBar)
//            }
//        }
//    }
//}
//
//extension View {
//
//    /// 탭바 숨김 처리 여부
//    /// - Parameter isHidden:
//    /// - Returns:
//    func setTabBarVisibility(isHidden : Bool) -> some View {
//      background(TabBarAccessor { tabBar in
//          print(">> TabBar height: \(tabBar.bounds.height)")
//          // !! use as needed, in calculations, @State, etc.
//          // 혹은 높이를 변경한다던지 여러가지 설정들이 가능하다.
//          tabBar.isHidden = isHidden
//      })
//  }
//}
