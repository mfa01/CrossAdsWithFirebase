//
//  CrossAdsInterstitialViewController.swift
//  CrossPromotionWithFirebase
//
//  Created by Mabed on 17/07/2022.
//

import UIKit

public class CrossAdsInterstitialViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var presentation: Presentation?

    public static func showAd(adModel: CrossAdModel?, placeholderImage: UIImage?, inVC: UIViewController) {
        let bundle = Bundle(for: CrossAdsInterstitialViewController.self)
        let vc = CrossAdsInterstitialViewController.init(nibName: "CrossAdsInterstitialViewController", bundle: bundle)
        vc.presentation = Presentation(adModel: adModel, placeholderImage: placeholderImage)
        vc.modalPresentationStyle = .fullScreen
        inVC.present(vc, animated: true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setCloseButton()
    }
    
    func setCloseButton() {
        closeButton.layer.cornerRadius = closeButton.frame.size.width/2
        closeButton.layer.borderColor = UIColor.black.cgColor
        closeButton.layer.borderWidth = 1
        closeButton.isHidden = true
        let duration = presentation?.adModel?.allowDismissAfter ?? 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.closeButton.isHidden = false
        }
    }

    func updateUI() {
        
        guard let presentation = presentation, let model = presentation.adModel else {
            return
        }
        setBannerImage()
        setMainImage()
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
        actionButton.setTitle(model.actionButtonTitle, for: .normal)
        actionButton.layer.cornerRadius = 5
        actionButton.superview?.superview?.layer.cornerRadius = 5
    }
    
    func setBannerImage() {
        if let imagePath = presentation?.adModel?.image {
            if let url = URL(string: imagePath) {
                bannerImageView.kf.setImage(with: url, placeholder: presentation?.placeholderImage)
            }
        } else {
            bannerImageView.image = presentation?.placeholderImage
        }
        bannerImageView.layer.cornerRadius = 10

    }
    func setMainImage() {
        if let imagePath = presentation?.adModel?.mainImage {
            if let url = URL(string: imagePath) {
                mainImageView.kf.setImage(with: url, placeholder: presentation?.placeholderImage)
            }
        } else {
            mainImageView.image = presentation?.placeholderImage
        }
    }
    
    @IBAction func closeTapped() {
//        CrossAdsLogger.shared.d
        self.dismiss(animated: true)
    }
}
