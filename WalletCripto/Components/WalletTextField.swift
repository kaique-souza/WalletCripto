//
//  WallettextField.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import UIKit

class WalletTextField : UITextField {

    init() {
        super.init(frame: .zero)
        applyStyle()
        setupHierarchy()
        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyStyle() {
        textColor = UIColor.darkGray
    }

    lazy var view: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
}

extension WalletTextField: ViewCode {
    func setupHierarchy() {
        addSubview(view)
    }

    func setupContraints() {
        self.view.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension String {
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        return formatter.string(from: number)!
    }

    func isNotnull() -> Bool {
        guard self != "" else { return false }
        return true
    }
}
