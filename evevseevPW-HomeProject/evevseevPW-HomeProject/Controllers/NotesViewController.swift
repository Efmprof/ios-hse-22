import UIKit

class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // TODO: Make proper error handling
    private var notes = try! UserDefaultsStorage.getNotes()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupView()
    }

    private func setupView() {
        setupNavBar()
        setupTableView()
    }

    private func setupNavBar() {
        self.title = "Notes"

        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }

    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)

        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(tableView)
        tableView.pin(to: self.view)
    }

    private func handleDelete(indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        tableView.reloadData()

        // TODO: Make proper error handling
        try! UserDefaultsStorage.saveNotes(notes)
    }

    @objc
    private func dismissView() {
        self.dismiss(animated: true)
    }
}

extension NotesViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return notes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = notes[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell;
            }
        }
        return UITableViewCell()
    }
}

extension NotesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (indexPath.section == 0) {
            return nil
        }
        let deleteAction = UIContextualAction(
                style: .destructive,
                title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }

        deleteAction.image = UIImage(
                systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)

        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        notes.insert(note, at: 0)
        tableView.reloadData()

        // TODO: Make proper error handling
        try! UserDefaultsStorage.saveNotes(notes)
    }
}
