//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//

struct Book: Codable {
    let url: String
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: String
    let characters: [String]
}

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
        var request = URLRequest(url: URL(string: "https://anapioficeandfire.com/api/books")!)
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
            
            let books = try! JSONDecoder().decode([Book].self, from: data!)
            self.loadData(books: books)
            
        })
        task.resume()
    }
    
    func loadData(books: [Book]) {
        cachedBooks = books
        tableView.reloadData()
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
