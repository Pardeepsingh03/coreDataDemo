//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by MBA-0019 on 13/03/23.
//

import UIKit
import CoreData

protocol addcontacts
{
    func addcontactsdata(condata : MyData)
}


class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var UserAddress: UITextField!
    @IBOutlet weak var UserAge: UITextField!
    @IBOutlet weak var UserName: UITextField!
    var addcontactsdelegates : addcontacts?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func SaveData(_ sender: Any) {
        
        _ = profileImageView.image?.jpegData(compressionQuality: 0.75)
        let png = profileImageView.image?.pngData()
        
        
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appdelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "MyData", in: managedContext)!
      let user = MyData(entity: userEntity, insertInto: managedContext)
        user.name = UserName.text
        user.age = UserAge.text
        user.address = UserAddress.text
        user.image = png
        
        print(user)
        do{
            try managedContext.save()
            
            print(user)
            addcontactsdelegates?.addcontactsdata(condata: user)
            navigationController?.popViewController(animated: true)
        }
        catch {
            print("Error in saving data")
        }
        
        
    }
    
    @IBAction func ChooseImage(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        {
            profileImageView.image = image
        }
            
        picker.dismiss(animated: true)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
