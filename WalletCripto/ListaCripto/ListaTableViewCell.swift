//
//  HomeTableViewCell.swift
//  criptoNotes
//
//  Created by kaique souza on 29/11/21.
//

import UIKit
import SnapKit
import Foundation

class ListaTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()

    private lazy var labelValor: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "")
        return imageView
    }()

    public func setNome(_ model: ListaModel.Datum) {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.darkGray

        labelName.text = model.symbol
        labelValor.text = "R$\(formatterCurrency(model.quote?.usd?.price ?? 0.0))"
        applyStyle()
    }

    func formatterCurrency(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:number)) ?? "0.0"
    }
}

extension ListaTableViewCell: ViewCode {
    func setupHierarchy() {
        addSubview(labelName)
        addSubview(labelValor)
    }

    func setupContraints() {
        labelName.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
        }

        labelValor.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
        }
    }

}
