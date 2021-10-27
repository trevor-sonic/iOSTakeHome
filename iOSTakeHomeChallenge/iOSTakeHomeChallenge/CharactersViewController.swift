//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//

import Foundation
import UIKit

struct Character: Codable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases:  [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
}

class CharactersViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cachedCharacters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        getCharacters()
    }
    
    func getCharacters() {
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/characters")!)
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("Oops")
            }
            
            if let data = data {
                do{
                    let characters = try JSONDecoder().decode([Character].self, from: data)
                    self.loadData(characters: characters)
                }catch{
                    print("📛 \(error) is NIL \(#function) in\(self.description)")
                }
            }else{
                print("📛 data is NIL \(#function) in\(self.description)")
            }
            
        })
        task.resume()
    }
    
    func loadData(characters: [Character]) {
        cachedCharacters = characters
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
}

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    func setupWith(character: Character) {
        nameLabel.text = character.name
        cultureLabel.text = character.culture
        bornLabel.text = character.born
        diedLabel.text = character.died
        
        var seasons: String = ""
        
        for season in character.tvSeries {
            if season == "Season 1" {
                seasons.append("I ")
            } else if season == "Season 2" {
                seasons.append("II, ")
            } else if season == "Season 3" {
                seasons.append("III, ")
            } else if season == "Season 4" {
                seasons.append("IV, ")
            } else if season == "Season 5" {
                seasons.append("V, ")
            } else if season == "Season 6" {
                seasons.append("VI, ")
            }  else if season == "Season 7" {
                seasons.append("VII, ")
            } else if season == "Season 8" {
                seasons.append("VIII")
            }
        }
        
        seasonLabel.text = seasons
    }
}
