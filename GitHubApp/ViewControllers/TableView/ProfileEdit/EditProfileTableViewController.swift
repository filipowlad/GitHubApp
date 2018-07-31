//
//  EditProfileTableViewController.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UITableViewController, Refresh {

    var userInfo: UserInfo!
    var token: String!
    var imageSetDelegate: ImageSetter!
    var image: UIImage?
    
    var editableUserData = EditableUserData()
    var credentials = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func refresh() {
        refreshTableWithBackgroundSpinner(in: self, with: token) { response in
            guard let response = response else { return }
            self.userInfo = response
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.displaySpinner()
        GitHubConnectionManager.setUserInfo(with: token, editableUserData) { response in
            self.removeSpinner()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = EditProfileSectionType(rawValue: section) else { return 0 }
        if let _ = userInfo {
            switch section {
            case .avatar, .bio:
                return 1
            case .credentials:
                return 4
            }
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = EditProfileSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .avatar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AvatarTableViewCell.reuseIdentifier, for: indexPath) as? AvatarTableViewCell else { return UITableViewCell() }
            if let image = image {
                cell.configure(with: image)
            } else {
                cell.configure(with: userInfo.avatarURL!)
            }
            self.imageSetDelegate = cell
            cell.imageSharingDelegate = self
            return cell
        case .credentials:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EditCredentialTableViewCell.reuseIdentifier, for: indexPath) as? EditCredentialTableViewCell else { return UITableViewCell() }
            cell.credentialsDelegate = self
            cell.configure(with: userInfo.editable[indexPath.row])
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
        self.displaySpinner()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.purple
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.purple]
        
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
        if credentials.count == 4 {
            self.editableUserData.name = credentials["Name:"]!
            self.editableUserData.blog = credentials["Blog:"]!
            self.editableUserData.company = credentials["Company:"]!
            self.editableUserData.location = credentials["Location:"]!
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
        
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.image = image
        self.removeSpinner()
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        self.removeSpinner()
        dismiss(animated: true, completion: nil)
    }
}

