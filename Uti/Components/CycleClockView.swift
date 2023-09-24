//
//  CycleClockView.swift
//  Uti
//
//  Created by lrsv on 23/09/23.
//

import Foundation
import UIKit

class CycleClockView: UIView {
    let iconView: UIView = UIView()
    let hourView: UIView = UIView()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let iconImageView: UIImageView = UIImageView()
    var dayNightState: DayNightState = .night {
        didSet {
            setupIconImageView()
            setupIconViewGradient()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(hourView)
        addSubview(iconView)
        addSubview(iconImageView)
        addSubview(timeLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        self.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        hourView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: self.topAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 64),
            iconView.heightAnchor.constraint(equalToConstant: 36),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            hourView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hourView.topAnchor.constraint(equalTo: iconView.bottomAnchor),
            hourView.widthAnchor.constraint(equalToConstant: 64),
            hourView.heightAnchor.constraint(equalToConstant: 28),
            
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: hourView.centerYAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupIconViewGradient()
        iconView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        
        setupIconImageView()
        iconImageView.contentMode = .center
        iconImageView.tintColor = .white
        
        hourView.layer.backgroundColor = UIColor(red: 0.863, green: 0.545, blue: 0.525, alpha: 0.6).cgColor
        hourView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
    }
    
    private func setupIconImageView() {
        iconImageView.tintColor = .white
        switch dayNightState {
        case .day:
            iconImageView.image = UIImage(systemName: "sun.max.fill")
        case .night:
            iconImageView.image = UIImage(systemName: "moon.stars.fill")
        }
    }
    
    private func setupIconViewGradient() {
        let gradient = CAGradientLayer()
        let gradientColors: [CGColor] = {
            switch dayNightState {
            case .day:
                return [
                    UIColor(red: 0.942, green: 0.649, blue: 0.306, alpha: 1).cgColor,
                    UIColor(red: 0.908, green: 0.503, blue: 0.129, alpha: 1).cgColor
                ]
            case .night:
                return [
                    UIColor(red: 0.141, green: 0.265, blue: 0.583, alpha: 1).cgColor,
                    UIColor(red: 0.261, green: 0.38, blue: 0.688, alpha: 1).cgColor
                ]
            }
        }()
        
        gradient.colors = gradientColors
        gradient.frame = iconView.bounds
        
        let backgroundLayer = CALayer()
        backgroundLayer.frame = iconView.bounds
        backgroundLayer.addSublayer(gradient)
        
        iconView.layer.addSublayer(backgroundLayer)
    }
}

enum DayNightState {
    case day
    case night
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.layoutIfNeeded()
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = bounds

        layer.mask = maskLayer
    }
}
