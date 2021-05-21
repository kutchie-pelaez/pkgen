import UIKit
import Core

final class ExampleView: UIView {

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = String.someExtension
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: 16,
            weight: .bold
        )

        return label
    }()

    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 32
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMaxYCorner
        ]

        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        label.frame.size.width = bounds.size.width / 2
        label.sizeToFit()
        label.center = .init(
            x: bounds.width / 2,
            y: bounds.height / 2
        )
    }
}
