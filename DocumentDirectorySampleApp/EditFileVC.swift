
import UIKit

class EditFileVC: UIViewController {

	@IBOutlet var textViewEnteredText: UITextView!
	@IBOutlet var textFieldEnteredFileName: UITextField!

	var fileModel = FileModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func buttonSaveFileContents(sender: UIButton) {

		if textViewEnteredText.text.isEmpty {
			let alert = UIAlertController(title: "Alert", message: "Please enter some text",
			                              preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		} else {
			self.createFileAndSave()
			self.navigationController?.popViewControllerAnimated(true)
		}
	}

	func createFileAndSave() {
		fileModel.fileName = textFieldEnteredFileName.text
		let text = textViewEnteredText.text
		if let directory = NSSearchPathForDirectoriesInDomains(
			NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
			let path = NSURL(fileURLWithPath: directory).URLByAppendingPathComponent(fileModel.fileName)

			//writing
			do {
				try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
			} catch {
				print("unable to write")
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
