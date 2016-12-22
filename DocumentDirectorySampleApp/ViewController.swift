
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet var tableViewObject: UITableView!

	var cellIdentifier: String!
	var textFilesCount: Int!
	var txtFileNames: [String]!
	var contentsOfFile: NSString = ""

	let FILE_EXTENSION = ".txt"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getDocumentDirectoryContents()
		tableViewObject.reloadData()
	}

	/**
	This method is triggered when the user taps on Add button
	The method takes user to next ViewController.

	- parameter sender: UIBarButtonItem
	*/
	@IBAction func buttonAddNewFile(sender: UIBarButtonItem) {
		if let editFileVC = storyboard?.instantiateViewControllerWithIdentifier("EditFileVC") as? EditFileVC {
			self.navigationController?.pushViewController(editFileVC, animated: true)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// Mark: TableView Delegate Methods
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		cellIdentifier = "FileListTableViewCell"
		var fileListTableViewCell = tableViewObject.dequeueReusableCellWithIdentifier(
			cellIdentifier) as? FileListTableViewCell

		if fileListTableViewCell == nil {
			let nib: NSArray = NSBundle.mainBundle().loadNibNamed(
				cellIdentifier, owner: self, options: nil)

			fileListTableViewCell = (nib .objectAtIndex(0) as? FileListTableViewCell)!
		}

		fileListTableViewCell?.labelFileName.text = txtFileNames[indexPath.row]

		return fileListTableViewCell ?? UITableViewCell()
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 90
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return textFilesCount
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if let displayFileContentsVC = storyboard?.instantiateViewControllerWithIdentifier("DisplayFileContentsVC") as? DisplayFileContentsVC {
			displayFileContentsVC.contents = self.readFileContents(indexPath.row)
			displayFileContentsVC.fileName = txtFileNames[indexPath.row]
			
			self.navigationController?.pushViewController(displayFileContentsVC, animated: true)
		}
	}

	/**
	This method reads contents of the file when clicked on the cell in tableView
	*/
	func readFileContents(index: Int) -> NSString {

		if let directory = NSSearchPathForDirectoriesInDomains(
			NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
			let path = NSURL(fileURLWithPath: directory).URLByAppendingPathComponent(txtFileNames[index] + FILE_EXTENSION ?? "")

			//reading
			do {
				contentsOfFile = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding)
				print(contentsOfFile)
			} catch {
				print("unable to read file contents")
			}
		}
		return contentsOfFile
	}

	/**
	This method gets the file names amd count from Document Directory by filtering results
	*/
	func getDocumentDirectoryContents() {
		let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!

		do {
			// Get the directory contents urls (including subfolders urls)
			let directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtURL( documentsUrl, includingPropertiesForKeys: nil, options: [])

			// To filter the directory contents
			let txtFiles = directoryContents.filter{ $0.pathExtension == "txt" }
			txtFileNames = txtFiles.flatMap({$0.URLByDeletingPathExtension?.lastPathComponent})
			textFilesCount = txtFileNames.count

		} catch let error as NSError {
			print(error.localizedDescription)
		}
	}
}
