//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 川上知宏 on 2021/05/13.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView! //上の画像
    @IBOutlet var imgView2: UIImageView! //真ん中の画像
    @IBOutlet var imgView3: UIImageView! //下の画像
    
    @IBOutlet var resultLabel: UILabel! //スコアを表示するラベル
    
    var timer: Timer! //画像を動かすためのタイマー
    var score: Int = 1000 //スコアの値
    let defaults = UserDefaults.standard //スコアを保存するための変数
    
    let width: CGFloat = UIScreen.main.bounds.size.width //画面幅
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]//画面の入りの配列
    var dx: [CGFloat] = [3.0, -5.0, 2.5] //画像の動かす幅
    
    func start() {
        resultLabel.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        positionX = [width/2, width/2, width/2]
        self.start()
    }
    
    @objc func up() {
        for i in 0 ..< 3 {
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i]
        }
        imgView1.center.x = positionX[0]
        imgView2.center.x = positionX[1]
        imgView3.center.x = positionX[2]
    }
    
    @IBAction func stop() {
        if timer.isValid == true {
            timer.invalidate()
        }
        
        for i in 0..<3 {
            score = score - abs(Int(width/2 - positionX[i]))*2
        }
        resultLabel.text = "Score : " + String(score)
        resultLabel.isHidden = false
        
        let highScore1: Int = defaults.integer(forKey: "score1")
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")
    
        if score > highScore1 {
            defaults.set(score,forKey: "score1")
            defaults.set(highScore1, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        }else if score > highScore2 {
            defaults.set(score, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        }else if score > highScore3 {
            defaults.set(score, forKey: "score3")
        }
        
        defaults.synchronize()
    }
    
    @IBAction func retry() {
        score = 1000
        positionX = [width/2,width/2,width/2]
        if timer.isValid == false {
            self.start()
        }
    }
    
    @IBAction func toTop() {
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
