//
//  LoaderView.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import Foundation
import Lottie

class LoaderUIView: UIView {
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.alpha = 0.9
        return blurEffectView
    }()

    private let loaderView: AnimationView = {
        let animationView = AnimationView(name: "loader")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        return animationView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setAutolayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(blurEffectView)
        addSubview(loaderView)
    }

    func setAutolayout() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            loaderView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
        ])
    }

    func playLottie() {
        loaderView.play()
    }
}
