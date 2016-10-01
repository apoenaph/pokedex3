//
//  ViewController.swift
//  pokedex3
//
//  Created by Apoena on 9/29/16.
//  Copyright © 2016 Apoena Herrero. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonList = [Pokemon]()
    var pokemonSearch = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let musicPath = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: musicPath)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        let csvPath = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: csvPath)
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pk = Pokemon(name: name, pokedexId: pokeId)
                
                pokemonList.append(pk)
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell{
            
            var pk: Pokemon
            
            if inSearch{
                pk = pokemonSearch[indexPath.row]
            }else{
                pk = pokemonList[indexPath.row]
            }
            
            cell.confiureCell(pk)
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pk: Pokemon
        
        if inSearch{
            pk = pokemonSearch[indexPath.row]
        }else{
            pk = pokemonList[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokemonDetailVC", sender: pk)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearch{
            return pokemonSearch.count
        }else{
            return pokemonList.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearch = false
            collection.reloadData()
        }else{
            inSearch = true
            let lower = searchBar.text!.lowercased()
            
            pokemonSearch = pokemonList.filter({$0.name.range(of: lower) != nil})
            
            collection.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailVC"{
            if let detailesVC = segue.destination as? PokemonDetailVC{
                if let poke = sender as? Pokemon {
                    detailesVC.pokemon = poke
                }
            }
        }
    }
    
}

