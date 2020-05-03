//
//  BattleAvengerSelectViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class BattleVillainSelectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SelectedVillainDelegate?
    
    lazy var availableVillain: [Villains] = {
        return Utilities.shared.getVillains()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
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

extension BattleVillainSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Get task count for current task state selected
        return availableVillain.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get custom cell view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BattleVillainSelectTableViewCell.cellIdentifier,
    for: indexPath) as? BattleVillainSelectTableViewCell else {
    return UITableViewCell()
    }
    // Get tasks for current task state selected
        let villain = availableVillain[indexPath.row]
        
        cell.delegate = self
        
        cell.imageVillain.image = UIImage(named: villain.image ?? "")
        cell.nameVillain.text = villain.name
        cell.imagePowerVillain.image = UIImage(named: Utilities.shared.getImageSuperPower(power: Int(villain.power)))
        
        cell.setCharacter(villain: villain)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
    }
}

extension BattleVillainSelectViewController: SelectedVillainBattleDelegate {
    func selectedVillainBattle(villain: Villains) {
        delegate?.selectedVillain(villain: villain)
        navigationController?.popViewController(animated: true)
    }
}
