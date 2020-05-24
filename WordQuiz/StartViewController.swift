//
//  StartViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/02.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
import AudioToolbox

class StartViewController: UIViewController {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    //private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var userDefaults = UserDefaults.standard
    
    @IBOutlet weak var createQuizButton: UIButton!
    @IBOutlet weak var topSetting: UIButton!

    @IBOutlet weak var pressQuizText: UILabel!
    @IBOutlet weak var pressSettingText: UILabel!
    
    let quizDic = [["Image":"ひこうきImage","Text":"ひこうき","Status":"表示する","Correct":"未正解"],["Image":"とらっくImage","Text":"とらっく","Status":"表示する","Correct":"未正解"],["Image":"しょうぼうしゃImage","Text":"しょうぼうしゃ","Status":"表示する","Correct":"未正解"],["Image":"きゅうきゅうしゃImage","Text":"きゅうきゅうしゃ","Status":"表示する","Correct":"未正解"],["Image":"なすImage","Text":"なす","Status":"表示する","Correct":"未正解"],["Image":"きゅうりImage","Text":"きゅうり","Status":"表示する","Correct":"未正解"],["Image":"とうもろこしImage","Text":"とうもろこし","Status":"表示する","Correct":"未正解"],["Image":"しろねぎImage","Text":"しろねぎ","Status":"表示する","Correct":"未正解"],["Image":"れたすImage","Text":"れたす","Status":"表示する","Correct":"未正解"],["Image":"りんごImage","Text":"りんご","Status":"表示する","Correct":"未正解"],["Image":"みかんImage","Text":"みかん","Status":"表示する","Correct":"未正解"],["Image":"ぱいなっぷるImage","Text":"ぱいなっぷる","Status":"表示する","Correct":"未正解"],["Image":"めろんImage","Text":"めろん","Status":"表示する","Correct":"未正解"],["Image":"ぶどうImage","Text":"ぶどう","Status":"表示する","Correct":"未正解"],["Image":"ばななImage","Text":"ばなな","Status":"表示する","Correct":"未正解"],["Image":"れもんImage","Text":"れもん","Status":"表示する","Correct":"未正解"],["Image":"さくらんぼImage","Text":"さくらんぼ","Status":"表示する","Correct":"未正解"],["Image":"ほっとけーきImage","Text":"ほっとけーき","Status":"表示する","Correct":"未正解"],["Image":"ぷりんImage","Text":"ぷりん","Status":"表示する","Correct":"未正解"],["Image":"くっきーImage","Text":"くっきー","Status":"表示する","Correct":"未正解"],["Image":"さんどいっちImage","Text":"さんどいっち","Status":"表示する","Correct":"未正解"],["Image":"ぱすたImage","Text":"ぱすた","Status":"表示する","Correct":"未正解"],["Image":"おにぎりImage","Text":"おにぎり","Status":"表示する","Correct":"未正解"],["Image":"なっとうまきImage","Text":"なっとうまき","Status":"表示する","Correct":"未正解"],["Image":"おすしImage","Text":"おすし","Status":"表示する","Correct":"未正解"],["Image":"かれーらいすImage","Text":"かれーらいす","Status":"表示する","Correct":"未正解"],["Image":"らーめんImage","Text":"らーめん","Status":"表示する","Correct":"未正解"],["Image":"ぽてとImage","Text":"ぽてと","Status":"表示する","Correct":"未正解"],["Image":"かぶとむしImage","Text":"かぶとむし","Status":"表示する","Correct":"未正解"],["Image":"へびImage","Text":"へび","Status":"表示する","Correct":"未正解"],["Image":"さるImage","Text":"さる","Status":"表示する","Correct":"未正解"],["Image":"うまImage", "Text": "うま","Status":"表示する","Correct":"未正解"],["Image":"いぬImage","Text":"いぬ","Status":"表示する","Correct":"未正解"],["Image":"ひつじImage","Text":"ひつじ","Status":"表示する","Correct":"未正解"],["Image":"にわとりImage","Text":"にわとり","Status":"表示する","Correct":"未正解"],["Image":"ねずみImage", "Text": "ねずみ","Status":"表示する","Correct":"未正解"],["Image":"うしImage","Text":"うし","Status":"表示する","Correct":"未正解"],["Image":"とらImage","Text":"とら","Status":"表示する","Correct":"未正解"],["Image":"うさぎImage","Text":"うさぎ","Status":"表示する","Correct":"未正解"],["Image":"わにImage","Text":"わに","Status":"表示する","Correct":"未正解"],["Image":"いるかImage","Text":"いるか","Status":"表示する","Correct":"未正解"],["Image":"いかImage","Text":"いか","Status":"表示する","Correct":"未正解"],["Image":"とりけらとぷすImage","Text":"とりけらとぷす","Status":"表示する","Correct":"未正解"],["Image":"てぃらのさうるすImage","Text":"てぃらのさうるす","Status":"表示する","Correct":"未正解"],["Image":"ぷてらのどんImage","Text":"ぷてらのどん","Status":"表示する","Correct":"未正解"],["Image":"ぶらきおさうるすImage","Text":"ぶらきおさうるす","Status":"表示する","Correct":"未正解"],["Image":"あんきろさうるすImage","Text":"あんきろさうるす","Status":"表示する","Correct":"未正解"],["Image":"ちきゅうImage", "Text": "ちきゅう","Status":"表示する","Correct":"未正解"],["Image":"たいようImage","Text":"たいよう","Status":"表示する","Correct":"未正解"],["Image":"あめImage","Text":"あめ","Status":"表示する","Correct":"未正解"],["Image":"どらいやーImage", "Text": "どらいやー","Status":"表示する","Correct":"未正解"],["Image":"せんぷうきImage","Text":"せんぷうき","Status":"表示する","Correct":"未正解"],["Image":"すいはんきImage","Text":"すいはんき","Status":"表示する","Correct":"未正解"], ["Image":"ろうそくImage", "Text": "ろうそく","Status":"表示する","Correct":"未正解"],["Image":"はさみImage","Text":"はさみ","Status":"表示する","Correct":"未正解"],["Image":"べっどImage","Text":"べっど","Status":"表示する","Correct":"未正解"],["Image":"あいろんImage","Text":"あいろん","Status":"表示する","Correct":"未正解"],["Image":"ぴあのImage","Text":"ぴあの","Status":"表示する","Correct":"未正解"],["Image":"すぽんじImage","Text":"すぽんじ","Status":"表示する","Correct":"未正解"],["Image":"まいくImage", "Text": "まいく","Status":"表示する","Correct":"未正解"],["Image":"てんとImage","Text":"てんと","Status":"表示する","Correct":"未正解"],["Image":"らっぱImage", "Text": "らっぱ","Status":"表示する","Correct":"未正解"],["Image":"おばけImage","Text":"おばけ","Status":"表示する","Correct":"未正解"],["Image":"ぜろimage","Text":"ぜろ","Status":"表示する","Correct":"未正解"],["Image":"いちImage","Text":"いち","Status":"表示する","Correct":"未正解"],["Image":"にImage","Text":"に","Status":"表示する","Correct":"未正解"],["Image":"さんImage","Text":"さん","Status":"表示する","Correct":"未正解"],["Image":"よんImage","Text":"よん","Status":"表示する","Correct":"未正解"],["Image":"ごImage","Text":"ご","Status":"表示する","Correct":"未正解"],["Image":"ろくImage","Text":"ろく","Status":"表示する","Correct":"未正解"],["Image":"ななImage","Text":"なな","Status":"表示する","Correct":"未正解"],["Image":"はちImage","Text":"はち","Status":"表示する","Correct":"未正解"],["Image":"きゅうImage","Text":"きゅう","Status":"表示する","Correct":"未正解"]]

    var settingDic = ["Bgm":"オン","Sound":"オン","Vibe":"オン","Stop":"オン","Press":"オン"]
    
    var recognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress))
    var recognizerSetting = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressSetting))
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.register(defaults: ["日本語" : quizDic])
        // Do any additional setup after loading the view.
        userDefaults.register(defaults: ["設定" : settingDic])
        // Do any additional setup after loading the view.
        
        settingDic =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        print("viewDid時:\(settingDic)")
        
        recognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress))
        recognizerSetting = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressSetting))
        createQuizButton.addGestureRecognizer(recognizer)
        topSetting.addGestureRecognizer(recognizerSetting)
        
        if settingDic["Press"] == "オン"{
            recognizer.minimumPressDuration = 1.5
            recognizerSetting.minimumPressDuration = 1.5
            pressQuizText.text = "(2秒以上長押し)"
            pressSettingText.text = "(2秒以上長押し)"
            
        }else{
            recognizer.minimumPressDuration = 0
            recognizerSetting.minimumPressDuration = 0
            pressQuizText.text = ""
            pressSettingText.text = ""
        }
        print("秒数:\(recognizer.minimumPressDuration)")
        
        //BGMの設定
        let soundFilePath : String = Bundle.main.path(forResource: "mainBGM", ofType: "mp3")!
        let fileURL : URL = URL(fileURLWithPath: soundFilePath)
        
        //マナーモード設定
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(.playback, mode: .default)
        try! audioSession.setActive(true)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        }
        catch{
        }
        
        //numberOfLoopsに-1を指定すると無限ループする。
        audioPlayer.numberOfLoops = -1
        
        if settingDic["Bgm"]=="オン"{
            audioPlayer.volume = 0.2
            audioPlayer.play()
        }
        
        view.backgroundColor = UIColor.init(red: 255/255, green: 237/255, blue: 205/255, alpha: 100/100)
        
    }
    
    //バイブレーション
    func tapVibrate() {
        AudioServicesPlaySystemSound(1519 );
        AudioServicesDisposeSystemSoundID(1519 );
    }
    
    /// セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.settingDic["Vibe"] == "オン" {
            self.tapVibrate()
        }
        if settingDic["Bgm"]=="オン"{
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            print("bgmPlayer を停止")
        }
    }
    
    
    @IBAction func zukanButton(_ sender: Any) {
        if self.settingDic["Vibe"] == "オン" {
            self.tapVibrate()
        }
        
        let storyboard: UIStoryboard = self.storyboard!
        let third = storyboard.instantiateViewController(withIdentifier: "zukanView")
        if settingDic["Bgm"]=="オン"{
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            print("bgmPlayer を停止")
        }
        
        self.present(third, animated: true, completion: nil)
    }
    
    
    
    @objc func onLongPress() {
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(withIdentifier: "Nav")
        self.present(second, animated: true, completion: nil)
    }
    
    @objc func onLongPressSetting() {
        
        let storyboard: UIStoryboard = self.storyboard!
        let topSettingView: TopSettingViewController = storyboard.instantiateViewController(withIdentifier: "topsetting") as! TopSettingViewController
        topSettingView.audioPlayer = self.audioPlayer
        self.present(topSettingView, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingDic =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        print("viewWill時:\(settingDic)")
        
        if settingDic["Press"] == "オン"{
            recognizer.minimumPressDuration = 1.5
            recognizerSetting.minimumPressDuration = 1.5
            pressQuizText.text = "(2秒以上長押し)"
            pressSettingText.text = "(2秒以上長押し)"
        } else {
            recognizer.minimumPressDuration = 0
            recognizerSetting.minimumPressDuration = 0
            pressQuizText.text = ""
            pressSettingText.text = ""
        }
        print("秒数:\(recognizer.minimumPressDuration)")
        
        if settingDic["Bgm"]=="オン"{
            audioPlayer.volume = 0.2
            audioPlayer.play()
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
