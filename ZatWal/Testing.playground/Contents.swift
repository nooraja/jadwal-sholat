import UIKit
import PlaygroundSupport

class VCMain: UIViewController {

	lazy var label: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.text = "Makan"
		lbl.clipsToBounds = true
		return lbl
	}()

	let c = Clock()

	var timer: Timer?

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.addSubview(label)
		label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

		timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
	}

	@objc func updateLabel() {
		let formatter = DateFormatter()
		formatter.timeStyle = .long
		label.text = formatter.string(from: c.currentTime())
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		updateLabel()
	}

}

class Clock {
	func currentTime() -> Date {
		return Date()
	}
}

let vw = VCMain()
vw.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
let nav = UINavigationController(rootViewController: vw)

PlaygroundPage.current.liveView = nav





