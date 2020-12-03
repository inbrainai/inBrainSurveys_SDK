//
//  NativeSurveysViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Sergey Blazhko on 02.10.2020.
//  Copyright © 2020 InBrain. All rights reserved.
//

import UIKit

import InBrainSurveys_SDK_Swift

class NativeSurveysViewController: UIViewController, LoadableView {
    
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var collectionView: UICollectionView?

    private let inBrain: InBrain = InBrain.shared
    private var surveys: [InBrainNativeSurvey] = [] {
        didSet { collectionView?.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Native Surveys"
        navigationController?.navigationBar.tintColor = .white
        
        let image = UIColor(hex: "92D050").image()
        navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        headerView?.setShadow(color: .black, opacity: 0.1, radius: 8,
                              offset: .init(width: -2, height: 6))

        //No reason to make some extension to simplify
        //Cell usage. Just 1 place with cells...
        let id = "NativeSurveyCollectionViewCell"
        let nib = UINib(nibName: id, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: id)
        collectionView?.alpha = 0
        
        inBrain.nativeSurveysDelegate = self
        inBrain.getNativeSurveys()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension NativeSurveysViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NativeSurveyCollectionViewCell",
                                                            for: indexPath) as! NativeSurveyCollectionViewCell
        
        let survey = surveys[indexPath.row]
        cell.set(survey: survey, delegate: self)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension NativeSurveysViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 36) / 2
        return .init(width: cellWidth, height: 149)
    }
}

//MARK: - NativeSurveyDelegate
extension NativeSurveysViewController: NativeSurveyDelegate {
    func nativeSurveysLoadingStarted() {
        startActivity()
        surveys.removeAll()
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView?.alpha = 0
        }
    }
        
    func nativeSurveysReceived(_ surveys: [InBrainNativeSurvey]) {
        self.surveys = surveys

        defer { stopActivity() }
        
        let newAlpha: CGFloat
        
        if surveys.isEmpty {
            newAlpha = 0
            MessagePresenter.shared.show(message: "Ooops.. No surveys available right now!", type: .error)
        } else {
            newAlpha = 1
        }
        
        if collectionView?.alpha == newAlpha { return }
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView?.alpha = newAlpha
        }
    }
    
    func failedToReceiveNativeSurveys(error: Error) {
        MessagePresenter.shared.show(message: "Ooops.. Something went wrog", type: .error)
        print("Failded to receive rewards: \(error.localizedDescription)")
        
        stopActivity()
    }
}

extension NativeSurveysViewController: NativeSurveyCellDelegate {
    func onStartPressed(at cell: NativeSurveyCollectionViewCell) {
        guard let ip = collectionView?.indexPath(for: cell) else { return }
        
        let survey = surveys[ip.row]
        inBrain.showNativeSurveyWith(id: survey.id, from: self)
    }
}

private extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
