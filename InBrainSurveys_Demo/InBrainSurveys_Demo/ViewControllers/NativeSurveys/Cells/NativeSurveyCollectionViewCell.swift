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
    
    @IBOutlet weak var categoryLabel: EFAutoScrollLabel?
    
    @IBOutlet weak var startButtonContainerView: UIView?
    @IBOutlet weak var startButton: UIButton?
    
    weak var delegate: NativeSurveyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = false
        
        backgroundColor = .clear
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .white
        contentView.setShadow(color: .black, opacity: 0.15, radius: 8)

        startButton?.layer.cornerRadius = cornerRadius
        startButton?.layer.masksToBounds = true
        
        startButtonContainerView?.layer.cornerRadius = cornerRadius
        startButtonContainerView?.setShadow(color: .mainColor, opacity: 0.6,
                                           radius: 6, offset: .init(width: 0, height: 2))
    }
    
    @IBAction func onStartPressed(_ sender: UIButton) {
        delegate?.onStartPressed(at: self)
    }
    
    func set(survey: InBrainNativeSurvey, delegate: NativeSurveyCellDelegate) {
        self.delegate = delegate
        
        setupCategoryLabel(survey.categories)
        rewardLabel?.attributedText = attributedRewardWith(survey.value, divider: survey.multiplier)
        durationLabel?.text = "\(survey.time) min"
        
        for (index, imageView) in rankImageViews.enumerated() {
            let imageName = index <= survey.rank ? "star_filled" : "star_empty"
            imageView.image = UIImage(named: imageName)
        }
    }

}

private extension NativeSurveyCollectionViewCell {
    func setupCategoryLabel(_ categories: [InBrainSurveyCategory]?) {
        guard let categories else {
            categoryLabel?.text = nil
            return
        }
        
        let text = categories.compactMap { $0.title }.joined(separator: ", ")
        categoryLabel?.textAlignment = .center
        categoryLabel?.text = text
        categoryLabel?.font = .systemFont(ofSize: 14)
        categoryLabel?.textColor = .mainColor
    }
    
    func attributedRewardWith(_ reward: Double, divider: Double) -> NSAttributedString {
        let rewardText = String(format: "%.0f points", reward)
        
        guard divider != 1 else { return attributedString(with: rewardText) }

        let oldRewardText = String(format: "%.0f", reward / divider)
        let fullRewardText = String(format: "\(oldRewardText) %.0f points", reward)

        let range = (fullRewardText as NSString).range(of: oldRewardText)
        if range.location != NSNotFound {
            let attrText = attributedString(with: fullRewardText)
            let mutableAttrText = NSMutableAttributedString(attributedString: attrText)
            let color: UIColor = .lightGray

            mutableAttrText.addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                           .strikethroughColor: color, .foregroundColor: color],
                                          range: range)
            return mutableAttrText
        }

        return attributedString(with: rewardText)
    }
    
    func attributedString(with string: String, color: UIColor = .mainColor) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        return NSAttributedString(string: string, attributes: [.font: font, .foregroundColor: color])
    }
}
