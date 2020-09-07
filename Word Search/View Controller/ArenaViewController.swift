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
    let totalWords = 9
    var matrix : Array<[Int]> = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomFromList()
        matrix =  Array(repeating: Array(repeating: 0, count: totalColomns), count: totalRows)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var wordsCollection: UICollectionView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getRandomLetter() -> String {
        let letters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let char = letters.randomElement()!
        return String(char)
    }
    
    func getRandomFromList() {
        // make sure word is not repeating and size > row or column
        for _ in 0...totalWords {
            var word = WordsLists.country_list.randomElement()!
            while (word.count > totalRows || wordsList.contains(word)) {
                word = WordsLists.country_list.randomElement()!
            }
            wordsList.append(word)
        }
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

        cell.letter.text = getRandomLetter()
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
        cell.letter.backgroundColor = UIColor.yellow
        //update Matrix
    }
}
