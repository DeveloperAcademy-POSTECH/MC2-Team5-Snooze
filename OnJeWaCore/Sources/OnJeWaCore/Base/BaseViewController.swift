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
}
