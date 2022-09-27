//
//  SimulacaoViewScreen.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import UIKit
import SnapKit

protocol SimulacaoViewScreenDelegate {
    func didTapCalcular(_ symbol: String, _ amount: String)
    func showAlert()
}

internal class SimulacaoViewScreen: UIView {

    var delegate: SimulacaoViewScreenDelegate?

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()

    lazy var title: WalletLabel = {
        let label = WalletLabel(color: UIColor.black)
        label.text = "Simlução"
        label.textAlignment = .center
        return label
    }()

    lazy var titleMoeda: WalletLabel = {
        let label = WalletLabel(color: UIColor.black)
        label.text = "Informe a sigla da moeda:"
        return label
    }()

    lazy var titleQuantidade: WalletLabel = {
        let label = WalletLabel(color: UIColor.black)
        label.text = "Informe a quantidade adquirida:"
        return label
    }()

    lazy var txtMoeda: WalletTextField = {
        let text = WalletTextField()
        text.placeholder = "Ex: BTC"
        text.addTarget(self, action: #selector(formatterCurrency), for: .editingChanged)
        return text
    }()

    lazy var titleValor: WalletLabel = {
        let label = WalletLabel(color: UIColor.black)
        label.text = "Informe o Valor investido:"
        return label
    }()

    lazy var txtValor: WalletTextField = {
        let text = WalletTextField()
        text.placeholder = "Valor"
        text.addTarget(self, action: #selector(formatterCurrency), for: .editingChanged)
        return text
    }()

    lazy var txtQuantidade: WalletTextField = {
        let text = WalletTextField()
        text.placeholder = "Ex: 100"
        text.keyboardType = .numberPad
        text.addTarget(self, action: #selector(formatterCurrency), for: .editingChanged)
        return text
    }()

    lazy var botaoCalcular: UIButton = {
        var button = UIButton()
        button.setTitle("Calcular", for: .normal)
        button.tintColor = UIColor.darkGray
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapCalcular), for: .touchUpInside)
        return button
    }()

    lazy var lblResultado: WalletLabel = {
        let label = WalletLabel(color: UIColor.black)
        label.text = "Resultado: R$ 0.0"
        label.textAlignment = .center
        return label
    }()

    func addSubviews(views: [UIView]) {
        views.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }

    @objc func formatterCurrency(textField: UITextField) {
        switch textField {
        case txtValor:
            self.txtValor.text = "R$\(textField.text?.currencyInputFormatting() ?? "")"
        case txtMoeda:
            guard let limitText = textField.text else { return }
            self.txtMoeda.text = String(limitText.prefix(3).uppercased())
        default:
            return
        }
    }

    @objc func didTapCalcular() {
        if verificaPreenchimento() {
            delegate?.didTapCalcular(self.txtMoeda.text ?? "", txtQuantidade.text ?? "0")
        } else {
            delegate?.showAlert()
        }
    }

    private func verificaPreenchimento() -> Bool {
        return (
            txtMoeda.text?.isNotnull() ?? false &&
            txtQuantidade.text?.isNotnull() ?? false &&
            txtValor.text?.isNotnull() ?? false
        )
    }

    private func setValueResult(_ value: Double) {
        if value < 0.0 {
            self.lblResultado.textColor = UIColor.red
        } else {
            self.lblResultado.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        let valueFormated = doubleForformatterCurrency(value)
        self.lblResultado.text = "Resultado: R$ " + valueFormated
        layoutIfNeeded()
    }

    func doubleForformatterCurrency(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt_BR")
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:number)) ?? "0.0"
    }
}

extension SimulacaoViewScreen: CallbackService {
    func setValue(_ result: SimulacaoModel.Datum) {
        guard let valor = txtValor.text else { return }
        let valorAtual = result.data.quote.brl.price
        let valorAntigo = Double(
                            valor.replacingOccurrences(of: "R$", with: "")
                            .replacingOccurrences(of: ".", with: "")
                            .replacingOccurrences(of: ",", with: "")
                          ) ?? 0.0

        let resultado = valorAtual - valorAntigo

        setValueResult(resultado)
    }


}

extension SimulacaoViewScreen: ViewCode {
    func setupHierarchy() {
        addSubviews(views: [title, titleMoeda, txtMoeda, titleValor, txtValor,
                            titleQuantidade, txtQuantidade, botaoCalcular, lblResultado])
        addSubview(stackView)
    }

    func setupContraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview()
        }

        title.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        titleMoeda.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        titleValor.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        txtValor.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }

        titleQuantidade.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        txtMoeda.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }

        txtQuantidade.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }

        botaoCalcular.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        lblResultado.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
}
