//
//  Pokemon.swift
//  pokedex3
//
//  Created by Apoena on 9/30/16.
//  Copyright © 2016 Apoena Herrero. All rights reserved.
//

import Foundation

class Pokemon{
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _Type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nexEvolutionText: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}
