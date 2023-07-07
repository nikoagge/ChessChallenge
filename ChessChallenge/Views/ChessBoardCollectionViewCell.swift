//
//  ChessBoardCollectionViewCell.swift
//  ChessChallenge
//
//  Created by Nikos Aggelidis on 6/7/23.
//

import UIKit

final class ChessBoardCollectionViewCell: UICollectionViewCell {
    private let positionLabel = UILabel.newAutoLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with highlighted: Bool) {
        positionLabel.text = ""
        
        backgroundColor = highlighted ? .green : .white
    }
}

// MARK: - Private

private extension ChessBoardCollectionViewCell {
    func setupUI() {
        setupPositionLabel()
    }
    
    func setupPositionLabel() {
        positionLabel.textAlignment = .center
        contentView.addSubview(positionLabel)
        positionLabel.fillToSuperview()
    }
}
