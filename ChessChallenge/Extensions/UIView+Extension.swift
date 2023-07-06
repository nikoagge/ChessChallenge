//
//  UIView+Extension.swift
//  ChessChallenge
//
//  Created by Nikos Aggelidis on 6/7/23.
//

import UIKit

extension UIView {
    static func newAutoLayout() -> Self {
        let view = Self()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }
    
    func fillToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)
        ])
    }
}
