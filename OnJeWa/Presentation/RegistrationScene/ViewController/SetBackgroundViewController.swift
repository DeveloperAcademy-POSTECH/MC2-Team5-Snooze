//
//  SetBackgroundViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/08.
//

import UIKit

import OnJeWaCore
import OnJeWaUI
import OnJeWaNetwork

final class SetBackgroundViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var setBackgroundImageStatus = false
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    //MARK: - Views
    
    private let setBackgroundView = SetBackgroundView()
    private let pageControl = OnJeWaPageControl(frame: CGRect.zero, entirePage: 4, currentPage: 3)
    
    //MARK: - Functions
    
    override func setupView() {
        
        setBackgroundView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pageControl)
        
        [setBackgroundView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            setBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            setBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            setBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func bindViewModel() { }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = setBackgroundImageStatus ? .black.withAlphaComponent(0.1) : .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension SetBackgroundViewController: SetBackgroundViewDelegate {
    func didTapNextButton() {
        guard let profile else { return }
        let registerAddressViewController = RegisterAddressViewController(profile: profile)
        self.navigationController?.pushViewController(registerAddressViewController, animated: true)
    }
    
    func didSetBackgroundImageView(image: UIImage) {
        setBackgroundImageStatus = true
        self.profile?.backgroundImage = image.jpegData(compressionQuality: 0.5)
        configureNavigationBar()
    }
}
