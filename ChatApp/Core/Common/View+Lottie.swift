//
//  View+Lottie.swift
//  ChatApp
//
//  Created by Angel Aguilar on 11/10/20.
//

import Lottie
import UIKit

extension View where Self: UIViewController {
    
    static func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes 
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
    
    func showLoader() {
        DispatchQueue.main.async (flags: .barrier) {
            
            if let keyWindowView = Self.getKeyWindow(),
                !self.isShowingLoader() {
                    let loaderView = LoaderUIView()
                    keyWindowView.addSubview(loaderView)
                    loaderView.frame.origin = CGPoint.zero
                    loaderView.frame.size = self.view.frame.size
                    loaderView.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
                    loaderView.playLottie()
                }
        }
    }

    func hideLoader() {
        DispatchQueue.main.async (flags: .barrier) {
            if let keyWindowView = Self.getKeyWindow(),
                let loaderView = keyWindowView.subviews.first(where: { (view) -> Bool in view is LoaderUIView }) {
                loaderView.removeFromSuperview()
            }
        }
    }

    func isShowingLoader() -> Bool {
        if let keyWindowView = Self.getKeyWindow(),
            keyWindowView.subviews.first(where: { (view) -> Bool in view is LoaderUIView }) != nil {
            return true
        }
        return false
    }
}

