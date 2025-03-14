//
//  BattleViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    let dataProvider = DataProvider()
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var battles: [Battles] = {
        return Utilities.shared.getBattles()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? BattleAddViewController {
            vc.delegate = self
        }
    }
    

}

extension BattleViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Get task count for current task state selected
        return battles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get custom cell view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BattleTableViewCell.cellIdentifier,
    for: indexPath) as? BattleTableViewCell else {
    return UITableViewCell()
    }
    // Get tasks for current task state selected

        cell.setBattle(battles: battles[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
    }
}

extension BattleViewController: BattleDelegate {
    func finishBattle() {
        battles = Utilities.shared.getBattles()
        self.tableView.reloadData()
    }
}
