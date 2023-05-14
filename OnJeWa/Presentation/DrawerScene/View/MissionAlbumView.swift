//
//  MissionAlbumView.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/13.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

protocol MissionAlbumViewDelegate: AnyObject {
    func didTapAlbum()
}

final class MissionAlbumView: BaseView {
    
    //MARK: - Properties
    
    weak var delegate: MissionAlbumViewDelegate?
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let albumImageTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "막둥이랑\n공놀이 하기")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let albumImageDayTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4월 24일"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let currentAlbumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private let missionAlbumTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "미션 앨범"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var titleBadgeAndArrowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let circleBadge: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "family")
        return imageView
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rightArrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = OnjewaColor.button.color
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        return view
    }()
    
    //MARK: - Functions
    
    @objc private func headerStackViewTapped() {
        delegate?.didTapAlbum()
    }
}

private extension MissionAlbumView {
    func setupView() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(headerStackViewTapped))
        headerStackView.addGestureRecognizer(tapGestureRecognizer)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [missionAlbumTitle, rightArrowIcon].forEach {
            titleBadgeAndArrowStackView.addArrangedSubview($0)
        }
        
        [titleBadgeAndArrowStackView, emptyView, circleBadge].forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        [headerStackView, currentAlbumImageView, albumImageTitle, albumImageDayTitle].forEach {
            backgroundView.addSubview($0)
        }
        
        addSubview(backgroundView)
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: 20),
            headerStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                     constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                      constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            currentAlbumImageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor,
                                                       constant: 24),
            currentAlbumImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                           constant: 20),
            currentAlbumImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                            constant: -20),
            currentAlbumImageView.heightAnchor.constraint(equalTo: currentAlbumImageView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            albumImageTitle.topAnchor.constraint(equalTo: currentAlbumImageView.topAnchor,
                                                 constant: 18),
            albumImageTitle.leadingAnchor.constraint(equalTo: currentAlbumImageView.leadingAnchor,
                                                     constant: 16),
            
            albumImageDayTitle.topAnchor.constraint(equalTo: albumImageTitle.bottomAnchor,
                                                    constant: 10),
            albumImageDayTitle.leadingAnchor.constraint(equalTo: currentAlbumImageView.leadingAnchor,
                                                        constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
