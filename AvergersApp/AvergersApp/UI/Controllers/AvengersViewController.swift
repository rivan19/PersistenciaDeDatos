//
//  ViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 30/04/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class AvengersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let segue_Avenger = "SEGUE_HEROES_DETAIL"
    let avengers : [Character] = [Character.init(name: "Capitana Marvel", image: "img_heroe_marvel_captain", descripcion: "Descripcion Capitana Marvel", power: 5),
                                  Character.init(name: "Capitan America", image: "img_heroe_america_captain", descripcion: "Descripcion: Capitan America", power: 4),
                                  Character.init(name: "Black Panther", image: "img_heroe_black_panther", descripcion: "Descripcion_ Black Panther", power: 3),
                                  Character.init(name: "Viuda Negra", image: "img_heroe_black_widow", descripcion: "Descripcion: Viuda Negra", power: 2),
                                  Character.init(name: "Doctor Extraño", image: "img_heroe_dr_strange", descripcion: "Descripcion: Doctor Extraño", power: 4),
                                  Character.init(name: "Gamora", image: "img_heroe_gamora", descripcion: "Descripcion: Gamora", power: 3)]
    
    private var avengerSelected : Character? = nil
    
    //private var _character : Character
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        
    }
    
    func setCharacterSelected(avenger : Character) {
        avengerSelected = avenger
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let vc = segue.destination as? CharacterDetailViewController else {
            return
        }
        
        guard let avenger = avengerSelected else {
            return
        }
        
        vc.title = avenger.name
        vc.navigationItem.title = avenger.name
        
        vc.setCharacter(character: avenger)
        
        
        
    }
    
}


extension AvengersViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        let nib = UINib.init(nibName: CharacterTableViewCell.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get task count for current task state selected
        return avengers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get custom cell view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellIdentifier,
                                                       for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
    // Get tasks for current task state selected
        
        
        cell.setCharacter(avengers[indexPath.row])
        cell.delegate = self
        cell.selectCell = { [weak self] () -> Void in
            guard let self = self else {
                return
            }
            
            self.performSegue(withIdentifier: self.segue_Avenger, sender: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

extension AvengersViewController: SelectedCharacterDelegate {
    func selectedCharacter(character: Character) {
        self.avengerSelected = character
    }
}


