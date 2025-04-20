//
//  ViewController.swift
//  DemoAlamofire
//
//  Created by Siddhesh P on 20/04/25.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
//MARK: - Properties
    private let cellIdentifier = "PokemonCell"
    private let cellName = "PokemonListTVC"
    private let viewModel = PokemonListViewModel()

//MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
 
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        bindViewModel()
        fetchPokemonList()
    }
    

}
// MARK: - Setup
extension HomeVC{
    
    func registerTableView(){
        let cell = UINib(nibName: cellName, bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: cellIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func bindViewModel(){
        viewModel.onDataUpdate = { [weak self] pokemons in
                // Reload tableView or collectionView
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }

            viewModel.onError = { [weak self] error in
                // Show error alert
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: AlertConstants.errorTitle, message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: AlertConstants.okButton, style: .default))
                    self?.present(alert, animated: true)
                }
            }
    }

    func fetchPokemonList(){
        viewModel.fetchPokemonList()
    }
    
}

extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PokemonListTVC else{
            return UITableViewCell()
        }
        let pokemon = viewModel.pokemons[indexPath.row]
        cell.pokemonLbl.text = pokemon.name.capitalized
        return cell
    }
}
