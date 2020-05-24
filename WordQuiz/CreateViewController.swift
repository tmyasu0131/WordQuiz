//
//  CreateViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/02.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var quizDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]
    var userDefaults = UserDefaults.standard
    var alertController: UIAlertController!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = .orange
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        view.backgroundColor = UIColor.init(red: 255/255, green: 237/255, blue: 205/255, alpha: 100/100)
    }
    
    @IBAction func settingButton(_ sender: Any) {
        self.performSegue(withIdentifier: "Setting", sender: nil)
    }
    
    
    // 取り出しメソッド
    func getImageToDocumentDirectory(fileName: String) -> UIImage? {
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentURL.appendingPathComponent(fileName)
            if let imageData = try? Data(contentsOf: fileURL),
                let image = UIImage(data: imageData) {
                return image
            }
        }
        return nil
    }
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let quizDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]
        return quizDic.count
    }
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        present(alertController, animated: true)
    }
    
    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let quizDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Cellに値を設定する.  --- ここから ---
        //cell.textLabel?.font = UIFont(name: "AP", size: 20)
        
        let quizList = quizDic[indexPath.row]
        
        cell.textLabel?.text = quizList["Text"]!.precomposedStringWithCanonicalMapping
        //cell.textLabel?.font = UIFont(name: "", size: 30)
        
        let cellImageView = cell.viewWithTag(1) as! UIImageView
        cellImageView.layer.cornerRadius = cellImageView.frame.size.width * 0.05
        cellImageView.clipsToBounds = true
        let editImage = quizList["Image"]!
        let image = UIImage(named: "\(editImage)")
        //if image == nil { Path から画像を取り出して代入する }
        if image != nil {
            cellImageView.image = image
        } else {
            cellImageView.image = getImageToDocumentDirectory(fileName: editImage)
        }
        
        //スイッチボタンアクションを追加
        //UISwitchをcellのアクセサリービューに追加する
        let switchView = UISwitch()
        //スイッチの状態
        if quizList["Status"] == "表示する" {
            switchView.setOn(true, animated: false);
        }else{
            switchView.setOn(false, animated: true);
        }
        cell.accessoryView = switchView
        //タグの値にindexPath.rowを入れる。
        switchView.tag = indexPath.row
        //スイッチが押されたときの動作
        switchView.addTarget(self, action: #selector(switchTriggered(_:)), for: .valueChanged)
        
        return cell
    }
    
    //cellのアクセサリービューに追加したUISwitchが変化すると呼ばれる
    @objc func switchTriggered(_ sender: UISwitch) {
        print(sender.tag)
        print(sender.isOn)
        
        let row = sender.tag
        var updateDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]

        //スイッチの変更時の挙動
        // UISwitch値を取得
        let onCheck: Bool = sender.isOn
        
        if updateDic.filter({ $0["Status"] == "表示する" }).count == 1 && updateDic[row]["Status"]=="表示する" {
            alert(title: "更新できません",
                  message: "最低1つ以上は表示してください")
        }else if onCheck {
            print("ON")
            updateDic[row].updateValue("表示する", forKey: "Status")
            print(updateDic[row])
        }else{
            print("OFF")
            updateDic[row].updateValue("非表示", forKey: "Status")
            print(updateDic[row])
        }
        //userDefaults へ保存する
        self.userDefaults.set(updateDic, forKey: "日本語")
        //更新情報
        //TableView を更新
        self.tableView.reloadData()
    
    }
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addQuiz",sender: nil)
    }
    
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //メッセージ
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "本当に削除しますか？", preferredStyle:  UIAlertController.Style.alert)
        
        //OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            if editingStyle == .delete {
                self.quizDic.remove(at: indexPath.row)
                //userDefaults へ保存する
                self.userDefaults.set(self.quizDic, forKey: "日本語")
                tableView.reloadData()
                SVProgressHUD.showSuccess(withStatus: "削除しました")
            }
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        //UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        //Alertを終了
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "addQuiz" {
            let PostViewController:PostViewController = segue.destination as! PostViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            PostViewController.quizDicNo = indexPath!.row
        }
        
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
