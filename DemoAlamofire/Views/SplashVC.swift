//
//  SplashVC.swift
//  DemoAlamofire
//
//  Created by Siddhesh P on 20/04/25.
//

import UIKit

class SplashVC: UIViewController {

    private let gradientLayer = CAGradientLayer()
    private var gradientSet = [[CGColor]]()
    private var currentGradient = 0
    let gradientView = AnimatedGradientView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gradientView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gradientView.heightAnchor.constraint(equalTo: view.heightAnchor),
            gradientView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
//        animateGradient()
//        transitionToHomeAfterDelay()
    }

    private func setupGradient() {
        // Custom colors
        let color1 = [
            UIColor(red: 200/255, green: 80/255, blue: 72/255, alpha: 1).cgColor,
            UIColor(red: 168/255, green: 32/255, blue: 40/255, alpha: 1).cgColor
        ]

        let color2 = [
            UIColor(red: 168/255, green: 32/255, blue: 40/255, alpha: 1).cgColor,
            UIColor(red: 200/255, green: 80/255, blue: 72/255, alpha: 1).cgColor
        ]


        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.addSublayer(gradientLayer)
    }

    private func animateGradient() {
        currentGradient = (currentGradient + 1) % gradientSet.count
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = 2.5
        animation.toValue = gradientSet[currentGradient]
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradientLayer.add(animation, forKey: "colorChange")
    }

    private func transitionToHomeAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            let homeVC = HomeVC() // Replace with your app's main screen
            homeVC.modalTransitionStyle = .crossDissolve
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true)
        }
    }
}

extension SplashVC: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradientLayer.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}


import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        guard hexSanitized.count == 6,
              let rgbValue = UInt64(hexSanitized, radix: 16) else {
            return nil
        }

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class AnimatedGradientView: UIView {

    private let gradientLayer = CAGradientLayer()
    private var colorSets: [[CGColor]] = []
    private var currentColorIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        startAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
        startAnimating()
    }

    private func setupGradientLayer() {
        // Define color sets
        colorSets = [
            [UIColor(hex: "#70b8f0")!.cgColor, UIColor(hex: "#a82028")!.cgColor],
            [UIColor(hex: "#a82028")!.cgColor, UIColor(hex: "#70b8f0")!.cgColor],
            [UIColor(hex: "#70b8f0")!.cgColor, UIColor(hex: "#a82028")!.cgColor],
            [UIColor(hex: "#70b8f0")!.cgColor, UIColor(hex: "#a82028")!.cgColor],
            [UIColor(hex: "#a82028")!.cgColor, UIColor(hex: "#70b8f0")!.cgColor]

//            [UIColor(hex: "#70b8f0")!.cgColor, UIColor(hex: "#f0f0f8")!.cgColor],
//            [UIColor(hex: "#a8b8c8")!.cgColor, UIColor(hex: "#c85048")!.cgColor],
        ]

        // Initial colors
        gradientLayer.colors = colorSets[currentColorIndex]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func startAnimating() {
        animateToNextColor()
    }

    private func animateToNextColor() {
        let nextColorIndex = (currentColorIndex + 1) % colorSets.count
        let nextColors = colorSets[nextColorIndex]

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = nextColors
        animation.duration = 4
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.delegate = self

        gradientLayer.add(animation, forKey: "colorChange")
//        gradientLayer.colors = nextColors // For continuity
//        currentColorIndex = nextColorIndex
    }
}

extension AnimatedGradientView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animateToNextColor()
        }
    }
}

