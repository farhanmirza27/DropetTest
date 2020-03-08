//
//  ProfileViewController.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

private let reuseIdentifier = "profileCellId"

enum ProfileRows  {
    case Picture
    case FirstName
    case LastName
    case Phone
    case Email
    case Location
    case Save
}


class ProfileViewController : BaseViewController {
    var  presenter : ViewToPresenterProfileProtocol?
    
    let tableView = UIComponents.shared.tableView()
    let profilePictureView = UIComponents.shared.imageView(name: "defaul")
    let firstNameTF = UIComponents.shared.textField(placeHolder: "First Name")
    let lastNameTF = UIComponents.shared.textField(placeHolder: "Last Name")
    let phoneTF = UIComponents.shared.textField(placeHolder: "Phone", keyboardType: .numberPad)
    let emailTF = UIComponents.shared.textField(placeHolder: "Email")
    let locationTF = UIComponents.shared.textField(placeHolder: "Location")
    let saveBtn = UIComponents.shared.button(text: "Save")
    
    let profile = Profile(firstName: "Farhan", lastName: "Mirza", phone: "7367339991", email: "farhan@farhanmirza.me", location: "cb42qf", profilePicture: "")
    let profileRows : [ProfileRows] = [.Picture,.FirstName,.LastName,.Phone,.Email,.Location,.Save]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showSpinner()
        presenter?.viewDidLoad()
    }
    
    func setupView() {
        self.navigationItem.title = "Profile"
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        saveAreaView.addSubview(tableView)
        saveAreaView.addConstraintsWithFormat("H:|[v0]|", views: tableView)
        saveAreaView.addConstraintsWithFormat("V:|[v0]|", views: tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.hidesBackButton = true
    }
    
    @objc func logout() {
        presenter?.logout()
    }
    
    func populateData(profile : Profile) {
        firstNameTF.text = profile.firstName
        lastNameTF.text  = profile.lastName
        phoneTF.text     = profile.phone
        emailTF.text     = profile.email
        locationTF.text  = profile.location
        if let pictureURL = profile.profilePicture {
            if !pictureURL.isEmpty {
                profilePictureView.image = ImageConverter().convertBase64StringToImage(imageBase64String: pictureURL)
            }
        }
    }
}


extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        switch profileRows[indexPath.row] {
        case .Picture:
            profilePictureView.backgroundColor = .gray
            profilePictureView.layer.cornerRadius = 50
            profilePictureView.clipsToBounds = true
            profilePictureView.contentMode = .scaleAspectFill
            profilePictureView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer()
            tapGesture.addTarget(self, action: #selector(changeProfilePicture))
            profilePictureView.addGestureRecognizer(tapGesture)
            cell.addSubview(profilePictureView)
            cell.addConstraintsWithFormat("H:[v0(100)]", views: profilePictureView)
            cell.addConstraintsWithFormat("V:|-30-[v0(100)]-16-|", views: profilePictureView)
            profilePictureView.centerHorizontally(toView: cell)
        case .FirstName:
            cell.addSubview(firstNameTF)
            cell.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: firstNameTF)
            cell.addConstraintsWithFormat("V:|-16-[v0(40)]-16-|", views: firstNameTF)
        case .LastName:
            cell.addSubview(lastNameTF)
            cell.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: lastNameTF)
            cell.addConstraintsWithFormat("V:|-16-[v0(40)]-16-|", views: lastNameTF)
        case .Phone:
            cell.addSubview(phoneTF)
            cell.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: phoneTF)
            cell.addConstraintsWithFormat("V:|-16-[v0(40)]-16-|", views: phoneTF)
        case .Email:
            cell.addSubview(emailTF)
            cell.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: emailTF)
            cell.addConstraintsWithFormat("V:|-16-[v0(40)]-16-|", views: emailTF)
        case .Location:
            cell.addSubview(locationTF)
            cell.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: locationTF)
            cell.addConstraintsWithFormat("V:|-16-[v0(40)]-16-|", views: locationTF)
        case .Save:
            cell.addSubview(saveBtn)
            saveBtn.addTarget(self, action: #selector(didClickSave), for: .touchUpInside)
            cell.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: saveBtn)
            cell.addConstraintsWithFormat("V:|-30-[v0(40)]-30-|", views: saveBtn)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func validateData() -> Bool {
        let textfields = [firstNameTF,lastNameTF,phoneTF,emailTF,locationTF]
        for field in textfields {
            if let text = field.text {
                if text.isEmpty {
                   return false
                }
            }
        }
        return true
    }
    
    
  @objc func didClickSave() {
    
    guard validateData() else {
        self.alert(message: "Please provide all required fields")
       return
    }
    
    let profile = Profile(firstName: firstNameTF.text!, lastName: lastNameTF.text!, phone: phoneTF.text!, email: emailTF.text!, location: locationTF.text!, profilePicture: ImageConverter().convertImageToBase64String(img: profilePictureView.image!))
    showSpinner()
    presenter?.updateProfile(profile: profile)
    }
    
    @objc func changeProfilePicture() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension ProfileViewController :  PresenterToViewProfileProtocol {
    func updateSucess() {
        removeSpinner()
        self.showToast(message: "Profile Updated")
    }
    
    func displayProfile(profile: Profile) {
        DispatchQueue.main.async { [weak self] in
            self?.populateData(profile: profile)
            self?.removeSpinner()
        }
    }
    
    func error(error : String) {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            self?.alert(message: error)
        }
    }
}



extension ProfileViewController  : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
       
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.profilePictureView.image = image
    }
}
