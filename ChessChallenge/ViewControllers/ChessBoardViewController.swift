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
        let row = indexPath.item / chessBoardSize
        let column = indexPath.item % chessBoardSize
        chessBoardCollectionViewCell.configure(
            rowNumber: row+1,
            columnNumber: column,
            highlighted: chessBoard[row][column]
        )
                
        return chessBoardCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let row = indexPath.item / chessBoardSize
            let column = indexPath.item % chessBoardSize
            
            if startRow == -1 && startColumn == -1 {
                startRow = row
                startColumn = column
                chessBoard[startRow][startColumn] = true
                chessBoardCollectionView.reloadItems(at: [indexPath])
            } else if endRow == -1 && endColumn == -1 {
                endRow = row
                endColumn = column
                chessBoard[endRow][endColumn] = true
                chessBoardCollectionView.reloadItems(at: [indexPath])
                
                calculateKnightPaths()
                
                if knightPaths.isEmpty {
                    showAlert(withMessage: "No solution found.")
                } else {
                    chessBoardCollectionView.reloadData()
                    showPathsAlert()
                }
            }
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
    
    func calculateKnightPaths() {
        knightPaths = []
        var path: [(row: Int, column: Int)] = []
        path.append((row: startRow, column: startColumn))
        dfs(row: startRow, column: startColumn, moves: 0, path: &path)
    }
        
    func dfs(row: Int, column: Int, moves: Int, path: inout [(row: Int, column: Int)]) {
        if moves == 3 {
            if row == endRow && column == endColumn {
                knightPaths.append(path)
            }
            
            return
        }
        
        let possibleMoves = [(2, 1), (1, 2), (-2, 1), (-1, 2), (2, -1), (1, -2), (-2, -1), (-1, -2)]
        for move in possibleMoves {
            let newRow = row + move.0
            let newColumn = column + move.1
            
            if newRow >= 0 && newRow < chessBoardSize && newColumn >= 0 && newColumn < chessBoardSize && !path.contains(where: { $0.row == newRow && $0.column == newColumn }) {
                path.append((row: newRow, column: newColumn))
                dfs(row: newRow, column: newColumn, moves: moves + 1, path: &path)
                path.removeLast()
            }
        }
    }
        
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
        
    func showPathsAlert() {
        let alertController = UIAlertController(title: "Paths", message: "\(knightPaths.count) possible paths found.", preferredStyle: .alert)
        
        for (index, path) in knightPaths.enumerated() {
            let pathString = path.map({ "\($0.column)\(String(UnicodeScalar($0.row + 65)!))" }).joined(separator: " -> ")
            let actionTitle = "\(index + 1). \(pathString)"
            let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
