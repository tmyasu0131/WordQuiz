//
//  SettingViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/07.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import SVProgressHUD

class SettingViewController: UIViewController {
    
    var userDefaults = UserDefaults.standard
    var quizDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]
    var alertController: UIAlertController!
    
    let defaultDic = [["Image":"ひこうきImage","Text":"ひこうき","Status":"表示する","Correct":"未正解"],["Image":"とらっくImage","Text":"とらっく","Status":"表示する","Correct":"未正解"],["Image":"しょうぼうしゃImage","Text":"しょうぼうしゃ","Status":"表示する","Correct":"未正解"],["Image":"きゅうきゅうしゃImage","Text":"きゅうきゅうしゃ","Status":"表示する","Correct":"未正解"],["Image":"なすImage","Text":"なす","Status":"表示する","Correct":"未正解"],["Image":"きゅうりImage","Text":"きゅうり","Status":"表示する","Correct":"未正解"],["Image":"とうもろこしImage","Text":"とうもろこし","Status":"表示する","Correct":"未正解"],["Image":"しろねぎImage","Text":"しろねぎ","Status":"表示する","Correct":"未正解"],["Image":"れたすImage","Text":"れたす","Status":"表示する","Correct":"未正解"],["Image":"りんごImage","Text":"りんご","Status":"表示する","Correct":"未正解"],["Image":"みかんImage","Text":"みかん","Status":"表示する","Correct":"未正解"],["Image":"ぱいなっぷるImage","Text":"ぱいなっぷる","Status":"表示する","Correct":"未正解"],["Image":"めろんImage","Text":"めろん","Status":"表示する","Correct":"未正解"],["Image":"ぶどうImage","Text":"ぶどう","Status":"表示する","Correct":"未正解"],["Image":"ばななImage","Text":"ばなな","Status":"表示する","Correct":"未正解"],["Image":"れもんImage","Text":"れもん","Status":"表示する","Correct":"未正解"],["Image":"さくらんぼImage","Text":"さくらんぼ","Status":"表示する","Correct":"未正解"],["Image":"ほっとけーきImage","Text":"ほっとけーき","Status":"表示する","Correct":"未正解"],["Image":"ぷりんImage","Text":"ぷりん","Status":"表示する","Correct":"未正解"],["Image":"くっきーImage","Text":"くっきー","Status":"表示する","Correct":"未正解"],["Image":"さんどいっちImage","Text":"さんどいっち","Status":"表示する","Correct":"未正解"],["Image":"ぱすたImage","Text":"ぱすた","Status":"表示する","Correct":"未正解"],["Image":"おにぎりImage","Text":"おにぎり","Status":"表示する","Correct":"未正解"],["Image":"なっとうまきImage","Text":"なっとうまき","Status":"表示する","Correct":"未正解"],["Image":"おすしImage","Text":"おすし","Status":"表示する","Correct":"未正解"],["Image":"かれーらいすImage","Text":"かれーらいす","Status":"表示する","Correct":"未正解"],["Image":"らーめんImage","Text":"らーめん","Status":"表示する","Correct":"未正解"],["Image":"ぽてとImage","Text":"ぽてと","Status":"表示する","Correct":"未正解"],["Image":"かぶとむしImage","Text":"かぶとむし","Status":"表示する","Correct":"未正解"],["Image":"へびImage","Text":"へび","Status":"表示する","Correct":"未正解"],["Image":"さるImage","Text":"さる","Status":"表示する","Correct":"未正解"],["Image":"うまImage", "Text": "うま","Status":"表示する","Correct":"未正解"],["Image":"いぬImage","Text":"いぬ","Status":"表示する","Correct":"未正解"],["Image":"ひつじImage","Text":"ひつじ","Status":"表示する","Correct":"未正解"],["Image":"にわとりImage","Text":"にわとり","Status":"表示する","Correct":"未正解"],["Image":"ねずみImage", "Text": "ねずみ","Status":"表示する","Correct":"未正解"],["Image":"うしImage","Text":"うし","Status":"表示する","Correct":"未正解"],["Image":"とらImage","Text":"とら","Status":"表示する","Correct":"未正解"],["Image":"うさぎImage","Text":"うさぎ","Status":"表示する","Correct":"未正解"],["Image":"わにImage","Text":"わに","Status":"表示する","Correct":"未正解"],["Image":"いるかImage","Text":"いるか","Status":"表示する","Correct":"未正解"],["Image":"いかImage","Text":"いか","Status":"表示する","Correct":"未正解"],["Image":"とりけらとぷすImage","Text":"とりけらとぷす","Status":"表示する","Correct":"未正解"],["Image":"てぃらのさうるすImage","Text":"てぃらのさうるす","Status":"表示する","Correct":"未正解"],["Image":"ぷてらのどんImage","Text":"ぷてらのどん","Status":"表示する","Correct":"未正解"],["Image":"ぶらきおさうるすImage","Text":"ぶらきおさうるす","Status":"表示する","Correct":"未正解"],["Image":"あんきろさうるすImage","Text":"あんきろさうるす","Status":"表示する","Correct":"未正解"],["Image":"ちきゅうImage", "Text": "ちきゅう","Status":"表示する","Correct":"未正解"],["Image":"たいようImage","Text":"たいよう","Status":"表示する","Correct":"未正解"],["Image":"あめImage","Text":"あめ","Status":"表示する","Correct":"未正解"],["Image":"どらいやーImage", "Text": "どらいやー","Status":"表示する","Correct":"未正解"],["Image":"せんぷうきImage","Text":"せんぷうき","Status":"表示する","Correct":"未正解"],["Image":"すいはんきImage","Text":"すいはんき","Status":"表示する","Correct":"未正解"], ["Image":"ろうそくImage", "Text": "ろうそく","Status":"表示する","Correct":"未正解"],["Image":"はさみImage","Text":"はさみ","Status":"表示する","Correct":"未正解"],["Image":"べっどImage","Text":"べっど","Status":"表示する","Correct":"未正解"],["Image":"あいろんImage","Text":"あいろん","Status":"表示する","Correct":"未正解"],["Image":"ぴあのImage","Text":"ぴあの","Status":"表示する","Correct":"未正解"],["Image":"すぽんじImage","Text":"すぽんじ","Status":"表示する","Correct":"未正解"],["Image":"まいくImage", "Text": "まいく","Status":"表示する","Correct":"未正解"],["Image":"てんとImage","Text":"てんと","Status":"表示する","Correct":"未正解"],["Image":"らっぱImage", "Text": "らっぱ","Status":"表示する","Correct":"未正解"],["Image":"おばけImage","Text":"おばけ","Status":"表示する","Correct":"未正解"],["Image":"ぜろimage","Text":"ぜろ","Status":"表示する","Correct":"未正解"],["Image":"いちImage","Text":"いち","Status":"表示する","Correct":"未正解"],["Image":"にImage","Text":"に","Status":"表示する","Correct":"未正解"],["Image":"さんImage","Text":"さん","Status":"表示する","Correct":"未正解"],["Image":"よんImage","Text":"よん","Status":"表示する","Correct":"未正解"],["Image":"ごImage","Text":"ご","Status":"表示する","Correct":"未正解"],["Image":"ろくImage","Text":"ろく","Status":"表示する","Correct":"未正解"],["Image":"ななImage","Text":"なな","Status":"表示する","Correct":"未正解"],["Image":"はちImage","Text":"はち","Status":"表示する","Correct":"未正解"],["Image":"きゅうImage","Text":"きゅう","Status":"表示する","Correct":"未正解"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func singalealert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        self.present(alertController, animated: true)
    }
    
    @IBAction func allHyojiButton(_ sender: Any) {
        //メッセージ
        let alert: UIAlertController = UIAlertController(title: "「全てのクイズを表示」しますか？", message: "クイズ作成ページから個別に設定できます", preferredStyle:  UIAlertController.Style.alert)
        
        
        //OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            
            
            print("OK")
            
            var updateDic = self.quizDic
            
            let x = updateDic.count
            print(x)
            
            for num in 0..<x {
                if updateDic[num]["Status"] == "非表示" {
                    updateDic[num]["Status"]="表示する"
                }
            }
            self.quizDic = updateDic
            self.userDefaults.set(self.quizDic, forKey: "日本語")
            

            
            print("更新後\(updateDic)")
            
            SVProgressHUD.showSuccess(withStatus: "「全てのクイズを表示」に変更しました")
            
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
    
    @IBAction func allIncorrectButton(_ sender: Any) {
        //メッセージ
        let alert: UIAlertController = UIAlertController(title: "「不正解または未回答のクイズのみ表示」に変更しますか？", message: "クイズ作成ページから個別に設定できます", preferredStyle:  UIAlertController.Style.alert)
        
        //OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            var updateDic = self.quizDic
            //辞書を更新
            let x = updateDic.count
            
            if updateDic.filter({ $0["Correct"] == "未正解" }).count == 0 {
                self.singalealert(title: "更新できません",
                                  message: "全問正解してます")
            } else {
                for num in 0..<x {
                    if updateDic[num]["Correct"] == "未正解" {
                        updateDic[num]["Status"]="表示する"
                    } else {
                        updateDic[num]["Status"]="非表示"
                    }
                }
                
                self.userDefaults.set(updateDic, forKey: "日本語")
                print("更新後\(updateDic)")
                SVProgressHUD.showSuccess(withStatus: "「不正解または未回答のクイズのみ表示」に変更しました")
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
    
    @IBAction func allOriginalButton(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "「オリジナルクイズのみ表示」に変更しますか", message: "クイズ作成ページから個別に設定できます", preferredStyle:  UIAlertController.Style.alert)
        
        //OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            var updateDic = self.quizDic
            //辞書を更新
            let x = updateDic.count
            let y = x-73
            
            if y == 0 {
                
                self.singalealert(title: "オリジナルクイズがありません",
                                  message: "クイズ作成ページから作成できます")
            } else {
                for num in 0...y-1 {
                    updateDic[num]["Status"]="表示する"
                }
                for num in y..<x {
                    updateDic[num]["Status"]="非表示"
                    
                    self.userDefaults.set(updateDic, forKey: "日本語")
                    print("更新後\(updateDic)")
                    SVProgressHUD.showSuccess(withStatus: "「オリジナルクイズのみ表示」に変更しました")
                }
                
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
    
    @IBAction func defaultButton(_ sender: Any) {
        //メッセージ
        let alert: UIAlertController = UIAlertController(title: "本当に初期化しますか？", message: "追加したクイズとスコアが全てリセットされます", preferredStyle:  UIAlertController.Style.alert)
        
        //OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            self.quizDic.removeAll()
            self.quizDic = self.defaultDic
            print("代入後: \(self.quizDic)")
            //辞書を更新
            self.userDefaults.set(self.quizDic, forKey: "日本語")
            SVProgressHUD.showSuccess(withStatus: "初期化しました")
            
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
    
    
    @IBAction func backHome(_ sender: Any) {
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
