//
//  WordsList.swift
//  Word Search
//
//  Created by Anuraj on 9/6/20.
//  Copyright © 2020 Anuraj. All rights reserved.
//

import Foundation

struct WordsListsManager {
    let country_list = ["Austria","Bahamas","Bahrain","Belarus","Belgium","Bermuda","Bhutan","Brazil","Chile","China","Colombia","Congo","Denmark","Fiji","Finland","France","Greece","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Kenya","Kuwait","Lebanon","Lesotho","Liberia","Libya","Malaysia","Maldives","Mali","Malta","Monaco","Nigeria","Norway","Oman","Poland","Portugal","Qatar","Romania","Russia","Singapore","Slovakia","Sudan","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Turkey","Ukraine","Uruguay","Vietnam", "US","Yemen","Zambia"];

    let sports_list =
        [ "Athletics","Archery","Badminton","Baseball",
          "Basketball","Boxing","Canoeing","Curling","Cricket",
          "Cycling","Darts","Diving","Fencing","Football",
          "Gymnastics","Handball","Hockey","Judo","Netball",
          "Rowing","Sailing","Shooting","Snooker","Squash",
          "Swimming","Taekwondo","Tennis","Volleyball","Wrestling"]
    
    func getRandomLetter() -> String {
        let letters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let char = letters.randomElement()!
        return String(char)
    }
    
    func getRandomFromList(totalWords: Int, wordLimit: Int) -> [String] {
        // make sure word is not repeating and size > row or column
        var list: [String] = []
        for _ in 0..<totalWords {
            var word = country_list.randomElement()!
            while (word.count > wordLimit || list.contains(word)) {
                word = country_list.randomElement()!
            }
            list.append(word)
        }
        return list
    }

}
