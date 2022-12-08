import UIKit

class NewsListViewController: UIViewController {
    // TODO: implement loading state
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var newsList: [ArticleViewModel] = []
    private var isLoading = false

    override func viewDidLoad() {
        setupView()
        getNews()
    }

    private func getNews() {
        isLoading = true
        NewsApiCom().getTopHeadlines { [weak self] result in
            switch result {
            case .success(let articles):
                self?.newsList = articles
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func refreshNews() {
        getNews()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        setupTableView()
        setupNavbar()
        setupTableViewDelegate()
        setupTableViewCell()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120

        view.addSubview(tableView)
        tableView.pin(to: view, [.left: 0, .right: 0, .bottom: 0])
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }

    private func setupNavbar() {
        navigationItem.title = "News"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.left"),
                style: .plain,
                target: self,
                action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "arrow.triangle.2.circlepath"),
                style: .plain,
                target: self,
                action: #selector(refreshNews))

        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    private func setupTableViewCell() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }

    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isLoading) {
            return 0
        } else {
            return newsList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (isLoading) {

        } else {
            let news = newsList[indexPath.row]
            if let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell {
                newsCell.configure(news)
                return newsCell
            }
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (!isLoading) {
            let newsVC = NewsViewController();
            newsVC.configure(newsList[indexPath.row])
            navigationController?.pushViewController(newsVC, animated: true)
        }
    }
}
