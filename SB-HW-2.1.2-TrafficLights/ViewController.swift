//
//  ViewController.swift
//  SB-HW-2.1.2-TrafficLights
//
//  Created by Sergey Nestroyniy on 01.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var redView: UIView!
    @IBOutlet var yellowView: UIView!
    @IBOutlet var greenView: UIView!
    
    @IBOutlet var buttonStartNext: UIButton!
    
    enum Lights {
        case start
        case red
        case yellow
        case green
    }
    
    private var stage = Lights.start
    
    private let alphaOn : CGFloat = 1.0
    private let alphaOff : CGFloat = 0.3

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let buttonCornerRadius = buttonStartNext.layer.frame.height / 2
        
        redView.alpha = alphaOff
        yellowView.alpha = alphaOff
        greenView.alpha = alphaOff

        buttonStartNext.layer.cornerRadius = buttonCornerRadius
        
    }
// функция установки радиусов скругления у свефтофора
    func changeLightsCornerRadius () {
        let lightCornerRadius = self.redView.layer.frame.height / 2
        
        self.redView.layer.cornerRadius = lightCornerRadius
        self.yellowView.layer.cornerRadius = lightCornerRadius
        self.greenView.layer.cornerRadius = lightCornerRadius
    }
// перед первой отрисовкой светофора надо скруглить углы у вьюшек
    override func viewWillLayoutSubviews() {
        self.changeLightsCornerRadius()
    }
    
// данная функция поможет нам поймать момент когда происходит поворот экрана (для того что бы изменить скругления у светофора)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            // This is called during the animation
            self.changeLightsCornerRadius()
        }, completion: { context in
            // This is called after the rotation is finished. Equal to deprecated `didRotate`
        })
    }
    
    
    @IBAction func pressButton(_ sender: Any) {
        switch stage {
        case .start:
            buttonStartNext.setTitle("Next", for: .normal)
            redView.alpha = alphaOn
            stage = .red
        case .red:
            redView.alpha = alphaOff
            yellowView.alpha = alphaOn
            stage = .yellow
        case .yellow:
            yellowView.alpha = alphaOff
            greenView.alpha = alphaOn
            stage = .green
        case .green:
            greenView.alpha = alphaOff
            redView.alpha = alphaOn
            stage = .red
        }
    }
    
}

