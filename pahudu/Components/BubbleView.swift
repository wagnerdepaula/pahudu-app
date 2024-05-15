//
//  BubbleView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/21/24.
//

import SwiftUI
import UIKit


class BubbleView: UIView {
    init(color: UIColor, diameter: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        self.backgroundColor = color
        self.layer.cornerRadius = diameter / 2.0
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class DynamicsView: UIView {
    private var animator: UIDynamicAnimator!
    private var collision: UICollisionBehavior!
    private var displayLink: CADisplayLink?

    // Center of the view, acting as the point of gravity
    private var centerPoint: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        setupDynamics()
        addBubblesDirectly()

        // Start the display link to update bubble positions
        startDisplayLink()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDynamics() {
        animator = UIDynamicAnimator(referenceView: self)
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

    func addBubble(bubble: BubbleView) {
        addSubview(bubble)
        collision.addItem(bubble)
    }

    func addBubblesDirectly() {
        let colors: [UIColor] = [.red, .blue, .green, .yellow]
        let diameters: [CGFloat] = [30, 40, 50, 60]

        for _ in 1...10 {
            let color = colors.randomElement()!
            let diameter = diameters.randomElement()!
            let bubble = BubbleView(color: color, diameter: diameter)
            bubble.center = CGPoint(x: CGFloat.random(in: 0...self.bounds.width),
                                    y: CGFloat.random(in: 0...self.bounds.height))
            addBubble(bubble: bubble)
        }
    }

    private func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink?.add(to: .current, forMode: .common)
    }

    @objc private func step() {
        // Adjust the position of each bubble towards the center
        for bubble in subviews.compactMap({ $0 as? BubbleView }) {
            let direction = CGVector(dx: centerPoint.x - bubble.center.x, dy: centerPoint.y - bubble.center.y)
            let distance = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
            
            guard distance != 0 else { continue }
            
            let normalizedDirection = CGVector(dx: direction.dx / distance, dy: direction.dy / distance)
            bubble.center = CGPoint(x: bubble.center.x + normalizedDirection.dx * 1, y: bubble.center.y + normalizedDirection.dy * 1)
        }
    }

    deinit {
        displayLink?.invalidate()
    }
}





class ContinuousRadialGravityBehavior: UIDynamicBehavior {
    var centerPoint: CGPoint
    var strength: CGFloat // The force strength towards the center
    
    private var items: [UIDynamicItem] = []
    
    init(centerPoint: CGPoint, strength: CGFloat = 0.005) {
        self.centerPoint = centerPoint
        self.strength = strength
        super.init()
    }
    
    func addItem(_ item: UIDynamicItem) {
        items.append(item)
        self.addChildBehavior(UIAttachmentBehavior(item: item, attachedToAnchor: item.center))
    }
    
    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
        super.willMove(to: dynamicAnimator)
        
        // If removing from an animator, stop the timer
        if dynamicAnimator == nil {
            self.action = nil
        } else {
            // Configure a periodic action to update item positions
            self.action = { [weak self] in
                guard let self = self else { return }
                
                for item in self.items {
                    let dx = self.centerPoint.x - item.center.x
                    let dy = self.centerPoint.y - item.center.y
                    let distance = sqrt(dx*dx + dy*dy)
                    
                    if distance == 0 { continue } // Prevent division by zero
                    
                    // Normalize direction
                    let direction = CGVector(dx: dx / distance, dy: dy / distance)
                    
                    // Apply force towards the center
                    item.center = CGPoint(x: item.center.x + direction.dx * self.strength * distance,
                                          y: item.center.y + direction.dy * self.strength * distance)
                    
                    // Required to notify the dynamic animator of changes in the item
                    dynamicAnimator?.updateItem(usingCurrentState: item)
                }
            }
        }
    }
}




// SwiftUI View that integrates a UIKit view with dynamic animations
struct BubblesView: UIViewRepresentable {
    
    var navigateAction: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, navigateAction: navigateAction)
    }
    
    func makeUIView(context: Context) -> UIView {
        return context.coordinator.bubbleContainerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    class Coordinator: NSObject {
        var parent: BubblesView
        var bubbleContainerView: UIView = UIView(frame: UIScreen.main.bounds)
        var animator: UIDynamicAnimator?
        var gravity: UIGravityBehavior = UIGravityBehavior()
        var collision: UICollisionBehavior = UICollisionBehavior()
        var dynamicItemBehavior: UIDynamicItemBehavior = UIDynamicItemBehavior()
        var navigateAction: () -> Void // Declare the closure here
        
        init(_ parent: BubblesView, navigateAction: @escaping () -> Void) {
            self.parent = parent
            self.navigateAction = navigateAction
            super.init()
            setupAnimator()
        }
        
        func setupAnimator() {
            animator = UIDynamicAnimator(referenceView: bubbleContainerView)
            setupBehaviors()
            createBubbles()
        }
        
        func setupBehaviors() {
            collision.translatesReferenceBoundsIntoBoundary = true
            dynamicItemBehavior.elasticity = 0.6
            animator?.addBehavior(gravity)
            animator?.addBehavior(collision)
            animator?.addBehavior(dynamicItemBehavior)
        }
        
        func createBubbles() {
            for _ in 0..<30 {
                let size = CGFloat.random(in: 50...120)
                let bubbleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
                bubbleView.backgroundColor = .accent
                bubbleView.layer.cornerRadius = size / 2
                bubbleContainerView.addSubview(bubbleView)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped))
                bubbleView.addGestureRecognizer(tap)
                
                let pan = UIPanGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
                bubbleView.addGestureRecognizer(pan)
                
                bubbleView.isUserInteractionEnabled = true
                
                gravity.addItem(bubbleView)
                collision.addItem(bubbleView)
                dynamicItemBehavior.addItem(bubbleView)
                
                // Randomly position bubbles
                let randomX = CGFloat.random(in: 0...bubbleContainerView.bounds.width)
                let randomY = CGFloat.random(in: -100...bubbleContainerView.bounds.height - size)
                bubbleView.center = CGPoint(x: randomX, y: randomY)
            }
        }
        
        @objc func bubbleTapped() {
            navigateAction() // Call the closure to navigate
        }
        
        @objc func handleDrag(_ gestureRecognizer: UIPanGestureRecognizer) {
            guard let bubbleView = gestureRecognizer.view else { return }
            
            switch gestureRecognizer.state {
            case .began, .changed:
                let translation = gestureRecognizer.translation(in: bubbleContainerView)
                bubbleView.center = CGPoint(x: bubbleView.center.x + translation.x, y: bubbleView.center.y + translation.y)
                gestureRecognizer.setTranslation(CGPoint.zero, in: bubbleContainerView)
                animator?.updateItem(usingCurrentState: bubbleView)
            default:
                break
            }
        }
    }
}

//ZStack {
//    BubblesView {
//        navigateToYearView = true
//    }
//    .edgesIgnoringSafeArea(.all)
//}
//.navigationTitle("Fashion Calendar")
//.navigationDestination(isPresented: $navigateToYearView) {
//    YearView()
//}
