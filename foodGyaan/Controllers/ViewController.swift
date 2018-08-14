//
//  ViewController.swift
//  foodGyaan
//
//  Created by Hetvi Shah on 7/22/18.
//  Copyright © 2018 Hetvi Shah. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialAppBar

class ViewController: UIViewController {
    
    //Declare all the variables here
    let categoryNames = ["famousFood", "fruits","vegetables","spices"]
    var categorySelected : String = ""
    
    @IBOutlet var CategoriesCard: [MDCCard]!
    @IBOutlet var DescriptionLabels: [UILabel]!
    
    @IBAction func QuizBtnPressed(_ sender: UIButton) {
        print(sender.tag)
        categorySelected = categoryNames[sender.tag]
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    
    @IBOutlet var ScoreLabels: [UILabel]!
    @IBOutlet var QuizBtns: [UIButton]!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateScores()
    }
    
    
    override func viewDidLoad() {
        changeCardsUI()
        createAppBar()
        addBtnsBorder()
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQuiz"{
            let quizVC = segue.destination as! QuizViewController
            quizVC.category = categorySelected
        }
    }
    
    func updateScores(){
        let keys = ["famousFood","fruits","vegetables","spices"]
        for (index, scorelabel) in ScoreLabels.enumerated() {
            let score = UserDefaults.standard.integer(forKey: keys[index])
            scorelabel.text = "Score : \(score)"
        }
    }
    
    
    func createAppBar () {
        let appBar = MDCAppBar()
        self.addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(hexFromString: "#FF0266")
        appBar.addSubviewsToParent()
        appBar.navigationBar.titleTextColor = UIColor.white
        appBar.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: .heavy)] 
        title = "Categories"
        
    }
    
    func addBtnsBorder () {
        for btn in QuizBtns {
            btn.layer.shadowOffset = CGSize(width: 3, height: 2)
            btn.layer.shadowColor = UIColor(hexFromString: "#C0C0C0").cgColor
            btn.layer.shadowRadius = 1
            btn.layer.shadowOpacity = 1.0
            btn.layer.masksToBounds = false
        }
    }
    
    func changeCardsUI (){
        var borderClrs = [UIColor]()
        borderClrs.append(UIColor(hexFromString: "#1b0000"))
        borderClrs.append(UIColor(hexFromString: "#1b0000"))
        borderClrs.append(UIColor(hexFromString: "#1b0000"))
        borderClrs.append(UIColor(hexFromString: "#1b0000"))
        var index = 0;
        for  cards in  CategoriesCard {
            cards.setShadowElevation(ShadowElevation(rawValue: 9.0), for: .normal)
            cards.setShadowColor(borderClrs[index], for: .normal)
            index = index + 1;
        }
    }
    
    
}

