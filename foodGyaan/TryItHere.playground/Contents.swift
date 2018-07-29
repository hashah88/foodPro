//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func getRandom (word : String) -> String {
    
    var op =  selectedNames[Int(arc4random_uniform(UInt32(selectedNames.count)))]
    
    if (op == word) {
        op = getRandom(word : word)
    }
    
    return op
}






var selectedNames = ["apple" , "banana" , "mango", "leaf", "opp" , "hetvi", "khushi","hello", "reema"]
var options = ["reema"]
for _ in 0...2 {
    var name = getRandom(word: " ")
    if (options.contains(name)){
        name = getRandom(word : name)
    }
    options.append(name)
    
}
print(options)




