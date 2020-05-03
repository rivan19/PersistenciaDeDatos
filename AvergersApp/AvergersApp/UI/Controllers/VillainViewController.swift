//
//  VillainViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class VillainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var villains = Utilities.shared.getDataVillain()
    private var villainSelected: Character? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

        // Do any additional setup after loading the view.
    }
    
    func setCharacterSelected(villain : Character) {
        villainSelected = villain
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let vc = segue.destination as? CharacterDetailViewController else {
            return
        }
        
        guard let villain = villainSelected else {
            return
        }
        
        vc.title = villain.name
        vc.navigationItem.title = villain.name
        vc.delegate = self
        vc.setCharacter(character: villain)
        
    }

}

extension VillainViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        let nib = UINib.init(nibName: CharacterTableViewCell.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get task count for current task state selected
        return villains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get custom cell view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellIdentifier,
                                                       for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
    // Get tasks for current task state selected
        
        let villain = villains[indexPath.row]
        let character = Character.init(id: Int(villain.id),
                                       name: villain.name ?? "",
                                       image: villain.image,
                                       descripcion: villain.descripcion,
                                       power: Int(villain.power),
                                       kind: "V")
        
        cell.setCharacter(character)
        cell.delegate = self
        cell.selectCell = { [weak self] () -> Void in
            guard let self = self else {
                return
            }
            
            self.performSegue(withIdentifier: Utilities.shared.segue_Villain, sender: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

extension VillainViewController: SelectedCharacterDelegate {
    func selectedCharacter(character: Character) {
        self.villainSelected = character
    }
}

extension VillainViewController: EditCharacterDelegate {
    func onCharacterSaved(){
        villains = Utilities.shared.getDataVillain()
        tableView.reloadData()
    }
}
