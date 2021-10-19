//
//  ViewController.swift
//  TodoPractice2
//
//  Created by daiki nishimura on 2021/10/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        todoCell.textLabel?.text = todoAry[indexPath.row]
        return todoCell
    }
    
    func loadTodoList(){
//        var component = URL(string: "http://localhost:3000")!
//        component.queryItems = [URLQueryItem(name: "title", value: "test")]
//
//        URLSession.shared.dataTask(with: component.url!) { (data, response, error) in
//            let json = String(data: data!, encoding: utf8)!
//            print(json)
//        }.resume()
        
        let url = URL(string: "http://localhost:3000/todos")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse {
                print()
                // HTTPヘッダの取得
                print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                // HTTPステータスコード
                print("statusCode: \(response.statusCode)")
                print(String(data: data, encoding: String.Encoding.utf8)!)
                
            }
//            let json = String(data: data!, encoding: utf8)!
//            print(json)
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tableView: UITableView!
    
}

