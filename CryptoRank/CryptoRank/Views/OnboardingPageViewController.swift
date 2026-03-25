import UIKit

struct OnboardingItem {
    let subtitle: String
    let description: String
    let imageName: String
}

class OnboardingPageViewController: UIViewController,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    private let titleText: String
    private let items: [OnboardingItem]
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView
    private var autoScrollTimer: Timer?
    init(title: String, items: [OnboardingItem]) {
        self.titleText = title
        self.items = items
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Title
        titleLabel.text = titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        // CollectionView
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        // Layout
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let topSpace = titleLabel.frame.maxY + 20
            let height = view.bounds.height - topSpace
            layout.itemSize = CGSize(width: view.bounds.width, height: height)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAutoScroll()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        autoScrollTimer?.invalidate()
    }
    // MARK: - Auto Scroll
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let currentIndex = Int(self.collectionView.contentOffset.x / self.collectionView.frame.width)
            let nextIndex = currentIndex + 1
            if nextIndex < self.items.count {
                self.autoScroll(to: nextIndex)
            } else {
                self.autoScrollTimer?.invalidate() // stop at last page
            }
        }
    }
    func autoScroll(to index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "OnboardingCell",
            for: indexPath
        ) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        cell.configure(with: item, index: indexPath.item, totalPages: items.count)
        cell.onNextTapped = { [weak self] in
                guard let self = self else { return }
                if indexPath.item == self.items.count - 1 {
                    // Last page push Register screen
                    let registerVC = RegisterViewController()
                    self.navigationController?.pushViewController(registerVC, animated: true)
                } else {
                    // Otherwisescroll to next page
                    self.autoScroll(to: indexPath.item + 1)
                }
            }

        return cell
    }
}

// MARK: - Custom Cell
class OnboardingCell: UICollectionViewCell {
    var onNextTapped: (() -> Void)?
    private let imageView = UIImageView()
    private let subtitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let pageControl = UIPageControl()
    private let nextButton = UIButton(type: .system)
    private let stackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Configure elements
        imageView.contentMode = .scaleAspectFit
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .systemCyan
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.backgroundColor = .systemCyan
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        // StackView
        stackView.axis = .vertical
        stackView.alignment = .fill   // full width
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Add arranged subviews
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        contentView.addSubview(stackView)
        // Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc private func nextButtonTapped() {
         onNextTapped?()
        }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    func configure(with item: OnboardingItem, index: Int, totalPages: Int) {
        imageView.image = UIImage(named: item.imageName)
        subtitleLabel.text = item.subtitle
        descriptionLabel.text = item.description
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = index
        if index == totalPages - 1 {
            nextButton.setTitle("Get Started", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
}
