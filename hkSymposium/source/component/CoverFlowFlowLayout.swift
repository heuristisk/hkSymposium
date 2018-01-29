//
//  CoverFlowFlowLayout.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 28/01/2018.
//  Copyright © 2018 Anderson Santos Gusmão. All rights reserved.
//

import UIKit

class CoverFlowFlowLayout: UICollectionViewFlowLayout {

    let activeDistance: CGFloat = 100.0
    let translateDistance: CGFloat = 100.0
    let zoomFactor: CGFloat = 0.2
    let flowOffset: CGFloat = 40.0
    let inactiveGreyValue: CGFloat = 0.6

    override class var layoutAttributesClass: AnyClass {
        return CollectionViewLayoutAttributes.self
    }

    override init() {
        super.init()
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: 180, height: 180)
        self.minimumLineSpacing = -60      // Gets items up close to one another
        self.minimumInteritemSpacing = 200; // Makes sure we only have 1 row of items in portrait mode
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: 180, height: 180)
        self.minimumLineSpacing = -60      // Gets items up close to one another
        self.minimumInteritemSpacing = 200
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard self.collectionView != nil else {
            return nil
        }

        let layoutAttributesArray = super.layoutAttributesForElements(in: rect)
        let visibleRect = CGRect(x: self.collectionView?.contentOffset.x ?? 0,
                                 y: self.collectionView?.contentOffset.y ?? 0,
                                 width: self.collectionView?.bounds.width ?? 0,
                                 height: self.collectionView?.bounds.height ?? 0)

        for attributes in layoutAttributesArray! {
            if attributes.frame.intersects(rect) {
                self.applyLayoutAttributes(attributes: attributes, visibleRect: visibleRect)
            }
        }

        return layoutAttributesArray
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {

        guard self.collectionView != nil else {
            return UICollectionViewLayoutAttributes()
        }

        let attributes: UICollectionViewLayoutAttributes =
            super.layoutAttributesForItem(at: indexPath) ?? UICollectionViewLayoutAttributes()

        let visibleRect = CGRect(x: self.collectionView?.contentOffset.x ?? 0,
                                 y: self.collectionView?.contentOffset.y ?? 0,
                                 width: self.collectionView?.bounds.width ?? 0,
                                 height: self.collectionView?.bounds.height ?? 0)

        self.applyLayoutAttributes(attributes: attributes, visibleRect: visibleRect)

        return attributes
    }

    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard self.collectionView != nil else {
            return CGPoint()
        }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter: CGFloat = (proposedContentOffset.x + 70) + (self.collectionView?.bounds.width ?? 0 / 2.0)

        let proposedRect: CGRect = CGRect(x: proposedContentOffset.x,
                                          y: 0.0,
                                          width: self.collectionView?.bounds.size.width ?? 0,
                                          height: self.collectionView?.bounds.size.height ?? 0)

        if let array = layoutAttributesForElements(in: proposedRect) {

            for layoutAttributes in array {

                if  layoutAttributes.representedElementCategory != UICollectionElementCategory.cell {
                    continue
                }

                let itemHorizontalCenter: CGFloat = layoutAttributes.center.x
                if fabsf(Float(itemHorizontalCenter - horizontalCenter)) < fabsf(Float(offsetAdjustment)) {
                    offsetAdjustment = itemHorizontalCenter - horizontalCenter
                }
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    private func applyLayoutAttributes(attributes: UICollectionViewLayoutAttributes,
                                       visibleRect: CGRect) {

        guard attributes.representedElementKind == nil else {
            return
        }

        let distanceFromVisibleRectToItem: CGFloat = visibleRect.midX - attributes.center.x
        let  normalizedDistance = distanceFromVisibleRectToItem / activeDistance
        let isLeft: Bool = distanceFromVisibleRectToItem > 0
        var transform: CATransform3D = CATransform3DIdentity

        var maskAlpha: CGFloat = 0.0

        if fabsf(Float(distanceFromVisibleRectToItem)) < Float(activeDistance) {
            let x = (isLeft ? (flowOffset * -1) : flowOffset) * abs(distanceFromVisibleRectToItem/translateDistance)
            let z = (CGFloat(1 - fabsf(Float(normalizedDistance)) * 40000 + (isLeft ? 200 : 0)))

            transform = CATransform3DTranslate(CATransform3DIdentity, x, 0, z)
            transform.m34 = -1/(4.6777 * self.itemSize.width)
            let zoom: CGFloat = 1 + zoomFactor * (1 - abs(normalizedDistance))

            transform = CATransform3DRotate(transform,
                                            CGFloat((isLeft ? 1 : -1) *
                                                fabsf(Float(normalizedDistance)) * 45 *
                                                Float(Double.pi / 180)),
                                            0,
                                            1,
                                            0)

            transform = CATransform3DScale(transform, zoom, zoom, 1)
            attributes.zIndex = 1
            let ratioToCenter: CGFloat = (activeDistance - CGFloat(fabsf(Float(distanceFromVisibleRectToItem))))
                / activeDistance
            maskAlpha = inactiveGreyValue + ratioToCenter * (-inactiveGreyValue)

        } else {
            transform.m34 = -1/(4.6777 * self.itemSize.width)
            transform = CATransform3DTranslate(transform, isLeft ? (flowOffset * -1) : flowOffset, 0, 0)
            transform = CATransform3DRotate(transform, CGFloat((isLeft ? 1 : -1) * 45 * Double.pi / 180), 0, 1, 0)
            attributes.zIndex = 0
            maskAlpha = inactiveGreyValue
        }

        attributes.transform3D = transform

        if let attr = attributes as? CollectionViewLayoutAttributes {
            attr.shouldRasterize = true
            attr.maskingValue = maskAlpha
        }
    }
}
