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
    var famousFoodNames = ["AlooTikki", "BhajiPav","Bhel","CholeBhature","Dabeli","DahiVada","DryManchurian","Khaman","MasalaDosa","PaniPuri","PaneerTikka","PaniPuri", "Samosa","VadaPav"]
    let fruitsNames = ["Carambola","Chapa","Dadham","Draksh","Galeli","Jambu","Jamrukh","KaachiKeri","Keri","Keru","Limbu","Safarjan","Sherdi","Tarbooch","VilayatiImli"]
    
    let vegetablesNames = ["Bataka","Dudhi","Kaakdi","Kanda","Palak","Tindoora","TuvarLilva","Vatana"]
    let spicesNames = ["Ajmo","Hardar","LaalMarchu","Mari","Meethu"]
    var selectedCatNames = [String]()
    var imageNum = 0;
    var button = UIButton()
    
    @IBAction func NextButton(_ sender: UIButton) {
        displayNextImage()
    }
    
    @IBAction func ExitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var FoodImageView: UIImageView!
    @IBAction func OptionsSelected(_ sender: UIButton) {
        print("Hey i am inside the Options selected and My tag number is")
        print(sender.tag)
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        print("Hey I am in Quiz View")
        print (category)
        setSelectedCatNames()
        selectedCatNames = shuffleTheArray(input : selectedCatNames)
        print(selectedCatNames)
        imageNum = -1
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
    func shuffleTheArray<T>(input : [T])->[T]{
        var shuffledArray = input;
        var last = shuffledArray.count - 1;
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            shuffledArray.swapAt(last, rand)
            last -= 1
        }
        return shuffledArray
        
    }
    
    
    //MARK: displayNextImage()
    func displayNextImage(){
        imageNum += 1
        print(imageNum)
        if (imageNum < selectedCatNames.count){
            FoodImageView.image = UIImage(named: "\(selectedCatNames[imageNum])\(".jpg")")
            setOptions();
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
            
            
            
    //MARK: setOptions()
    
    func setOptions(){
            var randomBtnTags = [10,11,12,13]
            var randomOptions = [selectedCatNames[imageNum]]
        
        for _ in 1...3{
            let option = getRandomName(isPresent: randomOptions)
            randomOptions.append(option)
        }

        randomOptions = shuffleTheArray(input: randomOptions)
        randomBtnTags = shuffleTheArray(input: randomBtnTags)
        print(randomOptions)
        print(randomBtnTags)
        for i in 0...3{
                let btn = self.view.viewWithTag(randomBtnTags[i]) as? UIButton
                    btn?.setTitle(randomOptions[i], for: .normal)
        }
            
    }
    
    
    
    
    
    
    //MARK : getRandomName()
    func getRandomName(isPresent : [String])-> String {
        
        var option = selectedCatNames[Int(arc4random_uniform(UInt32(selectedCatNames.count)))]
        
        if (isPresent.contains(option)){
            option = getRandomName(isPresent: isPresent)
        }
        
        return option
        
    }
    
    
            
            
            
    
    
    
    
    
    
    
    
    
}




