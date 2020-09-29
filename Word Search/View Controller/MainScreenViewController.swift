//
//  MainScreenViewController.swift
//  Word Search
//
//  Created by Anuraj on 9/6/20.
//  Copyright © 2020 Anuraj. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var wordsCategoryPicker : UIPickerView!
    
    @IBOutlet weak var wordCategortField: UITextField!
    var selectedCategory : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCategoryPicker()
    }
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToArena", sender: self)
    }
    
    func setupCategoryPicker() {
        wordsCategoryPicker = UIPickerView()
        wordsCategoryPicker.delegate = self
        wordCategortField.inputView = wordsCategoryPicker
        wordCategortField.addTarget(self, action: #selector(selectedWordCategoryPicker), for: .touchDown)
        dismissPickerOnTap()
    }
    
    @objc func selectedWordCategoryPicker(textField: UITextField) {
        wordsCategoryPicker.selectRow(selectedCategory, inComponent: 0, animated: false)
        wordsCategoryPicker.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WordsListsManager.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return WordsListsManager.categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = row
        wordCategortField.text = WordsListsManager.categories[row]
        print(WordsListsManager.categories[selectedCategory])
    }
    
    // MARK: Dismiss input views
    
    //tap off the picker to dismiss
    func dismissPickerOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ArenaViewController
        
        if selectedCategory == -1 {
            // set to only tech
            selectedCategory = 0
                //Int.random(in: 0..<WordsListsManager.categories.count)
        }
        
        destinationVC.wordCategory = WordsListsManager.categories[selectedCategory]
    }
}

