//
//  QuizViewController.swift
//  foodGyaan
//
//  Created by Hetvi Shah on 7/22/18.
//  Copyright © 2018 Hetvi Shah. All rights reserved.
//

import UIKit
import GameplayKit

/**
 Extend array to enable random shuffling
 */




class QuizViewController: UIViewController {
    
    var category : String = ""
    var famousFoodNames = ["BhajiPav", "VadaPav","Dabeli","PaniPuri","Samosa"]
    let fruitsNames = ["Mango", "Keru","Apple"]
    let vegetablesNames = ["Palak","Tindoora","Dudhi"]
    let spicesNames = ["hardar","methu"]
    var selectedCatNames = [String]()
    var imageNum = 0;
    var button = UIButton()
    
    @IBAction func NextButton(_ sender: UIButton) {
    }
    
    @IBAction func ExitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var FoodImageView: UIImageView!
    @IBAction func OptionsSelected(_ sender: UIButton) {
        
         button = sender
        print("Hey I was clicked and my tag is ")
        print(button.tag)
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        print("Hey I am in Quiz View")
        print (category)
        setSelectedCatNames()
        shuffleTheArray()
        imageNum = -1;
        displayNextImage()
        super.viewDidLoad()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    
    //MARK: setSelectedCategoryNames()
    func setSelectedCatNames(){
        if (category == "famousFood"){
            selectedCatNames = famousFoodNames
            }
        else if (category == "fruits"){
            selectedCatNames = fruitsNames
        }
        else if (category == "vegetables"){
            selectedCatNames = vegetablesNames
        }
        else if (category == "spices"){
            selectedCatNames = spicesNames
        }
        
    }
    
    
    
    //MARK: shuffleTheArray()
    //Time Complexity is O(n). Most efficient way!
    func shuffleTheArray(){
        var last = selectedCatNames.count - 1;
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            selectedCatNames.swapAt(last, rand)
            last -= 1
        }
        print ("Shuffled Array")
        print(selectedCatNames)
        
    }
    
    
    //MARK: displayNextImage()
    func displayNextImage(){
        imageNum += 1
        print(imageNum)
        if (imageNum < selectedCatNames.count){
            FoodImageView.image = UIImage(named: "\(selectedCatNames[imageNum])\(".jpg")")
            let btn = self.view.viewWithTag(1) as? UIButton
            btn?.setTitle("Hello", for: .normal)
            
          
            
            
            
        }
    }
    
    
    
    
    
    
    
}




