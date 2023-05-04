//
//  OnboardingViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore

// 수정 : 전체 패딩, 컬러, 이미지 추가
final class OnboardingViewController: BaseViewController {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Views
    
    private let scrollView = UIScrollView()
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.currentPage = 0
        control.numberOfPages = 4
        return control
    } ()
    private var onboardingPages: [UIView] = []
    
    //MARK: - Functions
    
    override func setupView() {
        setupSlideScrollView()
        view.addSubview(pageControl)
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            // 수정 : 패딩
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupSlideScrollView() {
        let fourOnboardingView = FourOnboardingView()
        fourOnboardingView.delegate = self
        onboardingPages = [FirstOnboardingView(), SecondOnboardingView(),
                           ThirdOnboardingView(), fourOnboardingView]
        scrollView.isDirectionalLockEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(onboardingPages.count),
                                        height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< onboardingPages.count {
            onboardingPages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0,
                                              width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(onboardingPages[i])
        }
        view.addSubview(scrollView)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension OnboardingViewController: FourOnboardingViewDelegate {
    func didTapStartButton() {
        print("Start button tapped!")
        // after push
    }
}
