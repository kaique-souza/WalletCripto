//
//  HomeViewScreen.swift
//  criptoNotes
//
//  Created by kaique souza on 25/11/21.
//

import Foundation
import UIKit
import SnapKit

class ListaViewScreen: UIView {
    
    init() {
        super.init(frame: .zero)
        self.setupLayout()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var title: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.text = "Lista de criptos"
        label.textColor = UIColor.yellow
        return label
    }()
    
    public lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor.darkGray
        return tableView
    }()
    
}

extension ListaViewScreen {
    func setupLayout() {
        self.backgroundColor = UIColor.darkGray
        addSubview(title)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(600)
        }
    }
}



