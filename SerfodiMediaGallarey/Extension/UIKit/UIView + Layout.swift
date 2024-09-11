//
//  UIView + Layout.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 11.09.2024.
//

import UIKit


// MARK: Layout

extension UIView {
        
    func edgesToSuperView(value: CGFloat = 0) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: value),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -value),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: value),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -value)
        ])
    }
    
    func topToSuperview(value: CGFloat = 0, usingSafeArea: Bool = false) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = usingSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        self.topAnchor.constraint(equalTo: constraint , constant: value).isActive = true
    }
    
    func leadingToSuperview(value: CGFloat = 0, usingSafeArea: Bool = false) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = usingSafeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
        self.leadingAnchor.constraint(equalTo: constraint, constant: value).isActive = true
    }
    
    func trailingToSuperview(value: CGFloat = 0, usingSafeArea: Bool = false) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = usingSafeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
        self.trailingAnchor.constraint(equalTo: constraint, constant: -value).isActive = true
    }
    
    func bottomToSuperview(value: CGFloat = 0, usingSafeArea: Bool = false) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = usingSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor
        self.bottomAnchor.constraint(equalTo: constraint, constant: -value).isActive = true
    }
    
    func leadingToTrailing(of view: UIView, value: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: value).isActive = true
    }
    
    func trailingToLeading(of view: UIView, value: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -value).isActive = true
    }
    
    func centerYToSuperview() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerXToSuperview() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func width(_ width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func height(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func aspectRatio(_ ratio: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
    }
    
}
