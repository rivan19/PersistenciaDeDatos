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
        
        characterPowerImage.image = UIImage(named: Utilities.shared.getImageSuperPower(power: character.power ?? 0))
        
        characterDescription.text = _character?.descripcion
    }
    
    func setCharacterer(character: Character) -> Void {
        _character = character
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupUI()
        cell.battlesLabel.text = "Batalla \(indexPath.row)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 60.0)
    }
    
}
