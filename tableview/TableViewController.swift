//
//  ViewController.swift
//  tableview
//
//  Created by Kelvin Fok on 30/1/23.
//

import UIKit

enum Style {
  case quote
  case advert
}

protocol LayoutType {
  var id: String { get }
  var style: Style { get }
}

protocol QuoteLayoutType: LayoutType {
  var authorName: String { get }
  var quote: String { get }
}

protocol AdvertLayoutType: LayoutType {
  var bgImage: String { get }
}

class QuoteLayout: QuoteLayoutType {
  let authorName: String
  let quote: String
  let id: String
  let style: Style
  
  init(authorName: String, quote: String, id: String, style: Style) {
    self.authorName = authorName
    self.quote = quote
    self.id = id
    self.style = style
  }
}

class AdvertLayout: AdvertLayoutType {
  let bgImage: String
  let id: String
  let style: Style
  
  init(bgImage: String, id: String, style: Style) {
    self.bgImage = bgImage
    self.id = id
    self.style = style
  }
}

struct Feed {
  let layouts: [LayoutType]

  static let `default`: Self = .init(
    layouts: [
      QuoteLayout(
        authorName: "Barney Stinson",
        quote: "When I'm sad, I stop being sad and be awesome instead. True story.",
        id: UUID().uuidString,
        style: .quote),
      AdvertLayout(
        bgImage: "https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F421385179%2F862949525083%2F1%2Foriginal.20230110-032305?w=940&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C100%2C3200%2C1600&s=77e97194773bf104064c84200234aebb",
        id: UUID().uuidString,
        style: .advert),
      QuoteLayout(
        authorName: "Kelvin Fok",
        quote: "Live to fight another day. Put a stop loss!",
        id: UUID().uuidString,
        style: .quote),
      QuoteLayout(
        authorName: "Kelvin Fok",
        quote: "Martingale trading strategy is a death spiral.",
        id: UUID().uuidString,
        style: .quote),
      QuoteLayout(
        authorName: "Kelvin Fok",
        quote: "Sell put options to make a side income.",
        id: UUID().uuidString,
        style: .quote),
    ])
}

class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

  private let feed: Feed

  init(feed: Feed) {
    self.feed = feed
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feed.layouts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let layout = feed.layouts[indexPath.item]
    switch layout.style {
    case .quote:
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! QuoteCell
      if let layout = layout as? QuoteLayout {
        cell.configure(layout: layout)
      }
      return cell
    case .advert:
      let cell = tableView.dequeueReusableCell(withIdentifier: "adCellId", for: indexPath) as! AdvertCell
      if let layout = layout as? AdvertLayoutType {
        cell.configure(imageURL: layout.bgImage)
      }
      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let layout = feed.layouts[indexPath.item]
    switch layout.style {
    case .quote:
      return 56
    case .advert:
      return 201
    }
  }
}

class TableViewController: UITableViewController {
  
  private let feed: Feed = .default
  
  private lazy var myDataSource: DataSource = {
    let dataSource = DataSource(feed: feed)
    return dataSource
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(QuoteCell.self, forCellReuseIdentifier: "cellId")
    tableView.register(AdvertCell.self, forCellReuseIdentifier: "adCellId")
    tableView.dataSource = myDataSource
  }
  
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return feed.layouts.count
//  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let layout = feed.layouts[indexPath.item]
//    switch layout.style {
//    case .quote:
//      let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! QuoteCell
//      if let layout = layout as? QuoteLayout {
//        cell.configure(layout: layout)
//      }
//      return cell
//    case .advert:
//      let cell = tableView.dequeueReusableCell(withIdentifier: "adCellId", for: indexPath) as! AdvertCell
//      if let layout = layout as? AdvertLayoutType {
//        cell.configure(imageURL: layout.bgImage)
//      }
//      return cell
//    }
//  }
//
//  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    let layout = feed.layouts[indexPath.item]
//    switch layout.style {
//    case .quote:
//      return UITableView.automaticDimension
//    case .advert:
//      return 200
//    }
//  }
}

class QuoteCell: UITableViewCell {
  
  private let quoteLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.numberOfLines = 2
    return label
  }()
  
  private let authorNameLabel: UILabel = {
    let label = UILabel()
    label.font = .italicSystemFont(ofSize: 12)
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      quoteLabel,
      authorNameLabel
    ])
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layout() {
    contentView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
    ])
  }
  
  func configure(layout: QuoteLayout) {
    quoteLabel.text = layout.quote
    authorNameLabel.text = layout.authorName
  }
}

class AdvertCell: UITableViewCell {
  
  private let adImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layout() {
    contentView.addSubview(adImageView)
    adImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      adImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      adImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      adImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      adImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  func configure(imageURL: String) {
    adImageView.load(url: URL(string: imageURL)!)
  }

}

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
