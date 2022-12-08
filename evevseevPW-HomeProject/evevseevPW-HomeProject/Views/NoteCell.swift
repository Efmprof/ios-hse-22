import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"

    private var noteTextLabel = UILabel();

    override init(style: CellStyle, reuseIdentifier: String?) {
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

    private func setupView() {
        noteTextLabel.font = .systemFont(ofSize: 16, weight: .regular)
        noteTextLabel.textColor = .label
        noteTextLabel.numberOfLines = 0
        noteTextLabel.backgroundColor = .clear
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(noteTextLabel)
        noteTextLabel.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
    }

    public func configure(_ note: ShortNote) {
        noteTextLabel.text = note.text
    }
}