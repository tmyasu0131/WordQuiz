//
//  ZukanViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/12.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ZukanViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout   {
    
    // レイアウト設定　UIEdgeInsets については下記の参考図を参照。
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
    // 1行あたりのアイテム数
    private let itemsPerRow: CGFloat = 3
    var talker = AVSpeechSynthesizer()
    var zukanDic = UserDefaults.standard.object(forKey: "日本語")! as! [[String:String]]

    var userDefaults = UserDefaults.standard

    var settingDic =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        zukanDic.shuffle()
        
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
    
    //バイブレーション
    func correctVibrate() {
        AudioServicesPlaySystemSound(1519 );
        AudioServicesDisposeSystemSoundID(1519 );
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
    
    // １つのセクションの中に表示するセル（要素）の数。
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zukanDic.count
    }
    
    // セル（要素）に表示する内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // "Cell" の部分は　Storyboard でつけた cell の identifier。
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let zukanList = zukanDic[indexPath.row]
    
        // Tag番号を使ってインスタンスをつくる
        let photoImageView = cell.contentView.viewWithTag(1)  as! UIImageView
        //画像を丸くする
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width * 0.05
        photoImageView.clipsToBounds = true
        
        //画像を入れる
        let zukanImage = zukanList["Image"]!
        let photoImage = UIImage(named:"\(zukanImage)")
        if photoImage != nil {
            photoImageView.image = photoImage
        } else {
            photoImageView.image = getImageToDocumentDirectory(fileName: zukanImage)
        }
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = zukanList["Text"]!.precomposedStringWithCanonicalMapping
        
        return cell
    }
    
    // Screenサイズに応じたセルサイズを返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1) //+1
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem - 10 , height: widthPerItem + 50 )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    // セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0 // 10.0
    }
    
    // セルが選択されたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(zukanDic[indexPath.row])がtapされたよ")
        
        let zukanList = zukanDic[indexPath.row]
        
        if self.settingDic["Vibe"] == "オン" {
            self.correctVibrate()
        }

        guard let readText = zukanList["Text"] else {
            return
        }
        // 話す内容をセット
        let utterance = AVSpeechUtterance(string: readText)
        // 言語を日本に設定
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.volume = 2
        self.talker.speak(utterance)
        
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

extension Array {

    mutating func shuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }

    var shuffled: Array {
        var copied = Array<Element>(self)
        copied.shuffle()
        return copied
    }
}
