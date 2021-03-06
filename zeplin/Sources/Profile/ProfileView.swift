//
//  ProfileView.swift
//  zeplin
//
//  Created by yagiz on 3/2/20.
//  Copyright © 2020 Yagiz Nizipli. All rights reserved.
//

import SnapKit
import UIKit
import RxSwift
import RxCocoa
import SafariServices
import MessageUI

final class ProfileView: UIView {
  // MARK: - Properties
  var bag = DisposeBag()
  
  private let userImageView: UIView
  
  private let usernameLabel: UILabel = .create(text: "", numberOfLines: 1, textAlignment: .left, textColor: .white, font: .regular(20))
  
  private let emailLabel: UILabel = .create(text: "", numberOfLines: 1, textAlignment: .left, textColor: .white, font: .medium(12))
  
  private lazy var userStack: UIStackView = .create(arrangedSubViews: [usernameLabel, emailLabel], axis: .vertical, alignment: .fill, distribution: .fill, spacing: 4)
  
  private let privacyPolicyButton: UIButton = {
    let view = UIButton(type: .custom)
    view.setTitle("Privacy Policy".localized(), for: .normal)
    view.setTitleColor(.white, for: .normal)
    view.backgroundColor = Colors.profileButtonsBackground.color
    view.titleLabel?.font = UIFont.regular(17)
    view.contentHorizontalAlignment = .leading
    view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    view.snp.makeConstraints { $0.height.equalTo(60) }
    return view
  }()
  
  private let contactButton: UIButton = {
    let view = UIButton(type: .custom)
    view.setTitle("Contact Us".localized(), for: .normal)
    view.setTitleColor(.white, for: .normal)
    view.backgroundColor = Colors.profileButtonsBackground.color
    view.titleLabel?.font = UIFont.regular(17)
    view.contentHorizontalAlignment = .leading
    view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    view.snp.makeConstraints { $0.height.equalTo(60) }
    return view
  }()
  
  private let logoutButton: UIButton = {
    let view = UIButton(type: .custom)
    view.setTitle("Log Out".localized(), for: .normal)
    view.setTitleColor(.white, for: .normal)
    view.backgroundColor = Colors.profileButtonsBackground.color
    view.titleLabel?.font = UIFont.regular(17)
    view.contentHorizontalAlignment = .leading
    view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    view.snp.makeConstraints { $0.height.equalTo(60) }
    return view
  }()
  
  private let informationLabel: UILabel = {
    let texts = [
      "This app is created by two Zeplin admirers in Istanbul.".localized(),
      "We have no association with Zeplin, Inc.".localized(),
      "Zeplin logo is a trademark by Zeplin, Inc.".localized()
      ].joined(separator: "\n")
    let label: UILabel = .create(text: texts, numberOfLines: 0, textAlignment: .center, textColor: Colors.descriptionGray.color, font: .regular(11))
    label.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.2)
    return label
  }()
  
  private let separator: UIView = {
    let view = UIView()
    view.backgroundColor = Colors.seperatorGray.color
    view.snp.makeConstraints { $0.height.equalTo(1) }
    return view
  }()
  
  private lazy var buttonStack: UIStackView = .create(arrangedSubViews: [
    privacyPolicyButton,
    separator,
    contactButton,
    logoutButton,
    informationLabel
  ], axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
  
  // MARK: - Initialization
  init(user: User?) {
    if let user = user {
      userImageView = user.getProfileImage(size: 60, emotarSize: 24, initialSize: 18)
      usernameLabel.text = user.username
      emailLabel.text = user.email
    } else {
      userImageView = UIView()
    }
    

    super.init(frame: .zero)
    
    [userImageView, userStack, buttonStack].forEach(addSubview(_:))
    
    userImageView.snp.makeConstraints {
      $0.leading.top.equalToSuperview()
        .inset(UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 0))
    }
    
    userStack.snp.makeConstraints {
      $0.leading.equalTo(userImageView.snp.trailing).offset(16)
      $0.trailing.equalToSuperview()
      $0.centerY.equalTo(userImageView)
    }
    
    buttonStack.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(userImageView.snp.bottom).offset(24)
    }
    
    buttonStack.setCustomSpacing(32.5, after: contactButton)
    buttonStack.setCustomSpacing(24, after: logoutButton)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Populate
extension ProfileView {
  func onPrivacyPolicy() -> ControlEvent<Void> {
    return privacyPolicyButton.rx.tap
  }
  
  func onContact() -> ControlEvent<Void> {
    return contactButton.rx.tap
  }
  
  func onLogout() -> ControlEvent<Void> {
    return logoutButton.rx.tap
  }
}
