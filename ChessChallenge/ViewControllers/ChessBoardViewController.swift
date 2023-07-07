//
//  ChessBoardViewController.swift
//  ChessChallenge
//
//  Created by Nikos Aggelidis on 6/7/23.
//

import UIKit

final class ChessBoardViewController: UIViewController {
    private var contentView = UIView.newAutoLayout()
    private var chessBoardCollectionView: UICollectionView!
    
    private var chessBoardSize = 8
    private var chessBoard: [[Bool]] = []
    private var startRow = -1
    private var startColumn = -1
    private var endRow = -1
    private var endColumn = -1
    private var knightPaths: [[(row: Int, column: Int)]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        generateChessBoard()
    }
}

// MARK: - UICollectionViewDatasource, UICollectionViewDelegate

extension ChessBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chessBoardSize * chessBoardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let chessBoardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChessBoardCollectionViewCell.self), for: indexPath) as? ChessBoardCollectionViewCell else { return UICollectionViewCell() }
        // TODO: Might delete it later
//        let row = indexPath.item / chessBoardSize
//        let column = indexPath.item % chessBoardSize
        chessBoardCollectionViewCell.configure(with: Bool.random())
                
        return chessBoardCollectionViewCell
    }
}

// MARK: - Private

private extension ChessBoardViewController {
    func generateChessBoard() {
        chessBoard = Array(
            repeating: Array(
                repeating: false,
                count: chessBoardSize
            ), count: chessBoardSize
        )
    }
    
    func setupUI() {
        setupContentView()
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.fillToSuperview()
        setupChessCollectionView()
    }
    
    func setupChessCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 4
        chessBoardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        chessBoardCollectionView.register(
            ChessBoardCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ChessBoardCollectionViewCell.self)
        )
        chessBoardCollectionView.dataSource = self
        chessBoardCollectionView.delegate = self
        chessBoardCollectionView.allowsMultipleSelection = false
        // TODO: Might delete following line later
        chessBoardCollectionView.backgroundColor = .blue
        contentView.addSubview(chessBoardCollectionView)
        chessBoardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        chessBoardCollectionView.fillToSuperview()
    }
}
