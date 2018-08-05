//
//  QuizViewController.swift
//  foodGyaan
//
//  Created by Hetvi Shah on 7/22/18.
//  Copyright © 2018 Hetvi Shah. All rights reserved.
//

import UIKit




class QuizViewController: UIViewController {
    
    var category : String = ""
    var famousFoodNames = ["AlooTikki", "BhajiPav","Bhel","CholeBhature","Dabeli","DahiVada","DryManchurian","Khaman","MasalaDosa","PaniPuri","PaneerTikka","PaniPuri", "Samosa","VadaPav"]
    let fruitsNames = ["Carambola","Chapa","Dadham","Draksh","Galeli","Jambu","Jamrukh","KaachiKeri","Keri","Keru","Limbu","Safarjan","Sherdi","Tarbooch","VilayatiImli"]
    
    let vegetablesNames = ["Bataka","Dudhi","Kaakdi","Kanda","Palak","Tindoora","TuvarLilva","Vatana"]
    let spicesNames = ["Ajmo","Hardar","LaalMarchu","Mari","Meethu"]
    var selectedCatNames = [String]()
    var imageNum = 0;
    var button = UIButton()
    var score = 0;
    var optionBtnTags  = [10,11,12,13];
    var optionBtns = [UIButton]()
    
    
    @IBOutlet weak var Like: DOFavoriteButton!
    
    
    
    @IBAction func NextButton(_ sender: UIButton) {
        Comment.text = " "
        displayNextImage()
    }
    
    @IBAction func ExitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var FoodImageView: UIImageView!
    
    @IBAction func OptionsSelected(_ sender: UIButton) {
       let userAns = sender.title(for: .normal)
        checkAns(userAns: userAns!,userAnsBtnTag: sender.tag )
    }
    
    @IBOutlet weak var Comment: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    
    @IBAction func StopCheering(_ sender: UIButton) {
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        Like.addTarget(self, action: Selector(("tapped:")), for: .touchUpInside)
        print("Hey I am in Quiz View")
        print (category)
        createOptionBtnArr();
        changeBtnUI()
        setSelectedCatNames()
        selectedCatNames = shuffleTheArray(input : selectedCatNames)
        print(selectedCatNames)
        imageNum = -1
        score = 0;
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

    func tapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
        }
    }
    
    
    
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
            var randomBtnTags = optionBtnTags
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
    
    // MARK : checkAns()
    func checkAns (userAns : String , userAnsBtnTag : Int)->Void{
        if (userAns == selectedCatNames[imageNum]){
            Comment.text = "GOOD JOB!!"
            score = score + 1;
          
            Score.text = "Current Score : \(score)"
            
        }
        else {
            Comment.text = "It is Okay. Just keep trying"
            // disable the other buttons
            // animate the right button
            // find the right button
            var btnToAnimate = UIButton()
            for i in optionBtnTags{
                let btn = self.view.viewWithTag(i) as? UIButton
                if (btn?.title(for: .normal) == selectedCatNames[imageNum]){
                    btnToAnimate = btn!
                }
        }
            
            UIButton.animate(withDuration: 0.2, animations: {
                for btn in self.optionBtns {
                    if (btn != btnToAnimate){
                        btn.backgroundColor = UIColor(hexFromString: "#D19D9C")
                    }
                    else {
                        btn.backgroundColor = UIColor(hexFromString: "#B1D3C3")
                    }
                }
//                btnToAnimate.backgroundColor = UIColor(hexFromString: "#B1D3C3")
                btnToAnimate.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            
    }
    }
    
    //MARK : cheerUserUp();
    
    
    //MARK  : changeBtnUI();
    func changeBtnUI(){
        for i in optionBtnTags{
             let btn = self.view.viewWithTag(i) as? UIButton
             btn?.layer.borderWidth = 2.0
            btn?.layer.cornerRadius = (btn?.bounds.size.height)!/2
             btn?.clipsToBounds = true
            btn?.layer.shadowOffset = CGSize(width: 3, height: 5)
            btn?.layer.shadowColor = UIColor(hexFromString: "#C0C0C0").cgColor
            btn?.layer.shadowRadius = 2
            btn?.layer.shadowOpacity = 1.0
            btn?.layer.masksToBounds = false
             btn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            
        }
    }
    
    // MARK : createOptionBtnArr();
    func createOptionBtnArr(){
        for i in optionBtnTags{
            let btn = self.view.viewWithTag(i) as? UIButton
            optionBtns.append(btn!)
    }
    }
    
    
    
    
    
    
    
 
    
            
   
    
    
    
}




