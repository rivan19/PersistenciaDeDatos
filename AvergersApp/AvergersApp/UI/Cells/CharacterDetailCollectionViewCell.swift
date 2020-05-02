//
//  CharacterDetailCollectionViewCell.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 02/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class CharacterDetailCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = String(describing: CharacterDetailCollectionViewCell.self)
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var battlesLabel: UILabel!
    
    func setupUI(){
        viewCollection.layer.cornerRadius = 8
        viewCollection.backgroundColor = .blue
        
        
    }
    
}
