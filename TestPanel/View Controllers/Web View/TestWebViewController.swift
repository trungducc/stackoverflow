import UIKit
import WebKit

class TestWebViewController: UIViewController, UIScrollViewDelegate, PanelAnimationControllerDelegate {
	@IBOutlet weak private var testWebView:WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        testWebView.scrollView.delegate = self

		let htmlContent = """
			<html>
				<head>
					<meta name="viewport" content="width=device-width, initial-scale=1">
					<style>
						body {
							padding: 1em;
						}
						p {
							font-size: 16pt;
						}
					</style>
				</head>
				<body>
					<h4>Testing</h4>
					<p>Nam vel aspernatur quibusdam ea mollitia quia asperiores delectus. Tempore eos consequatur quas nam sed. Et commodi nobis et laboriosam porro magnam aut nulla. Nulla id exercitationem qui voluptatem. Occaecati illo voluptatem ad qui ut. Voluptatibus maxime qui consequatur atque iste totam.</p>
					<p>Quia maiores eos maiores. Alias quia quis nesciunt ratione praesentium consequatur reprehenderit voluptatibus. Architecto doloremque vero voluptatem quam accusantium sit.</p>
					<p>Porro eum quo quia accusantium aut sequi odit tempora. Omnis corrupti magni quia dolore laboriosam. Unde aspernatur aut sed animi atque atque.</p>
					<p>Aut dolorem fugiat voluptas optio fugit delectus. Quaerat corporis atque quasi rem rem. Aliquid dolor minima et laboriosam at dolorem.</p>
					<h4>Testing</h4>
					<p>Vel deserunt ducimus velit et voluptate possimus. Voluptate quidem quia eius facere qui expedita. Placeat rem eum qui aperiam dolorum ut delectus aut. Vel et aut quasi quisquam optio totam.</p>
					<p>Nam vel aspernatur quibusdam ea mollitia quia asperiores delectus. Tempore eos consequatur quas nam sed. Et commodi nobis et laboriosam porro magnam aut nulla. Nulla id exercitationem qui voluptatem. Occaecati illo voluptatem ad qui ut. Voluptatibus maxime qui consequatur atque iste totam.</p>
					<p>Quia maiores eos maiores. Alias quia quis nesciunt ratione praesentium consequatur reprehenderit voluptatibus. Architecto doloremque vero voluptatem quam accusantium sit.</p>
					<p>Porro eum quo quia accusantium aut sequi odit tempora. Omnis corrupti magni quia dolore laboriosam. Unde aspernatur aut sed animi atque atque.</p>
					<h4>Testing</h4>
					<p>Aut dolorem fugiat voluptas optio fugit delectus. Quaerat corporis atque quasi rem rem. Aliquid dolor minima et laboriosam at dolorem.</p>
					<p>Vel deserunt ducimus velit et voluptate possimus. Voluptate quidem quia eius facere qui expedita. Placeat rem eum qui aperiam dolorum ut delectus aut. Vel et aut quasi quisquam optio totam.</p>
					<p>Nam vel aspernatur quibusdam ea mollitia quia asperiores delectus. Tempore eos consequatur quas nam sed. Et commodi nobis et laboriosam porro magnam aut nulla. Nulla id exercitationem qui voluptatem. Occaecati illo voluptatem ad qui ut. Voluptatibus maxime qui consequatur atque iste totam.</p>
					<p>Quia maiores eos maiores. Alias quia quis nesciunt ratione praesentium consequatur reprehenderit voluptatibus. Architecto doloremque vero voluptatem quam accusantium sit.</p>
					<h4>Testing</h4>
					<p>Porro eum quo quia accusantium aut sequi odit tempora. Omnis corrupti magni quia dolore laboriosam. Unde aspernatur aut sed animi atque atque.</p>
					<p>Aut dolorem fugiat voluptas optio fugit delectus. Quaerat corporis atque quasi rem rem. Aliquid dolor minima et laboriosam at dolorem.</p>
					<p>Vel deserunt ducimus velit et voluptate possimus. Voluptate quidem quia eius facere qui expedita. Placeat rem eum qui aperiam dolorum ut delectus aut. Vel et aut quasi quisquam optio totam.</p>
				</body>
			</html>
		"""

		self.testWebView.loadHTMLString(htmlContent, baseURL: nil)
	}

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    testWebView.scrollView.bounces = (testWebView.scrollView.contentOffset.y > 10)
  }

  func shouldHandlePanelInteractionGesture() -> Bool {
    return (testWebView.scrollView.contentOffset.y == 0)
  }
}
