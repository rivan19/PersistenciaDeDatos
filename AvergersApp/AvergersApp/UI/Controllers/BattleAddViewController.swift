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
    
    private let dataProvider = DataProvider()
    
    lazy var availableAvengers: [Avengers] = {
        return Utilities.shared.getAvengers()
    }()
    
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
    }
    
    @IBAction func addBattleCloseWindowButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
