//
//  EditPowerCharacterViewController.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 03/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit
import CoreData

class EditPowerCharacterViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var buttonAceptar: UIButton!
    @IBOutlet weak var cancelarButton: UIButton!
    
    
    private var _character: Character?
    private var avenger: Avengers?
    private var villain: Villains?
    private var dataProvider = DataProvider()
    private var esSuperHeroe: Bool = false
    private var actualPower: Int32 = 0
    
    var delegate: EditPowerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAceptar.layer.cornerRadius = 8
        cancelarButton.layer.cornerRadius = 8
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        viewContainer.layer.cornerRadius = 8.0
        configureViewEffects()
        paintStartsPower(power: _character?.power ?? 0)
        
    }
    
    func paintStartsPower(power: Int) {
        let imageFill = UIImage.init(systemName: "star.fill")
        let image = UIImage.init(systemName: "star")
        
        actualPower = Int32(power)
        
        for index in 1...power {
            switch index {
            case 1:
                star1.setImage(imageFill, for: .normal)
            case 2:
                star2.setImage(imageFill, for: .normal)
            case 3:
                star3.setImage(imageFill, for: .normal)
            case 4:
                star4.setImage(imageFill, for: .normal)
            case 5:
                star5.setImage(imageFill, for: .normal)
            default:
                break
            }
        }
        
        if power + 1 < Utilities.shared.maxPower {
            for index in power + 1...Utilities.shared.maxPower {
                switch index {
                case 1:
                    star1.setImage(image, for: .normal)
                case 2:
                    star2.setImage(image, for: .normal)
                case 3:
                    star3.setImage(image, for: .normal)
                case 4:
                    star4.setImage(image, for: .normal)
                case 5:
                    star5.setImage(image, for: .normal)
                default:
                    break
                }
            }
        }
        
    }
    
    private func configureViewEffects() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        view.sendSubviewToBack(blurredEffectView)
    }
    
    func setCharacter(character: Character){
        _character = character
        if _character?.kind == KindSuperHeroe.avenger.rawValue {
            esSuperHeroe = true
            guard let id = _character?.id else {
                return
            }
            guard let avenger = dataProvider.loadBy(entitie: .avenger, id: id) as? [Avengers] else {
                return
            }
            
            self.avenger = avenger.first
            actualPower = self.avenger?.power ?? 0
        }
        else if _character?.kind == KindSuperHeroe.villain.rawValue {
            esSuperHeroe = false
            guard let id = _character?.id else {
                return
            }
            
            guard let villain = dataProvider.loadBy(entitie: .villain, id: id) as? [Villains] else {
                return
            }
            
            self.villain = villain.first
            actualPower = self.villain?.power ?? 0
        }
        
    }
    
    @IBAction func pushStar(_ sender: UIButton) {
        paintStartsPower(power: sender.tag)
    }
    
    @IBAction func aceptarButton(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            
            
            guard let self = self else {
                return
            }
            
            if self.esSuperHeroe {
                self.avenger?.power = self.actualPower
                self.dataProvider.save()
                guard let id = self.avenger?.id else {
                    return
                }
                
                self.delegate?.onPowerSaved(entitie: .avenger, id: Int(id), esSuperHeroe: self.esSuperHeroe)
            } else {
                self.villain?.power = self.actualPower
                self.dataProvider.save()
                guard let id = self.villain?.id else {
                    return
                }
                
                self.delegate?.onPowerSaved(entitie: .villain, id: Int(id), esSuperHeroe: self.esSuperHeroe)
            }
            
            
        }
    }
    
    @IBAction func cancelarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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


