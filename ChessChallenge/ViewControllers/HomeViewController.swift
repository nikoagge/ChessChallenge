//
//  HomeViewController.swift
//  ChessChallenge
//
//  Created by Nikos Aggelidis on 6/7/23.
//

import UIKit

final class HomeViewController: UIViewController {
    private var contentView = UIView.newAutoLayout()
    private var chessCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension HomeViewController {
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
        collectionViewFlowLayout.minimumLineSpacing = 0
        chessCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
//        chessCollectionView.register(ChessboardCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//        chessCollectionView.dataSource = self
//        chessCollectionView.delegate = self
        chessCollectionView.backgroundColor = .green
        contentView.addSubview(chessCollectionView)
        chessCollectionView.translatesAutoresizingMaskIntoConstraints = false
        chessCollectionView.fillToSuperview()
    }
}
