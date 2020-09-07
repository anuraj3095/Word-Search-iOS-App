//
//  ArenaViewController.swift
//  Word Search
//
//  Created by Anuraj on 9/6/20.
//  Copyright © 2020 Anuraj. All rights reserved.
//

import UIKit

class ArenaViewController: UIViewController {

    let reuseIdentifier = "letterCell"
    var wordsList: [String] = []
    let totalElements = 144
    let totalRows = 12
    let totalColomns = 12
    let totalWords = 3
    var matrix : Array<[Int]> = [[]]
    var wordsLabelsList : Array<UILabel> = []
    var currentWordSelection: String = "" {
        didSet {
            checkWordSelection()
        }
    }
    var selectedCells: [Int] = []
    var numberOfWordsGuessed = 0
    var wordsManager = WordsListsManager()
    var wordCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
//        wordsList = wordsManager.getRandomFromList(totalWords: totalWords, wordLimit: totalColomns, category: wordCategory)
//        updateWordsLables()
//        matrix =  Array(repeating: Array(repeating: 0, count: totalColomns), count: totalRows)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlets
    @IBOutlet weak var wordsCollection: UICollectionView!
    @IBOutlet weak var word1Label: UILabel!
    @IBOutlet weak var word2Label: UILabel!
    @IBOutlet weak var word3Label: UILabel!
    @IBOutlet weak var word4Label: UILabel!
    @IBOutlet weak var word5Label: UILabel!
    @IBOutlet weak var word6Label: UILabel!
    
    // MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        resetGame()
    }
    // MARK: - methods
    
    
    func updateWordsLables() {
        wordsLabelsList.append(word1Label)
        wordsLabelsList.append(word2Label)
        wordsLabelsList.append(word3Label)
        wordsLabelsList.append(word4Label)
        wordsLabelsList.append(word5Label)
        wordsLabelsList.append(word6Label)
        word1Label.text = wordsList[0]
        word2Label.text = wordsList[1]
        word3Label.text = wordsList[2]
//        word4Label.text = wordsList[3]
//        word5Label.text = wordsList[4]
//        word6Label.text = wordsList[5]
    }
    
    func addWordsToCollection() {
        
        for word in wordsList {
            
            var startRow = Int.random(in: 0..<totalRows)
            var startColumn = Int.random(in: 0..<totalColomns)
            let wordSize = word.count
            // if we have space to add in right continue or again get a random value
            
            var row = startRow
            var colm = startColumn
            var iter = 0
            
            while iter != wordSize {
                
                if colm >= totalColomns || row >= totalRows || matrix[row][colm] == 1  {
                    // we have collision or we are out of bounds get a new
                    iter = 0 // reset iterations
                    // get new starting row and colmn
                    startRow = Int.random(in: 0..<totalRows)
                    startColumn = Int.random(in: 0..<totalColomns)
                    row = startRow
                    colm = startColumn
                } else {
                    iter += 1
                    //row += 1
                    colm += 1
                }
            }
            
            // we got a place to put our word
            var indx = (startRow * totalRows) + startColumn
            for char in word {
            let indxPath = IndexPath(row: indx, section: 0)
                if let cell = wordsCollection.cellForItem(at: indxPath) as? WordCollectionViewCell {
                cell.letter.text = String(char).capitalized
                // testing new entries
                cell.letter.textColor = UIColor.red
                //update Matrix
                }
                matrix[startRow][startColumn] = 1
                //startRow += 1
                startColumn += 1
                indx += 1
                
            }
            
        }

    }

}

extension ArenaViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // will be dynamic for different levels
        return totalElements //self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WordCollectionViewCell

        cell.letter.text = wordsManager.getRandomLetter()
        cell.letter.textColor = UIColor.black
        //cell.backgroundColor = UIColor.cyan
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == totalElements - 1 {
            // done loading all collection view cells
            DispatchQueue.main.async {
                self.addWordsToCollection()
            }
        }
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item) and section \(indexPath.section) and  row \(indexPath.row)!")
        
        let cell = wordsCollection.cellForItem(at: indexPath) as! WordCollectionViewCell
        
        if selectedCells.isEmpty || selectedCells.last == indexPath.item - 1 {
            cell.letter.backgroundColor = UIColor.yellow
            selectedCells.append(indexPath.row)
            currentWordSelection += cell.letter.text!
        }
        else {
            clearAllSelction()
        }
    }
    
    func clearAllSelction() {
        currentWordSelection = ""
        for cellIndx in selectedCells {
            let cell = wordsCollection.cellForItem(at: IndexPath(row: cellIndx, section: 0)) as! WordCollectionViewCell
            cell.letter.backgroundColor = UIColor.clear
        }
        selectedCells.removeAll()
    }
    
    func checkWordSelection() {
        var indx = 0
        for word in wordsList {
            
            if word.caseInsensitiveCompare(currentWordSelection) == .orderedSame {
                
                numberOfWordsGuessed += 1
                for cellIndx in selectedCells {
                    let cell = wordsCollection.cellForItem(at: IndexPath(row: cellIndx, section: 0)) as! WordCollectionViewCell
                    cell.letter.textColor = UIColor.green
                    cell.letter.backgroundColor = UIColor.clear
                }
                
                wordsLabelsList[indx].textColor = UIColor.red
                currentWordSelection = ""
                selectedCells.removeAll()
            }
            indx += 1
        }
        
        if numberOfWordsGuessed == totalWords {
            //Alert User we won
            winAlert()
            //resetGame()
        }
    }
    
    func winAlert() {
        let alert = UIAlertController(title: "WON",message: "You Found Them ALL", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "RESET", style: .destructive, handler: {_ in self.resetGame()})
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion:  nil)
        // change the background color
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        //subview.backgroundColor = UIColor.purple
    }
    
    func resetGame() {
        numberOfWordsGuessed = 0
        selectedCells.removeAll()
        currentWordSelection = ""
        matrix =  Array(repeating: Array(repeating: 0, count: totalColomns), count: totalRows)
        wordsList = wordsManager.getRandomFromList(totalWords: totalWords, wordLimit: totalColomns, category: wordCategory)
        wordsCollection.reloadData()
        updateWordsLables()
        
    }
}
