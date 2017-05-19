//
//  ViewController.swift
//  FileManagement
//
//  Created by Cntt04 on 5/19/17.
//  Copyright © 2017 Cntt04. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnCreateFile: UIButton!
    var filePath: NSString?
    var fileManager: FileManager?
    var documentDir: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileManager = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        print("path : \(String(describing: documentDir))")        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCreateFileAct(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        filePath=documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
    }
    func showSuccessAlert(titleAlert:String, messageAlert: String)
    {
        let alert:UIAlertController = UIAlertController(title:titleAlert, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
    //Tao thu muc
    @IBAction func btnCreateDirectoryAct(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/folder1") as NSString?
        do {
            try fileManager?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    //
    @IBAction func btnWriteFileAct(_ sender: Any) {
        let content: NSString = NSString(string: "Noi dunng file: HOW ARE YOU ?")
        let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
        try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("file1.txt")), options: [.atomic])
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
    }
    //Ham doc file file1.txt trong thu muc new
    @IBAction func btnReadFileAct(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/file1.txt") as NSString?
        var fileContent: Data?
        fileContent = fileManager?.contents(atPath: filePath! as String)
        do{
            
            let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
            
            self.showSuccessAlert(titleAlert: "Success", messageAlert: ("data : \(str)" as NSString) as String)
            
        }
        //catch {
        //self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
        // }
    }
    //Move file tu thu muc nguon den thu muc dich
    @IBAction func btnMoveFileAct(_ sender: Any) {
        let oldFilePath:String = documentDir!.appendingPathComponent("file1.txt")
        let newFilePath: String = documentDir!.appendingPathComponent("file1.txt") as String
        do {
            try fileManager?.moveItem(atPath: oldFilePath, toPath: newFilePath)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
    }
    //
    @IBAction func btnCopyFileAct(_ sender: Any) {
        let originalFile=documentDir?.appendingPathComponent("file1.txt")
        let copyFile=documentDir?.appendingPathComponent("copy.txt")
        try? fileManager?.copyItem(atPath: originalFile!, toPath: copyFile!)
        print(documentDir!)
        self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copy Thanh cong!")
        
    }
    //
    @IBAction func btnFilePermissionsAct(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("temp.txt") as NSString?
        var filePermissions:NSString = ""
        
        if(fileManager?.isWritableFile(atPath: filePath! as String))!
        {
            filePermissions=filePermissions.appending("file is writable. ") as NSString
        }
        if(fileManager?.isReadableFile(atPath: filePath! as String))!
        {
            filePermissions=filePermissions.appending("file is readable. ") as NSString
        }
        if(fileManager?.isExecutableFile(atPath: filePath! as String))!
        {
            filePermissions=filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert:"Success", messageAlert: "\(filePermissions)")
        //filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
    }
    //
    @IBAction func btnEqualityTestAct(_ sender: Any) {
        let filePath1=documentDir?.appendingPathComponent("temp.txt")
        let filePath2=documentDir?.appendingPathComponent("copy.txt")
        if(fileManager? .contentsEqual(atPath: filePath1!, andPath: filePath2!))!
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }
    }
    //
    @IBAction func btnDirectoryConstantAct(_ sender: Any) {
        
        do {
            let arrDirContent = try fileManager!.contentsOfDirectory(atPath: filePath! as String)
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)")
        }
        catch _ as NSError {
            
        }
        
    }
    //
    @IBAction func btnRemoveFileAct(_ sender: Any) {
        
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        try?fileManager?.removeItem(atPath: filePath! as String)
        self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")
        
    }
    //
}

