//
//  BattleAvengerSelectViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class BattleAvengerSelectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SelectedAvengerDelegate?
    
    lazy var availableAvengers: [Avengers] = {
        return Utilities.shared.getAvengers()
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

extension BattleAvengerSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Get task count for current task state selected
        return availableAvengers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get custom cell view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BattleAvengerSelectTableViewCell.cellIdentifier,
    for: indexPath) as? BattleAvengerSelectTableViewCell else {
    return UITableViewCell()
    }
    // Get tasks for current task state selected
        
        let avenger = availableAvengers[indexPath.row]
        
        cell.delegate = self
        
        cell.imageAvenger.image = UIImage(named: avenger.image ?? "")
        cell.nameAvenger.text = avenger.name
        cell.imagePowerAvenger.image = UIImage(named: Utilities.shared.getImageSuperPower(power: Int(avenger.power)))
        
        cell.setCharacter(avenger: avenger)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
    }
}


extension BattleAvengerSelectViewController: SelectedAvengerBattleDelegate {
    
    func selectedAvengerBattle(avenger: Avengers) {
        
        delegate?.selectedAvenger(avenger: avenger)
        navigationController?.popViewController(animated: true)
    }
}
