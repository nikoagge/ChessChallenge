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
    
    func configure(
        rowNumber: Int,
        columnNumber: Int,
        highlighted: Bool
    ) {
        positionLabel.text = "\(rowNumber), \(matchColumnNumberWithLetter(for: columnNumber))"
        backgroundColor = highlighted ? .black : .white
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
    
    func matchColumnNumberWithLetter(for columnNumber: Int) -> String {
        switch columnNumber {
        case 0:
            return "A"
        case 1:
            return "B"
            
        case 2:
            return "C"
            
        case 3:
            return "D"
            
        case 4:
            return "E"
            
        case 5:
            return "F"
            
        case 6:
            return "G"
            
        default:
            return "H"
        }
    }
}
