//
//  NativeSurveyCollectionViewCell.swift
//  InBrainSurveys_Demo
//
//  Created by Sergey Blazhko on 02.10.2020.
//  Copyright © 2020 InBrain. All rights reserved.
//

import UIKit

import InBrainSurveys

private let cornerRadius: CGFloat = 13

protocol NativeSurveyCellDelegate: AnyObject {
    func onStartPressed(at cell: NativeSurveyCollectionViewCell)
}

class NativeSurveyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rewardLabel: UILabel?
    
    @IBOutlet var rankImageViews: [UIImageView]!
    
    @IBOutlet weak var durationLabel: UILabel?
    
    @IBOutlet weak var startButtonContainerView: UIView?
    @IBOutlet weak var startButton: UIButton?
    
    weak var delegate: NativeSurveyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = false
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .white
        contentView.setShadow(color: .black, opacity: 0.15, radius: 8)
        
        let btnColor = UIColor(hex: "00a5ed")
        
        startButton?.layer.cornerRadius = cornerRadius
        startButton?.layer.masksToBounds = true
        
        startButtonContainerView?.layer.cornerRadius = cornerRadius
        startButtonContainerView?.setShadow(color: btnColor, opacity: 0.6,
                                           radius: 6, offset: .init(width: 0, height: 2))
    }
    
    @IBAction func onStartPressed(_ sender: UIButton) {
        delegate?.onStartPressed(at: self)
    }
    
    func set(survey: InBrainNativeSurvey, delegate: NativeSurveyCellDelegate) {
        self.delegate = delegate
        
        rewardLabel?.text = String(format: "%.0f points", survey.value)
        durationLabel?.text = "\(survey.time) min"
        
        for (index, imageView) in rankImageViews.enumerated() {
            let imageName = index <= survey.rank ? "star_filled" : "star_empty"
            imageView.image = UIImage(named: imageName)
        }
    }

}
