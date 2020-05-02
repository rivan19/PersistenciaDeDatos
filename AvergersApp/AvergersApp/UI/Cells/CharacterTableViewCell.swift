//
//  CharacterTableViewCell.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit



class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImagePower: UIImageView!
    
    private var _character : Character?
    
    var selectCell: (() -> Void)?
    var delegate: SelectedCharacterDelegate?
    
    static let cellIdentifier : String = String(describing: CharacterTableViewCell.self)
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    func setupUI(){
        characterImage.image = UIImage.init(named: _character?.image ?? "")
        characterName.text = _character?.name
        
        characterImagePower.image = UIImage(named: Utilities.shared.getImageSuperPower(power: _character?.power ?? 0))
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 8
        // Initialization code
    }
    
    func setCharacter(_ character: Character){
        _character = character
        setupUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let character = _character else {
            return
        }
        delegate?.selectedCharacter(character: character)
        self.selectCell?()
    }
    
}
