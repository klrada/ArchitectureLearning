//
//  ViewController.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var accountTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.placeholder = "Print account name"
        return $0
    }(UITextField())
    
    lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.placeholder = "Print password"
        return $0
    }(UITextField())
    
    lazy var saveButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Save data", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.addTarget(self, action: #selector(saveAccount), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var seePasswordButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("See current password for account", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.titleLabel?.numberOfLines = 0
        $0.titleLabel?.textAlignment = .center
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.addTarget(self, action: #selector(seeAccountsPassword), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var passwordLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .red
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 21, weight: .semibold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var password = ""
    private var account = ""
    private var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Save your password"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(accountTextField)
        view.addSubview(passwordTextField)
        view.addSubview(saveButton)
        view.addSubview(seePasswordButton)
        view.addSubview(passwordLabel)
        
        createConstraints()
        
    }
    
    @objc func saveAccount() {
        let password = passwordTextField.text ?? ""
        let account = accountTextField.text ?? ""
        do {
            status = try KeychainManager.save(password: password.data(using: .utf8) ?? Data(), account: account)
            passwordLabel.text = status
        } catch {
            print(error)
            passwordLabel.text = "Error saving password"
        }
    }
    
    @objc func seeAccountsPassword() {
        let account 
        do {
            let data = try KeychainManager.getPassword(for: account)
            status = String(decoding: data ?? Data(), as: UTF8.self)
            passwordLabel.text = status
        } catch {
            print(error)
            passwordLabel.text = "Don't have account \(account)"
        }
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            accountTextField.heightAnchor.constraint(equalToConstant: 40),
            accountTextField.widthAnchor.constraint(equalToConstant: 300),
            accountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            accountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            //saveButton.heightAnchor.constraint(equalToConstant: 75),
            //saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            //seePasswordButton.heightAnchor.constraint(equalToConstant: 75),
            //seePasswordButton.widthAnchor.constraint(equalToConstant: 150),
            seePasswordButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 25),
            seePasswordButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            
            passwordLabel.heightAnchor.constraint(equalToConstant: 60),
            passwordLabel.widthAnchor.constraint(equalToConstant: 200),
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.topAnchor.constraint(equalTo: seePasswordButton.bottomAnchor, constant: 10)
        ])
    }
    
}

