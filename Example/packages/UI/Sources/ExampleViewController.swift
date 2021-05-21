import UIKit

public final class ExampleViewController: UIViewController {

    private lazy var exampleView: ExampleView = {
        let view = ExampleView()
        view.backgroundColor = .systemRed

        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(exampleView)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        exampleView.frame.size = .init(width: 100, height: 100)
        exampleView.center = view.center
    }
}
