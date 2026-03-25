import UIKit

class OnboardingViewController: UIViewController {
    private var onboardingVC: OnboardingPageViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Onboarding data
        let items = [
            OnboardingItem(subtitle: "View Top 100 Coins",
                           description: "Explore top 100 cryptos based on performance \n and price. Easily find the most popular coins you want to track.",
                           imageName: "Slider II"),
            OnboardingItem(subtitle: "Coin Performance Chart",
                           description: "View the performance of your selected coin over time with our \n interactive chart. Adjust the time filter for different period from 1hr",
                           imageName: "Slider I"),
            OnboardingItem(subtitle: "Track Your Favorites",
                           description: "Easily access all your favorite coins and tap on any coin to view \n detailed information in one place",
                           imageName: "Slider III")
        ]
        onboardingVC = OnboardingPageViewController(title: "Welcome to CryptoRank", items: items)
        addChild(onboardingVC)
        view.addSubview(onboardingVC.view)
        onboardingVC.didMove(toParent: self)
        onboardingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let skipButton = UIBarButtonItem(title: "Skip",
                                         style: .plain,
                                         target: self,
                                         action: #selector(skipTapped))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]
        skipButton.setTitleTextAttributes(attributes, for: .normal)
        skipButton.setTitleTextAttributes(attributes, for: .highlighted)
        navigationItem.rightBarButtonItem = skipButton
    }
    @objc private func skipTapped() {
        let registerVC = RegisterViewController()
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
