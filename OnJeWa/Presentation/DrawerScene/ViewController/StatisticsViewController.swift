//
//  StatisticsViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/13.
//

import UIKit

import OnJeWaCore

final class StatisticsViewController: BaseViewController {
    
    //MARK: - Preperteis
    
    var shouldHideFirstView: Int? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            switch shouldHideFirstView {
            case 0:
                self.firstView.isHidden = false
                self.secondView.isHidden = true
                self.thirdView.isHidden = true
                break
            case 1:
                self.firstView.isHidden = true
                self.secondView.isHidden = false
                self.thirdView.isHidden = true
                break
            case 2:
                self.firstView.isHidden = true
                self.secondView.isHidden = true
                self.thirdView.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "함께한 시간"
        
        switch UserDefaultsSetting.mainPet {
        case "dog":
            lastWeekTopImageView.image = UIImage(named: "dogLastWeek")
            lastMonthTopImageView.image = UIImage(named: "dogLastMonth")
            sixMonthTopImageView.image = UIImage(named: "dogSixMonth")
            lastWeekBottomImageView.image = UIImage(named: "dogLastWeekBottom")
            lastMonthBottomImageView.image = UIImage(named: "dogLastMonthBottom")
            sixMonthBottomImageView.image = UIImage(named: "dogSixMonthBottom")
            break
        case "cat":
            lastWeekTopImageView.image = UIImage(named: "catLastWeek")
            lastMonthTopImageView.image = UIImage(named: "catLastMonth")
            sixMonthTopImageView.image = UIImage(named: "catSixMonth")
            lastWeekBottomImageView.image = UIImage(named: "catLastWeekBottom")
            lastMonthBottomImageView.image = UIImage(named: "catLastMonthBottom")
            sixMonthBottomImageView.image = UIImage(named: "catSixMonthBottom")
            break
        case "parrot":
            lastWeekTopImageView.image = UIImage(named: "parrotLastWeek")
            lastMonthTopImageView.image = UIImage(named: "parrotLastMonth")
            sixMonthTopImageView.image = UIImage(named: "parrotSixMonth")
            lastWeekBottomImageView.image = UIImage(named: "parrotLastWeekBottom")
            lastMonthBottomImageView.image = UIImage(named: "parrotLastMonthBottom")
            sixMonthBottomImageView.image = UIImage(named: "parrotSixMonthBottom")
            break
        case "rabbit":
            lastWeekTopImageView.image = UIImage(named: "rabbitLastWeek")
            lastMonthTopImageView.image = UIImage(named: "rabbitLastMonth")
            sixMonthTopImageView.image = UIImage(named: "rabbitSixMonth")
            lastWeekBottomImageView.image = UIImage(named: "rabbitLastWeekBottom")
            lastMonthBottomImageView.image = UIImage(named: "rabbitLastMonthBottom")
            sixMonthBottomImageView.image = UIImage(named: "rabbitSixMonthBottom")
            break
        default:
            break
        }
    }
    
    //MARK: - Views
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["이번주", "이번달", "6개월"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let firstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lastWeekTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogLastWeek")
        return imageView
    }()
    
    private let lastWeekBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogLastWeekBottom")
        return imageView
    }()
    
    private let secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lastMonthTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogLastMonth")
        return imageView
    }()
    
    private let lastMonthBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogLastMonthBottom")
        return imageView
    }()
    
    private let thirdView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sixMonthTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogSixMonth")
        return imageView
    }()
    
    private let sixMonthBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dogSixMonthBottom")
        return imageView
    }()
    
    //MARK: - Funceions
    
    override func setupView() {
        
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)),
                                        for: .valueChanged)
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.firstView)
        self.view.addSubview(self.secondView)
        self.view.addSubview(self.thirdView)
        
        [lastWeekTopImageView, lastWeekBottomImageView].forEach {
            firstView.addSubview($0)
        }
        
        [lastMonthTopImageView, lastMonthBottomImageView].forEach {
            secondView.addSubview($0)
        }
        
        [sixMonthTopImageView, sixMonthBottomImageView].forEach {
            thirdView.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                        constant: 16),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                         constant: -16),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                       constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            self.firstView.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.firstView.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.firstView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                   constant: -80),
            self.firstView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor,
                                                constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            lastWeekTopImageView.topAnchor.constraint(equalTo: firstView.topAnchor),
            lastWeekBottomImageView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.secondView.leftAnchor.constraint(equalTo: self.firstView.leftAnchor),
            self.secondView.rightAnchor.constraint(equalTo: self.firstView.rightAnchor),
            self.secondView.bottomAnchor.constraint(equalTo: self.firstView.bottomAnchor),
            self.secondView.topAnchor.constraint(equalTo: self.firstView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            lastMonthTopImageView.topAnchor.constraint(equalTo: secondView.topAnchor),
            lastMonthBottomImageView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.thirdView.leftAnchor.constraint(equalTo: self.secondView.leftAnchor),
            self.thirdView.rightAnchor.constraint(equalTo: self.secondView.rightAnchor),
            self.thirdView.bottomAnchor.constraint(equalTo: self.secondView.bottomAnchor),
            self.thirdView.topAnchor.constraint(equalTo: self.secondView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            sixMonthTopImageView.topAnchor.constraint(equalTo: thirdView.topAnchor),
            sixMonthBottomImageView.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor)
        ])
    }
    
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex
    }
}
