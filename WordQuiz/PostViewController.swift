//
//  PostViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/03.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import SwiftCop
import SVProgressHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addText: UITextField!

    var quizStatus: String! = "表示する"
    var alertController: UIAlertController!
  
    // Let's create a cop!
    let swiftCop = SwiftCop()
    var quizDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]
    var userDefaults = UserDefaults.standard
    var quizDicNo: Optional<Int> = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 255/255, green: 237/255, blue: 205/255, alpha: 100/100)
        // 角丸にする
        addImage.layer.cornerRadius = addImage.frame.size.width * 0.05
        addImage.clipsToBounds = true
        
        addText.addTarget(self, action: #selector(onExitAction(sender:)), for: .editingDidEndOnExit)
        
        //Cell をタップした時に値を代入
        if quizDicNo != nil {
            //画像を挿入
            let editImage = quizDic[quizDicNo!]["Image"]!
            let image = UIImage(named: "\(editImage)")
            //if image == nil { Path から画像を取り出して代入する }
            if image != nil {
                addImage.image = image
            } else {
                addImage.image = getImageToDocumentDirectory(fileName: editImage)
            }
            
            //テキストを代入
            self.addText.text = quizDic[quizDicNo!]["Text"]
            
        }
        
        // Do any additional setup after loading the view.
        swiftCop.addSuspect(Suspect(view: self.addText, sentence: "ひらがなを入力してください", trial: HogeTrial.Hiragana))
        
        self.navigationController?.navigationBar.barTintColor = .orange
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
    }
    
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// `.editingDidEndOnExit` イベントが送信されると呼ばれる
    @objc func onExitAction(sender: Any) {
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
    
    @IBAction func addImageFromLibrary(_ sender: Any) {
        //SVProgressHUD.show()
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func addImageFromCamera(_ sender: Any) {
        //SVProgressHUD.show()
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    // 写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //SVProgressHUD.dismiss()
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            
            print("DEBUG_PRINT: image = \(image)")
            
            let cropimage = cropThumbnailImage(image :image, w:180, h:180)
            self.addImage.image = cropimage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func cropThumbnailImage(image :UIImage, w:Int, h:Int) ->UIImage
    {
        // リサイズ処理
        let origRef    = image.cgImage
        let origWidth  = Int(origRef!.width)
        let origHeight = Int(origRef!.height)
        var resizeWidth:Int = 0, resizeHeight:Int = 0

        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }

        let resizeSize = CGSize.init(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))

        UIGraphicsBeginImageContext(resizeSize)

        image.draw(in: CGRect.init(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))

        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // 切り抜き処理

        let cropRect  = CGRect.init(x: CGFloat((resizeWidth - w) / 2), y: CGFloat((resizeHeight - h) / 2), width: CGFloat(w), height: CGFloat(h))
        let cropRef   = resizeImage!.cgImage!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)

        return cropImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // ImageSelectViewController画面を閉じてタブ画面に戻る
        //SVProgressHUD.dismiss()
        picker.dismiss(animated: true, completion: nil)
    }
    
    //画像保存
    func saveImageToDocumentsDirectory(Image: UIImage, filename: String) -> Bool { // ファイルに画像を保存する
        if let data = Image.pngData() {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(filename)
            do {
                try data.write(to: fileURL)
            } catch {
                //エラー処理
                return false
            }
        }
        return true
    }
    
    @IBAction func saveQuiz(_ sender: Any) {
        
        SVProgressHUD.show()
        
        func alert(title:String, message:String) {
            alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK",
                                                    style: .default,
                                                    handler: nil))
            present(alertController, animated: true)
        }
        
        if self.addImage.image != nil && self.addText.text != "" && swiftCop.isGuilty(addText) == nil {
            
            //画像を適正な角度に修正
            let nomalised = fixOrientation(img: self.addImage.image!)
            //normalizedImage を保存する
            _ = saveImageToDocumentsDirectory(Image: nomalised, filename: self.addText.text!+"Image")
            
            //quizDic として userDefaults を取り出す
            quizDic = UserDefaults.standard.array(forKey: "日本語") as! [[String : String]]
            
            
            if quizDicNo != nil {
                //配列 を更新する
                quizDic[quizDicNo!].updateValue("\(self.addText.text!)"+"Image", forKey: "Image")
                quizDic[quizDicNo!].updateValue(self.addText.text!, forKey: "Text")
                //userDefaults へ保存する
                userDefaults.set(quizDic, forKey: "日本語")
                print("既存更新\(quizDic)")
                SVProgressHUD.showSuccess(withStatus: "更新しました")
            }else{
                //先頭に追加する
                quizDic.insert( ["Image":"\(self.addText.text!)"+"Image","Text":self.addText.text!,"Status":"表示する","Correct":"未正解"],at:0)
                //userDefaults へ保存する
                userDefaults.set(quizDic, forKey: "日本語")
                print("追加更新\(quizDic)")
                SVProgressHUD.showSuccess(withStatus: "保存しました")
            }
            
            self.navigationController?.popViewController(animated: true)
            
        } else if swiftCop.isGuilty(addText) != nil{
            alert(title: "更新できません",
                  message: "ひらがなを入力してください")
            SVProgressHUD.dismiss()
        } else if addImage.image != nil{
            alert(title: "更新できません",
                  message: "テキストが入力されていません")
            SVProgressHUD.dismiss()
        } else {
            alert(title: "更新できません",
                  message: "画像がセットされていません")
            SVProgressHUD.dismiss()
        }
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

extension ViewController: UITextFieldDelegate{
//リターンキーでテキストフィールドを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
