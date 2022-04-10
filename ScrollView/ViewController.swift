//
//  ViewController.swift
//  ScrollView
//
//  Created by Gurjap on 2022-04-07.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:  vars
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 2)
    
    // scroll view
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemCyan
        scrollView.frame = view.bounds
        scrollView.bounces = true
        scrollView.autoresizingMask = .flexibleWidth
        scrollView.contentSize = contentViewSize
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // content view or container views
    lazy var containerView : UIView = {
        let containerView = UIView()
        containerView.frame.size = contentViewSize
        return containerView
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginLogo")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.text = "Sign in and have fun..."
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.textColor = .darkGray
        textField.clearButtonMode = .always
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        //  textField.setLeftPaddingPoints(20)
        return textField
    }()
    
    lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password.."
        textField.textColor = .darkGray
        textField.clearButtonMode = .always
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        // textField.setLeftPaddingPoints(20)
        
        return textField
    }()
    
    lazy var signInButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .systemPink
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 30
        return button
    }()
    
    //MARK:  View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add subviews
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(containerView)
    
        //add subviews to container view
        containerView.addSubview(imageView)
        containerView.addSubview(label)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(signInButton)
        
        // disable autoresizing mask
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
         //MARK:  Text field delegates
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
         //MARK:  Hide keyboard when view is tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tapGesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        
         //MARK:   handle keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            print("Keyboard size is \(keyboardSize)")
            let edgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = edgeInsets
        }
    }
    
    @objc func keyboardDidHide(_ notification : NSNotification) {
        
    }
     
        // dismiss the keyboard
    @objc func dismissKeyboard(_ recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        //setupconstraints
        setupConstraints()
    }
    
    //MARK:  Setup
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //image view
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo:containerView.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            //label constriants
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            
            // email text field
            emailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            emailTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            
            //MARK:  password text field constriants
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            passwordTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            
             //MARK:  Sign in constraint
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            signInButton.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 40),
            signInButton.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}


