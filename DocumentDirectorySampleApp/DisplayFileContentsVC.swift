
import UIKit

class DisplayFileContentsVC: UIViewController {

	@IBOutlet var textViewDisplayContents: UITextView!

	var contents: NSString?
	var fileName: String!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		if contents != nil {
			textViewDisplayContents.text = contents as! String
		}
	}

	@IBAction func buttonUpdatePressed(sender: UIButton) {
		self.updateFileContents()
		self.navigationController?.popViewControllerAnimated(true)
	}

	func updateFileContents() {

		if let directory = NSSearchPathForDirectoriesInDomains(
			NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
			let path = NSURL(fileURLWithPath: directory).URLByAppendingPathComponent(fileName + ".txt" ?? "")

			let data = textViewDisplayContents.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!

			if NSFileManager.defaultManager().fileExistsAtPath(path.path!) {
				if let fileHandle = try?NSFileHandle(forWritingToURL: path) {
					fileHandle.seekToEndOfFile()
					fileHandle.writeData(data)
					fileHandle.closeFile()
				}
				else {
					print("Can't open fileHandle")
				}
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
