//
//  BattleAddViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class BattleAddViewController: UIViewController {

    @IBOutlet weak var addBattleLabel: UILabel!
    @IBOutlet weak var addBattleAvengerImage: UIImageView!
    @IBOutlet weak var addBattleVillainImage: UIImageView!
    
    @IBOutlet weak var addBattleAvenger: UIButton!
    @IBOutlet weak var addBattleVillain: UIButton!
    
    private var selectedAvenger: Avengers?
    private var selectedVillain: Villains?
    
    let dataProvider = DataProvider()
    
    var delegate: BattleDelegate?
    
    lazy var villain: [Villains] = {
        return Utilities.shared.getVillains()
    }()
    
    lazy var battles: [Battles] = {
        return Utilities.shared.getBattles()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        addBattleLabel.text = "Batalla \(battles.count + 1)"
    }
    
    @IBAction func addBattleAvengerButton(_ sender: Any) {
    }
    
    @IBAction func addBattleVillainButton(_ sender: Any) {
    }
    
    @IBAction func addBattleFightButton(_ sender: Any) {
        
        guard let selectedAvenger = self.selectedAvenger else {
            return
        }
        
        guard let selectedVillain = self.selectedVillain else {
            return
        }
        
        let randomAvenger = Double.random(in: 1.0...5.0)
        let randomVillain = Double.random(in: 1.0...5.0)
        
        let avangerResult = Double(selectedAvenger.power) * randomAvenger
        let villainResult = Double(selectedVillain.power) * randomVillain
        
        let winBattle = avangerResult >= villainResult ? KindSuperHeroe.avenger.rawValue : KindSuperHeroe.villain.rawValue
        
        let battle = dataProvider.createBattle()
        
        battle?.setValue(battles.count + 1, forKey: "id")
        battle?.setValue(winBattle, forKey: "win")
        battle?.setValue(selectedAvenger, forKey: "avenger")
        battle?.setValue(selectedVillain, forKey: "villain")
        
        dataProvider.save()
        delegate?.finishBattle()
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vcAvenger = segue.destination as? BattleAvengerSelectViewController
        {
            vcAvenger.delegate = self
        }
        
        if let vcVillain = segue.destination as? BattleVillainSelectViewController{
            vcVillain.delegate = self
        }
    }
    

}

extension BattleAddViewController: SelectedAvengerDelegate {
    func selectedAvenger(avenger: Avengers) {
        self.selectedAvenger = avenger
        
        addBattleAvenger.isHidden = true
        self.addBattleAvengerImage.image = UIImage(named: avenger.image ?? "")
        self.addBattleAvengerImage.alpha = CGFloat(1.0)
    }
}

extension BattleAddViewController: SelectedVillainDelegate {
    func selectedVillain(villain: Villains) {
        self.selectedVillain = villain
        
        addBattleVillain.isHidden = true
        self.addBattleVillainImage.image = UIImage(named: villain.image ?? "")
        self.addBattleVillainImage.alpha = CGFloat(1.0)
    }
}
