//
//  MainModel.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import Foundation

struct MainWeekModel {
  let day: String
  let image: String
  let index: Int
}

var mainWeekData: [MainWeekModel] = [
  MainWeekModel(day: "월", image: "full", index: 2),
  MainWeekModel(day: "화", image: "half", index: 3),
  MainWeekModel(day: "수", image: "full", index: 4),
  MainWeekModel(day: "목", image: "zero", index: 5),
  MainWeekModel(day: "금", image: "zero", index: 6),
  MainWeekModel(day: "토", image: "zero", index: 7),
  MainWeekModel(day: "일", image: "zero", index: 1)
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


