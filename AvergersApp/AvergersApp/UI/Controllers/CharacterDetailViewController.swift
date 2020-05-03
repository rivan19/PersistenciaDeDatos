//
//  CharacterDetailViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit
import CoreData

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var _character : Character?
    private var dataProvider = DataProvider()
    var delegate: EditCharacterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        characterImage.image = UIImage(named: _character?.image ?? "")
    }
    
    func setCharacter(character: Character){
        _character = character
    }
    
    @IBAction func editPowerCharacterButton(_ sender: Any) {
        self.performSegue(withIdentifier: Utilities.shared.segue_edit_Power, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let vc = segue.destination as? EditPowerCharacterViewController else {
            return
        }
        
        guard let character = _character else {
            return
        }
        vc.delegate = self
        vc.setCharacter(character: character)
        
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Get task count for current task state selected
    return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get custom cell view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailTableViewCell.cellIdentifier,
    for: indexPath) as? CharacterDetailTableViewCell else {
    return UITableViewCell()
    }
    // Get tasks for current task state selected
        cell.setCharacterer(character: _character!)
        
        return cell
 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 500
    }
}

extension CharacterDetailViewController: EditPowerViewDelegate {
    
    func onPowerSaved(entitie: KindEntity, id: Int, esSuperHeroe: Bool) {
        
        if esSuperHeroe {
            guard let avenger = dataProvider.loadBy(entitie: entitie, id: id) as? [Avengers] else {
                return
            }
            
            guard let avg = avenger.first else {
                return
            }
            
            _character = Character(id: id, name: avg.name ?? "", image: avg.image, descripcion: avg.descripcion, power: Int(avg.power), kind: KindSuperHeroe.avenger.rawValue)
            
        } else {
            guard let villain = dataProvider.loadBy(entitie: entitie, id: id) as? [Villains] else {
                return
            }
            
            guard let vil = villain.first else {
                return
            }
            
            
            _character = Character(id: id, name: vil.name ?? "", image: vil.image, descripcion: vil.descripcion, power: Int(vil.power), kind: KindSuperHeroe.villain.rawValue)
        }
        
        tableView.reloadData()
        delegate?.onCharacterSaved()
        
    }
}
