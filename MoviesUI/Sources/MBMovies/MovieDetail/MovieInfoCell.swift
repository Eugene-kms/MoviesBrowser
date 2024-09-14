import UIKit
import SnapKit
import SDWebImage

class MovieInfoCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(resource: .avatar)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let voteAverage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let overview: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieDetail) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        voteAverage.text = String(movie.voteAverage)
        overview.text = movie.overview
        
        if let posterPath = movie.posterPath {
            let fullImageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            profileImageView.sd_setImage(with: URL(string: fullImageUrl), placeholderImage: UIImage(resource: .avatar))
        } else {
            profileImageView.image = UIImage(resource: .avatar)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.sd_cancelCurrentImageLoad()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(voteAverage)
        contentView.addSubview(overview)
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(300)
            make.top.equalToSuperview().offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        voteAverage.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        overview.snp.makeConstraints { make in
            make.top.equalTo(voteAverage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
