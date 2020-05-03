//
//  BattleAvengerSelectTableViewCell.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class BattleVillainSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVillain: UIImageView!
    @IBOutlet weak var nameVillain: UILabel!
    @IBOutlet weak var imagePowerVillain: UIImageView!
    
    private var selectedVillain: Villains?
    
    static let cellIdentifier: String = String(describing: BattleVillainSelectTableViewCell.self)
    
    var delegate: SelectedVillainBattleDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        imagePowerVillain.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCharacter(villain: Villains){
        self.selectedVillain = villain
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let villain = selectedVillain else {
            return
        }
        delegate?.selectedVillainBattle(villain: villain)
    }

}
