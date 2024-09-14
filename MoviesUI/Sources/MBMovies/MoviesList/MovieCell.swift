import UIKit
import SnapKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.image = UIImage(resource: .avatar)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Title of movie"
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.text = "Release date of movie"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        
        if let posterPath = movie.posterPath {
            let fullImageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            profileImageView.sd_setImage(with: URL(string: fullImageUrl), placeholderImage: UIImage(resource:.avatar))
        } else {
            profileImageView.image = UIImage(resource: .avatar)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.sd_cancelCurrentImageLoad()
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(releaseDateLabel)
            
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16))
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8).priority(.medium)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.top.equalTo(profileImageView.snp.top).offset(4)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
    }
}
