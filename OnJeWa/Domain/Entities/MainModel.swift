//
//  MainModel.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import Foundation

struct MainWeekModel {
  let day: String
}

var mainWeekData: [MainWeekModel] = [
  MainWeekModel(day: "월"),
  MainWeekModel(day: "화"),
  MainWeekModel(day: "수"),
  MainWeekModel(day: "목"),
  MainWeekModel(day: "금"),
  MainWeekModel(day: "토"),
  MainWeekModel(day: "일")
]

struct GalleryPhotoModel {
    let photoImage:String
}

var gridList: [GalleryPhotoModel] = [
    GalleryPhotoModel(photoImage: "IMG_1"),
    GalleryPhotoModel(photoImage: "IMG_2"),
    GalleryPhotoModel(photoImage: "IMG_3"),
    GalleryPhotoModel(photoImage: "IMG_4"),
    GalleryPhotoModel(photoImage: "IMG_5"),
    GalleryPhotoModel(photoImage: "IMG_6"),
    GalleryPhotoModel(photoImage: "IMG_7"),
    GalleryPhotoModel(photoImage: "IMG_8"),
    GalleryPhotoModel(photoImage: "IMG_9"),
    GalleryPhotoModel(photoImage: "IMG_10"),
    GalleryPhotoModel(photoImage: "IMG_11"),
    GalleryPhotoModel(photoImage: "IMG_12"),
    GalleryPhotoModel(photoImage: "IMG_13"),
    GalleryPhotoModel(photoImage: "IMG_14")
]
