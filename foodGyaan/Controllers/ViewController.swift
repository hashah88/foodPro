//
//  ViewController.swift
//  foodGyaan
//
//  Created by Hetvi Shah on 7/22/18.
//  Copyright © 2018 Hetvi Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Declare all the variables here
   let categoryNames = ["famousFood", "fruits","vegetables","spices"]
    var categorySelected : String = ""
    
    
    
    
    @IBAction func CategorySelected(_ sender: UIButton) {
   categorySelected = categoryNames[sender.tag]
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQuiz"{
            let quizVC = segue.destination as! QuizViewController
            quizVC.category = categorySelected
            
        }
    }


}

