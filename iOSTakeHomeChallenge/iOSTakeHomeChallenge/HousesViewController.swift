//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//

import Foundation
import UIKit

struct House: Codable {
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLord: String
    let heir: String
    let overlord: String
    let founded: String
    let founder: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [String]
    let swornMembers: [String]
}

class HousesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cachedHouses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.contentInset.top = UIApplication.shared.statusBarFrame.height
        getHouses()
    }
    
    func getHouses() {
        DataService().read(endpoint: .houses) { result in
            switch result{
            case .success(let data):
                if let data = data {
                    do{
                        let houses = try JSONDecoder().decode([House].self, from: data)
                        self.loadData(houses: houses)
                    }catch{
                        print("📛 Error: \(error) \(#function) in\(self.description)")
                    }
                }else{
                    print("📛 data is NIL \(#function) in\(self.description)")
                }
                
            case .failure(let error):
                print("📛 Error: \(error) \(#function) in\(self.description)")
            }
        }
    }
    
    func loadData(houses: [House]) {
        cachedHouses = houses
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
        cell.setupWith(house: cachedHouses[indexPath.row])
        return cell
    }
}

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    func setupWith(house: House) {
        nameLabel.text = house.name
        regionLabel.text = house.region
        wordsLabel.text =  house.words
    }
}
