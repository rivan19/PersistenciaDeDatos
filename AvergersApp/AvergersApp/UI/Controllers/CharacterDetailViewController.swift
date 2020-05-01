//
//  CharacterDetailViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    private var _character : Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        //self.title = "prueba"
        //self.navigationController?.title = _character?.name
        nameLabel.text = _character?.name
    }
    
    func setCharacter(character: Character){
        _character = character
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
