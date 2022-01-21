//
//  SearchBarViewController.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/17.
//

import UIKit

class SearchBarViewController: UIViewController {

    var personData: [MovieData] = []
    
    let defaultHeight: CGFloat = 100
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
        
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.6
//        let tap = UITapGestureRecognizer(target: self, action: #selector(close(_:)))
//        view.addGestureRecognizer(tap)
        return view
    }()
    
    let searchTextField : UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "어떤 영화를 찾으시나요?"
        textfield.borderStyle = .none
//        textfield.borderStyle = .roundedRect
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.clearButtonMode = .always
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textfield.becomeFirstResponder() // textfield 눌렀을때 키보드를 올리는 방법
        return textfield
    }()
    
    let cancelBtn: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(close(_:)), for: .touchDown)
        return button
    }()
    
    let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = 100
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(close(_:)))
        dimmedView.addGestureRecognizer(tap) // 왜 viewDidLoad에서만 되냐? dimmedView안에서는 안뎀..
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
    }
    
    func setupContraints() {
        // 순서 중요!!
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(searchTextField)
        containerView.addSubview(cancelBtn)
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            searchTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: cancelBtn.leadingAnchor),
            
            cancelBtn.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor,constant: 15),
            cancelBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cancelBtn.widthAnchor.constraint(equalToConstant: 50),
            cancelBtn.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
        ])
        
        containerViewBottomConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -100)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0.6
        }
    }
    
    func animateDismissContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = -70
            self.view.layoutIfNeeded()
        }
        
        dimmedView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    @objc private func close(_ sender: Any) {
        animateDismissContainer()
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
//        self.containerViewHeightConstraint?.constant = self.view.bounds.height
        makeData()
        configure()
        addViews()
        autoLayout()
    }
    
    func makeData() {
        for _ in 0...1 {
            personData.append(MovieData.init(
                personImage: UIImage(systemName: "heart.fill")!,
                movieNameLabel: "",
                personAge: 20
            ))
        }
    }
    func configure() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    func addViews() {
        containerView.addSubview(movieTableView)
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }

}

extension SearchBarViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.containerViewHeightConstraint?.constant = 100 * CGFloat(personData.count + 1) //왜 1 더해야하지?
//        print(personData.count)
        return personData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.movieImage.image = personData[indexPath.row].personImage ?? UIImage(named: "default")
        cell.movieNameLabel.text = "table view test"
        cell.personAge.text = String(personData[indexPath.row].personAge)
        return cell
    }
}

extension SearchBarViewController: UITableViewDelegate {

}
