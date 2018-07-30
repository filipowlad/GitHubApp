//
//  EditProfileTableViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UITableViewController {

    var userInfo: UserInfo!
    var imageSetDelegate: ImageSetter!
    var editableUserData = EditableUserData()
    var credentials = [String: String]()
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        GitHubConnectionManager.setUserInfo(with: token, editableUserData) {
            if let error = $0 {
                print(error.localizedDescription)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = EditProfileSectionType(rawValue: section) else { return 0 }
        switch section {
        case .avatar, .bio:
            return 1
        case .credentials:
            let numberOfRows = userInfo.credentials.count
            return numberOfRows
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = EditProfileSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .avatar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AvatarTableViewCell.reuseIdentifier, for: indexPath) as? AvatarTableViewCell else { return UITableViewCell() }
            cell.configure(with: userInfo.avatarURL!)
            self.imageSetDelegate = cell
            cell.imageSharingDelegate = self
            return cell
        case .credentials:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CredentialsTableViewCell.reuseIdentifier, for: indexPath) as? CredentialsTableViewCell else { return UITableViewCell() }
            cell.credentialsDelegate = self
            cell.configure(with: userInfo.editableData[indexPath.row])
            return cell
        case .bio:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BioTableViewCell.reuseIdentifier, for: indexPath) as? BioTableViewCell else { return UITableViewCell() }
            cell.bioDelegate = self
            cell.configure(with: userInfo.bio)
            return cell
        }
    }
}

extension EditProfileTableViewController: ImageGetter {
    func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
}

extension EditProfileTableViewController: CredentialsData {
    func getCredentials(_ key: String, _ value: String) {
        credentials[key] = value
        print(credentials)
        if credentials.count == 4 {
            self.editableUserData.name = credentials["name"]!
            self.editableUserData.blog = credentials["blog"]!
            self.editableUserData.company = credentials["company"]!
            self.editableUserData.company = credentials["location"]!
        }
    }
}

extension EditProfileTableViewController: BioData {
    func getBio(_ value: String){
        self.editableUserData.bio = value
    }
}

extension EditProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imageSetDelegate.setImage(image)
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        dismiss(animated: true, completion: nil)
    }
}

protocol CredentialsData {
    func getCredentials(_ key: String, _ value: String)
}

protocol BioData {
    func getBio(_ value: String)
}

struct EditableUserData {
    var avatarURL = String()
    var name = String()
    var bio = String()
    var blog = String()
    var company = String()
    var location = String()
}

