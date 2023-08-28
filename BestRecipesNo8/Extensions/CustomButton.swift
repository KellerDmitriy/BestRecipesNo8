//
//  CustomButton.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit

class CustomButton: UIButton {
    var customTitle: String? {
        didSet {
            setTitle(customTitle, for: .normal)
        }
    }

    init(customTitle: String) {
        super.init(frame: .zero)
        self.customTitle = customTitle
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

  private func setupButton() {
    self.layer.cornerRadius = 10
    self.backgroundColor = .primaryColor

    self.setTitleColor(.whiteColor, for: .normal)
    self.setTitle(customTitle, for: .normal)
      self.titleLabel?.font = .poppinsRegular(size: 16)


    self.translatesAutoresizingMaskIntoConstraints = false
    }
}
