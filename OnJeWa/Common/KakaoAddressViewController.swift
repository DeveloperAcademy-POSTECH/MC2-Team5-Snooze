//
//  KakaoAddressViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit
import WebKit
import CoreLocation

import OnJeWaCore

final class KakaoAddressViewController: BaseWebViewController {
    
    // MARK: - Properties
    
    weak var delegate: KakaoAddressViewDelegate?
    
    private var coordinates: CLLocationCoordinate2D?
    
    private var addressEnglish = "" /// 기본 영문 주소
    private var roadAddress = "" /// 도로명 주소
    private var roadAddressEnglish = "" /// 영문 도로명 주소
    private var jibunAddressEnglish = "" /// 영문 지번 주소
    private var autoRoadAddressEnglish = "" /// autoRoadAddress의 영문 도로명 주소
    private var autoJibunAddressEnglish = "" /// autoJibunAddress의 영문 지번 주소
    private var sidoEnglish = "" /// 도/시 이름의 영문
    private var sigunguEnglish = "" /// 시/군/구 이름의 영문
    private var roadnameEnglish = "" /// 도로명 값, 검색 결과 중 선택한 도로명주소의 "도로명의 영문" 값이 들어갑니다.(
    private var bname = "" /// 법정동/법정리 이름
    private var bname2 = "" /// 법정동/법정리 이름
    private var sido = "" /// 도/시 이름
    private var sigungu = "" /// 시/군/구 이름
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension KakaoAddressViewController {
    override func userContentController(_ userContentController: WKUserContentController,
                                        didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            addressEnglish = data["addressEnglish"] as? String ?? ""
            roadAddress = data["roadAddress"] as? String ?? ""
            sidoEnglish = data["sidoEnglish"] as? String ?? ""
            sigunguEnglish = data["sigunguEnglish"] as? String ?? ""
            roadnameEnglish = data["roadnameEnglish"] as? String ?? ""
            roadAddressEnglish = data["roadAddressEnglish"] as? String ?? ""
            jibunAddressEnglish = data["jibunAddressEnglish"] as? String ?? ""
            autoRoadAddressEnglish = data["autoRoadAddressEnglish"] as? String ?? ""
            autoJibunAddressEnglish = data["autoJibunAddressEnglish"] as? String ?? ""
            bname = data["bname"] as? String ?? ""
            bname2 = data["bname2"] as? String ?? ""
            sido = data["sido"] as? String ?? ""
            sigungu = data["sigungu"] as? String ?? ""
        }
        
        let geocoder = CLGeocoder()
        let address1 = "\(sidoEnglish) \(sigunguEnglish) \(roadnameEnglish)"
        let address2 = roadnameEnglish
        
        geocoder.geocodeAddressString(address1, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                geocoder.geocodeAddressString(address2, completionHandler: {(placemarks, error) -> Void in
                    if error != nil {
                        return
                    }
                    if let placemark = placemarks?.first {
                        let coordinates = placemark.location?.coordinate
                        self.delegate?.dismissKakaoAddressWebView(address: self.roadAddress,
                                                                  coordinates: coordinates
                                                                  ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                if let placemark = placemarks?.first {
                    let coordinates = placemark.location?.coordinate
                    self.delegate?.dismissKakaoAddressWebView(address: self.roadAddress,
                                                              coordinates: coordinates
                                                              ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}
