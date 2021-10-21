//
//  ViewController.swift
//  TodoPractice2
//
//  Created by daiki nishimura on 2021/10/19.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        todoCell.textLabel?.text = todoAry[indexPath.row]
        return todoCell
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // URLSessionConfiguration の設定をする
        let config = URLSessionConfiguration.default
// URLSessionConfigurationの設定。defualtで保存されるキャッシュ(WEBページのCSS,JSなどの情報)、資格情報(パスワード)、クッキー(ユーザーの情報)を設定。
        let session = URLSession(configuration: config)

        // 取得するURLを作成
        let urlComponents = URLComponents(string: "http://localhost:3000/todos")
    
        // nilが代入された時のエラーを防ぐ為、オプショナル型にしてurlに代入
        let url = urlComponents?.url
        // GET通信を実行
        // リクエストのプロパティを設定
        let task = session.dataTask(with: url!) { data, response, error in
            // エラー時の処理
          if let error = error {
            print(error.localizedDescription)
            return
          }
         // 条件を満たさない時の処理。responseの中にあるHTTPURLResponseをダウンキャストで指定する。
          guard let data = data, let response = response as? HTTPURLResponse else {
              // 条件を満たさない処理が失敗した時の処理。
            print("データがありませんでした。")
           // guard文を終了させる。
              return
          }
            print(data)
            print(response)
            //レスポンスのstatusCodeが200で帰ってきた時の処理。
          if response.statusCode == 200 {
              // 内容
            do {
                // エラーがでる可能性のあるメソッド。JSONデータをFoundationオブジェクトに変換しJSONを読み取る処理
              let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
              print(json)
                // エラーが起こった時の処理
            } catch {
              print("不正なデータです")
            }
            // 処理...
          }
        }
        // タスクを開始するメソッド
        task.resume()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
}

