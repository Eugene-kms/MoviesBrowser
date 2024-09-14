import UIKit
import SnapKit

enum MoviesStrings: String {
    case moviesSection = "MOVIES"
}

public final class MoviesViewController: UIViewController {
    
    public var viewModel: MoviesViewModel!
    
    private lazy var searchController: UISearchController = {
        UISearchController(searchResultsController: nil)
    }()
    
    private var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            await viewModel.loadMovies()
            Task { @MainActor in
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
    }
}

extension MoviesViewController {
    private func setupUI() {
        setupNavigationtitle()
        setupSearchController()
        setupTableView()
    }
    
    private func setupNavigationtitle() {
        let title = UILabel()
        title.text = "Movies"
        title.font = .boldSystemFont(ofSize: 30)
        title.textColor = .black
        
        self.navigationItem.titleView = title
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .gray
        
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.tableView = tableView
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        viewModel.search(with: searchText)
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTitles.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = viewModel.sectionTitles[section]
        return viewModel.movies[key]?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else { return UITableViewCell() }
        
        let key = viewModel.sectionTitles[indexPath.section]
        let movie = viewModel.movies[key]![indexPath.row]
        
        cell.configure(with: movie)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = viewModel.sectionTitles[indexPath.section]
        let movie = viewModel.movies[key]![indexPath.row]
        
        viewModel.didSelectMovie(movie)
    }
}
