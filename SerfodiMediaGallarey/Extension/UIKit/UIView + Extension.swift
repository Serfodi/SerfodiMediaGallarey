//
//  UIView + Extension.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 11.09.2024.
//

import UIKit

// MARK: init

extension UIView {
    
    convenience init(addView: UIView, value: CGFloat = 0, color: UIColor? = nil) {
        self.init(frame: .zero)
        self.backgroundColor = color
        addSubview(addView)
        addView.edgesToSuperView(value: value)
    }
 
}

// MARK: Design

extension UIView {
    
    func addShadow(color: UIColor, path: UIBezierPath? = nil, offset: CGSize = .zero, opacity: CFloat = 1, radius: CGFloat = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        if let path = path {
            layer.shadowPath = path.cgPath
        } else {
            layer.shadowOffset = offset
        }
    }
    
    static func blurConfiguration(addView view: UIView, effect: UIBlurEffect = .init(style: .systemThinMaterial), height: CGFloat? = nil, padding: CGFloat = 0) -> UIView {
        let vibrancyEffect = UIVisualEffectView(effect: effect)
        vibrancyEffect.clipsToBounds = true
        if let height = height {
            vibrancyEffect.layer.cornerRadius = height / 2 + padding
        }
        let vibrancyEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect:  effect))
        vibrancyEffect.contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.contentView.addSubview(view)
        view.edgesToSuperView(value: padding)
        vibrancyEffectView.frame = vibrancyEffect.bounds
        vibrancyEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return vibrancyEffect
    }
    
}
