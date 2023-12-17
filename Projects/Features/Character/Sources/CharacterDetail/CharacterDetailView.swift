//
//  RMCharacterDetailView.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/12.
//

import UIKit

import CharacterInterface
import Core
import SnapKit

final class CharacterDetailView: RMBaseView {
  private(set) lazy var backButton = UIBarButtonItem(
    image: UIImage(systemName: "chevron.backward"),
    style: .plain,
    target: nil,
    action: nil
  )
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private(set) lazy var locationButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .darkGray
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    button.layer.borderWidth = 3
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.cornerRadius = 8

    return button
  }()

  lazy var episodeCollectionView: UICollectionView = {
    let layout: UICollectionViewFlowLayout = .createGridLayout(ratio: 0.8)
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    return collectionView
  }()

  override func makeUI() {
    self.addSubViews(imageView, locationButton, episodeCollectionView)

    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
      $0.height.equalTo(imageView.snp.width)
    }
    locationButton.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(imageView)
      $0.height.equalTo(50)
    }

    episodeCollectionView.setContentHuggingPriority(.defaultLow, for: .vertical)
    episodeCollectionView.snp.makeConstraints {
      $0.top.equalTo(locationButton.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(safeAreaLayoutGuide)
    }
  }

  func bind(item: RMCharacter) {
    self.locationButton.setTitle(item.location.name, for: .normal)
    self.imageView.setImage(url: item.image)
  }
}
