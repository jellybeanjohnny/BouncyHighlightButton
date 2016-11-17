//
//  BouncyHighlightButton.swift
//  DoorDashLite
//
//  Created by Matt Amerige on 11/15/16.
//  Copyright © 2016 Matt Amerige. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class BouncyHighlightButton: UIButton {

  @IBInspectable var layerCornerRadius: CGFloat = 0 {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var layerBorderWidth: CGFloat = 1 {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var bodyFillColor: UIColor = UIColor.black {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var bodyUnfilledColor: UIColor = UIColor.white {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var layerBorderColor: UIColor = UIColor.black {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var titleTextOn: String? {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var titleTextOff: String? {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var titleTextColorOn: UIColor = UIColor.white {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var titleTextColorOff: UIColor = UIColor.black {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var isOn: Bool = false {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var titleImageOn: UIImage? {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var titleImageOff: UIImage? {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var backgroundImageOn: UIImage? {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var backgroundImageOff: UIImage? {
    didSet {
      updateAppearanceProperties()
    }
  }
  
  @IBInspectable var compressionWidth: CGFloat = 0.85
  @IBInspectable var compressionHeight: CGFloat = 0.90
  @IBInspectable var compressionBounce: CGFloat = 0.0
  @IBInspectable var compressionSpeed: CGFloat = 20.0
  
  @IBInspectable var expansionBounce: CGFloat = 20.0
  @IBInspectable var expansionSpeed: CGFloat = 20.0
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    updateAppearanceProperties()
    setupTouchEvents()
  
  }
  
  
  
  
  func updateAppearanceProperties() {
    
    backgroundColor = isOn ? bodyFillColor : bodyUnfilledColor
    
    layer.cornerRadius = layerCornerRadius
    layer.borderWidth = layerBorderWidth
    
    layer.borderColor = layerBorderColor.cgColor
    
    setTitle(isOn ? titleTextOn : titleTextOff, for: .normal)
  
    setTitleColor(isOn ? titleTextColorOn : titleTextColorOff , for: .normal)
    
    setImage(isOn ? titleImageOn : titleImageOff, for: .normal)
    
    setBackgroundImage(isOn ? backgroundImageOn : backgroundImageOff, for: .normal)
    
  }
  
  func toggleButton() {
    isOn = !isOn
    updateAppearanceProperties()
  }
  
}

//MARK: - Animations
extension BouncyHighlightButton {
  func setupTouchEvents() {
    addTarget(self, action: #selector(touchDownHandler), for: .touchDown)
    addTarget(self, action: #selector(touchUpInsideHandler), for: .touchUpInside)
    addTarget(self, action: #selector(draggedOnExitHandler), for: .touchDragExit)

  }
  
  // Touching down on the button shrinks it
  func touchDownHandler() {
    animate(toSize: CGSize(width: compressionWidth, height: compressionHeight), withBounce: compressionBounce, speed: compressionSpeed)
  }
  
  // Releasing springs the button back to it's original size
  func touchUpInsideHandler() {
    toggleButton()
    animate(toSize: CGSize(width: 1.0, height: 1.0), withBounce: expansionBounce, speed: expansionSpeed)
  }
  
  // Dragging outside of the button should have it spring back to regular state
  func draggedOnExitHandler() {
    animate(toSize: CGSize(width: 1.0, height: 1.0), withBounce: expansionBounce, speed: expansionSpeed)
  }
  
  
  func animate(toSize size: CGSize, withBounce bounce: CGFloat, speed: CGFloat) {
    if let animation = self.pop_animation(forKey: "AnimateButton") as? POPSpringAnimation {
      animation.toValue = size
      animation.springBounciness = bounce
      animation.springSpeed = speed
    } else {
      let animation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
      animation?.toValue = size
      animation?.springBounciness = bounce
      animation?.springSpeed = speed
      layer.pop_add(animation, forKey: "AnimateButton")
    }
    
  }

}
