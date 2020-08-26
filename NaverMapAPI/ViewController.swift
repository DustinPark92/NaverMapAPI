//
//  ViewController.swift
//  NaverMapAPI
//
//  Created by Dustin on 2020/08/26.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import NMapsMap
import Pods_NaverMapAPI

class ViewController: UIViewController {
    let marker = NMFMarker()
    let button : UIButton = {
        let bt = UIButton(type: .system)
        bt.setDimensions(width: 100, height: 100)
        bt.setTitle("버튼", for: .normal)
        bt.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        bt.backgroundColor = .red
        return bt
    }()
    
    let infoWindow = NMFInfoWindow()
    let dataSource = NMFInfoWindowDefaultTextSource.data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        
        mapView.addSubview(button)
        mapView.bringSubviewToFront(button)
        button.anchor(bottom:mapView.bottomAnchor,right: mapView.rightAnchor,paddingBottom: 30,paddingRight: 30)
        
        
        
        //지도옵션
        
        mapView.mapType = .basic //6가지 지원
        mapView.isIndoorMapEnabled = true
        
        
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        marker.mapView = mapView
        
        //마커색 ,이미지
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = .red
        
        //마커 크기
        marker.width = 25
        marker.height = 40
        
        //마커 정보
        dataSource.title = "서울 시청 입니다."
        infoWindow.dataSource = dataSource
        
        
        infoWindow.open(with: marker)
        
        marker.touchHandler = { (overlay) in
            print("마커 클릭됨")
            return true
        }
        
        
        
        let southWest = NMGLatLng(lat: 31.43, lng: 122.37)
        let northEast = NMGLatLng(lat: 44.35, lng: 132)
        let bounds = NMGLatLngBounds(southWest: southWest, northEast: northEast)
        
        
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5666102, lng: 126.9783881))
        cameraUpdate.reason = 3
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        mapView.moveCamera(cameraUpdate, completion: { (isCancelled) in
            if isCancelled {
                print("카메라 이동 취소")
            } else {
                print("카메라 이동 성공")
            }
        })
    }
    
    
    @objc func handleButton() {
        
    }
    
    
    
    
    
    
    //    marker.mapView = naverMap;
}

