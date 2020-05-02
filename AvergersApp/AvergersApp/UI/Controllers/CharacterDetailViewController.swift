//
//  CharacterDetailViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var _character : Character?
    
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
