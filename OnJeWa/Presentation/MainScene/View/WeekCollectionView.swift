//
//  WeekCollectionViewController.swift
//  OnJeWa
//
//  Created by 최효원 on 2023/05/04.
//

import UIKit
import OnJeWaCore
import OnJeWaUI
import OnJeWaNetwork

protocol WeekCollectionViewDelegate: AnyObject {
    func didTapMission()
}

class WeekCollectionView: BaseView {
    
    weak var delegate: WeekCollectionViewDelegate?
    
    //MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let weekTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이번주 \(RealmManager.shared.readName())와 함께한 시간"
        //MARK: 수정 - 색상 변경 필요
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.adjusted, weight: .bold)
        return label
    }()
    
    private lazy var weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        register()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Extension
extension WeekCollectionView  {
    private func setupView() {
        [weekTitleLabel, weekCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.addSubview($0)
        }
        addSubview(backgroundView)
        
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weekTitleLabel.bottomAnchor.constraint(equalTo: weekCollectionView.topAnchor, constant: -16.adjusted),
            weekTitleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weekCollectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            weekCollectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            weekCollectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            weekCollectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
    }
    
    private func register() {
        weekCollectionView.register(WeekCollectionViewCell.self,
                                    forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
    }
}


extension WeekCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: 35.adjusted, height: 66.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.adjusted
    }
}


extension WeekCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return mainWeekData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier,
                                                   for: indexPath) as? WeekCollectionViewCell else { return UICollectionViewCell() }
        collectionCell.dataBind(model: mainWeekData[indexPath.item])
        collectionCell.missionTapAction = {
            self.delegate?.didTapMission()
        }
        return collectionCell
    }
    
}
