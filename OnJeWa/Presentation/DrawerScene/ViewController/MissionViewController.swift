//
//  MissionViewController.swift
//  OnJeWa
//
//  Created by Kim SungHun on 2023/05/13.
//

import UIKit

import OnJeWaCore
import OnJeWaUI
import AVFoundation

final class MissionViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var clickCellFlag = 1
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = OnjewaColor.main.color
        
        UserDefaultsSetting.mainPet = "rabbit"
        
        switch UserDefaultsSetting.mainPet {
        case "dog":
            let originalImage = UIImage(named: "dogcarrots")
            let size = CGSize(width: originalImage!.size.width / 3, height: originalImage!.size.height / 3)
            let renderer = UIGraphicsImageRenderer(size: size)
            let resizedImage = renderer.image { _ in
                originalImage!.draw(in: CGRect(origin: .zero, size: size))
            }
            bottomImageView.image = resizedImage
            bottomImageView.sizeToFit()
            break
        case "cat":
            let originalImage = UIImage(named: "catcarrots")
            let size = CGSize(width: originalImage!.size.width / 3, height: originalImage!.size.height / 3)
            let renderer = UIGraphicsImageRenderer(size: size)
            let resizedImage = renderer.image { _ in
                originalImage!.draw(in: CGRect(origin: .zero, size: size))
            }
            bottomImageView.image = resizedImage
            bottomImageView.sizeToFit()
            break
        case "parrot":
            let originalImage = UIImage(named: "parrotcarrots")
            let size = CGSize(width: originalImage!.size.width / 3, height: originalImage!.size.height / 3)
            let renderer = UIGraphicsImageRenderer(size: size)
            let resizedImage = renderer.image { _ in
                originalImage!.draw(in: CGRect(origin: .zero, size: size))
            }
            bottomImageView.image = resizedImage
            bottomImageView.sizeToFit()
            break
        case "rabbit":
            let originalImage = UIImage(named: "rabbitcarrots")
            let size = CGSize(width: originalImage!.size.width / 3, height: originalImage!.size.height / 3)
            let renderer = UIGraphicsImageRenderer(size: size)
            let resizedImage = renderer.image { _ in
                originalImage!.draw(in: CGRect(origin: .zero, size: size))
            }
            bottomImageView.image = resizedImage
            bottomImageView.sizeToFit()
            break
        default:
            break
        }
    }
    
    //MARK: - Functions
    
    override func setupView() {
        
        [timeRemainingTitle, timeRemainingValue].forEach {
            timeRemainingStackView.addArrangedSubview($0)
        }
        
        [carrotTitle, carrotValue].forEach {
            carrotStackView.addArrangedSubview($0)
        }
        
        [timeRemainingStackView, carrotStackView].forEach {
            timeRemainingCarrotStackView.addArrangedSubview($0)
        }
        
        [firstCellTitle, firstCellCarrotImage, firstCellCameraImage].forEach {
            firstCell.addSubview($0)
        }
        
        [secondCellTitle, secondCellCarrotImage, secondCellCameraImage].forEach {
            secondCell.addSubview($0)
        }
        
        [thirdCellTitle, thirdCellCarrotImage, thirdCellCameraImage].forEach {
            thirdCell.addSubview($0)
        }
        
        [firstCell, secondCell, thirdCell].forEach {
            firstStackView.addArrangedSubview($0)
        }
        
        [fourCellTitle, fourCellCarrotImage, fourCellCameraImage].forEach {
            fourCell.addSubview($0)
        }
        
        [fiveCellTitle, fiveCellCarrotImage, fiveCellCameraImage].forEach {
            fiveCell.addSubview($0)
        }
        
        [sixCellTitle, sixCellCarrotImage, sixCellCameraImage].forEach {
            sixCell.addSubview($0)
        }
        
        [fourCell, fiveCell, sixCell].forEach {
            secondStackView.addArrangedSubview($0)
        }
        
        [timeRemainingCarrotStackView,
         firstStackView, secondStackView,
         bottomTitle, bottomSubTitle, bottomImageView].forEach {
            view.addSubview($0)
        }
        
        let firstCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        firstCell.addGestureRecognizer(firstCellTapGesture)
        
        let secondCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        secondCell.addGestureRecognizer(secondCellTapGesture)
        
        let thirdCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        thirdCell.addGestureRecognizer(thirdCellTapGesture)
        
        let fourCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        fourCell.addGestureRecognizer(fourCellTapGesture)
        
        let fiveCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        fiveCell.addGestureRecognizer(fiveCellTapGesture)
        
        let sixCellTapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera(_:)))
        sixCell.addGestureRecognizer(sixCellTapGesture)
    }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            timeRemainingCarrotStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                              constant: 20),
            timeRemainingCarrotStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                  constant: 80),
            timeRemainingCarrotStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                   constant: -80),
        ])
        
        NSLayoutConstraint.activate([
            firstCellCarrotImage.topAnchor.constraint(equalTo: firstCell.topAnchor,
                                                      constant: 12),
            firstCellCarrotImage.leadingAnchor.constraint(equalTo: firstCell.leadingAnchor,
                                                          constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            firstCellCameraImage.bottomAnchor.constraint(equalTo: firstCell.bottomAnchor,
                                                         constant: -8),
            firstCellCameraImage.trailingAnchor.constraint(equalTo: firstCell.trailingAnchor,
                                                           constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            firstCellTitle.bottomAnchor.constraint(equalTo: firstCell.bottomAnchor,
                                                   constant: -8),
            firstCellTitle.leadingAnchor.constraint(equalTo: firstCell.leadingAnchor,
                                                    constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            secondCellCarrotImage.topAnchor.constraint(equalTo: secondCell.topAnchor,
                                                       constant: 12),
            secondCellCarrotImage.leadingAnchor.constraint(equalTo: secondCell.leadingAnchor,
                                                           constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            secondCellCameraImage.bottomAnchor.constraint(equalTo: secondCell.bottomAnchor,
                                                          constant: -8),
            secondCellCameraImage.trailingAnchor.constraint(equalTo: secondCell.trailingAnchor,
                                                            constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            secondCellTitle.bottomAnchor.constraint(equalTo: secondCell.bottomAnchor,
                                                    constant: -8),
            secondCellTitle.leadingAnchor.constraint(equalTo: secondCell.leadingAnchor,
                                                     constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            thirdCellCarrotImage.topAnchor.constraint(equalTo: thirdCell.topAnchor,
                                                      constant: 12),
            thirdCellCarrotImage.leadingAnchor.constraint(equalTo: thirdCell.leadingAnchor,
                                                          constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            thirdCellCameraImage.bottomAnchor.constraint(equalTo: thirdCell.bottomAnchor,
                                                         constant: -8),
            thirdCellCameraImage.trailingAnchor.constraint(equalTo: thirdCell.trailingAnchor,
                                                           constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            thirdCellTitle.bottomAnchor.constraint(equalTo: thirdCell.bottomAnchor,
                                                   constant: -8),
            thirdCellTitle.leadingAnchor.constraint(equalTo: thirdCell.leadingAnchor,
                                                    constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            fourCellCarrotImage.topAnchor.constraint(equalTo: fourCell.topAnchor,
                                                     constant: 12),
            fourCellCarrotImage.leadingAnchor.constraint(equalTo: fourCell.leadingAnchor,
                                                         constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            fourCellCameraImage.bottomAnchor.constraint(equalTo: fourCell.bottomAnchor,
                                                        constant: -8),
            fourCellCameraImage.trailingAnchor.constraint(equalTo: fourCell.trailingAnchor,
                                                          constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            fourCellTitle.bottomAnchor.constraint(equalTo: fourCell.bottomAnchor,
                                                  constant: -8),
            fourCellTitle.leadingAnchor.constraint(equalTo: fourCell.leadingAnchor,
                                                   constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            fiveCellCarrotImage.topAnchor.constraint(equalTo: fiveCell.topAnchor,
                                                     constant: 12),
            fiveCellCarrotImage.leadingAnchor.constraint(equalTo: fiveCell.leadingAnchor,
                                                         constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            fiveCellCameraImage.bottomAnchor.constraint(equalTo: fiveCell.bottomAnchor,
                                                        constant: -8),
            fiveCellCameraImage.trailingAnchor.constraint(equalTo: fiveCell.trailingAnchor,
                                                          constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            fiveCellTitle.bottomAnchor.constraint(equalTo: fiveCell.bottomAnchor,
                                                  constant: -8),
            fiveCellTitle.leadingAnchor.constraint(equalTo: fiveCell.leadingAnchor,
                                                   constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            sixCellCarrotImage.topAnchor.constraint(equalTo: sixCell.topAnchor,
                                                    constant: 12),
            sixCellCarrotImage.leadingAnchor.constraint(equalTo: sixCell.leadingAnchor,
                                                        constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            sixCellCameraImage.bottomAnchor.constraint(equalTo: sixCell.bottomAnchor,
                                                       constant: -8),
            sixCellCameraImage.trailingAnchor.constraint(equalTo: sixCell.trailingAnchor,
                                                         constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            sixCellTitle.bottomAnchor.constraint(equalTo: sixCell.bottomAnchor,
                                                 constant: -8),
            sixCellTitle.leadingAnchor.constraint(equalTo: sixCell.leadingAnchor,
                                                  constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: timeRemainingCarrotStackView.bottomAnchor,
                                                constant: 20),
            firstStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 20),
            firstStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -20),
            firstStackView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor,
                                                 constant: 8),
            secondStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 20),
            secondStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -20),
            secondStackView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            bottomTitle.topAnchor.constraint(equalTo: secondStackView.bottomAnchor,
                                             constant: 32),
            bottomTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomSubTitle.topAnchor.constraint(equalTo: bottomTitle.bottomAnchor,
                                                constant: 8),
            bottomSubTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomImageView.topAnchor.constraint(equalTo: bottomSubTitle.bottomAnchor,
                                                 constant: 24),
            bottomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func bindViewModel() { }
    
    
    //MARK: - Views
    
    /// (남은시간 + 02:43:00) + (오늘 번 당근 스택 뷰)
    private lazy var timeRemainingCarrotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    /// 남은시간 + 02:43:00
    private lazy var timeRemainingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    /// 남은시간
    private let timeRemainingTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "남은 시간"
        return label
    }()
    
    /// 02:43:00
    private let timeRemainingValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "02:43:00"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    /// 오늘 번 당근 스택 뷰
    private lazy var carrotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    /// 오늘 번 당근
    private let carrotTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 번 당근"
        return label
    }()
    
    /// 당근 모양
    private let carrotValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🥕x2"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    /// first, second, third cell
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let firstCellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키랑\n셀카 찍기"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let firstCellCarrotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrotbox")
        return imageView
    }()
    
    private let firstCellCameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "camera")
        return imageView
    }()
    
    /// 카키랑 셀카 찍기
    private let firstCell: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.tag = 1
        return view
    }()
    
    private let secondCellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키\n안아주기"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let secondCellCarrotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrotbox")
        return imageView
    }()
    
    private let secondCellCameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "camera")
        return imageView
    }()
    
    /// 카키 안아주기
    private let secondCell: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.tag = 2
        return view
    }()
    
    private let thirdCellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키 배\n만져주기"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let thirdCellCarrotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrotbox")
        return imageView
    }()
    
    private let thirdCellCameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "camera")
        return imageView
    }()
    
    /// 카키 배 만져주기
    private let thirdCell: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.tag = 3
        return view
    }()
    
    /// four, five, six cell
    private lazy var secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let fourCellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키와\n함께한\n저녁 식사"
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let fourCellCarrotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrotbox")
        return imageView
    }()
    
    private let fourCellCameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "camera")
        return imageView
    }()
    
    /// 카키와 함께한 저녁식사
    private let fourCell: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.tag = 4
        return view
    }()
    
    private let fiveCellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키랑\n소파에서\n놀기"
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let fiveCellCarrotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrotbox")
        return imageView
    }()
    
    private let fiveCellCameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "camera")
        return imageView
    }()
    
    /// 카키랑 소파에서 놀기
    private let fiveCell: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.tag = 5
        return view
    }()
    
    private let sixCellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키랑\n터그놀이\n같이하기"
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let sixCellCarrotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrotbox")
        return imageView
    }()
    
    private let sixCellCameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "camera")
        return imageView
    }()
    
    /// 카키랑 터그놀이 같이하기
    private let sixCell: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.tag = 6
        return view
    }()
    
    private let bottomTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "카키가 나와 함께 하고 싶어해요."
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = OnjewaColor.camerabutton.color
        return label
    }()
    
    private let bottomSubTitle: UILabel = {
        let attributedString = NSMutableAttributedString(string: "카키가 나의 시간을 얻기 위해 모아둔 당근이에요.\n미션을 수행해서 당근을 모아서 앨범을 채워보세요.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = OnjewaColor.button.color
        return label
    }()
    
    private let bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

extension MissionViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        switch clickCellFlag {
        case 1:
            self.firstCell.image = image
            break
        case 2:
            self.secondCell.image = image
            break
        case 3:
            self.thirdCell.image = image
            break
        case 4:
            self.fourCell.image = image
            break
        case 5:
            self.fiveCell.image = image
            break
        case 6:
            self.sixCell.image = image
            break
        default:
            break
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlertGoToSetting() {
        let alertController = UIAlertController(
            title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
            message: "설정 > {앱 이름}탭에서 접근을 활성화 할 수 있습니다.",
            preferredStyle: .alert
        )
        let cancelAlert = UIAlertAction(
            title: "취소",
            style: .cancel
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let goToSettingAlert = UIAlertAction(
            title: "설정으로 이동하기",
            style: .default) { _ in
                guard
                    let settingURL = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingURL)
                else { return }
                UIApplication.shared.open(settingURL, options: [:])
            }
        [cancelAlert, goToSettingAlert]
            .forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    @objc private func openCamera(_ sender: UITapGestureRecognizer) {
#if targetEnvironment(simulator)
        fatalError()
#endif
        
        guard let imageView = sender.view as? UIImageView else { return }
        clickCellFlag = imageView.tag
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
            guard isAuthorized else {
                self?.showAlertGoToSetting()
                return
            }
            
            DispatchQueue.main.async {
                let pickerController = UIImagePickerController()
                pickerController.sourceType = .camera
                pickerController.allowsEditing = false
                pickerController.mediaTypes = ["public.image"]
                pickerController.delegate = self
                self?.present(pickerController, animated: true)
            }
        }
    }
}
