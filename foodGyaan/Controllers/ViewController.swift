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
    
    @IBOutlet weak var famousFoodScore: UILabel!
    @IBOutlet weak var fruitsScore: UILabel!
    @IBOutlet weak var spicesScore: UILabel!
    @IBOutlet weak var vegetablesScore: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Your Code Here...
        updateScores();
    }
    
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
    
    func updateScores(){
        print ( "Hey I entered and will be displaying the default values")
        let score1 = UserDefaults.standard.integer(forKey: "famousFood")
        let score2 = UserDefaults.standard.integer(forKey: "fruits")
        let score3 = UserDefaults.standard.integer(forKey: "vegetables")
        let score4 = UserDefaults.standard.integer(forKey: "spices")
        print ("I am printing the scores")
        print(score1)
        print (score2)
        famousFoodScore.text = "Score : \(score1)"
        fruitsScore.text = "Score : \(score2)"
        vegetablesScore.text = "Score : \(score3)"
        spicesScore.text = "Score : \(score4)"
    }

}

