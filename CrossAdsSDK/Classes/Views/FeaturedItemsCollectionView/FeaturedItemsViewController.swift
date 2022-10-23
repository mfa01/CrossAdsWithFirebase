//
//  FeaturedItemsViewController.swift
//  CrossAdsSDK
//
//  Created by Mabed on 22/09/2022.
//

import UIKit

public class FeaturedItemsViewController: UIViewController {

    public static func instantiate(presentation: ViewData) -> FeaturedItemsViewController {
        let vc = FeaturedItemsViewController(nibName: "FeaturedItemsViewController", bundle: Bundle.getBundleForClass(cl: FeaturedItemsViewController.self))
        vc.presentation = presentation
        return vc
    }
    
    public struct ViewData {
        let leading: CGFloat
        let trailing: CGFloat
        let top: CGFloat
        let bottom: CGFloat
        let hidePager: Bool
        let pagerTintColor: UIColor
        let pagerCurrentPageColor: UIColor
        let ads:[CrossAdModel]
        let duration: CGFloat
        
        public init(leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0, hidePager: Bool = false, pagerTintColor: UIColor = .white, pagerCurrentPageColor: UIColor = .darkGray, ads: [CrossAdModel], duration: CGFloat = 0) {
            self.leading = leading
            self.trailing = trailing
            self.top = top
            self.bottom = bottom
            self.ads = ads
            self.pagerTintColor = pagerTintColor
            self.pagerCurrentPageColor = pagerCurrentPageColor
            self.duration = duration
            self.hidePager = hidePager
        }
    }
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!

    var presentation: ViewData?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCrossAdsCells()

        updateUI()
        if let duration = presentation?.duration, duration != 0 {
            startTimer(duration: duration)
        }
    }
    
    func updateUI() {
        collectionView.reloadData()
        guard let presentation = presentation else { return }
        pager.isHidden = presentation.hidePager
        pager.numberOfPages = presentation.ads.count
        pager.tintColor = presentation.pagerTintColor
        pager.currentPageIndicatorTintColor = presentation.pagerCurrentPageColor
        leadingConstraint.constant = presentation.leading
        trailingConstraint.constant = presentation.trailing
        topConstraint.constant = presentation.top
        bottomConstraint.constant = presentation.bottom
    }
    
    var clockCounter = 0
    func startTimer(duration: CGFloat) {
        clockCounter += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if (self.clockCounter+Int(duration)+1)%Int(duration) == 0, self.viewIfLoaded?.window != nil {
                var page = self.pager.currentPage + 1
                if page >= self.pager.numberOfPages {
                    page = 0
                }
                self.collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
            }
            self.startTimer(duration: duration)
        }
    }
}


extension FeaturedItemsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presentation = presentation else { return UICollectionViewCell() }
        let cell = collectionView.dequeueBannerCell(crossAd: presentation.ads[indexPath.row], placeholderImage: nil, indexPath: indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presentation?.ads.count ?? 0
    }
}

extension FeaturedItemsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

extension FeaturedItemsViewController: UICollectionViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        if let ip = collectionView.indexPathForItem(at: center) {
            pager.currentPage = ip.row
        }
        clockCounter = 0
    }
}
