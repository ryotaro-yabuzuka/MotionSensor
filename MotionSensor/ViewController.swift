//
//  ViewController.swift
//  MotionSensor
//
//  Created by Ryotaro Yabuzuka on 2023/02/08.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    //motionsensor全般を扱う
    let motionManager = CMMotionManager()
    
    @IBOutlet var fish: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //fishの最初のx座標
        let originalX = fish.center.x
        
        //isDeviceMotionAvailableでmotionsensorが使えるかどうかを判断
        if motionManager.isDeviceMotionAvailable {
            //motionの検知の間隔(0.02秒ごとにmotionを検知)
            motionManager.deviceMotionUpdateInterval = 0.02
            //startすることで、motionがスタートする
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler:
                {(motion, error) in
                print(motion!.attitude.roll) //iphoneを縦方向を軸とした傾き
                let newX = originalX + CGFloat(motion!.attitude.roll * 100) //CGFloatは座標を求めるのによく使用される
                self.fish.center = CGPoint(x: newX, y: self.fish.center.y)
            })
            
        }
    }
    
    //motionmsensorは多くのバッテリーを消費する
    //使用しない際は、以下を使用し止めておこう
    func stopSensor() {
        motionManager.stopDeviceMotionUpdates()
    }
    
}
