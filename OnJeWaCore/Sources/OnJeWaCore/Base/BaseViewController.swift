//
//  File.swift
//  
//
//  Created by Kim SungHun on 2023/04/25.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setLayout()
        bindViewModel()
    }
    
    open func setupView() { }
    
    open func setLayout() { }
    
    open func bindViewModel() { }
	
	public func configureNavigationBar() {
		self.navigationItem.hidesBackButton = true
		
		let backbutton = UIBarButtonItem(image: UIImage(named: "backbutton")?
			.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 0.0)),
										 style: .done, target: self, action: #selector(back))
		backbutton.tintColor = .black
		self.navigationItem.leftBarButtonItem = backbutton
		
		navigationController?.navigationBar.shadowImage = UIImage()
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .white
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
	}
	
	@objc func back() {
		self.navigationController?.popViewController(animated: true)
	}
}
