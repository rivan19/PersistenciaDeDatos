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
    
    lazy var avengers : [Avengers] = {
      return Utilities.shared.getDataAvengers()
    }()
    
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
        vc.delegate = self
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
        
        let superHeroe = avengers[indexPath.row]
        
        let character: Character = Character(id: Int(superHeroe.id),
                                  name: superHeroe.name ?? "",
                                  image: superHeroe.image,
                                  descripcion: superHeroe.descripcion,
                                  power: Int(superHeroe.power),
                                  kind: "A")
        
        cell.setCharacter(character)
        cell.delegate = self
        cell.selectCell = { [weak self] () -> Void in
            guard let self = self else {
                return
            }
            
            self.performSegue(withIdentifier: Utilities.shared.segue_Avenger, sender: nil)
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

extension AvengersViewController: EditCharacterDelegate {
    func onCharacterSaved(){        
        avengers = Utilities.shared.getDataAvengers()
        tableView.reloadData()
    }
}


