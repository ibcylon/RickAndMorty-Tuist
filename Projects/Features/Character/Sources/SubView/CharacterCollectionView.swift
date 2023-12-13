//
//  CharacterCollectionView.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/10.
//

import UIKit

import SnapKit

final class CharacterListView: UIView {

  let progressView: UIActivityIndicatorView = {
    let progressView = UIActivityIndicatorView(style: .large)
    progressView.hidesWhenStopped = true
    return progressView
  }()

  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    layout.footerReferenceSize = .init(width: UIScreen.main.bounds.width, height: 100)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isHidden = true
    collectionView.alpha = 0
    collectionView.register(cellType: RMCharacterCollectionViewCell.self)
    collectionView.register(type: RMFooterLoadingCollectionReusableView.self)
    collectionView.backgroundColor = .white
    return collectionView
  }()

  init() {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupView() {
    addSubViews(collectionView, progressView)

    progressView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(100)
    }

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    setUpCollectionView()
  }

  private func setUpCollectionView() {
    collectionView.delegate = self
  }
}

extension CharacterListView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (UIScreen.main.bounds.width - 30) / 2
    let height = width * 1.5

    return CGSize(
      width: width,
      height: height
    )
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let totalContentHeight = scrollView.contentSize.height
    let totalScrollViewFixedHeight = scrollView.frame.size.height

    if offset >= (totalContentHeight - totalScrollViewFixedHeight) {
      print("need fetching data")
    }
  }
}

