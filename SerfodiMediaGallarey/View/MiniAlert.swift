//
//  MiniAlert.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 11.09.2024.
//

import UIKit

class MiniAlert: UIView {

    enum State: String {
        case error = "Error"
        case done = "Done"
        case loader = "Download"
    }
    
    init(state: State) {
        super.init(frame: .zero)
        let alertView = MiniAlertView(state: state)
        let view = UIView.blurConfiguration(addView: alertView)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        addSubview(view)
        view.edgesToSuperView()
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showAlert() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.05) {
                self.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 1) {
                self.alpha = 0
            }
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    public func layoutConstraints(in view: UIView) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        return [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
    }
}


class MiniAlertView: UIView {
    
    let label = UILabel(title: "foo", fount: FontAppearance.title, alignment: .center)
    let imageView = UIImageView(image: StaticImage.doneIcon)
    
    private var loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        return loader
    }()
    
    init(state: MiniAlert.State) {
        super.init(frame: .zero)
        configuration()
        set(state: state)
    }
    
    public func set(state: MiniAlert.State) {
        label.text = state.rawValue.localized()
        switch state {
        case .error:
            imageView.image = StaticImage.errorIcon
            loaderView.isHidden = true
        case .done:
            imageView.image = StaticImage.doneIcon
            loaderView.isHidden = true
        case .loader:
            imageView.isHidden = true
            loaderView.startAnimating()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        self.width(150)
        self.aspectRatio(1)
        configurationLayout()
    }
    
    func configurationLayout() {
        addSubview(label)
        addSubview(imageView)
        addSubview(loaderView)
        
        imageView.width(75)
        imageView.aspectRatio(1)
        imageView.centerXToSuperview()
        imageView.topToSuperview(value: 22)
        
        loaderView.width(75)
        loaderView.aspectRatio(1)
        loaderView.centerXToSuperview()
        loaderView.topToSuperview(value: 22)
        
        label.bottomToSuperview(value: 22)
        label.centerXToSuperview()
    }
    
}
