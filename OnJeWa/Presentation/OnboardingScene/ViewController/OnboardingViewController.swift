//
//  OnboardingViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/04.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

final class OnboardingViewController: BaseViewController {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarAppearance()
    }
    
    //MARK: - Views
    
    private let scrollView = UIScrollView()
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 2, currentPage: 1)
    private var onboardingPages: [UIView] = []
    
    //MARK: - Functions
    
    override func setupView() {
        setupSlideScrollView()
        view.addSubview(pageControl)
    }
    
    override func setLayout() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSlideScrollView() {
        let fourOnboardingView = FourOnboardingView()
        fourOnboardingView.delegate = self
    onboardingPages = [FirstOnboardingView(), fourOnboardingView]
        scrollView.contentInsetAdjustmentBehavior = .never
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
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex) + 1
    }
}

extension OnboardingViewController: FourOnboardingViewDelegate {
    func didTapStartButton() {
      let mainViewController = ChoosePetTypeViewController()
          let navigationController = UINavigationController(rootViewController: mainViewController)
          navigationController.navigationBar.shadowImage = UIImage()
          navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
          let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
          guard let delegate = sceneDelegate else { return }
          delegate.window?.backgroundColor = .white
          delegate.window?.rootViewController = navigationController
          UIView.transition(with: delegate.window!, duration: 0.3,
                            options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
