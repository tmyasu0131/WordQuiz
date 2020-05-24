//
//  ViewController.swift
//  WordQuiz
//
//  Created by yasu on 2020/05/01.
//  Copyright © 2020 tmyasu. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var bgmPlayer: AVAudioPlayer!
    var talker = AVSpeechSynthesizer()
    
    // "ja-JP"を指定すると日本語になります。
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var micLabel: UILabel!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var hintButtonText: UIButton!
    @IBOutlet weak var micTextLabel: UILabel!
    
    var userDefaults = UserDefaults.standard
    
    let quizDic = [["Image":"ひこうきImage","Text":"ひこうき","Status":"表示する","Correct":"未正解"],["Image":"とらっくImage","Text":"とらっく","Status":"表示する","Correct":"未正解"],["Image":"しょうぼうしゃImage","Text":"しょうぼうしゃ","Status":"表示する","Correct":"未正解"],["Image":"きゅうきゅうしゃImage","Text":"きゅうきゅうしゃ","Status":"表示する","Correct":"未正解"],["Image":"なすImage","Text":"なす","Status":"表示する","Correct":"未正解"],["Image":"きゅうりImage","Text":"きゅうり","Status":"表示する","Correct":"未正解"],["Image":"とうもろこしImage","Text":"とうもろこし","Status":"表示する","Correct":"未正解"],["Image":"しろねぎImage","Text":"しろねぎ","Status":"表示する","Correct":"未正解"],["Image":"れたすImage","Text":"れたす","Status":"表示する","Correct":"未正解"],["Image":"りんごImage","Text":"りんご","Status":"表示する","Correct":"未正解"],["Image":"みかんImage","Text":"みかん","Status":"表示する","Correct":"未正解"],["Image":"ぱいなっぷるImage","Text":"ぱいなっぷる","Status":"表示する","Correct":"未正解"],["Image":"めろんImage","Text":"めろん","Status":"表示する","Correct":"未正解"],["Image":"ぶどうImage","Text":"ぶどう","Status":"表示する","Correct":"未正解"],["Image":"ばななImage","Text":"ばなな","Status":"表示する","Correct":"未正解"],["Image":"れもんImage","Text":"れもん","Status":"表示する","Correct":"未正解"],["Image":"さくらんぼImage","Text":"さくらんぼ","Status":"表示する","Correct":"未正解"],["Image":"ほっとけーきImage","Text":"ほっとけーき","Status":"表示する","Correct":"未正解"],["Image":"ぷりんImage","Text":"ぷりん","Status":"表示する","Correct":"未正解"],["Image":"くっきーImage","Text":"くっきー","Status":"表示する","Correct":"未正解"],["Image":"さんどいっちImage","Text":"さんどいっち","Status":"表示する","Correct":"未正解"],["Image":"ぱすたImage","Text":"ぱすた","Status":"表示する","Correct":"未正解"],["Image":"おにぎりImage","Text":"おにぎり","Status":"表示する","Correct":"未正解"],["Image":"なっとうまきImage","Text":"なっとうまき","Status":"表示する","Correct":"未正解"],["Image":"おすしImage","Text":"おすし","Status":"表示する","Correct":"未正解"],["Image":"かれーらいすImage","Text":"かれーらいす","Status":"表示する","Correct":"未正解"],["Image":"らーめんImage","Text":"らーめん","Status":"表示する","Correct":"未正解"],["Image":"ぽてとImage","Text":"ぽてと","Status":"表示する","Correct":"未正解"],["Image":"かぶとむしImage","Text":"かぶとむし","Status":"表示する","Correct":"未正解"],["Image":"へびImage","Text":"へび","Status":"表示する","Correct":"未正解"],["Image":"さるImage","Text":"さる","Status":"表示する","Correct":"未正解"],["Image":"うまImage", "Text": "うま","Status":"表示する","Correct":"未正解"],["Image":"いぬImage","Text":"いぬ","Status":"表示する","Correct":"未正解"],["Image":"ひつじImage","Text":"ひつじ","Status":"表示する","Correct":"未正解"],["Image":"にわとりImage","Text":"にわとり","Status":"表示する","Correct":"未正解"],["Image":"ねずみImage", "Text": "ねずみ","Status":"表示する","Correct":"未正解"],["Image":"うしImage","Text":"うし","Status":"表示する","Correct":"未正解"],["Image":"とらImage","Text":"とら","Status":"表示する","Correct":"未正解"],["Image":"うさぎImage","Text":"うさぎ","Status":"表示する","Correct":"未正解"],["Image":"わにImage","Text":"わに","Status":"表示する","Correct":"未正解"],["Image":"いるかImage","Text":"いるか","Status":"表示する","Correct":"未正解"],["Image":"いかImage","Text":"いか","Status":"表示する","Correct":"未正解"],["Image":"とりけらとぷすImage","Text":"とりけらとぷす","Status":"表示する","Correct":"未正解"],["Image":"てぃらのさうるすImage","Text":"てぃらのさうるす","Status":"表示する","Correct":"未正解"],["Image":"ぷてらのどんImage","Text":"ぷてらのどん","Status":"表示する","Correct":"未正解"],["Image":"ぶらきおさうるすImage","Text":"ぶらきおさうるす","Status":"表示する","Correct":"未正解"],["Image":"あんきろさうるすImage","Text":"あんきろさうるす","Status":"表示する","Correct":"未正解"],["Image":"ちきゅうImage", "Text": "ちきゅう","Status":"表示する","Correct":"未正解"],["Image":"たいようImage","Text":"たいよう","Status":"表示する","Correct":"未正解"],["Image":"あめImage","Text":"あめ","Status":"表示する","Correct":"未正解"],["Image":"どらいやーImage", "Text": "どらいやー","Status":"表示する","Correct":"未正解"],["Image":"せんぷうきImage","Text":"せんぷうき","Status":"表示する","Correct":"未正解"],["Image":"すいはんきImage","Text":"すいはんき","Status":"表示する","Correct":"未正解"], ["Image":"ろうそくImage", "Text": "ろうそく","Status":"表示する","Correct":"未正解"],["Image":"はさみImage","Text":"はさみ","Status":"表示する","Correct":"未正解"],["Image":"べっどImage","Text":"べっど","Status":"表示する","Correct":"未正解"],["Image":"あいろんImage","Text":"あいろん","Status":"表示する","Correct":"未正解"],["Image":"ぴあのImage","Text":"ぴあの","Status":"表示する","Correct":"未正解"],["Image":"すぽんじImage","Text":"すぽんじ","Status":"表示する","Correct":"未正解"],["Image":"まいくImage", "Text": "まいく","Status":"表示する","Correct":"未正解"],["Image":"てんとImage","Text":"てんと","Status":"表示する","Correct":"未正解"],["Image":"らっぱImage", "Text": "らっぱ","Status":"表示する","Correct":"未正解"],["Image":"おばけImage","Text":"おばけ","Status":"表示する","Correct":"未正解"],["Image":"ぜろimage","Text":"ぜろ","Status":"表示する","Correct":"未正解"],["Image":"いちImage","Text":"いち","Status":"表示する","Correct":"未正解"],["Image":"にImage","Text":"に","Status":"表示する","Correct":"未正解"],["Image":"さんImage","Text":"さん","Status":"表示する","Correct":"未正解"],["Image":"よんImage","Text":"よん","Status":"表示する","Correct":"未正解"],["Image":"ごImage","Text":"ご","Status":"表示する","Correct":"未正解"],["Image":"ろくImage","Text":"ろく","Status":"表示する","Correct":"未正解"],["Image":"ななImage","Text":"なな","Status":"表示する","Correct":"未正解"],["Image":"はちImage","Text":"はち","Status":"表示する","Correct":"未正解"],["Image":"きゅうImage","Text":"きゅう","Status":"表示する","Correct":"未正解"]]
    
    var settingDic =  UserDefaults.standard.object(forKey: "設定") as! [String:String]
    
    let startmicImage = UIImage(named: "mic3")
    let stopmicImage = UIImage(named: "mic0")
    let stopmicImage2 = UIImage(named: "mic2")
    let stopmicImage1 = UIImage(named: "mic1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad を実行")
        // Do any additional setup after loading the view.
        // 角丸にする
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.05
        imageView.clipsToBounds = true
        //ディクショナリ形式で初期値を指定
        //更新があればそちらを利用
        userDefaults.register(defaults: ["日本語" : quizDic])
        //シャッフルする
        Shuffle()
        //マイクREADY画像
        micButton.setImage(startmicImage, for: .normal)
        
        speechRecognizer.delegate = self
        micButton.isEnabled = false
        
        //BGMの設定
        BgmPlay()
        
    }
    
    func BgmPlay(){
        //BGMの設定
        let soundFilePath : String = Bundle.main.path(forResource: "quizBGM", ofType: "mp3")!
        let fileURL : URL = URL(fileURLWithPath: soundFilePath)
        //マナーモード設定
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(.playback, mode: .default)
        try! audioSession.setActive(true)
        
        do{
            bgmPlayer = try AVAudioPlayer(contentsOf: fileURL)
            
        }
        catch{
        }
        
        //numberOfLoopsに-1を指定すると無限ループする。
        bgmPlayer.numberOfLoops = -1
        
        if settingDic["Bgm"]=="オン"{
            bgmPlayer.play()
            bgmPlayer.volume = 0.3
            print("bgmPlayer を実行")
        }
    }
    
    func Shuffle() {
        let random_quiz: [String : String] = userDefaults.array(forKey: "日本語")!.randomElement() as! [String : String]
        if random_quiz["Status"] == "表示する"{
            let quizImage = random_quiz["Image"]!
            let quizText = random_quiz["Text"]!
            
            //画像を挿入
            let image = UIImage(named: "\(quizImage)")
            //if image == nil { Path から画像を取り出して代入する }
            if image != nil {
                imageView.image = image
            } else {
                imageView.image = getImageToDocumentDirectory(fileName: quizImage)
            }
            
            //テキストを挿入
            textLabel.text = quizText
            //正解テキストの色
            textLabel.textColor = UIColor.white
            
        }else{
            Shuffle()
        }
    }
    
    func correctVibrate() {
        AudioServicesPlaySystemSound(1003);
        AudioServicesDisposeSystemSoundID(1003);
    }
    
    func incorrectVibrate() {
        AudioServicesPlaySystemSound(1007);
        AudioServicesDisposeSystemSoundID(1007);
    }
    
    //タップバイブレーション
    func tapVibrate() {
        AudioServicesPlaySystemSound(1519 );
        AudioServicesDisposeSystemSoundID(1519 );
    }
    
    
    // ユーザー認証をとる
    override func viewWillAppear(_ animated: Bool) {
        //マイク認証
        AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: {(granted: Bool) in})
        //音声入力認証
        SFSpeechRecognizer.requestAuthorization { (status) in
            OperationQueue.main.addOperation {
            }
        }
        
        
    }
    // ローカル画像の取り出しメソッド
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
    
    //音声入力のリクエスト
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestRecognizerAuthorization()
    }
    
    private func requestRecognizerAuthorization() {
        //認証処理
        SFSpeechRecognizer.requestAuthorization { authStatus in
            //メインスレッドで処理したい内容のため、OperationQueue.main.addOperationを使う
            OperationQueue.main.addOperation { [weak self] in
                guard let `self` = self else { return }
                
                switch authStatus {
                case .authorized:
                    self.micButton.isEnabled = true
                    
                case .denied:
                    self.micButton.isEnabled = false
                    self.micButton.setTitle("端末の設定からマイクへのアクセスを許可してください。", for: .disabled)
                    
                case .restricted:
                    self.micButton.isEnabled = false
                    self.micButton.setTitle("端末の設定からマイクへのアクセスを許可してください。", for: .disabled)
                    
                case .notDetermined:
                    self.micButton.isEnabled = false
                    self.micButton.setTitle("端末の設定からマイクへのアクセスを許可してください。", for: .disabled)
                    
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    
    private func startRecording() throws {
        refreshTask()
        
        let audioSession = AVAudioSession.sharedInstance()
        // 録音用のカテゴリをセット
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // 録音が完了する前のリクエストを作るかどうかのフラグ。
        // trueだと現在-1回目のリクエスト結果が返ってくる模様。falseだとボタンをオフにしたときに音声認識の結果が返ってくる設定。
        recognitionRequest.shouldReportPartialResults = false
        
        print("recognitionTask前")
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let `self` = self else { return }
            
            var isFinal = false
            print("isFinal")
            
            if let result = result {
                var Kanji: String
                Kanji = result.bestTranscription.formattedString
                
                print(Kanji)
                //ひらがな化する
                var request = URLRequest(url: URL(string: "https://labs.goo.ne.jp/api/hiragana")!)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let postData = PostData(app_id: "26bccd74a36e0f3f95c4fc7979971c35722ee9752c745143964f1896afdcc1e7", request_id: "record003", sentence: Kanji, output_type: "hiragana")
                
                guard let uploadData = try? JSONEncoder().encode(postData) else {
                    print("json生成に失敗しました")
                    return
                }
                request.httpBody = uploadData
                
                let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
                    if let error = error {
                        print ("error: \(error)")
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                            print ("server error")
                            return
                    }
                    
                    guard let data = data, let jsonData = try? JSONDecoder().decode(Rubi.self, from: data) else {
                        print("json変換に失敗しました")
                        return
                    }
                    print(jsonData.converted)
                    
                    DispatchQueue.main.async {
                        self.micLabel.text = jsonData.converted
                        
                        //正解・不正解の音を鳴らす
                        if self.micLabel.text!.contains(self.textLabel.text!) {
                            //正解フラグを立てて更新する
                            self.micLabel.text = self.textLabel.text?.precomposedStringWithCanonicalMapping
                            let correctWord:String = self.textLabel.text!
                            var Quiz = self.userDefaults.array(forKey: "日本語")as? [[String: Any]]
                            let textArray = Quiz?.map{$0["Text"] as! String}
                            let indexNum = textArray?.firstIndex(of: correctWord)
                            Quiz?[indexNum!]["Correct"]="正解"
                            self.userDefaults.set(Quiz, forKey: "日本語")
                            print("正解更新: \(String(describing: Quiz?[indexNum!]))")
                            if self.settingDic["Sound"] == "オン" {
                                self.playSound(name: "correct")
                            }
                            self.textLabel.text = "せいかい！"
                            if self.settingDic["Vibe"] == "オン" {
                                self.correctVibrate()
                            }
                            self.textLabel.textColor = UIColor.black
                            
                            
                            // 0.25秒後に実行したい処理
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                
                                guard let text = self.micLabel.text else {
                                    return
                                }
                                // 話す内容をセット
                                let utterance = AVSpeechUtterance(string: text)
                                // 言語を日本に設定
                                utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
                                utterance.volume = 2
                                if self.settingDic["Sound"] == "オン" {
                                    // 実行
                                    self.talker.speak(utterance)
                                }
                            }
                            
                            // 2秒後に実行したい処理
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                //問題をシャッフルする
                                self.Shuffle()
                                self.BgmPlay()
                                self.micLabel.text = "これはなんでしょう?"
                                self.hintButtonText.setTitle("ヒントをみる", for: .normal)
                                self.micButton.isEnabled = true
                                //マイクREADY画像
                                self.micButton.setImage(self.startmicImage, for: .normal)
                            }
                            
                        } else{
                            if self.settingDic["Sound"] == "オン" {
                                self.playSound(name: "wrong")
                            }
                            
                            if self.settingDic["Vibe"] == "オン" {
                                self.incorrectVibrate()
                            }
                            
                            self.micLabel.text = "\(jsonData.converted) ではないよ"
                            self.micButton.isEnabled = true
                            //マイクREADY画像
                            self.micButton.setImage(self.startmicImage, for: .normal)
                            //不正解フラグを立てて更新する
                            let correctWord:String = self.textLabel.text!
                            var Quiz = self.userDefaults.array(forKey: "日本語")as? [[String: Any]]
                            let textArray = Quiz?.map{$0["Text"] as! String}
                            let indexNum = textArray?.firstIndex(of:correctWord)
                            Quiz?[indexNum!]["Correct"]="未正解"
                            
                            self.userDefaults.set(Quiz, forKey: "日本語")
                            print("不正解更新: \(String(describing: Quiz?[indexNum!]))")
                            self.BgmPlay()
                        }
                        
                    }
                }
                task.resume()
                
                
                isFinal = result.isFinal
                
            }
            
            
            
            // エラーがある、もしくは最後の認識結果だった場合の処理
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.micButton.isEnabled = true
                if error != nil {
                    self.BgmPlay()
                    self.micLabel.text = "これはなんでしょう？"
                    self.micTextLabel.text = "もういちど"
                    //マイクREADY画像
                    self.micButton.setImage(self.startmicImage, for: .normal)
                    
                } else {
                    self.micTextLabel.text = "ボタンをおしてこたえる"
                    self.micButton.isEnabled = false
                    //マイクREADY画像
                    self.micButton.setImage(self.startmicImage, for: .normal)
                }
                
            }
        }
        
        
        // マイクから取得した音声バッファをリクエストに渡す
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        try startAudioEngine()
    }
    
    private func refreshTask() {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }
    
    private func startAudioEngine() throws {
        // startの前にリソースを確保しておく。
        audioEngine.prepare()
        
        try audioEngine.start()
        
        micLabel.text = "かいとうちゅう..."
        //マイク止める時の画像
        self.micButton.setImage(self.stopmicImage, for: .normal)
    }
    
    
    @IBAction func tappedStartButton(_ sender: AnyObject) {
        
        if audioEngine.isRunning && settingDic["Stop"]=="オフ" {
            print("停止処理")
            audioEngine.stop()
            recognitionRequest?.endAudio()
            micButton.isEnabled = false
            micTextLabel.text = "はんていちゅう"
            //マイク止める時の画像
            self.micButton.setImage(self.stopmicImage, for: .normal)
            if self.settingDic["Vibe"] == "オン" {
                self.tapVibrate()
            }
        } else if audioEngine.isRunning && settingDic["Stop"]=="オン"{
            print("ボタン無効")
        } else  {
            print("再生処理")
            if self.settingDic["Vibe"] == "オン" {
                self.tapVibrate()
            }
            
            try! startRecording()
            micTextLabel.text = "ボタンをおしてこたえあわせ"
            //マイクREADY画像
            self.micButton.setImage(self.stopmicImage, for: .normal)
            
            if settingDic["Stop"]=="オン"{
                
                micTextLabel.text = "こたえてね"
                //マイクカウントダウン
                self.micButton.setImage(self.stopmicImage2, for: .normal)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    //マイクREADY画像
                    self.micButton.setImage(self.stopmicImage1, for: .normal)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // your code here
                    print("2秒経過停止")
                    if self.settingDic["Vibe"] == "オン" {
                        self.tapVibrate()
                    }
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                    self.micButton.isEnabled = false
                    self.micTextLabel.text = "はんていちゅう"
                    //マイク止める時の画像
                    self.micButton.setImage(self.stopmicImage, for: .normal)
                }
            }
        }
    }
    
    @IBAction func finish(_ sender: Any) {
        if settingDic["Bgm"]=="オン"{
            //音声をオフ
            bgmPlayer.currentTime = 0
            bgmPlayer.stop()
            print("bgmPlayer.stopが呼び出された")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        //問題をシャッフルする
        self.Shuffle()
        self.micLabel.text = "これはなんでしょう?"
        self.hintButtonText.setTitle("ヒントをみる", for: .normal)
    }
    
    @IBAction func hintButton(_ sender: UIButton) {
        let hintText:String = String(self.textLabel.text!.prefix(1)).precomposedStringWithCanonicalMapping
        sender.setTitle("「\(hintText)」 からはじまるよ", for: .normal)
        
        
    }
}

extension ViewController: SFSpeechRecognizerDelegate {
    // 音声認識の可否が変更したときに呼ばれるdelegate
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            micButton.isEnabled = true
            micTextLabel.text = "こたえる"
            //マイクREADY画像 //追加
            micButton.setImage(self.startmicImage, for: .normal)
        } else {
            micButton.isEnabled = false
            micTextLabel.text = "こたえあわせをする"
            //マイク止める時の画像
            micButton.setImage(self.stopmicImage, for: .normal)
        }
    }
}

struct Rubi:Codable {
    var request_id: String
    var output_type: String
    var converted: String
}

struct PostData: Codable {
    var app_id:String
    var request_id: String
    var sentence: String
    var output_type: String
}

extension ViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(.playback, mode: .default)
        try! audioSession.setActive(true)
        
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            
            // 音声の再生
            audioPlayer.play()
        } catch {
        }
    }
}


