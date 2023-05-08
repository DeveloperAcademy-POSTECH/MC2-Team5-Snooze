//
//  SetBackgroundViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit

import OnJeWaCore
import OnJeWaUI

final class SetBackgroundViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var backgroundImageFlag = false
    private var profile: Profile?

    //MARK: - Life Cycle
    
    init(profile: Profile) {
        super.init(nibName: nil, bundle: nil)
        self.profile = profile
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setBackgroundView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundImageFlag ? .black.withAlphaComponent(0.1) : .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Views
    
    private let setBackgroundView = SetBackgroundView()
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 3)
    
    
    //MARK: - Functions
    
    override func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [setBackgroundView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        setBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            setBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            setBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension SetBackgroundViewController: SetBackgroundViewDelegate {
    func didTapNextButton() {
        print("didTapNextButton")
        let registerAddressViewController = RegisterAddressViewController(profile: self.profile!)
        self.navigationController?.pushViewController(registerAddressViewController, animated: true)
    }
    
    func didSetBackgroundImageView(image: UIImage) {
        print("didSetProfileImageView")
        
        backgroundImageFlag = true
        
        self.profile?.backgroundImage = image
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black.withAlphaComponent(0.1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
