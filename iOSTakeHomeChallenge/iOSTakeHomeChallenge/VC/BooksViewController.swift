//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//



import Foundation
import UIKit

class BooksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cachedBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }
    
    func getBooks() {
        DataService().read(endpoint: .books) { result in
            switch result{
            case .success(let data):
                if let data = data {
                    do{
                        let books = try JSONDecoder().decode([Book].self, from: data)
                        self.loadData(books: books)
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
    
    func loadData(books: [Book]) {
        cachedBooks = books
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
}

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    func setupWith(book: Book) {
        titleLabel.text = book.name
        dateLabel.text = book.released
        pagesLabel.text =  String(book.numberOfPages)
    }
}
