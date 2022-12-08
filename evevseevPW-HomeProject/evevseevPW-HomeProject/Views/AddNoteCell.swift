import UIKit

protocol AddNoteDelegate {
    func newNoteAdded(note: ShortNote)
}

class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"

    private let textView = UITextView()
    private let stackView = UIStackView()
    private let addButton = UIButton()

    public var delegate: AddNoteDelegate? = nil

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setupTextView()
        setupAddButton()
        setupStackView()
    }

    private func setupTextView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .label
        textView.backgroundColor = .clear
        textView.setHeight(140)
    }

    private func setupAddButton() {
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)

        addButton.addTarget(self, action: #selector(addButtonTapped(_:)),
                for: .touchUpInside)
        addButton.isEnabled = true
        addButton.alpha = 0.8
    }

    private func setupStackView() {
        for view in [textView, addButton] {
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
    }

    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let inputText: String! = textView.text
        if (inputText != "") {
            delegate?.newNoteAdded(note: ShortNote(text: inputText))
            textView.text = ""
        }
    }
}
