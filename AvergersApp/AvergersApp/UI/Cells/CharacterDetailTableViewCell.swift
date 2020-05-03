//
//  CharacterDetailTableViewCell.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 02/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var characterPowerImage: UIImageView!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var viewCollectionBattles: UICollectionView!
    
    private var _character: Character?
    private var battlesFilter: [Battles]?
    
    static let cellIdentifier: String = String(describing: CharacterDetailTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        //viewCollectionBattles.frame.size = CGSize(width: 120.0, height: 30)
        configureViewCollection()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        guard let character = _character else {
            return
        }
        
        characterPowerImage.image = UIImage(named: Utilities.shared.getImageSuperPower(power: character.power))
        
        characterDescription.text = _character?.descripcion
    }
    
    func setCharacterer(character: Character) -> Void {
        _character = character
        let battles = Utilities.shared.getBattles()
        
        battlesFilter = battles.filter
        { [weak self] (battle) in
            
            if self?._character?.kind == KindSuperHeroe.avenger.rawValue {
                guard let avenger = battle.avenger else {
                    return false
                }
                
                if Int(avenger.id) == self?._character?.id {
                    return true
                }
                return false
            }
            else
            {
                guard let villain = battle.villain else {
                    return false
                }
                
                if Int(villain.id) == self?._character?.id {
                    return true
                }
                
                return false
            }
            
            
            
        }
    
        
        setupUI()
    }

    @IBAction func editCharacterPowerButton(_ sender: Any) {
    }
    
}

extension CharacterDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureViewCollection() {
        viewCollectionBattles.delegate = self
        viewCollectionBattles.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return battlesFilter?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupUI()
        
        let battleStates = battlesFilter?[indexPath.row]
        
        cell.battlesLabel.text = "Batalla \(battleStates?.id ?? 0)"
        
        if self._character?.kind == battleStates?.win {
            cell.viewCollection.backgroundColor = .blue
        }
        else {
            cell.viewCollection.backgroundColor = .red
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 60.0)
    }
    
}
