//
//  BattleAvengerSelectTableViewCell.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class BattleAvengerSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var imageAvenger: UIImageView!
    @IBOutlet weak var nameAvenger: UILabel!
    @IBOutlet weak var imagePowerAvenger: UIImageView!
    
    private var selectedAvenger: Avengers?
    
    static let cellIdentifier: String = String(describing: BattleAvengerSelectTableViewCell.self)
    
    var delegate: SelectedAvengerBattleDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI() {
        imagePowerAvenger.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCharacter(avenger: Avengers) {
        self.selectedAvenger = avenger
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let avenger = selectedAvenger else {
            return
        }
        delegate?.selectedAvengerBattle(avenger: avenger)
    }
    

}
