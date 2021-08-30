//
//  ViewController.swift
//  An App
//
//  Created by Rave Bizz on 8/29/21.
//

import UIKit

class ViewController: UITableViewController {
    var restroomsArr : [Restrooms] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "NewViewCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewViewCellTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restroomsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewViewCellTableViewCell") as? NewViewCellTableViewCell else {
            fatalError()
        }
        cell.nameLabel.text = restroomsArr[indexPath.row].name
        cell.streetLabel.text = restroomsArr[indexPath.row].street
        cell.cityLabel.text = restroomsArr[indexPath.row].city
        cell.stateLabel.text = restroomsArr[indexPath.row].state
        cell.unisexLabel.text = String(restroomsArr[indexPath.row].unisex)
        cell.accessibleLabel.text = String(restroomsArr[indexPath.row].accessible)
        cell.upvotesLabel.text = String(restroomsArr[indexPath.row].upvote)
        cell.downvotesLabel.text = String(restroomsArr[indexPath.row].downvote)
        return cell
    }

    func fetchData() {
        let refugeRestrooms = "https://www.refugerestrooms.org/api/v1/restrooms"
        if let url = URL(string: refugeRestrooms) {
            URLSession.shared.dataTask(with: url, completionHandler: {(data, response, err) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let restrooms = try decoder.decode([Restrooms].self, from: data)
                        self.restroomsArr = restrooms
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }).resume()
        } else {
            fatalError()
        }
    }
}
