//
//  AddController.swift
//  TodoPractice2
//
//  Created by daiki nishimura on 2021/10/19.
//

import UIKit
import Foundation

var todoAry = [String]()

class AddController: UIViewController {

    @IBOutlet weak var todoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddButton(_ sender: Any) {
        
        todoAry.append(todoTextField.text!)
        
        todoTextField.text = ""
        print(todoAry)

        
        let url = URL(string: "http://localhost:3000/todos")!

        // URLを渡してリクエストを作成する
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // content-type を application/json に設定する
        request.addValue("application/json", forHTTPHeaderField: "content-type")

        // データをを用意する
        struct todos: Codable {
          let id: Int
          let title: String
        }

        let todo = todos(id: 1, title: "Taro")

        do {
          // JSON形式にエンコードして、データをhttpBodyにセットする
          request.httpBody = try JSONEncoder().encode(todo)
        } catch {
          print("不正なデータです")
        }

        // データをPOST送信する
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          if error != nil {
            print("エラー")
            return
          }

          print("成功")
        }
        task.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
