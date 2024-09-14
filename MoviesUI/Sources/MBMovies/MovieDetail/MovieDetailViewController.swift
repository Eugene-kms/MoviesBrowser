import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    
    private weak var tableView: UITableView!
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureTableView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMovie()
    }
    
    private func fetchMovie() {
        Task {
            do {
                try await viewModel.fetch()
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupNavigationtitle()
        setupTableView()
        configureTableView()
    }
    
    private func setupNavigationtitle() {
        let title = UILabel()
        title.text = "Movie Detail"
        title.font = .boldSystemFont(ofSize: 30)
        title.textColor = .black
        
        self.navigationItem.titleView = title
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        self.tableView = tableView
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MovieInfoCell.self, forCellReuseIdentifier: "MovieInfoCell")
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as? MovieInfoCell else { return UITableViewCell() }
        
        cell.configure(with: viewModel.movieDetail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
