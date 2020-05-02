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
    
    let villains : [Character] = [Character.init(name: "Yon Rogg", image: "img_heroe_yon_rogg", descripcion: "Descripcion Yon Rogg", power: 5, kind: KindSuperHeroe.villain.rawValue),
    Character.init(name: "Dormammu", image: "img_villain_dormammu", descripcion: "Descripcion: Dormammu", power: 4, kind: KindSuperHeroe.villain.rawValue),
    Character.init(name: "Ego", image: "img_villain_ego", descripcion: "Descripcion: Ego", power: 3, kind: KindSuperHeroe.villain.rawValue),
    Character.init(name: "Hela", image: "img_villain_hela", descripcion: "Descripcion: Hela", power: 2, kind: KindSuperHeroe.villain.rawValue),
    Character.init(name: "Ivan Vanko", image: "img_villain_ivan_vanko", descripcion: "Descripcion: Ivan Vanko", power: 4, kind: KindSuperHeroe.villain.rawValue),
    Character.init(name: "Thanos", image: "img_villain_thanos", descripcion: "Descripcion: Thanos", power: 3, kind: KindSuperHeroe.villain.rawValue)]
    
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
        
        
        cell.setCharacter(villains[indexPath.row])
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
