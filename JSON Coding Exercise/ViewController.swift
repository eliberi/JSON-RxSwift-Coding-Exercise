//
//  ViewController.swift
//  JSON Coding Exercise
//
//  Created by Eric Liberi on 7/17/19.
//  Copyright © 2019 Eric Liberi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var users: [User] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON()
        
    }
    
    func parseJSON() {
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            do {
                
                self.users = try JSONDecoder().decode([User].self, from: data)
                
            } catch let jsonError {
                print(jsonError)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
       
        task.resume()
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.address?.zipcode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if let name = user.name {
            print(name)
        }
        
        if let email = user.email {
            print(email)
        }
        
        if let zipcode = user.address?.zipcode {
            print(zipcode)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
