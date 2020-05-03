//
//  BattleTableViewCell.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit
import CoreData

class BattleTableViewCell: UITableViewCell {

    @IBOutlet weak var BattleLabel: UILabel!
    @IBOutlet weak var BattleAvengerImage: UIImageView!
    @IBOutlet weak var BattleVillainImage: UIImageView!
    @IBOutlet weak var viewAvenger: UIView!
    @IBOutlet weak var viewVillain: UIView!
    
    private var _battles: Battles?
    
    static let cellIdentifier: String = String(describing: BattleTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        viewAvenger.layer.cornerRadius = 4
        viewVillain.layer.cornerRadius = 4
        BattleAvengerImage.layer.cornerRadius = 8
        BattleVillainImage.layer.cornerRadius = 8
        
        if let battles = _battles {
            BattleLabel.text = "Batalla \(battles.id)"
            BattleAvengerImage.image = UIImage(named: battles.avenger?.image ?? "")
            BattleVillainImage.image = UIImage(named: battles.villain?.image ?? "")
            if battles.win == KindSuperHeroe.avenger.rawValue {
                viewAvenger.backgroundColor = .blue
                viewVillain.backgroundColor = .red
            }
            else {
                viewAvenger.backgroundColor = .red
                viewVillain.backgroundColor = .blue
            }
        }
    }
    
    func setBattle(battles: Battles){
        _battles = battles
        setupUI()
    }

}
