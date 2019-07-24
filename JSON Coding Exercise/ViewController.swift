//
//  ViewController.swift
//  JSON Coding Exercise
//
//  Created by Eric Liberi on 7/17/19.
//  Copyright © 2019 Eric Liberi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var users: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON()
        setupTableView()
        setupCellTap()
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
                
                let users = try JSONDecoder().decode([User].self, from: data)
                self.users.accept(users)
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }
       
        task.resume()
        
    }

}
extension ViewController {
    
    func setupTableView() {
        users.bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
            row, model, cell in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.address?.zipcode
        }.disposed(by: disposeBag)
    }
    
    func setupCellTap() {
        tableView.rx.modelSelected(User.self)
            .subscribe(onNext: { user in
                if let name = user.name {
                    print(name)
                }
                
                if let email = user.email {
                    print(email)
                }
                
                if let zipcode = user.address?.zipcode {
                    print(zipcode)
                }
                
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
        .disposed(by: disposeBag)
    }
}
