import UIKit

class NewsCell: UITableViewCell {
    static let reuseIdentifier = "NewsCell"

    private let newsImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func configure(_ news: ArticleViewModel) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description

        // TODO: get rid of redundant code here and in NewsController
        if let data = news.imageData {
            DispatchQueue.main.async { [weak self] in
                self?.newsImageView.image = UIImage(data: data)
            }
        } else if let url = news.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                        guard let data = data else {
                            return
                        }
                        news.imageData = data
                        DispatchQueue.main.async {
                            self?.newsImageView.image = UIImage(data: data)
                        }
                    }
                    .resume()
        }
    }

    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupImageView() {
        newsImageView.image = UIImage(named: "landscape")
        newsImageView.backgroundColor = .secondarySystemBackground

        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.cornerCurve = .continuous
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill

        contentView.addSubview(newsImageView)
        newsImageView.pin(to: contentView, [.top: 12, .left: 16, .bottom: 12])
        newsImageView.pinWidth(to: newsImageView.heightAnchor)
    }

    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1

        contentView.addSubview(titleLabel)
        titleLabel.setHeight(titleLabel.font.lineHeight)

        titleLabel.pinLeft(to: newsImageView.trailingAnchor, 12)
        titleLabel.pinRight(to: contentView, 12)
        titleLabel.pinTop(to: contentView, 12)
    }

    private func setupDescriptionLabel() {
        // TODO: pin text to top edge of view
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0

        contentView.addSubview(descriptionLabel)
        descriptionLabel.pinLeft(to: newsImageView.trailingAnchor, 12)
        descriptionLabel.pinRight(to: contentView, 12)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 12)

        descriptionLabel.pinBottom(to: contentView, 12)
    }
}
