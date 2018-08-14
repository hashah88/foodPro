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
    var cheerBtnTags = [10 : 1, 11 : 2, 12 : 3, 13: 4]
    
    @IBOutlet weak var Like: DOFavoriteButton!
    @IBAction func ClosePopUp(_ sender: UIButton) {
        
    }
    @IBAction func NextButton(_ sender: UIButton) {
        changeBtnUI()
        enableOrDisableBtns(disable: false)
        hideCheerBtns()
        displayNextImage()
    }
    
    @IBAction func ExitButton(_ sender: UIButton) {
        UserDefaults.standard.set(score, forKey: category)
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var FoodImageView: UIImageView!
    
    @IBAction func OptionsSelected(_ sender: UIButton) {
        let userAns = sender.title(for: .normal)
        checkAns(userAns: userAns!,userAnsBtnTag: sender.tag )
    }
    
    
    @IBAction func exitFromQuiz(_ sender: UIButton) {
        UserDefaults.standard.set(score, forKey: category)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restartQuiz(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, animations: {
            self.labelForPopUp.alpha = 0
            var newFrame = self.PopUpView.frame
            newFrame.origin.x = -330
            self.PopUpView.frame = newFrame
        })
        selectedCatNames = shuffleTheArray(input : selectedCatNames)
        imageNum = -1
        score = 0;
        displayNextImage()
    }
    
    @IBOutlet weak var labelForPopUp: UILabel!
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var Comment: UILabel!
    @IBOutlet weak var Score: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        hideCheerBtns()
        createOptionBtnArr()
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
            
            showPopUp()
            
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
            score = score + 1;
            enableOrDisableBtns(disable: true)
            let btn = self.view.viewWithTag(userAnsBtnTag) as? UIButton
            btn?.backgroundColor = UIColor(hexFromString: "#B1D3C3")
            let tagNo = cheerBtnTags[userAnsBtnTag]
            let showCheerBtn = self.view.viewWithTag(tagNo!) as? DOFavoriteButton
            showCheerBtn?.isHidden = false
            showCheerBtn?.select()
            Score.text = "Current Score : \(score)"
            
        }
        else {
            var btnToAnimate = UIButton()
            for i in optionBtnTags{
                let btn = self.view.viewWithTag(i) as? UIButton
                if (btn?.title(for: .disabled) == selectedCatNames[imageNum]){
                    btnToAnimate = btn!
                    print("the button to animate's tag is")
                    print (btnToAnimate.tag)
                }
            }
            UIButton.animate(withDuration: 0.4, animations: {
                for btn in self.optionBtns {
                    if (btn != btnToAnimate){
                        btn.backgroundColor = UIColor(hexFromString: "#D19D9C")
                    }
                    else {
                        btn.backgroundColor = UIColor(hexFromString: "#B1D3C3")
                    }
                }
            })
            
        }
    }
    
    
    
    
    //MARK  : changeBtnUI();
    func changeBtnUI(){
        var index = 0;
        for i in optionBtnTags{
            let btn = self.view.viewWithTag(i) as? UIButton
            btn?.backgroundColor = UIColor(hexFromString: "#DAE6E8")
            btn?.layer.cornerRadius = (btn?.bounds.size.height)!/2
            btn?.clipsToBounds = true
            btn?.layer.shadowOffset = CGSize(width: 3, height: 5)
            btn?.layer.shadowColor = UIColor(hexFromString: "#C0C0C0").cgColor
            btn?.layer.shadowRadius = 2
            btn?.layer.shadowOpacity = 1.0
            btn?.layer.masksToBounds = false
            btn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            index = index + 1
        }
    }
    
    // MARK : createOptionBtnArr();
    func createOptionBtnArr(){
        for i in optionBtnTags{
            let btn = self.view.viewWithTag(i) as? UIButton
            optionBtns.append(btn!)
        }
        
    }
    
    //MARK : hideCheerBtns
    func hideCheerBtns(){
        let btns = getCheerBtns()
        for btn in btns {
            btn.isHidden = true
        }
        
        
    }
    
    //MARK : getCheerBtns
    func getCheerBtns() -> [DOFavoriteButton]{
        var btns = [DOFavoriteButton]()
        for i in 1...4 {
            let btn = self.view.viewWithTag(i) as? DOFavoriteButton
            btns.append(btn!)
        }
        return btns
        
    }
    
    // MARK : disableBtns()
    func enableOrDisableBtns (disable : Bool){
        for btn in optionBtns{
            if (disable){
                btn.isEnabled = false
            }
            else {
                btn.isEnabled = true
            }
        }
    }
    
    //MARK : showPopUp()
    func showPopUp(){
        UIView.animate(withDuration: 0.4, animations: {
            self.labelForPopUp.alpha = 1
            let gradientLayer:CAGradientLayer = CAGradientLayer()
            gradientLayer.frame.size = self.labelForPopUp.frame.size
            let color1 = UIColor(hexFromString: "#ff8a70")
            let color2 = UIColor(hexFromString: "#ffa48f")
            let color3 = UIColor(hexFromString: "#f96772")
            let color4 = UIColor(hexFromString: "#f9b9ab")
            gradientLayer.colors = [color1.cgColor, color2.cgColor,color4.cgColor, UIColor.white.cgColor, color4.cgColor,color3.cgColor]
            self.labelForPopUp.layer.addSublayer(gradientLayer)
            var newFrame = self.PopUpView.frame
            newFrame.origin.x = 30
            self.PopUpView.frame = newFrame
            self.PopUpView.layer.cornerRadius = 5;
            self.PopUpView.layer.masksToBounds = true;
        })
    }
    
    
}




