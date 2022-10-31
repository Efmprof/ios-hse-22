import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6

    init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let redControl = ColorSliderView(colorName: "R", value:
        Float(chosenColor.redComponent))
        let greenControl = ColorSliderView(colorName: "G", value:
        Float(chosenColor.greenComponent))
        let blueControl = ColorSliderView(colorName: "B", value:
        Float(chosenColor.blueComponent))

        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = UIColor(named: "LabelBackground")
        stackView.layer.cornerRadius = 12

        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                    for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self)
    }

    @objc
    private func sliderMoved(slider: ColorSliderView) {
        print("it'smoved")
        switch slider.tag {
        case 0:
            chosenColor = UIColor(
                    red: CGFloat(slider.value),
                    green: chosenColor.greenComponent,
                    blue: chosenColor.blueComponent,
                    alpha: chosenColor.alphaComponent
            )
        case 1:
            chosenColor = UIColor(
                    red: chosenColor.redComponent,
                    green: CGFloat(slider.value),
                    blue: chosenColor.blueComponent,
                    alpha: chosenColor.alphaComponent
            )
        default:
            chosenColor = UIColor(
                    red: chosenColor.redComponent,
                    green: chosenColor.greenComponent,
                    blue: CGFloat(slider.value),
                    alpha: chosenColor.alphaComponent
            )
        }
        sendActions(for: .touchDragInside)
    }
}

extension ColorPaletteView {
    private final class ColorSliderView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()

        private(set) var value: Float

        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            slider.value = value
            colorLabel.text = colorName
            setupView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 8
            addSubview(stackView)
            stackView.pin(to: self, [.left: 12, .top: 12, .right: 12, .bottom: 12])
            colorLabel.textColor = .secondaryLabel;
            slider.addTarget(self, action: #selector(sliderMoved), for: .touchDragInside)
        }

        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
