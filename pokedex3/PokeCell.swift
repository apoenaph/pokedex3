//
//  PokeCell.swift
//  pokedex3
//
//  Created by Apoena on 9/30/16.
//  Copyright © 2016 Apoena Herrero. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func confiureCell(_ p: Pokemon){
        self.pokemon = p
        lblName.text = self.pokemon.name.capitalized
        imgThumb.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
