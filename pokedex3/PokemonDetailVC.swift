//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Apoena on 9/30/16.
//  Copyright © 2016 Apoena Herrero. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblDefense: UILabel!
    @IBOutlet weak var lblPokedexId: UILabel!
    @IBOutlet weak var lblBaseAttack: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = pokemon.name
        imgPokemon.image = UIImage(named: "\(pokemon.pokedexId)")
    }

    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
