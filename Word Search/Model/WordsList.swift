//
//  WordsList.swift
//  Word Search
//
//  Created by Anuraj on 9/6/20.
//  Copyright © 2020 Anuraj. All rights reserved.
//

import Foundation

enum Direction: Int {
    case horizontal = 0
    case vertical = 1
}

struct WordsListsManager {
    
    static let categories = ["Countries", "Sports", "Body Parts"]
    
    let country_list = ["Austria","Bahamas","Bahrain","Belarus","Belgium","Bermuda","Bhutan","Brazil","Chile","China","Colombia","Congo","Denmark","Fiji","Finland","France","Greece","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Kenya","Kuwait","Lebanon","Lesotho","Liberia","Libya","Malaysia","Maldives","Mali","Malta","Monaco","Nigeria","Norway","Oman","Poland","Portugal","Qatar","Romania","Russia","Singapore","Slovakia","Sudan","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Turkey","Ukraine","Uruguay","Vietnam", "US","Yemen","Zambia"];

    let sports_list =
        [ "Athletics","Archery","Badminton","Baseball",
          "Basketball","Boxing","Canoeing","Curling","Cricket",
          "Cycling","Darts","Diving","Fencing","Football",
          "Gymnastics","Handball","Hockey","Judo","Netball",
          "Rowing","Sailing","Shooting","Snooker","Squash",
          "Swimming","Taekwondo","Tennis","Volleyball","Wrestling"]
    
    let bodyParts_list = ["Hair","Head","Ears", "Neck", "Shoulder", "Arms", "Chest", "Waist", "Elbow", "Forearm", "Back", "Hips", "Waist", "Groin", "Thigh", "Knee", "Calf", "Heel", "Ankle", "Foot"]
    
    func getRandomLetter() -> String {
        let letters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let char = letters.randomElement()!
        return String(char)
    }
    
    func getRandomFromList(totalWords: Int, wordLimit: Int, category: String) -> [String] {
        // make sure word is not repeating and size > row or column
        var wordsBucket = country_list
        switch category {
        case WordsListsManager.categories[0]:
            wordsBucket = country_list
        case WordsListsManager.categories[1]:
            wordsBucket = sports_list
        case WordsListsManager.categories[2]:
            wordsBucket = bodyParts_list
        default:
            break
        }
        
        var list: [String] = []
        for _ in 0..<totalWords {
            var word = wordsBucket.randomElement()!
            while (word.count > wordLimit || list.contains(word)) {
                word = wordsBucket.randomElement()!
            }
            list.append(word)
        }
        return list
    }

}
