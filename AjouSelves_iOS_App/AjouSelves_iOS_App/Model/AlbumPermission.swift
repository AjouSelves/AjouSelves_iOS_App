//
//  AlbumPermission.swift
//  AjouSelves_iOS_App
//
//  Created by Minhyun Cho on 2022/04/12.
//

import Foundation
import Photos

func checkAlbumPermission(){
    PHPhotoLibrary.requestAuthorization({ status in
        switch status{
        case .authorized:
            print("Album: 권한 허용")
            //setAlbumList()
        case .denied:
            print("Album: 권한 거부")
        case .restricted, .notDetermined:
            print("Album: 권한 선택하지 않음")
        default:
            break
        }
    })
}

func setAlbumList(){
    
}
