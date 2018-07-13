import UIKit

class TestTableViewController: UIViewController, UIScrollViewDelegate, PanelAnimationControllerDelegate {
	@IBOutlet weak private var testTableView:UITableView!
	private var tableItems:[String]						= ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10", "Item 11", "Item 12", "Item 13", "Item 14", "Item 15", "Item 16", "Item 17", "Item 18", "Item 19", "Item 20", "Item 21", "Item 22", "Item 23", "Item 24", "Item 25", "Item 26", "Item 27", "Item 28", "Item 29", "Item 30"]

    override func viewDidLoad() {
        super.viewDidLoad()
      testTableView.delegate = self
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      testTableView.bounces = (testTableView.contentOffset.y > 10)
    }

    func shouldHandlePanelInteractionGesture() -> Bool {
      return (testTableView.contentOffset.y == 0)
    }
}

extension TestTableViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tableItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = self.tableItems[indexPath.row]

		let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
		cell.textLabel?.text	= item

		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
