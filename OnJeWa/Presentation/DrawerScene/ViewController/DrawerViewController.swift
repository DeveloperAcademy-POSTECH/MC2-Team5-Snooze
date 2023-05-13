//
//  DrawerViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/13.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

// 워니 didTapAlbum 여기에 미션 앨범으로 넘어가는 코드 넣어주세요! :)
// 그리고 MissionAlbumView에 currentAlbumImageView 뷰에 image를 미션 앨범 첫번째에 있는 사진으로 세팅해주세요~
// + 디테일..
// 그리고 주석 지우고 push!

final class DrawerViewController: BaseViewController {
        
    //MARK: - Properties
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Views
    
    private let missionAlbumView = MissionAlbumView()
    
    private lazy var togetherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let togetherTimeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "함께한 시간"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let rightArrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = OnjewaColor.button.color
        return imageView
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let leftMainTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "오늘 카키가\n기다린 시간")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let leftTimeTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "7시간")
        let range = (attributedString.string as NSString).range(of: "7")
        let font = UIFont.systemFont(ofSize: 32, weight: .bold)
        attributedString.addAttribute(.font, value: font, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogLeft")
        return imageView
    }()
    
    private let rightMainTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "오늘 카키와\n함께한 시간")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let rightTimeTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "12시간")
        let range = (attributedString.string as NSString).range(of: "12")
        let font = UIFont.systemFont(ofSize: 32, weight: .bold)
        attributedString.addAttribute(.font, value: font, range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogRight")
        return imageView
    }()
    
    //MARK: - Functions
    
    override func setupView() {
        
        setupImageView()
        
        self.title = "서랍"
        
        view.backgroundColor = OnjewaColor.namebackground.color
        
        missionAlbumView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(didTapTogetherTime))
        togetherStackView.addGestureRecognizer(tapGestureRecognizer)
        
        [togetherTimeTitle, rightArrowIcon].forEach {
            togetherStackView.addArrangedSubview($0)
        }
        
        [leftImageView, rightImageView].forEach {
            imageStackView.addArrangedSubview($0)
        }
        
        [missionAlbumView, togetherStackView, imageStackView,
         leftMainTitle, leftTimeTitle, rightMainTitle, rightTimeTitle].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            missionAlbumView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 16),
            missionAlbumView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: 20),
            missionAlbumView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -20),
            missionAlbumView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        NSLayoutConstraint.activate([
            togetherStackView.topAnchor.constraint(equalTo: missionAlbumView.bottomAnchor,
                                                   constant: 24),
            togetherStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: 18),
        ])
        
        NSLayoutConstraint.activate([
            leftMainTitle.topAnchor.constraint(equalTo: leftImageView.topAnchor,
                                               constant: 18),
            leftMainTitle.leadingAnchor.constraint(equalTo: leftImageView.leadingAnchor,
                                                   constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            leftTimeTitle.bottomAnchor.constraint(equalTo: leftImageView.bottomAnchor,
                                                  constant: -16),
            leftTimeTitle.trailingAnchor.constraint(equalTo: leftImageView.trailingAnchor,
                                                    constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            rightMainTitle.topAnchor.constraint(equalTo: rightImageView.topAnchor,
                                                constant: 18),
            rightMainTitle.leadingAnchor.constraint(equalTo: rightImageView.leadingAnchor,
                                                    constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            rightTimeTitle.bottomAnchor.constraint(equalTo: rightImageView.bottomAnchor,
                                                   constant: -16),
            rightTimeTitle.trailingAnchor.constraint(equalTo: rightImageView.trailingAnchor,
                                                     constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: togetherStackView.bottomAnchor,
                                                constant: 16),
            imageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 12),
            imageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -12),
        ])
    }
    
    override func bindViewModel() { }
    
    private func setupImageView() {
        switch UserDefaultsSetting.mainPet {
        case "dog":
            leftImageView.image = UIImage(named: "dogLeft")
            rightImageView.image = UIImage(named: "dogRight")
            break
        case "cat":
            leftImageView.image = UIImage(named: "catLeft")
            rightImageView.image = UIImage(named: "catRight")
            break
        case "parrot":
            leftImageView.image = UIImage(named: "parrotLeft")
            rightImageView.image = UIImage(named: "parrotRight")
            break
        case "rabbit":
            leftImageView.image = UIImage(named: "rabbitLeft")
            rightImageView.image = UIImage(named: "rabbitRight")
            break
        default:
            break
        }
    }
    
    @objc private func didTapTogetherTime() {
        print("통계 뷰로 이동")
    }
}

extension DrawerViewController: MissionAlbumViewDelegate {
    func didTapAlbum() {
        
    }
}
