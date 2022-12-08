import UIKit

class NewsViewController: UIViewController {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func configure(_ news: ArticleViewModel) {
        // TODO: see News Cell
        titleLabel.text = news.title
        descriptionLabel.text = news.description

        if let data = news.imageData {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        } else if let url = news.imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                        guard let data = data else {
                            return
                        }
                        news.imageData = data
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                    .resume()
        }
    }

    @objc
    func goBack() {
        // TODO: implement
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        setupNavbar()
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupNavbar() {
        // TODO: implement
    }

    private func setupImageView() {
        imageView.image = UIImage()
        // imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        view.addSubview(imageView)

        imageView.pin(to: view, [.left: 0, .right: 0])
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        imageView.pinHeight(to: imageView.widthAnchor)
    }

    private func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label

        view.addSubview(titleLabel)
        titleLabel.pinTop(to: imageView.bottomAnchor, 12)
        titleLabel.pin(to: view, [.left: 16, .right: 16])
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel

        view.addSubview(descriptionLabel)
        descriptionLabel.pin(to: view, [.left: 16, .right: 16])
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 8)
    }
}
