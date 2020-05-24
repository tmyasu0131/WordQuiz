//
//  TopSettingViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/11.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import AVFoundation

var userDefaults = UserDefaults.standard
var quizDic = UserDefaults.standard.object(forKey: "日本語") as! [[String:String]]

var settingDic = ["Bgm":"オン","Sound":"オン","Vibe":"オン","Stop":"オン","Press":"オン"]

class TopSettingViewController: UIViewController {
    
    @IBOutlet weak var N1: UILabel!
    @IBOutlet weak var N2: UILabel!
    @IBOutlet weak var N3: UILabel!
    
    @IBOutlet weak var bgmSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibeSwitch: UISwitch!
    @IBOutlet weak var stopSwitch: UISwitch!
    @IBOutlet weak var pressSwitch: UISwitch!
    
    @IBOutlet weak var bgmStatusText: UILabel!
    @IBOutlet weak var soundStatusText: UILabel!
    @IBOutlet weak var vibeStatusText: UILabel!
    @IBOutlet weak var stopStatusText: UILabel!
    @IBOutlet weak var pressStatusText: UILabel!
    
    @IBOutlet weak var creditView: UIImageView!
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad 実行")
        let settingDic =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        
        N1.text = "\(quizDic.filter({ $0["Correct"] == "正解" }).count)"
        N2.text = "\(quizDic.count)"
        N3.text = "\(quizDic.filter({ $0["Status"] == "表示する" }).count)"
        
        //スイッチの状態
        if settingDic["Bgm"] == "オン" {
            bgmSwitch.setOn(true, animated: false);
            bgmStatusText.text = "オン"
            bgmStatusText.textColor = UIColor.darkGray
        }else{
            bgmSwitch.setOn(false, animated: true);
            bgmStatusText.text = "オフ"
            bgmStatusText.textColor = UIColor.red
        }
                
        
        if settingDic["Sound"] == "オン" {
            soundSwitch.setOn(true, animated: false);
            soundStatusText.text = "オン"
            soundStatusText.textColor = UIColor.darkGray
        }else{
            soundSwitch.setOn(false, animated: true);
            soundStatusText.text = "オフ"
            soundStatusText.textColor = UIColor.red
        }
        
        if settingDic["Vibe"] == "オン" {
            vibeSwitch.setOn(true, animated: false);
            vibeStatusText.text = "オン"
            vibeStatusText.textColor = UIColor.darkGray
        }else{
            vibeSwitch.setOn(false, animated: true);
            vibeStatusText.text = "オフ"
            vibeStatusText.textColor = UIColor.red
        }
        
        if settingDic["Stop"] == "オン" {
            stopSwitch.setOn(true, animated: false);
            stopStatusText.text = "オン"
            stopStatusText.textColor = UIColor.darkGray
        }else{
            stopSwitch.setOn(false, animated: true);
            stopStatusText.text = "オフ"
            stopStatusText.textColor = UIColor.red
        }
        
        if settingDic["Press"] == "オン" {
            pressSwitch.setOn(true, animated: false);
            pressStatusText.text = "オン"
            pressStatusText.textColor = UIColor.darkGray
        }else{
            pressSwitch.setOn(false, animated: true);
            pressStatusText.text = "オフ"
            pressStatusText.textColor = UIColor.red
        }
        
        creditView.image = UIImage(named: "credit")
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(red: 255/255, green: 237/255, blue: 205/255, alpha: 100/100)
    }
    
    @IBAction func bgmTap(_ sender: UISwitch) {
        
        var updateSetting =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        
        
        if sender.isOn{
            updateSetting["Bgm"] = "オン"
            bgmStatusText.text = "オン"
            bgmStatusText.textColor = UIColor.darkGray
            audioPlayer.volume = 0.2
            audioPlayer?.play()
            
        }else{
            updateSetting["Bgm"] = "オフ"
            bgmStatusText.text = "オフ"
            bgmStatusText.textColor = UIColor.red
            audioPlayer?.stop()
        }
        
        userDefaults.set(updateSetting, forKey: "設定")
        print(updateSetting)
    }
    
    @IBAction func soundTap(_ sender: UISwitch) {
        
        var updateSetting =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        
        if sender.isOn{
            updateSetting["Sound"] = "オン"
            soundStatusText.text = "オン"
            soundStatusText.textColor = UIColor.darkGray
        }else{
            updateSetting["Sound"] = "オフ"
            soundStatusText.text = "オフ"
            soundStatusText.textColor = UIColor.red
        }
        userDefaults.set(updateSetting, forKey: "設定")
        print(updateSetting)
    }

    @IBAction func vibeTap(_ sender: UISwitch) {
        
        var updateSetting =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        
        if sender.isOn{
            updateSetting["Vibe"] = "オン"
            vibeStatusText.text = "オン"
            vibeStatusText.textColor = UIColor.darkGray
            
        }else{
            updateSetting["Vibe"] = "オフ"
            vibeStatusText.text = "オフ"
            vibeStatusText.textColor = UIColor.red
        }
        userDefaults.set(updateSetting, forKey: "設定")
        print(updateSetting)
    }
    
    @IBAction func stopTap(_ sender: UISwitch) {
        var updateSetting =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        
        if sender.isOn{
            updateSetting["Stop"] = "オン"
            stopStatusText.text = "オン"
            stopStatusText.textColor = UIColor.darkGray
            
        }else{
            updateSetting["Stop"] = "オフ"
            stopStatusText.text = "オフ"
            stopStatusText.textColor = UIColor.red
        }
        userDefaults.set(updateSetting, forKey: "設定")
        print(updateSetting)
    }
    
    
    @IBAction func pressTap(_ sender: UISwitch) {
        
        var updateSetting =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
        
        if sender.isOn{
            updateSetting["Press"] = "オン"
            pressStatusText.text = "オン"
            pressStatusText.textColor = UIColor.darkGray
        }else{
            updateSetting["Press"] = "オフ"
            pressStatusText.text = "オフ"
            pressStatusText.textColor = UIColor.red
        }
        userDefaults.set(updateSetting, forKey: "設定")
        print(updateSetting)
    }
    
    
    
    
    @IBAction func settingBack(_ sender: Any) {
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
