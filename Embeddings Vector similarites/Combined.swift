// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsConfiguration.swift ---
//
//  DiscoverCardsConfiguration.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import Foundation

extension DiscoverCardsJourney {
    public struct Configuration {
        
        public init() {}

        /// Configuration of strings used on the `DiscoverCards` screen
        var strings = Strings()

        /// Configuration of design used on the `DiscoverCards` screen
        var design = Design()

        /// Configuration of image used on the `DiscoverCards` screen
        var images = Images()

        public enum DismissCardType {
            case goToLoyaltyDashboard
            case goToTransferMenu
            case goToPersonalFinanceManagementDashboard
        }

        public static func getNavigationFrom(deeplinkString: String) -> DismissCardType? {
            if deeplinkString.isEqual("snbdvneo://loyalty/dashboard") {
                return DismissCardType.goToLoyaltyDashboard
            } else if deeplinkString.isEqual("snbdvneo://transfers/hub") {
                return DismissCardType.goToTransferMenu
            } else if deeplinkString.isEqual("snbdvneo://pfm/dashboard") {
                return DismissCardType.goToPersonalFinanceManagementDashboard
            }
            return nil
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsRouter.swift ---
//
//  DiscoverCardsRouter.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension DiscoverCardsJourney {
    public struct Router {

        private(set) weak var navigationController: UINavigationController?
        private let closeAction: ((DiscoverCardsJourney.Configuration.DismissCardType) -> Void)?

        init(navigationController: UINavigationController,
             closeAction: ((DiscoverCardsJourney.Configuration.DismissCardType) -> Void)?
        ) {
            self.navigationController = navigationController
            self.closeAction = closeAction
        }

        func dismiss() {
            navigationController?.dismiss(animated: true)
        }

        func didTapOnButton(redirectionType: DiscoverCardsJourney.Configuration.DismissCardType?) {
            if let thisType = redirectionType {
                closeAction?(thisType)
            }
        }

        func showGenericError(from viewController: UIViewController,
                              for option: GenericErrorScreen.Configuration.Option) {
            let errorScreen = GenericErrorScreen.build(configuration: GenericErrorScreen.Configuration.make(for: option))
            viewController.present(errorScreen, animated: true)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsRouter.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsImages.swift ---
//
//  DiscoverCardsImages.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import UIKit

extension DiscoverCardsJourney {
    public struct Images {
        var closeIcon: UIImage? = .named("pdf_close")
        var genericErrorIcon: UIImage? = .named("genericError_somethingWentWrong", in: .snbCommon)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsImages.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsDesign.swift ---
//
//  DiscoverCardsDesign.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import UIKit
import BackbaseDesignSystem
import Resolver
import SNBCommon

extension DiscoverCardsJourney {
    public struct Design {

        let styles = Styles()

        public var bottomButtonHeight: CGFloat = 56.0
        public var closeButtonWidthHeight: CGFloat = 24.0
        public var closeButtonTopSpace: CGFloat = 74.0

        struct Styles {

            /// Style applied to Bottom CTAs buttons
            public var bottomButtonStyle: Style<Button> = { button in
                DesignSystem.shared.styles.primaryButton(button)
                button.setTitleColor(
                    UIColor(
                        light: DesignSystem.shared.colors.neutrals.neutral100,
                        dark: DesignSystem.shared.colors.neutrals.neutral100
                    ),
                    for: .normal
                )
            }

            /// Style applied to a card
            public var card = Card()
        }
    }
}

extension DiscoverCardsJourney.Design.Styles {
    public struct Card {
        var title: Style<UILabel> = {
            $0.textColor = DesignSystem.shared.colors.surfacePrimary.default
            $0.font = DesignSystem.shared.fonts.preferredFont(.largeTitle, .regular)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        var imageView: Style<WebImageView> = {
            $0.contentMode = .scaleAspectFit
        }
        var button: Style<Button> = {
            $0.normalBackgroundColor = DesignSystem.shared.colors.primary.default
            $0.setTitleColor(UIColor(hex: "#0B1619"), for: .normal)
            $0.titleLabel?.font = DesignSystem.shared.fonts.preferredFont(.body, .medium)
            $0.cornerRadius = .max()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsDesign.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsStrings.swift ---
//
//  DiscoverCardsStrings.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import Foundation
import RetailJourneyCommon
import SNBCommon

extension DiscoverCardsJourney {
    public struct Strings {

        /// The title displayed in First Discover Card Bottom CTA
        @Localizable public var goToloyaltyButtonTitle = "discoverCards.screen1.buttonTitle"

        /// The title displayed in Second Discover Card Bottom CTA
        @Localizable public var tryNowButtonTitle = "discoverCards.screen2.buttonTitle"

        /// The title displayed in Third Discover Card Bottom CTA
        @Localizable public var giveTryButtonTitle = "discoverCards.screen3.buttonTitle"

        /// Strings used foe edge case screen
        public var error = Error()
    }
}

extension DiscoverCardsJourney.Strings {
    public struct Error {
        @Localizable public var title = "discoverCards.error.title"
        @Localizable public var message = "discoverCards.error.message"
        @Localizable public var tryAgainButtonTitle = "discoverCards.error.tryAgainButtonTitle"
        @Localizable public var cancelButtonTitle = "discoverCards.error.cancelButtonTitle"
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsStrings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsJourney.swift ---
//
//  DiscoverCardsJourney.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import UIKit
import Resolver

public struct DiscoverCardsJourney {

    public static func build(
        navigationController: UINavigationController,
        configuration: Self.Configuration = Resolver.resolve(),
        closeAction: ((Self.Configuration.DismissCardType) -> Void)?
    ) -> UIViewController {

        let router = DiscoverCardsJourney.Router(
            navigationController: navigationController,
            closeAction: closeAction
        )

        let viewModel = DiscoverCardsViewModel.init(
            configuration: DiscoverCardsJourney.Configuration(),
            router: router
        )

        let discoverVC = DiscoverCardsViewController(viewModel: viewModel)
        discoverVC.modalPresentationStyle = .fullScreen
        return discoverVC
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Configuration/DiscoverCardsJourney.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/DiscoverCardsViewController.swift ---
//
//  DiscoverCardsViewController.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//
// swiftlint:disable file_length
import UIKit
import BackbaseDesignSystem
import SNBCommon
import Resolver
import Combine

protocol DiscoverCardCollectionViewCellDelegate: AnyObject {
    func pauseProgressBarAnimation()
    func resumeProgressBarAnimation()
}

final class DiscoverCardsViewController: UIViewController {
    @LazyInjected private var configuration: DiscoverCardsJourney.Configuration
    private var viewModel: DiscoverCardsViewModel
    private let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    private let tryAgain = PassthroughSubject<Void, Never>()
    private let didScroll = PassthroughSubject<DiscoverCardsParameters, Never>()
    private let didTap = PassthroughSubject<Int, Never>()
    private let didTapRegion = PassthroughSubject<DiscoverCardsViewRegion, Never>()
    private var cards = [DiscoverCard]()
    private var cancellables = Set<AnyCancellable>()
    private let activityView: ActivityView = {
        var view = ActivityView()
        view.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(configuration.images.closeIcon, for: .normal)
        return button
    }()

     let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        var layout = collectionViewFlowLayout
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.register(
            DiscoverCardCollectionViewCell.self,
            forCellWithReuseIdentifier: DiscoverCardCollectionViewCell.reuseID
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.semanticContentAttribute = .forceLeftToRight
        return collectionView
    }()

    var progressBarManager: StoryProgressBarManager!
    private var currentSegmentIndex: Int = 0 {
       didSet {
           if currentSegmentIndex != oldValue {
               progressBarManager.animateToSegment(currentSegmentIndex)
           }
       }
   }

    // MARK: - Initialization
    init(viewModel: DiscoverCardsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.configureBackgroundView(type: .plain)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        addConstraints()
        viewDidLoadPublisher.send()
    }

    // MARK: - Private methods
    private func bind() {
        closeButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in self?.viewModel.didTapCloseButton() }
            .store(in: &cancellables)
        StoryProgressBar.changeSegmentPublisher.sink { [weak self] index in
            guard index >= 0 && index < self?.cards.count ?? 0 else { return }
            let indexPath = IndexPath(row: index, section: 0)
            self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }.store(in: &cancellables)
        let input = DiscoverCardsViewModelInput(
            viewDidLoad: viewDidLoadPublisher.eraseToAnyPublisher(),
            tryAgain: tryAgain.eraseToAnyPublisher(),
            didScroll: didScroll.eraseToAnyPublisher(),
            didTap: didTap.eraseToAnyPublisher(),
            didTapRegion: didTapRegion.eraseToAnyPublisher()
        )
        let output = viewModel.bind(input: input)
        output.state.sink { [weak self] in
            switch $0 {
            case .error:
                self?.activityView.deactivate()
                self?.showGenericError()
            case .loading:
                self?.activityView.activate()
            case .success:
                self?.activityView.deactivate()
            }
        }.store(in: &cancellables)
        output.cards.sink { [weak self] in
            self?.cards = $0
            self?.collectionView.reloadData()
            self?.setupProgressbar(segmentCount: $0.count)
        }.store(in: &cancellables)
        output.scroll.sink { [weak self] in
            let indexPath = IndexPath(row: $0.scrollIndex, section: 0)
            if $0.scrollDirection == .previous {
                self?.progressBarManager.animateToPreviousSegment()
            } else {
                self?.progressBarManager.animateToNextSegment()
            }
            self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }.store(in: &cancellables)
    }

    private func setupProgressbar(segmentCount: Int) {
        progressBarManager = StoryProgressBarManager(parentView: view,
                                                     segmentCount: segmentCount,
                                                     parentViewController: self)
    }

    private func addConstraints() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(activityView)

        closeButton.snp.makeConstraints { make in
            make.height.width.equalTo(24.0)
            make.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28.0)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(closeButton.snp.bottom).offset(DesignSystem.shared.spacer.md)
        }

        activityView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }

    func showGenericError() {
        if viewModel.isInternetConnected {
            self.viewModel.showErrorWithRetry(viewController: self)
        } else {
            self.viewModel.router.showGenericError(from: self, for: .noInternetConnection)
        }
    }
}

extension DiscoverCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DiscoverCardCollectionViewCell.reuseID,
            for: indexPath
        ) as? DiscoverCardCollectionViewCell else { return UICollectionViewCell() }
        let card = cards[indexPath.row]
        cell.indexPath = indexPath
        cell.configure(card: card)
        cell.buttonTapped = { [weak self] in
            guard let indexPath = $0 else { return }
            self?.didTap.send(indexPath.row)
        }
        cell.previousCardTapped = { [weak self] in
            guard let index = $0?.row else { return }
            self?.didTapRegion.send(.previousCard(index: index))
        }
        cell.nextCardTapped = { [weak self] in
            guard let index = $0?.row else { return }
            self?.didTapRegion.send(.nextCard(index: index))
        }
        cell.delegate = self
        return cell
    }
}

extension DiscoverCardsViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
            progressBarManager.progressBar?.animateToSegment(currentIndex)
        }
    }
}

extension DiscoverCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.frame.size
    }
}

extension DiscoverCardsViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressBarManager?.startStoryAnimations()
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressBarManager?.resetAnimations()
    }
}

extension DiscoverCardsViewController: DiscoverCardCollectionViewCellDelegate {
    func pauseProgressBarAnimation() {
        progressBarManager?.pauseProgressBarAnimation()
    }

    func resumeProgressBarAnimation() {
        progressBarManager?.resumeProgressBarAnimation()
    }
}

// swiftlint:enable file_length

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/DiscoverCardsViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/StoryProgressBarManager.swift ---
//
//  StoryProgressBarManager.swift
//
//  Created by Monish Calapatapu on 17/08/23.
//
import UIKit

class StoryProgressBarManager {
    var progressBar: StoryProgressBar?
    weak var parentViewController: UIViewController?

    init(parentView: UIView, segmentCount: Int, parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        progressBar = StoryProgressBar(segmentCount: segmentCount)
        progressBar?.translatesAutoresizingMaskIntoConstraints = false
        progressBar?.allSegmentAnimationsFinishedCompletion = { [weak self] in
            self?.handleAllSegmentAnimationsFinished()
        }
        parentView.addSubview(progressBar!)
        setupConstraints(parentView: parentView)
    }

    private func setupConstraints(parentView: UIView) {
        NSLayoutConstraint.activate([
            progressBar!.heightAnchor.constraint(equalToConstant: 3), // Adjust segment height
            progressBar!.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            progressBar!.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            progressBar!.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
    }

    func startStoryAnimations() {
        progressBar?.startProgress()
    }

    func resetAnimations() {
        progressBar?.resetAnimations()
    }

    func animateToNextSegment() {
        progressBar?.animateToNextSegment()
    }

    func animateToPreviousSegment() {
        progressBar?.animateToPreviousSegment()
    }

    func animateToSegment(_ segmentIndex: Int) {
        progressBar?.animateToSegment(segmentIndex)
    }

    func pauseProgressBarAnimation() {
        progressBar?.pauseAnimation()
    }

    func resumeProgressBarAnimation() {
        progressBar?.resumeAnimation()
    }

    func handleAllSegmentAnimationsFinished() {
        DispatchQueue.main.async { [weak self] in
            if let presentedViewController = self?.parentViewController?.presentedViewController {
                presentedViewController.dismiss(animated: true) { [weak self] in
                    self?.parentViewController?.dismiss(animated: true)
                }
            } else {
                self?.parentViewController?.dismiss(animated: true)
            }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/StoryProgressBarManager.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/WebImageView.swift ---
//
//  WebImageView.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 25/07/2023.
//

import BackbaseDesignSystem
import UIKit

public final class WebImageView: UIImageView {
    public var urlString: String? {
        didSet {
            loadImage()
        }
    }

    private var task: Task<Void, Never>?
    private let imageLoader = ImageLoader()
    private let loadingImage: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        DesignSystem.shared.styles.loadingIndicator(view)
        view.hidesWhenStopped = true
        return view
    }()
    private let defaultImage = UIImage.named(
        "default",
        in: .main
    )
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        addSubview(loadingImage)
        loadingImage.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    private func loadImage() {
        task?.cancel()
        guard let urlStr = urlString, let url = URL(string: urlStr) else {
            loadingImage.stopAnimating()
            image = defaultImage
            return
        }
        loadingImage.isHidden = false
        loadingImage.startAnimating()
        let nextTask = Task {
            do {
                let imageDownloaded = try await imageLoader.loadImage(withURL: url)
                if !Task.isCancelled {
                    await MainActor.run {
                        loadingImage.stopAnimating()
                        image = imageDownloaded
                    }
                }
            } catch {
                if !Task.isCancelled {
                    await MainActor.run {
                        loadingImage.stopAnimating()
                        image = defaultImage
                    }
                }
            }
        }
        task = nextTask
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/WebImageView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/DiscoverCardsViewModel.swift ---
//
//  DiscoverCardsViewModel.swift
//  RetailApp
//
//  Created by Nihal Khokhari on 08/08/23.
//

import Combine
import Foundation
import Resolver
import SNBCommon

final class DiscoverCardsViewModel: ObservableObject {

    private var configuration: DiscoverCardsJourney.Configuration
    var router: DiscoverCardsJourney.Router
    private let cardsResponse = CurrentValueSubject<DiscoverCardsResponse?, Never>(nil)
    private let scroll = PassthroughSubject<DiscoverCardsParameters, Never>()
    private let state = PassthroughSubject<DiscoverCardsViewState, Never>()
    private var cancellables = Set<AnyCancellable>()
    let networkMonitor: NetworkChecking = Resolver.resolve()
    @LazyInjected private var useCase: DiscoverCardsUseCaseProtocol

    var isInternetConnected: Bool {
        return networkMonitor.isConnected
    }

    // MARK: - Initialization
    init(
        configuration: DiscoverCardsJourney.Configuration,
        router: DiscoverCardsJourney.Router
    ) {
        self.configuration = configuration
        self.router = router
    }

    private func getCards() {
        self.state.send(.loading)
        Task { [weak self] in
            do {
                guard let cards = try await self?.useCase.getCards() else { return }
                await MainActor.run { [weak self] in
                    self?.state.send(.success)
                    self?.cardsResponse.send(cards)
                }
            } catch _ {
                await MainActor.run { [weak self] in
                    self?.state.send(.error)
                }
            }
        }
    }
}

// MARK: - Interactions
extension DiscoverCardsViewModel {

    func didTapCloseButton() {
        router.dismiss()
    }

    func showErrorWithRetry(viewController: UIViewController) {
        var config = GenericErrorScreen.Configuration()
        config.designs.icon = configuration.images.genericErrorIcon
        config.strings.title = configuration.strings.error.title
        config.strings.body = configuration.strings.error.message
        config.strings.primaryActionButtonTitle = configuration.strings.error.tryAgainButtonTitle
        config.actionButtonDisplayMode = .primaryOnly
        config.router.didSelectPrimaryActionButton = { [weak self] alertVC in
            return { _ in
                self?.getCards()
                viewController.dismiss(animated: true)
            }
        }
        let bottomSheet = GenericErrorScreen.build(configuration: config)
        viewController.present(bottomSheet, animated: true)
    }
}

// MARK: - Binding
extension DiscoverCardsViewModel {
    func bind(input: DiscoverCardsViewModelInput) -> DiscoverCardsViewModelOutput {
        input.viewDidLoad.sink { [weak self] in
            self?.getCards()
        }.store(in: &cancellables)
        input.tryAgain.sink { [weak self] in
            self?.getCards()
        }.store(in: &cancellables)
        input.didTap.sink { [weak self] in
            guard let card = self?.cardsResponse.value?.stories[safe: $0] else { return }
            self?.router.didTapOnButton(redirectionType: DiscoverCardsJourney.Configuration.getNavigationFrom(
                deeplinkString: card.deepLink
            ))
        }.store(in: &cancellables)
        input.didTapRegion.sink { [weak self] in
            switch $0 {
            case .previousCard(let index):
                if index > 0 {
                    self?.scroll.send(DiscoverCardsParameters(scrollIndex: index - 1, scrollDirection: .previous))
                }
            case .nextCard(let index):
                guard let cardsCount = self?.cardsResponse.value?.stories.count else { return }
                if index < cardsCount - 1 {
                    self?.scroll.send(DiscoverCardsParameters(scrollIndex: index + 1, scrollDirection: .next))
                }
            }
        }.store(in: &cancellables)
        return DiscoverCardsViewModelOutput(
            cards: cardsResponse.compactMap({$0?.toCards}).eraseToAnyPublisher(),
            scroll: scroll.eraseToAnyPublisher(),
            state: state.eraseToAnyPublisher()
        )
    }
}

enum DiscoverCardsViewState {
    case loading
    case error
    case success
}

enum DiscoverCardsViewRegion {
    case previousCard(index: Int)
    case nextCard(index: Int)
}

enum DiscoverCardsDirection {
    case previous
    case next
}

struct DiscoverCardsViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let tryAgain: AnyPublisher<Void, Never>
    let didScroll: AnyPublisher<DiscoverCardsParameters, Never>
    let didTap: AnyPublisher<Int, Never>
    let didTapRegion: AnyPublisher<DiscoverCardsViewRegion, Never>
}

struct DiscoverCardsViewModelOutput {
    let cards: AnyPublisher<[DiscoverCard], Never>
    let scroll: AnyPublisher<DiscoverCardsParameters, Never>
    let state: AnyPublisher<DiscoverCardsViewState, Never>
}

extension DiscoverCardsStoryResponse {
    var toCard: DiscoverCard {
        DiscoverCard(
            description: description,
            imageURLString: imageUrl,
            buttonTitle: buttonText
        )
    }
}

extension DiscoverCardsResponse {
    var toCards: [DiscoverCard] {
        stories.map({$0.toCard})
    }
}

struct DiscoverCard {
    let description: String
    let imageURLString: String
    let buttonTitle: String
}

struct DiscoverCardsParameters {
    let scrollIndex: Int
    let scrollDirection: DiscoverCardsDirection
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/DiscoverCardsViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/StoryProgressBar.swift ---
//
//  StoryProgressBar.swift
//
//  Created by Monish Calapatapu on 17/08/23.
//

import UIKit
import Combine

class StoryProgressBar: UIView {
    var segmentCount: Int = 0
    var progress: CGFloat = 0
    private var animationCancellable: AnyCancellable?
    var isAnimating: Bool = false // Track animation state
    var currentSegment: Int = 0
    weak var progressBarManager: StoryProgressBarManager?
    var allSegmentAnimationsFinishedCompletion: (() -> Void)?
    private let segmentSpacing: CGFloat = 2
    private let segmentHeight: CGFloat = 5
    private let animationDuration: TimeInterval = 7.0
    static let changeSegmentPublisher = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    // The properties used to hanlde pause/resume the progress animation
    private var pausedProgress: CGFloat = 0
    private var isPaused: Bool = false

    init(segmentCount: Int) {
        self.segmentCount = max(1, segmentCount)
        super.init(frame: .zero)
        setupUI()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        // Call startProgress when the view is added to its superview (e.g., when the ViewController is presented)
        startProgress()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = self.segmentHeight / 2
    }

    func startProgress() {
        // Check if animation is already in progress
        guard !isAnimating else { return }
        // Reset the current segment and progress
        currentSegment = 0
        progress = 0
        isAnimating = true
        animateNextSegment()
    }

    private func animateNextSegmentWithRemainingTime(_ remainingTime: TimeInterval = 7.0) {
        animationCancellable?.cancel()
        progress = pausedProgress
        setNeedsDisplay()
        isAnimating = true // Set animation state
        let animationSteps = Int(remainingTime * 60) // 60 frames per second for smooth animation
        let stepIncrement = 1.0 / CGFloat(animationSteps)
        var currentStep = Int(progress * CGFloat(animationSteps))
        let animationCompletionPublisher = PassthroughSubject<Void, Never>()
        animationCancellable = Timer.publish(every: animationDuration / Double(animationSteps), on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                guard !self.isPaused else { return }
                currentStep += 1
                self.progress = CGFloat(currentStep) * stepIncrement
                self.setNeedsDisplay()

                if currentStep >= animationSteps {
                    self.animationCancellable?.cancel()

                    self.currentSegment += 1
                    self.progress = 0
                    self.pausedProgress = 0 // Reset paused progress
                    self.setNeedsDisplay()
                    self.isAnimating = false // Reset animation state

                    if self.currentSegment < self.segmentCount {
                        DispatchQueue.main.async {
                            animationCompletionPublisher.send()
                        }
                    } else {
                        if self.currentSegment >= self.segmentCount {
                            self.allSegmentAnimationsFinishedCompletion?()
                        }
                    }
                }
                animationCompletionPublisher
                    .sink { [weak self] in
                        Self.changeSegmentPublisher
                            .send(self?.currentSegment ?? 0) // Call the publisher for each segment animation completion
                        self?.animateNextSegment() // Start animating the next segment
                    }
                    .store(in: &self.cancellables)
            }

        // Resume from the stored progress state if the animation was paused
        if isPaused {
            progress = pausedProgress
            // Adjust the remaining time for subsequent segments
            let remainingTimeForSubsequentSegments = animationDuration - remainingTime
            // Resume the animation from the adjusted remaining time (using default of 7 seconds if remainingTimeForSubsequentSegments is 0)
            self.animateNextSegmentWithRemainingTime(
                remainingTimeForSubsequentSegments > 0 ? remainingTimeForSubsequentSegments : animationDuration
            )
        }
    }

    func animateNextSegment() {
        pausedProgress = 0 // set this when other than current pause segment selected
        animateNextSegmentWithRemainingTime()
    }

    // Move to previous segment
    func animateToPreviousSegment() {
        guard currentSegment > 0 else {
            return
        }
        currentSegment -= 1
        progress = 0
        setNeedsDisplay()
        animateNextSegment()
    }

    // Move to next segment
    func animateToNextSegment() {
        guard currentSegment < segmentCount - 1 else {
            return
        }
        currentSegment += 1
        progress = 0
        setNeedsDisplay()
        animateNextSegment()
    }

    // This function is used to navigate particular segment
    func animateToSegment(_ segmentIndex: Int) {
        currentSegment = segmentIndex
        progress = 0
        setNeedsDisplay()
        updateProgress()
    }

    // Reset animations and start from the first segment
    func resetAnimations() {
        currentSegment = 0
        progress = 0
        isAnimating = false
        setNeedsDisplay()
        animateNextSegment()
    }

    func cancelAnimation() {
        // Cancel ongoing animation
        animationCancellable?.cancel()
        isAnimating = false
    }

    func pauseAnimation() {
        guard isAnimating else { return }
        // Store the current progress state
        pausedProgress = progress
        // Cancel ongoing animation
        animationCancellable?.cancel()
        isAnimating = false
        isPaused = true
    }

    func resumeAnimation() {
        guard !isAnimating, isPaused else { return }
        // Resume animation from the stored progress state
        isAnimating = true
        isPaused = false
        // Calculate the remaining time for the current segment based on the remaining progress
        let remainingTime = TimeInterval((1.0 - pausedProgress) * animationDuration)
        // Resume the animation from the remaining time (using default of 7 seconds if remainingTime is 0)
        animateNextSegmentWithRemainingTime(remainingTime > 0 ? remainingTime : animationDuration)
    }

    private func updateProgress() {
        animateNextSegment()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard segmentCount > 0 else { return }

        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let totalSpacing = CGFloat(segmentCount - 1) * segmentSpacing
        let availableWidth = frame.width - totalSpacing
        let segmentWidth = availableWidth / CGFloat(segmentCount)
        let blueWidth = segmentWidth * progress

        for i in 0..<segmentCount {
            let x = CGFloat(i) * (segmentWidth + segmentSpacing)

            let segmentLayer = CAShapeLayer()
            segmentLayer.frame = CGRect(x: x, y: (frame.height - segmentHeight) / 2, width: segmentWidth, height: segmentHeight)
            segmentLayer.cornerRadius = segmentHeight / 2

            if i < currentSegment {
                segmentLayer.backgroundColor = UIColor(hex: "#0DB4BA").cgColor
            } else {
                segmentLayer.backgroundColor = UIColor(hex: "#D9E4E8").cgColor
            }

            layer.addSublayer(segmentLayer)

            if i == currentSegment {
                let blueLayer = CAShapeLayer()
                blueLayer.frame = CGRect(x: x, y: (frame.height - segmentHeight) / 2, width: blueWidth, height: segmentHeight)
                blueLayer.cornerRadius = segmentHeight / 2
                blueLayer.backgroundColor = UIColor(hex: "#0DB4BA").cgColor

                // Add rounded mask to the blue layer for rounded start and end
                let maskPath = UIBezierPath(
                    roundedRect: blueLayer.bounds,
                    byRoundingCorners: [
                        .topLeft,
                        .bottomLeft,
                        .topRight,
                        .bottomRight
                    ],
                    cornerRadii: CGSize(
                        width: segmentHeight / 2,
                        height: segmentHeight / 2
                    )
                )
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                blueLayer.mask = maskLayer

                layer.addSublayer(blueLayer)
            }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/StoryProgressBar.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/ActivityView.swift ---
//
//  ActivityView.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 25/07/2023.
//

import BackbaseDesignSystem
import UIKit

public final class ActivityView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        DesignSystem.shared.styles.loadingIndicator(view)
        view.hidesWhenStopped = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func activate() {
        isHidden = false
        activityIndicator.startAnimating()
    }

    public func deactivate() {
        isHidden = true
    }

    private func setUpLayout() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/ActivityView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/DiscoverCardCollectionViewCell.swift ---
//
//  DiscoverCardCollectionViewCell.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 16/08/2023.
//

import BackbaseDesignSystem
import Foundation
import Resolver
import UIKit

final class DiscoverCardCollectionViewCell: UICollectionViewCell {
    static let reuseID = "DiscoverCardCollectionViewCell"
    private let configuration: DiscoverCardsJourney.Configuration = Resolver.resolve()
    var buttonTapped: ((IndexPath?) -> Void)?
    var indexPath: IndexPath?
    private let previousCard = UIView()
    private lazy var regionTapGestureRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(didTapRegion(sender:)))
        return recognizer
    }()
    private lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        return recognizer
    }()
    private let nextCard = UIView()
    var previousCardTapped: ((IndexPath?) -> Void)?
    var nextCardTapped: ((IndexPath?) -> Void)?
    private lazy var messageLabel: UILabel = {
        var label = UILabel()
        configuration.design.styles.card.title(label)
        return label
    }()
    private lazy var imageView: WebImageView = {
        var imageView = WebImageView(frame: .zero)
        configuration.design.styles.card.imageView(imageView)
        return imageView
    }()
    private lazy var button: Button = {
        var button = Button()
        configuration.design.styles.card.button(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    weak var delegate: DiscoverCardCollectionViewCellDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpSubviews() {
        let spacer1 = UIView()
        let spacer2 = UIView()
        [messageLabel, spacer1, imageView, spacer2, button].forEach {
            addSubview($0)
        }
        addSubview(previousCard)
        addSubview(nextCard)
        addGestureRecognizer(regionTapGestureRecognizer)
        addGestureRecognizer(longPressGestureRecognizer)
        messageLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        spacer1.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.96)
            $0.height.equalTo(imageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(spacer1.snp.bottom)
        }
        spacer2.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(spacer1.snp.height)
        }
        button.snp.makeConstraints {
            $0.top.equalTo(spacer2.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(DesignSystem.shared.spacer.sm)
            $0.height.equalTo(56.0)
        }
        previousCard.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(button.snp.top)
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        nextCard.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.bottom.equalTo(button.snp.top)
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
    }
    @objc private func didTapButton() {
        buttonTapped?(indexPath)
    }
    @objc private func didTapRegion(sender: UITapGestureRecognizer) {
        if sender == regionTapGestureRecognizer {
            let location = sender.location(in: previousCard)
            if previousCard.bounds.contains(location) {
                previousCardTapped?(indexPath)
            } else {
                let location = sender.location(in: nextCard)
                if nextCard.bounds.contains(location) {
                    nextCardTapped?(indexPath)
                }
            }
        }
    }
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            // Pause animation
            delegate?.pauseProgressBarAnimation()
        case .ended, .cancelled, .failed:
            // Resume animation
            delegate?.resumeProgressBarAnimation()
        default:
            break
        }
    }
    func configure(card: DiscoverCard) {
        messageLabel.text = card.description
        imageView.urlString = card.imageURLString
        button.setTitle(card.buttonTitle, for: .normal)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/View/DiscoverCardCollectionViewCell.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/UseCase/DiscoverCardsUseCase.swift ---
//
//  DiscoverCardsUseCase.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 11/08/2023.
//

import Foundation
import Resolver

public final class DiscoverCardsUseCase {
    @LazyInjected private var client: DiscoverCardsClientProtocol
    public init() {}
}

extension DiscoverCardsUseCase: DiscoverCardsUseCaseProtocol {
    public func getCards() async throws -> DiscoverCardsResponse {
        try await client.requestCards().toResponse
    }
}

extension DiscoverCardsStoryResponseDTO {
    public var toResponse: DiscoverCardsStoryResponse {
        DiscoverCardsStoryResponse(
            description: description,
            deepLink: deepLink,
            buttonText: buttonText,
            imageUrl: imageUrl
        )
    }
}

extension DiscoverCardsResponseDTO {
    public var toResponse: DiscoverCardsResponse {
        DiscoverCardsResponse(
            noOfStories: numberOfStories,
            stories: stories.map({$0.toResponse})
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/UseCase/DiscoverCardsUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/UseCase/DiscoverCardsUseCaseProtocol.swift ---
//
//  DiscoverCardsUseCaseProtocol.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 11/08/2023.
//

import Foundation

public struct DiscoverCardsStoryResponse {
    public let description: String
    public let deepLink: String
    public let buttonText: String
    public let imageUrl: String
}

public struct DiscoverCardsResponse {
    public let noOfStories: Int
    public let stories: [DiscoverCardsStoryResponse]
}

public protocol DiscoverCardsUseCaseProtocol {
    func getCards() async throws -> DiscoverCardsResponse
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/UseCase/DiscoverCardsUseCaseProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Client/DiscoverCardsClientProtocol.swift ---
//
//  DiscoverCardsClientProtocol.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 11/08/2023.
//

import Foundation

public protocol DiscoverCardsClientProtocol {
  func requestCards() async throws -> DiscoverCardsResponseDTO
}

public struct DiscoverCardsStoryResponseDTO: Decodable {
    public let description: String
    public let deepLink: String
    public let buttonText: String
    public let imageUrl: String
}

public struct DiscoverCardsResponseDTO: Decodable {
    public let numberOfStories: Int
    public let stories: [DiscoverCardsStoryResponseDTO]
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Client/DiscoverCardsClientProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Client/DiscoverCardsClient.swift ---
//
//  DiscoverCardsClient.swift
//  RetailApp
//
//  Created by Cisowski Łukasz on 11/08/2023.
//

import Backbase
import ClientCommon
import Foundation
import Resolver
import SNBCommon

public final class DiscoverCardsClient: NSObject, DBSClient {
    private enum Endpoint: EndpointConfiguration {
        case getStories
        
        var path: String {
            switch self {
            case .getStories:
                return "discover/stories"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .getStories:
                return .get
            }
        }
        
        var queryParameters: [URLQueryItem]? {
            switch self {
            case .getStories:
                return nil
            }
        }
        
        var body: Encodable? {
            switch self {
            case .getStories:
                return nil
            }
        }
    }
    
    public var dataProvider: DBSDataProvider?
    public var baseURL: URL
    
    @available(*, unavailable)
    override init() {
        fatalError("init() not implemented")
    }
    
    init(baseURL: URL, dataProvider: DBSDataProvider? = Resolver.optional(DBSDataProvider.self)) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }
}

extension DiscoverCardsClient: DiscoverCardsClientProtocol {
    public func requestCards() async throws -> DiscoverCardsResponseDTO {
        let endpointConfiguration = Endpoint.getStories
        
        guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }
        
        let request = try RequestBuilder.makeRequest(baseURL: baseURL, configuration: endpointConfiguration)
        let call = Call<DiscoverCardsResponseDTO>(dataProvider: dataProvider, request: request)
        let callResponse = try await call.execute()
        
        guard let responseBody = callResponse.body else { throw CallError.emptyDataResponse }
        return responseBody
    }
}

public enum DiscoverCardsClientFactory {
    public static func makeClient() -> DiscoverCardsClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        
        let requestURL = serverURL.appendingPathComponent("/api/discovery-service/client-api/v1/")
        let client = DiscoverCardsClient(baseURL: requestURL)
        
        return client
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Discover Cards/Client/DiscoverCardsClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationClient.swift ---
//
//  AccountIDValidationClient.swift
//  SNBCommon
//
//  Created by Nihal Khokhari on 27/10/23.
//

import Backbase
import ClientCommon
import Resolver

public protocol AccountIDValidationClientProtocol {
    func validateAccountID(_ requestObject: AccountIDValidationRequestDTO) async throws -> AccountIDValidationResponseDTO
    func getBeneficiaryDetails(_ requestId: String) async throws -> AccountIDValidationResponseDTO
}

final class AccountIDValidationClient: NSObject, DBSClient {
    var dataProvider: DBSDataProvider?
    var baseURL: URL

    @available(*, unavailable)
    override init() {
        fatalError("init() not implemented")
    }

    init(baseURL: URL, dataProvider: DBSDataProvider? = Resolver.optional(DBSDataProvider.self)) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }
}

extension AccountIDValidationClient {
    private enum Endpoint: EndpointConfiguration {
        case validateNeoAccountID(requestObject: AccountIDValidationRequestDTO)
        case validateAccountID(requestObject: AccountIDValidationRequestDTO)
        case getBeneficiary(requestId: String)

        var path: String {
            switch self {
            case .validateNeoAccountID: return "contacts/validateNeo"
            case .validateAccountID: return "contacts/validate"
            case .getBeneficiary(let requestId): return "contacts/\(requestId)"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .validateNeoAccountID, .validateAccountID: return .post
            case .getBeneficiary: return .get
            }
        }

        var queryParameters: [URLQueryItem]? {
            switch self {
            case .validateNeoAccountID, .validateAccountID, .getBeneficiary: return nil
            }
        }

        var body: Encodable? {
            switch self {
            case .validateNeoAccountID(let requestObject): return requestObject
            case .validateAccountID(let requestObject): return requestObject
            case .getBeneficiary: return nil
            }
        }
    }
}

extension AccountIDValidationClient: AccountIDValidationClientProtocol {
    func validateAccountID(_ requestObject: AccountIDValidationRequestDTO) async throws -> AccountIDValidationResponseDTO {
        do {
            if requestObject.customerType == .NEO {
                return try await performRequest(
                    endpoint: Endpoint.validateNeoAccountID(requestObject: requestObject)
                )
            } else {
                return try await performRequest(
                    endpoint: Endpoint.validateAccountID(requestObject: requestObject)
                )
            }
        } catch ClientCommon.ErrorResponse.error(let code, let data, let error) {
            if code == 400, let data {
                do {
                    let error: AccountIDValidationResponseDTO.Error = try JSONDecoder().decode(
                        AccountIDValidationResponseDTO.Error.self,
                        from: data
                    )
                    throw error.toResponse
                } catch let error {
                    throw error
                }
            }
            throw ClientCommon.ErrorResponse.error(code, data, error)
        }
    }

    func getBeneficiaryDetails(_ requestId: String) async throws -> AccountIDValidationResponseDTO {
        try await performRequest(
            endpoint: Endpoint.getBeneficiary(requestId: requestId)
        )
    }
}

extension SNBCommon {
    public enum AccountIDValidationClientFactory {
        public static func makeClient() -> AccountIDValidationClientProtocol {
            guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
                fatalError("Invalid or no serverURL found in the SDK configuration.")
            }

            let requestURL = serverURL.appendingPathComponent("api/beneficiary-manager/client-api/v2/")
            let client = AccountIDValidationClient(baseURL: requestURL)

            return client
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationRequestDTO.swift ---
//
//  AccountIDValidationRequestDTO.swift
//  SNBCommon
//
//  Created by Nihal Khokhari on 27/10/23.
//

public enum ValidationType: String, Encodable {
    case NEO
    case NotNEO
}

public struct AccountIDValidationRequestDTO: Encodable {
    public struct Account {
        let accountID: AccountID
        let accountType: String
        let alias: String
    }

    let name: String
    let accounts: [Account]
    public var customerType: ValidationType
}

extension AccountIDValidationRequestDTO.Account: Encodable {
    private enum CodingKeys: String, CodingKey {
        case accountType
        case accountNumber
        case phoneNumber
        case iban = "IBAN"
        case alias
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch accountID {
        case .accountNumber(let value):
            try container.encode(value, forKey: .accountNumber)
        case .iban(let value):
            try container.encode(value, forKey: .iban)
        case .phoneNumber(let value):
            try container.encode(value, forKey: .phoneNumber)
        }
        try container.encode(accountType, forKey: .accountType)
        try container.encode(alias, forKey: .alias)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationRequestDTO.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationRequestResponse.swift ---
//
//  AccountIDValidationRequestResponse.swift
//  SNBCommon
//
//  Created by Nihal Khokhari on 27/10/23.
//

public enum AccountID {
    case iban(value: String)
    case accountNumber(value: String)
    case phoneNumber(value: String)
}

public struct AccountIDValidationRequest {
    public let accountID: AccountID
    public let alias: String?
    public let validationType: ValidationType

    public init(
        accountID: AccountID,
        alias: String? = nil,
        validationType: ValidationType
    ) {
        self.accountID = accountID
        self.alias = alias
        self.validationType = validationType
    }
}

public struct AccountIDValidationResponse {
    public struct Account {
        public let name: String
        public let iban: String?
        public let accountNumber: String?
        public let bankCode: String?
        public let bankName: String?
        public let phoneNumber: String?
        public let additions: [String: String]?

        public init(
            name: String,
            iban: String? = nil,
            accountNumber: String? = nil,
            bankCode: String? = nil,
            bankName: String? = nil,
            phoneNumber: String? = nil,
            additions: [String: String]? = nil
        ) {
            self.name = name
            self.iban = iban
            self.accountNumber = accountNumber
            self.bankCode = bankCode
            self.bankName = bankName
            self.phoneNumber = phoneNumber
            self.additions = additions
        }
    }
    public let name: String
    public let account: Account?
    public var isNeo: Bool {
        if let dict = account?.additions, let isNeoCustomer = dict["isNeo"] {
            return isNeoCustomer == "true"
        }
        return false
    }

    public init(name: String, account: Account?) {
        self.name = name
        self.account = account
    }
}

public extension AccountIDValidationResponse {
    public enum Error {
        case invalid
        case invalidPhone
        case notNEO
        case registered(beneficiary: AccountIDValidationResponseDTO.BeneficiaryDetails?)
        case ambiguousAccountsFound
        case unknown
        case ownAccount
    }

    public struct BeneficiaryDetails {
        public let beneficiaryId: String?
        public let name: String?
        public let bankCode: String?
        public let isNeo: Bool?
        public let IBAN: String?
    }
}

extension AccountIDValidationResponse.Error: Error {}

public extension AccountIDValidationResponseDTO {
    public var toResponse: AccountIDValidationResponse {
        guard let acc = accounts.first else {
            return AccountIDValidationResponse(
                name: name,
                account: nil
            )
        }
        return AccountIDValidationResponse(
            name: name,
            account: AccountIDValidationResponse.Account(
                name: acc.name,
                iban: acc.iban,
                accountNumber: acc.accountNumber,
                bankCode: acc.bankCode,
                bankName: acc.bankName,
                phoneNumber: acc.phoneNumber,
                additions: acc.additions
            )
        )
    }
}

public extension AccountIDValidationResponseDTO.Error {
    public var toResponse: AccountIDValidationResponse.Error {
        if key == "NotNeoError" {
            return .invalid
        }
        if key == "NotBelongsToNeoError" {
            return .notNEO
        }
        if key == "AlreadyRegistered" {
            return .registered(beneficiary: beneficiaryDetails)
        }
        if key == "AmbiguousCustomersFound" {
            return .ambiguousAccountsFound
        }
        if key == "InvalidPhoneNumber" {
            return .invalidPhone
        }
        if key == "OwnAccountError" {
            return .ownAccount
        }
        return .unknown
    }

    public var beneficiaryDetails: AccountIDValidationResponseDTO.BeneficiaryDetails? {
        guard let context = errors?.first?.context else { return nil }
        return AccountIDValidationResponseDTO.BeneficiaryDetails(
            beneficiaryId: context.beneficiaryId,
            name: context.name,
            bankCode: context.bankCode,
            isNeo: context.isNeo,
            IBAN: context.IBAN,
            alias: context.alias
        )
    }
}

public extension AccountIDValidationRequest {
    public var toDTO: AccountIDValidationRequestDTO {
        AccountIDValidationRequestDTO(
            name: "",
            accounts: [
                AccountIDValidationRequestDTO.Account(
                    accountID: accountID,
                    accountType: "LOCAL",
                    alias: alias ?? ""
                )
            ],
            customerType: validationType
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationRequestResponse.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationResponseDTO.swift ---
//
//  AccountIDValidationResponseDTO.swift
//  SNBCommon
//
//  Created by Nihal Khokhari on 27/10/23.
//

public struct AccountIDValidationResponseDTO: Decodable {
    let name: String
    let accounts: [Account]
}

public struct Account: Decodable {
    let name: String
    let iban: String?
    let accountNumber: String?
    let bankCode: String?
    let bankName: String?
    let phoneNumber: String?
    let additions: [String: String]?
}

public extension AccountIDValidationResponseDTO {
    public struct Error: Decodable {
        let message: String
        let key: String
        let errors: [ErrorObject]?
    }

    public struct ErrorObject: Decodable {
        let message: String
        let key: String
        let context: BeneficiaryDetails?
    }

    public struct BeneficiaryDetails: Decodable {
        public let beneficiaryId: String?
        public let name: String?
        public let bankCode: String?
        public let isNeo: String?
        public let IBAN: String?
        public let alias: String?

        public var isNeoBool: Bool {
            if let isNeoCustomer = isNeo { return isNeoCustomer == "true" }
            return false
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/User Validation/AccountIDValidationResponseDTO.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/Receipt/ReceiptResponse.swift ---
import Foundation

public struct ReceiptResponse: Codable {
    public let content: Data

    public init(content: Data) {
        self.content = content
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/Receipt/ReceiptResponse.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/Receipt/ReceiptClient.swift ---
import ClientCommon
import Resolver
import Backbase

public protocol ReceiptClientProtocol {
    func fetchReceipt(_ requestObject: ReceiptRequest) async throws -> ReceiptResponse
}

public final class ReceiptClient: NSObject, DBSClient, ReceiptClientProtocol {
    public enum Service: String {
        case transferBetweenMyAccounts = "own-transfers"
        case internationalTransfer = "international-transfers"
        case localTransfer = "local-transfers"
        case internalTransfer = "internal-transfers"
        case internationalTransferCancellations = "international-transfer-cancellations"
        case neoTransfer = "internal-neo-transfers"
        case musanedTransfer = "musaned-transfers"
    }

    private enum Endpoint: EndpointConfiguration {
        case receipt(requestObject: ReceiptRequest, service: Service)

        private var baseURLDestination: String {
            return "api/receipt-generation-service/client-api/v1/receipts"
        }

        var path: String {
            switch self {
            case .receipt(_, let service):
                return [baseURLDestination, service.rawValue].joined(separator: "/")
            }
        }
        var method: HTTPMethod { .get }
        var queryParameters: [URLQueryItem]? {
            switch self {
            case .receipt(let requestObject, _):
                return [ URLQueryItem(name: "id", value: requestObject.id) ]
            }
        }
        var body: Encodable? { nil }
    }

    public var dataProvider: DBSDataProvider?

    public var baseURL: URL

    private let service: Service

    public init(baseURL: URL,
                service: Service,
                dataProvider: DBSDataProvider? = Resolver.optional(DBSDataProvider.self)) {

        self.dataProvider = dataProvider
        self.baseURL = baseURL
        self.service = service
    }

    public func fetchReceipt(_ requestObject: ReceiptRequest) async throws -> ReceiptResponse {
        let endpointConfiguration = Endpoint.receipt(requestObject: requestObject, service: service)
        guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }

        let request = try RequestBuilder.makeRequest(baseURL: baseURL, configuration: endpointConfiguration)
        let call = Call<ReceiptResponse>(dataProvider: dataProvider, request: request)
        let callResponse = try await call.execute()

        guard let responseBody = callResponse.body else { throw CallError.emptyDataResponse }
        return responseBody
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/Receipt/ReceiptClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/Receipt/ReceiptRequest.swift ---
import Foundation

public struct ReceiptRequest {
    public init(id: String) {
        self.id = id
    }

    public let id: String
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Clients/Receipt/ReceiptRequest.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/CollectionView/RTLCollectionFlowLayout.swift ---
//
//  RTL.swift
//  ActiveLabel
//
//  Created by Divine Dube on 24/01/2024.
//

import Foundation

public final class RTLCollectionFlowLayout: UICollectionViewFlowLayout {
    public override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        LocaleSelector.shared.isArabic
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/CollectionView/RTLCollectionFlowLayout.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/DBSClient+performRequest.swift ---
//
//  DBSClient+performRequest.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 12/04/2023.
//

import Backbase
import ClientCommon

public extension DBSClient {
    func performRequest<Response: Decodable>(
        endpoint: EndpointConfiguration,
        bodyEncoder: RequestBodyEncoder = JSONEncoder()
    ) async throws -> Response {
        guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }
        let request = try RequestBuilder.makeRequest(baseURL: baseURL, configuration: endpoint, bodyEncoder: bodyEncoder)
        let call = Call<Response>(dataProvider: dataProvider, request: request)
        let callResponse = try await withTaskCancellationHandler {
            do {
                return try await call.execute()
            } catch ClientCommon.ErrorResponse.error(let code, let data, let error) {
                let restrictionError = userRestriction(from: data)

                if restrictionError?.has(error: .serviceAgreement) == true {
                    throw CommonError.serviceAgreementMissing
                } else if code == 403 {
                    throw CommonError.stepUpCancelledByUser
                } else if restrictionError?.has(error: .serviceDenied) == true {
                    throw CommonError.serviceDenied
                }

                throw ClientCommon.ErrorResponse.error(code, data, error)
            }
        } onCancel: {
            _ = call.cancel()
        }
        guard let responseBody = callResponse.body else { throw CallError.emptyDataResponse }
        return responseBody
    }

    private func userRestriction(from data: Data?) -> UserRestrictionErrorResponse? {
        guard let data else { return nil }
        return try? JSONDecoder().decode(UserRestrictionErrorResponse.self, from: data)
    }

    func performRequest(endpoint: EndpointConfiguration) async throws {
        try await performRequest(endpoint: endpoint) as NoResponse
    }
}

extension UserRestrictionErrorResponse {
    enum ErrorKey: String {
        case serviceAgreement = "error.service.agreement.is.missing.in.context"
        case serviceDenied = "ERROR_TX_001"
    }

    func has(error code: ErrorKey) -> Bool {
        errors.first { $0.key == code.rawValue } != nil
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/DBSClient+performRequest.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/CommonError.swift ---
//
//  CommonError.swift
//  SNBCommon
//
//  Created by Grzegorz Pawłowicz on 16/05/2023.
//

import Foundation

public enum CommonError: Error {
    case serviceAgreementMissing
    case stepUpCancelledByUser
    case noDatafound
    case serviceDenied
}

public struct UserRestrictionErrorResponse: Decodable {
    let errors: [Error]

    public struct Error: Decodable {
        public let message: String
        public let key: String?
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/CommonError.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/DataProvider.swift ---
//
//  DataProvider.swift
//  SNBCommon
//
//  Created by Basistyi, Yevhen on 28/02/2023.
//

import Foundation
import Backbase

public protocol SNBDVDataProviderProtocol: DBSDataProvider {}

public class SNBDVDataProvider: NSObject, SNBDVDataProviderProtocol {
    let extraHeaders: [String: String]

    public init(extraHeaders: [String: String] = [:]) {
        self.extraHeaders = extraHeaders
    }

    public func execute(_ request: URLRequest, completionHandler: ((URLResponse?, Data?, Error?) -> Void)? = nil) {
        let session = URLSession(configuration: Backbase.securitySessionConfiguration())
        var mutableRequest = request

        extraHeaders.forEach { key, value in
            mutableRequest.allHTTPHeaderFields?[key] = value
        }
        Backbase.securitySessionConfiguration().httpAdditionalHeaders?.forEach { header in
            if let key = header.key as? String, let value = header.value as? String {
                mutableRequest.allHTTPHeaderFields?[key] = value
            }
        }

        session.dataTask(with: mutableRequest) { data, response, error in
            DispatchQueue.main.async {
                completionHandler?(response, data, error)
            }
        }.resume()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/DataProvider.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/HTTPMethod.swift ---
//
//  HTTPMethod.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 27/02/2023.
//

import Foundation

public enum HTTPMethod: String, CaseIterable {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
    case patch = "PATCH"
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/HTTPMethod.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/EndpointConfiguration.swift ---
//
//  EndpointConfiguration.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 27/02/2023.
//

import Foundation

public protocol EndpointConfiguration {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [URLQueryItem]? { get }
    var body: Encodable? { get }
    var header: [String: String]? { get }
}
public extension EndpointConfiguration {
    var header: [String: String]? {
        return nil
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/EndpointConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/Call+execute.swift ---
//
//  Call+execute.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 26/02/2023.
//

import ClientCommon

public extension Call {
    /// Convenience method that wraps regular ClientCommon.execute into an async method
    ///
    /// Note: In case of an error it will throw a `ClientCommon.ErrorResponse` error. For details please check its declaration.
    func execute() async throws -> ClientCommon.Response<T> {
        try await withCheckedThrowingContinuation { continuation in
            execute { result in
                continuation.resume(with: result)
            }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/Call+execute.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/BaseDBSClient.swift ---
//
//  BaseDBSClient.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 01/06/2023.
//

import Backbase
import Resolver
import ClientCommon

open class BaseDBSClient: NSObject, DBSClient {
    public var dataProvider: DBSDataProvider?
    public var baseURL: URL

    @available(*, unavailable)
    override init() {
        fatalError("init() not implemented")
    }

    public init(baseURL: URL, dataProvider: DBSDataProvider? = Resolver.optional(DBSDataProvider.self)) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/BaseDBSClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/RequestBuilder+makeRequest.swift ---
//
//  RequestBuilder+makeRequest.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 27/02/2023.
//

import Foundation
import ClientCommon

public extension RequestBuilder {

    /// Creates a URLRequest using ClientCommon request builder and custom EndpointConfiguration
    ///
    /// This method leverages the endpoint configuration from a EndpointConfiguration object and pass it down
    /// to the RequestBuilder to create the request. This will take care of adding all auth related headers necessary.
    ///
    ///  **Note:** At the moment this can only handle posting data with body in `Content-Type` as `application/json`.
    ///  **If you need to have it you need to manually create you URLRequest.**
    ///
    /// - Parameter baseURL: BaseURL that will make the final URL in the URLRequest
    /// - Parameter configuration: EndpointConfiguration to be used while creating the URLRequest
    /// - Parameter bodyEncoder: Custom encoder to be used when encoding the body data. Must conform to `RequestBodyEncoder`
    /// - Returns: Resulting URLRequest using provided configuration
    static func makeRequest(
        baseURL: URL,
        configuration: EndpointConfiguration,
        bodyEncoder: RequestBodyEncoder = JSONEncoder(),
        requiresMfa: Bool = true
    ) throws -> URLRequest {
        var requestURL = baseURL.appendingPathComponent(configuration.path)
        var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
        var queryItems = components?.queryItems ?? []
        if requiresMfa == true && queryItems.first(where: {$0.name == "mfaState"}) == nil {
            queryItems.append(.init(name: "mfaState", value: "initiate"))
        }
        // Condtion added, because empty queryItems set to URLComponents, add an extra '?' to the components?.url generated
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        if let newURL = components?.url {
            requestURL = newURL
        }
        let queryKeyPairs = (configuration.queryParameters ?? []).map { ($0.name, $0.value) }
        var queryParameters = Dictionary(queryKeyPairs, uniquingKeysWith: { (first, _) in return first }) as [String: Any]
        if requiresMfa == true && queryParameters["mfaState"] == nil {
            queryParameters["mfaState"] = "initiate"
        }
        var request = try Self.createURLRequest(
            requestUrl: requestURL,
            method: configuration.method.rawValue,
            queryParameters: queryParameters,
            bodyParameters: nil,
            bodyType: configuration.body != nil ? .json : .none)

        if let body = configuration.body {
            request.httpBody = try bodyEncoder.encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if let header = configuration.header {
            var allHTTPHeaderFields = request.allHTTPHeaderFields ?? [:]
            for (key, value) in header {
                allHTTPHeaderFields[key] = value
            }
            request.allHTTPHeaderFields = allHTTPHeaderFields
        }

        return request
    }
}

public protocol RequestBodyEncoder {
    func encode<T>(_ value: T) throws -> Data where T: Encodable
}

extension JSONEncoder: RequestBodyEncoder { }

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Custom Client/RequestBuilder+makeRequest.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SNBCommon+Configuration.swift ---
//
//  SNBCommon+Configuration.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 14/02/2023.
//

import UIKit
import BackbaseDesignSystem

public struct SNBCommon {
    public class Configuration {
        public var images: Images
        public var strings: Strings
        public var styles: Styles

        public init(images: Images = .init(), strings: Strings = .init(), styles: Styles = .init()) {
            self.images = images
            self.strings = strings
            self.styles = styles
        }
    }
}

// MARK: - Images

extension SNBCommon.Configuration {
    public struct Images {
        public var patternBackground = UIImage.named("pattern-background", in: .snbCommon)!
        public var gradientBackground = UIImage.named("gradient-background", in: .snbCommon)!
        public var showPasswordIcon = UIImage.named("show-password-icon", in: .snbCommon)!
        public var hidePasswordIcon = UIImage.named("hide-password", in: .main)!
        public var noSearchResultsIcon = UIImage.named("no-results", in: .snbCommon)!
        public var arrowBack = UIImage.named("arrow-back", in: .snbCommon)!
        public var settingsIcon = UIImage.named("settingsIcon", in: .snbCommon)!
        public var logout = UIImage.named("logout", in: .snbCommon)
        public var crossIcon = UIImage.named("cross-icon", in: .snbCommon)!
        public var roundedCheckboxOn = UIImage.named("roundedCheckboxOn", in: .snbCommon)!
        public var roundedCheckboxOff = UIImage.named("roundedCheckboxOff", in: .snbCommon)!
        public var rectangularCheckboxOn = UIImage.named("rectangularCheckboxOn", in: .snbCommon)!
        public var rectangularCheckboxOff = UIImage.named("rectangularCheckboxOff", in: .snbCommon)!
        public var rectBlackCheckboxOn = UIImage.named("rectBlackCheckboxOn", in: .snbCommon)!
        public var rectBlackCheckboxOff = UIImage.named("rectBlackCheckboxOff", in: .snbCommon)!
        public var calendarIcon = UIImage.named("calendar_filled", in: .snbCommon)!
        public var lockOpen = UIImage.named("lock_open", in: .snbCommon)!
        public var lock = UIImage.named("lock", in: .snbCommon)!
        public var avatar = UIImage.named("avatar", in: .snbCommon)!
        public var somethingWentWrong = UIImage.named("genericError_somethingWentWrong", in: .snbCommon)!
        public var noInternet = UIImage.named("genericError_noInternet", in: .snbCommon)!

        public init() {}
    }
}

// MARK: - Strings

extension SNBCommon.Configuration {
    public struct Strings {
        @Localizable(in: .snbCommon) public var editAmountTotalDue = "common.edit-amount.callout.total-due"
        @Localizable(in: .snbCommon) public var amountInvalidError = "common.edit-amount.error.invalid"
        @Localizable(in: .snbCommon) public var amountNegativeError = "common.edit-amount.error.negative"
        @Localizable(in: .snbCommon) public var amountZeroError = "common.edit-amount.error.zero"
        @Localizable(in: .snbCommon) public var noSearchResultsTitle = "common.no-search-results.title"
        @Localizable(in: .snbCommon) public var noSearchResultsDescription = "common.no-search-results.description"
        @Localizable(in: .snbCommon) public var doneButton = "common.buttons.done"
        @Localizable(in: .snbCommon) public var copytoCliped = "common.copiedtoclipboard"
        @Localizable(in: .snbCommon) public var referralCodeTitle = "referral.label.code"
        @Localizable(in: .snbCommon) public var loadingTitle = "loadingView.label.text"
        @Localizable(in: .snbCommon) public var dailyLimitExceeded = "common.error.dailyLimitExceeded"
        @Localizable(in: .snbCommon) public var monthlyLimitExceeded = "common.error.monthlyLimitExceeded"
        @Localizable(in: .snbCommon) public var dailyLimitExceededMessage = "common.alert.dailyLimitExceededMessage"
        @Localizable(in: .snbCommon) public var monthlyLimitExceededMessage = "common.alert.monthlyLimitExceededMessage"
        @Localizable(in: .snbCommon) public var marketplaceDailyLimitError = "marketplace.cart.error.dailyLimitExceeded"
        @Localizable(in: .snbCommon) public var marketplaceMonthlyLimitError = "marketplace.cart.error.monthlyLimitExceeded"
        @Localizable(in: .snbCommon) public var marketplaceLimitError = "marketplace.cart.error.limitExceeded"
        @Localizable(in: .snbCommon) public var sadadDailyLimitError = "sadad.error.dailyLimitExceeded"
        @Localizable(in: .snbCommon) public var sadadMonthlyLimitError = "sadad.error.monthlyLimitExceeded"
        @Localizable(in: .snbCommon) public var sadadLimitError = "sadad.error.limitExceeded"
        @Localizable(in: .snbCommon) var commonLimitError = "common.errors.limitExceeded"
        @Localizable(in: .snbCommon) public var noInternetTitle = "genericError.noInternetConnection.title"
        @Localizable(in: .snbCommon) public var noInternetSubtitle = "genericError.noInternetConnection.subtitle"
        @Localizable(in: .snbCommon) public var loadingFailedTitle = "common.error.loadingFailedTitle"
        @Localizable(in: .snbCommon) public var loadingFailedSubtitle = "common.error.loadingFailedSubtitle"
        @Localizable(in: .snbCommon) public var tryAgainButton = "common.buttons.tryAgain"

        public init() {}
    }
}

// MARK: - Styles

extension SNBCommon.Configuration {
    public struct Styles {
        var noSearchResultsTitle: Style<UILabel> = {
            $0.textColor = DesignSystem.shared.colors.text.default
            $0.font = DesignSystem.shared.fonts.preferredFont(.title2, .medium)
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        var noSearchResultsDescription: Style<(UILabel, String)> = {
            let (label, text) = $0
            label.numberOfLines = 0
            label.attributedText = AttributedStringBuilder()
                .foregroundColor(DesignSystem.shared.colors.text.support)
                .paragraphStyle(
                    font: DesignSystem.shared.fonts.preferredFont(.callout, .regular),
                    lineHeight: 21,
                    textAlignment: .center
                )
                .build(text: text)
        }

        public init() {}
    }
}

// MARK: - Bundle + snbCommon

public extension Bundle {
    private final class CommonClass {}

    public static let snbCommon = Bundle(for: CommonClass.self)
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SNBCommon+Configuration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/ImagePicker/ImagePicker.swift ---
//
//  ImagePicker.swift
//  ActiveLabel
//
//  Created by Rafael Nascimento on 18/04/2023.
//

import RetailJourneyCommon
import UIKit
import AVFoundation
import Photos

public protocol ImagePickerDelegate: AnyObject {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool, to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func cancelButtonDidClick(on imageView: ImagePicker)
}

@objc(SNBImagePicker)
public final class ImagePicker: NSObject {
    private enum TargetName {
        case camera, photoGallery

        var string: String {
            switch self {
            case .camera: return Strings.Target.camera
            case .photoGallery: return Strings.Target.photoGallery
            }
        }
    }

    private enum Strings {
        enum Target {
            @Localizable(in: .snbCommon) static var camera = "image.picker.target.camera"
            @Localizable(in: .snbCommon) static var photoGallery = "image.picker.target.photo.gallery"
        }
        enum AccessRequest {
            @Localizable(in: .snbCommon) static var cancelButton = "image.picker.cancel.button"
            @Localizable(in: .snbCommon) static var settingsButton = "image.picker.settings.button"

            @Localizable(in: .snbCommon) static private var title = "image.picker.request.access.title"
            @Localizable(in: .snbCommon) static private var description = "image.picker.request.access.description"

            static func title(with target: String) -> String { String(format: title, target)}
            static func description(with target: String) -> String { String(format: description, target)}
        }
    }

    private enum UserDefaultKeys {
        static let cameraAccess: String = "camera_access_request_denied"
        static let photoLibraryAccess: String = "photo_library_access_request_denied"
    }

    private weak var controller: UIImagePickerController?
    weak public var delegate: ImagePickerDelegate?
    private let defaults = UserDefaults.standard
    var isCameraAccessDenied: Bool {
        get { defaults.bool(forKey: ImagePicker.UserDefaultKeys.cameraAccess) }
        set { defaults.set(newValue, forKey: ImagePicker.UserDefaultKeys.cameraAccess) }
    }
    var isPhotoLibraryAccessDenied: Bool {
        get { defaults.bool(forKey: ImagePicker.UserDefaultKeys.photoLibraryAccess) }
        set { defaults.set(newValue, forKey: ImagePicker.UserDefaultKeys.photoLibraryAccess) }
    }

    public func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    public func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }

    private func showAlert(targetName: TargetName, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alertController = UIAlertController(title: Strings.AccessRequest.title(with: targetName.string),
                                                    message: Strings.AccessRequest.description(with: targetName.string),
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Strings.AccessRequest.settingsButton, style: .default, handler: { action in
                guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                        UIApplication.shared.canOpenURL(settingsUrl) else { completion?(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                    self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            alertController.addAction(UIAlertAction(
                title: Strings.AccessRequest.cancelButton, style: .cancel, handler: { _ in completion?(false) }
            ))
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?
                .rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    public func cameraAccessRequest() {
        if delegate == nil { return }
        let source = UIImagePickerController.SourceType.camera
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            delegate?.imagePicker(self, grantedAccess: true, to: source)
        } else {
            // Ensure it doesn't try to run on simulator
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }

            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self else { return }
                if granted {
                    self.delegate?.imagePicker(self, grantedAccess: granted, to: source)
                } else {
                    if self.isCameraAccessDenied == false { self.isCameraAccessDenied = true ; return }
                    self.showAlert(targetName: .camera) { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
                }
            }
        }
    }

    public func photoGalleryAccessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self else { return }
            let source = UIImagePickerController.SourceType.photoLibrary
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                }
            } else {
                if self.isPhotoLibraryAccessDenied == false { self.isPhotoLibraryAccessDenied = true; return }
                self.showAlert(targetName: .photoGallery) { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
            }
        }
    }
}

extension ImagePicker: UINavigationControllerDelegate { }

extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            return
        }

        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
        } else {
            // Other source
            // TODO: Handle it in a future US, if needed
        }
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/ImagePicker/ImagePicker.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/RestrictionManager/NewUserRestrictionManager+PrepaidCards.swift ---
//
//  NewUserRestrictionManager+PrepaidCards.swift
//  SNBCommon
//
//  Created by Sudeep George on 25/10/24.
//

import Foundation

extension NewUserRestrictionManager {
    public func prepaidOriginationDisabled() -> Bool {
        if disabledCardfeatures == nil || disabledCardfeatures?.prepaidOriginationDisabled == "true" {
            refreshRestrictions()
            return true
        }
        return false
    }

    public func prepaidViewDetailsDisabled() -> Bool {
        if disabledCardfeatures == nil || disabledCardfeatures?.prepaidViewDetailsDisabled == "true" {
            refreshRestrictions()
            return true
        }
        return false
    }

    public func prepaidAppleWalletDisabled() -> Bool {
        if disabledCardfeatures == nil || disabledCardfeatures?.prepaidAppleWalletDisabled == "true" {
            refreshRestrictions()
            return true
        }
        return false
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/RestrictionManager/NewUserRestrictionManager+PrepaidCards.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/RestrictionManager/NewUserRestrictionManager.swift ---
//
//  NewUserRestrictionManager.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 23/11/23.
//

import Foundation
import Backbase

public protocol NewUserRestrictionProtocol {
    func fetchRestrictions() async throws

    func isLocalTransferDisabled() -> Bool
    func isRequestMoneyDisabled() -> Bool
    func isQuickPayDisabled() -> Bool
    func isInternationalTransferDisabled() -> Bool

    func isMCDCDisabled() -> Bool

    func prepaidOriginationDisabled() -> Bool
    func prepaidViewDetailsDisabled() -> Bool
    func prepaidAppleWalletDisabled() -> Bool
}

public class NewUserRestrictionManager: NewUserRestrictionProtocol {
    public static let shared = NewUserRestrictionManager()
    public var transferFeatures: TransferFeatures?
    public var disabledCardfeatures: CardFeatures?
    private init() { }

    public func fetchRestrictions() async throws {
        let usecase = NewUserRestrictionUseCase()
        let response = try await usecase.fetchFeaturePermissionsForNewUsers()
        transferFeatures = response.disabledPayments
        disabledCardfeatures = response.disabledCards
    }
    
    func refreshRestrictions() {
        Task {
            try? await fetchRestrictions()
        }
    }

    public func isLocalTransferDisabled() -> Bool {
        if let transferFeatures, transferFeatures.isLocalTransferDisabled == "true" {
            refreshRestrictions()
            return true
        } else {
            return false
        }
    }

    public func isRequestMoneyDisabled() -> Bool {
        if let transferFeatures, transferFeatures.isRequestMoneyDisabled == "true" {
            refreshRestrictions()
            return true
        } else {
            return false
        }
    }

    public func isQuickPayDisabled() -> Bool {
        if let transferFeatures, transferFeatures.isQuickPayDisabled == "true" {
            refreshRestrictions()
            return true
        } else {
            return false
        }
    }

    public func isInternationalTransferDisabled() -> Bool {
        if let transferFeatures, transferFeatures.isInternationalTransferDisabled == "true" {
            refreshRestrictions()
            return true
        } else {
            return false
        }
    }

    public func isMCDCDisabled() -> Bool {
        if let disabledCardfeatures, disabledCardfeatures.isMCDCDisabled == "true" {
            refreshRestrictions()
            return true
        } else {
            return false
        }
    }

    public func showErrorScreen(
        with option: GenericErrorScreen.Configuration.Option,
        isDismissible: Bool = false,
        completion: @escaping () -> Void
    ) -> UIViewController {
        var configuration: GenericErrorScreen.Configuration = .make(for: option)
        configuration.actionButtonDisplayMode = .primaryOnly
        configuration.isDismissByDragginEnabled = isDismissible
        configuration.router.didSelectPrimaryActionButton = { viewController in { [weak viewController] _ in
                viewController?.dismiss(animated: true)
                completion()
            }
        }
        return GenericErrorScreen.build(configuration: configuration)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/RestrictionManager/NewUserRestrictionManager.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/UseCase/NewUserRestrictionUseCase.swift ---
//
//  NewUserRestrictionUseCase.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 23/11/23.
//

import Foundation
import Resolver

public protocol NewUserRestrictionUseCaseProtocol {
    func fetchFeaturePermissionsForNewUsers() async throws -> RestrictionFeatureResponse
}

public final class NewUserRestrictionUseCase: NewUserRestrictionUseCaseProtocol {
    private let client: NewUserRestrictionClientProtocol

    public init(client: NewUserRestrictionClientProtocol = NewUserRestrictionClientFactory.makeClient()) {
        self.client = client
    }
    public func fetchFeaturePermissionsForNewUsers() async throws -> RestrictionFeatureResponse {
        try await client.fetchFeaturePermissionsForNewUsers()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/UseCase/NewUserRestrictionUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/UseCase/RestrictionFeatureResponse.swift ---
//
//  RestrictionFeatureResponse.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 23/11/23.
//

import Foundation

public struct RestrictionFeatureResponse: Codable {
    public let disabledPayments: TransferFeatures
    public let disabledCards: CardFeatures
}

public struct TransferFeatures: Codable {
    public let isRequestMoneyDisabled: String
    public let isLocalTransferDisabled: String
    public let isInternationalTransferDisabled: String
    public let isQuickPayDisabled: String

    enum CodingKeys: String, CodingKey {
        case isRequestMoneyDisabled = "REQUEST_MONEY"
        case isLocalTransferDisabled = "LOCAL_TRANSFER"
        case isInternationalTransferDisabled = "INTERNATIONAL_TRANSFERS"
        case isQuickPayDisabled = "QUICKPAY"
    }
}

public struct CardFeatures: Codable {
    public let isMCDCDisabled: String
    public let prepaidAppleWalletDisabled: String
    public let prepaidOriginationDisabled: String
    public let prepaidViewDetailsDisabled: String

    enum CodingKeys: String, CodingKey {
        case isMCDCDisabled = "MCDC"
        case prepaidAppleWalletDisabled = "PREPAID_APPLE_WALLET"
        case prepaidOriginationDisabled = "PREPAID_ORIGINATION"
        case prepaidViewDetailsDisabled = "PREPAID_VIEW_DETAILS"
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/UseCase/RestrictionFeatureResponse.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/Client/NewUserRestrictionClient.swift ---
//
//  NewUserRestrictionClient.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 23/11/23.
//

import Foundation
import Resolver

public protocol NewUserRestrictionClientProtocol {
    func fetchFeaturePermissionsForNewUsers() async throws -> RestrictionFeatureResponse
}

final class NewUserRestrictionClient: BaseDBSClient, NewUserRestrictionClientProtocol {
    func fetchFeaturePermissionsForNewUsers() async throws -> RestrictionFeatureResponse {
        return try await performRequest(endpoint: Endpoint.featureFlags)
    }
}

// MARK: - Endpoint configuration
private extension NewUserRestrictionClient {
    private enum Endpoint: EndpointConfiguration {
        case featureFlags

        var path: String {
            switch self {
            case .featureFlags:  return "user-profile/feature-flags"
            }
        }

        var method: HTTPMethod { .get }
        var queryParameters: [URLQueryItem]? { nil }
        var body: Encodable? { nil }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/Client/NewUserRestrictionClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/Client/NewUserRestrictionClientFactory.swift ---
//
//  NewUserRestrictionClientFactory.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 23/11/23.
//

import Backbase
import Resolver

public enum NewUserRestrictionClientFactory {
    public static func makeClient() -> NewUserRestrictionClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("api/user-profile-manager/client-api/v2")
        return NewUserRestrictionClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/NewDeviceRegisterationManager/Client/NewUserRestrictionClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CustomToggleStyle.swift ---
//
//  CustomToggleStyle.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 23/08/24.
//

import SwiftUI

public struct CustomToggleStyle: ToggleStyle {
    public var onColor: Color
    public var offColor: Color
    public var thumbColor: Color

    public init(onColor: Color, offColor: Color, thumbColor: Color) {
        self.onColor = onColor
        self.offColor = offColor
        self.thumbColor = thumbColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .font(.body)
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CustomToggleStyle.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Background/View+withBackground.swift ---
//
//  View+withBackground.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 16/03/2023.
//

import SwiftUI
import BackbaseDesignSystem
import Resolver

public extension View {
    func withPatternBackground() -> some View {
        modifier(CardPatternBackgroundModifier())
    }

    func withPlainBackground() -> some View {
        modifier(CardPlainBackgroundModifier())
    }

    func withContainerCardView(topOffset: CGFloat = DesignSystem.shared.spacer.sm) -> some View {
        withContainerCardView {
            Color.clear
                .frame(height: topOffset)
        }
    }

    func withContainerCardView<ContentView: View>(topView: () -> ContentView, additionalTopOffset: CGFloat = 0) -> some View {
        let containerCardView = ContainerBackgroundView()
            .safeAreaInset(edge: .top, content: topView)
            .padding(.top, additionalTopOffset)
            .ignoresSafeArea(edges: .bottom)
        return modifier(CardPatternBackgroundModifier(backgroundOverlay: containerCardView))
    }
}

public struct ContainerBackgroundView: View {
    public init() {}

    public var body: some View {
        DesignSystem.shared.colors.foundation.default.color
            .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

struct CardPatternBackgroundModifier<ContentView: View>: ViewModifier {
    @Injected private var commonConfiguration: SNBCommon.Configuration
    let backgroundOverlay: ContentView

    func body(content: Content) -> some View {
        content
            .modifier(
                BackgroundImageViewModifier(
                    image: commonConfiguration.images.patternBackground.image,
                    backgroundOverlay: backgroundOverlay
                )
            )
    }
}

extension CardPatternBackgroundModifier where ContentView == EmptyView {
    init() {
        self.backgroundOverlay = EmptyView()
    }
}

struct CardPlainBackgroundModifier: ViewModifier {
    @Injected private var commonConfiguration: SNBCommon.Configuration

    func body(content: Content) -> some View {
        content
            .modifier(BackgroundImageViewModifier(image: commonConfiguration.images.gradientBackground.image))
    }
}

private struct BackgroundImageViewModifier<ContentView: View>: ViewModifier {
    let image: Image
    let backgroundOverlay: ContentView

    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    image
                        .resizable()
                        .ignoresSafeArea()

                    backgroundOverlay
                }
            }
    }
}

extension BackgroundImageViewModifier where ContentView == EmptyView {
    init(image: Image) {
        self.image = image
        self.backgroundOverlay = EmptyView()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Background/View+withBackground.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Background/View+withScrollableCardBackground.swift ---
//
//  View+withScrollableCardBackground.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 26/02/2023.
//

import SwiftUI
import BackbaseDesignSystem
import Resolver

/// Do not create own ScrollView in conjunction with `withScrollableCardBackground()` because it does it for you already.
/// Check out `withContainerCardView()` for a more customized approach.
///
/// ```
/// LazyVStack {
///     Text("Put")
///     Text("Some")
///     Text("Content")
///     Text("Here")
/// }
/// .withScrollableCardBackground(topView: {
///     Text("This will be attached above container card view and will always stick to the top, no matter the scroll position")
/// }, topPinnedContent: {
///     Text("This view will stick to the top inside of container card view")
/// })
/// ```
public extension View {
    func withScrollableCardBackground<TopPinnedContent: View>(
        @ViewBuilder topPinnedContent: @escaping () -> TopPinnedContent,
        topOffset: CGFloat = DesignSystem.shared.spacer.sm,
        topPinnedViewPadding: CGFloat = 0
    ) -> some View {
        modifier(ScrollableCardBackgroundModifier(
            topPinnedContent: topPinnedContent,
            topOffset: topOffset,
            topPinnedViewPadding: topPinnedViewPadding
        ))
    }

    func withScrollableCardBackground<TopView: View>(@ViewBuilder topView: @escaping () -> TopView) -> some View {
        modifier(ScrollableCardBackgroundModifier(topView: topView))
    }

    func withScrollableCardBackground<TopView: View, TopPinnedContent: View>(
        @ViewBuilder topView: @escaping () -> TopView,
        @ViewBuilder topPinnedContent: @escaping () -> TopPinnedContent
    ) -> some View {
        modifier(ScrollableCardBackgroundModifier(topView: topView, topPinnedContent: topPinnedContent))
    }

    func withScrollableCardBackground(topOffset: CGFloat = DesignSystem.shared.spacer.sm) -> some View {
        modifier(ScrollableCardBackgroundModifier(topOffset: topOffset))
    }
}

public struct ScrollableCardBackgroundModifier<TopPinnedContent: View, TopView: View>: ViewModifier {
    var topView: () -> TopView // Between card view and navigation bar
    var topPinnedContent: () -> TopPinnedContent // Inside card view

    @Injected private var commonConfiguration: SNBCommon.Configuration
    @State private var scrollViewOffset: CGPoint = .zero
    @State private var pinnedContentHeight: CGFloat = 0
    @State private var topViewOffset: CGFloat = 0
    private var topPinnedViewPadding: CGFloat = 0

    private var scrollViewContainerOffset: CGFloat {
        guard scrollViewOffset.y < 0 else { return 0 }
        return abs(scrollViewOffset.y)
    }

    public init(topView: @escaping () -> TopView, topPinnedContent: @escaping () -> TopPinnedContent) {
        self.topView = topView
        self.topPinnedContent = topPinnedContent
    }

    public func body(content: Content) -> some View {
        GeometryReader { proxy in
            OffsetObservingScrollView(offset: $scrollViewOffset) {
                content
                    .frame(minHeight: scrollViewContentMinHeight(container: proxy))
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: proxy.safeAreaInsets.bottom)
                    }
                    .animation(.easeOut, value: topViewOffset)
                    .animation(.easeOut, value: pinnedContentHeight)
            }
            .clipped()
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: topViewOffset + pinnedContentHeight)
            }
            .withContainerCardView(topView: {
                topView()
                    .frame(maxWidth: .infinity)
                    .background(GeometryReader { proxy in
                        Color.clear
                            .onAppear { topViewOffset = proxy.size.height }
                            .onChange(of: proxy.size.height) { topViewOffset = $0 }
                    })
            }, additionalTopOffset: scrollViewContainerOffset)
            .ignoresSafeArea(edges: .bottom)
            .overlay {
                VStack {
                    topPinnedContent()
                        .padding(.top, topPinnedViewPadding)
                        .frame(maxWidth: .infinity)
                        .background(GeometryReader { proxy in
                            ContainerBackgroundView()
                                .onAppear { pinnedContentHeight = proxy.size.height }
                                .onChange(of: proxy.size.height) { pinnedContentHeight = $0 }
                        })
                    Spacer()
                }
                .padding(.top, scrollViewContainerOffset + topViewOffset)
            }
        }
    }

    private func scrollViewContentMinHeight(container: GeometryProxy) -> CGFloat {
        container.size.height - topViewOffset - pinnedContentHeight - DesignSystem.shared.spacer.md
    }
}

public extension ScrollableCardBackgroundModifier where TopPinnedContent == EmptyView, TopView == AnyView {
    init(topOffset: CGFloat) {
        self.topPinnedContent = { EmptyView() }
        self.topView = { AnyView(Color.clear.frame(height: topOffset)) }
    }
}

public extension ScrollableCardBackgroundModifier where TopView == AnyView {
    init(
        topPinnedContent: @escaping () -> TopPinnedContent,
        topOffset: CGFloat,
        topPinnedViewPadding: CGFloat
    ) {
        self.topPinnedContent = topPinnedContent
        self.topView = { AnyView(Color.clear.frame(height: topOffset)) }
        self.topPinnedViewPadding = topPinnedViewPadding
    }
}

public extension ScrollableCardBackgroundModifier where TopPinnedContent == EmptyView {
    init(topView: @escaping () -> TopView) {
        self.topPinnedContent = { EmptyView() }
        self.topView = topView
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Background/View+withScrollableCardBackground.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/FullScreenErrorView.swift ---
//
//  FullScreenErrorView.swift
//  SNBCommon
//
//  Created by Dhaval Panchal on 13/08/24.
//

import BackbaseDesignSystem
import SNBCommon
import SwiftUI
import Resolver
import ClientCommon

public struct FullScreenErrorView: View {
    let viewModel: FullScreenErrorViewModel

    public init(viewModel: FullScreenErrorViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 24) {
            // Error Icon
            HStack(alignment: .center) {
                viewModel.iconImage?.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 144, height: 144)
            }
            // Text and description
            VStack(spacing: 8) {
                Text(viewModel.title ?? "")
                    .font(DesignSystem.shared.fonts.preferredFont(.title2, .bold).font)
                    .foregroundStyle(DesignSystem.shared.colors.text.default.color)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                Text(viewModel.description ?? "")
                    .font(DesignSystem.shared.fonts.preferredFont(.callout, .regular).font)
                    .foregroundStyle(DesignSystem.shared.colors.text.support.color)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            // Primary action button
            if let primaryButtonTitle = viewModel.primaryButtonTitle {
                Button {
                    viewModel.primaryAction?()
                } label: {
                    Text(primaryButtonTitle)
                        .font(DesignSystem.shared.fonts.preferredFont(.body, .medium).font)
                        .foregroundStyle(DesignSystem.shared.colors.text.default.color)
                }
                .buttonStyle(.primary(size: .custom(height: 56, padding: 24)))
            }
        }
        .padding([.bottom, .leading, .trailing], 24)
        .cornerRadius(24.0, corners: [.topLeft, .topRight])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

public struct FullScreenErrorViewModel {
    let iconImage: UIImage?
    let title: String?
    let description: String?
    let primaryButtonTitle: String?
    let primaryAction: (() -> Void)?

    public init(
        iconImage: UIImage?,
        title: String?,
        description: String?,
        primaryButtonTitle: String?,
        primaryAction: (() -> Void)?
    ) {
        self.iconImage = iconImage
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryAction = primaryAction
    }

    public init(with primaryAction: (() -> Void)?, error: Error? = nil) {
        let configuration = Resolver.resolve(SNBCommon.Configuration.self)
        if let error, case ClientCommon.ErrorResponse.error(_, _, let callError) = error,
           let callError = callError as? CallError, callError.isInternetConnectionError {
            iconImage = configuration.images.noInternet
            title = configuration.strings.noInternetTitle
            description = configuration.strings.noInternetSubtitle
        } else {
            iconImage = configuration.images.somethingWentWrong
            title = configuration.strings.loadingFailedTitle
            description = configuration.strings.loadingFailedSubtitle
        }
        primaryButtonTitle = configuration.strings.tryAgainButton
        self.primaryAction = primaryAction
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/FullScreenErrorView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CommonBackgroundView.swift ---
//
//  CommonBackgroundView.swift
//  SNBCommon
//
//  Created by Dhaval Panchal on 15/07/23.
//

import Foundation
import SwiftUI
import BackbaseDesignSystem

public struct CommonBackgroundView: View {

    public init(topView: any View, contentView: any View, bottomView: (any View)?) {
        self.topView = AnyView(topView)
        self.contentView = AnyView(contentView)
        if let bottomView {
            self.bottomView = AnyView(bottomView)
        }
    }

    var bottomView: AnyView?
    var topView: AnyView
    var contentView: AnyView
    var horizontalPadding: CGFloat = DesignSystem.shared.spacer.md
    var verticalPadding: CGFloat = DesignSystem.shared.spacer.sm * 3
    var topCornerRadius: CGFloat = DesignSystem.shared.cornerRadius.medium * 3

    public var body: some View {
        VStack {
            topView
            VStack {
                ScrollView {
                    contentView
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, verticalPadding)
                    Spacer()
                }
            bottomView
            }
            .background(DesignSystem.shared.colors.foundation.default.color)
            .cornerRadius(topCornerRadius, corners: [.topLeft, .topRight])
            .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
        }
        .withPatternBackground()
        .forceCorrectSementicContentAttribute()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CommonBackgroundView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/FormContentView.swift ---
//
//  FormContentView.swift
//  SNBCommon
//
//  Created by Gabriel Rodrigues Minucci on 04/04/2023.
//

import UIKit

/// Wrapper to handle form navigation using keyboard's toolbar arrows
///
/// To make it work simply build the entire navigatable form inside this view and
/// the arrows should navigate automatically.
/// It will also work when using a UIStackView directly inside it.
final public class FormContentView: UIView { }

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/FormContentView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SNBPickerView.swift ---
//
//  SNBPickerView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 14/06/2023.
//

import SwiftUI
import BackbaseDesignSystem

public struct SNBPickerView<SelectionValue: Hashable, Content: View>: View {
    private let selection: Binding<SelectionValue>
    private let content: () -> Content

    public init(selection: Binding<SelectionValue>, @ViewBuilder content: @escaping () -> Content) {
        self.selection = selection
        self.content = content
    }

    public var body: some View {
        Picker("", selection: selection, content: content)
            .pickerStyle(.segmented)
            .roundedBorder(cornerRadius: 9)
            .padding(DesignSystem.shared.spacer.md)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SNBPickerView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+roundedBorder.swift ---
//
//  View+roundedBorder.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 15/03/2023.
//

import SwiftUI
import BackbaseDesignSystem

public extension View {
    func roundedBorder(
        cornerRadius: CGFloat = DesignSystem.shared.cornerRadius.large,
        backgroundColor: Color = Color.clear,
        borderColor: Color = DesignSystem.shared.colors.inputBorder.color
    ) -> some View {
        background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(borderColor, lineWidth: 1)
            }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+roundedBorder.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputAreaView.swift ---
//
//  AmountInputAreaView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 10/03/2023.
//

import SwiftUI
import BackbaseDesignSystem
import Combine

public struct AmountInputAreaView: View {
    @StateObject private var viewModel: AmountInputAreaViewModel
    @FocusState private var isFocused: Bool

    public init(viewModel: AmountInputAreaViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    public init(
        title: String,
        initialValue: Double,
        prefilledValue: Double? = nil,
        currency: String,
        totalDueAmount: Double? = nil,
        state: CurrentValueSubject<AmountInputState, Never>,
        additionalValidations: [AmountValidation] = []
    ) {
        _viewModel = .init(wrappedValue: .init(
            title: title,
            initialValue: initialValue,
            prefilledValue: prefilledValue,
            currency: currency,
            totalDueAmount: totalDueAmount,
            state: state,
            additionalValidations: additionalValidations
        ))
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.xs + 2) {
            VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.sm) {
                Text(viewModel.title)
                    .font(.preferredFont(.body, .medium))
                    .foregroundColor(DesignSystem.shared.colors.text.default.color)
                HStack(spacing: 0) {
                    Text(viewModel.currency)
                    Spacer(minLength: DesignSystem.shared.spacer.md)
                    textField
                }
                .font(.preferredFont(.largeTitle, .medium))
                .foregroundColor(foregroundColor)
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.preferredFont(.footnote, .regular))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(4)
                        .foregroundColor(DesignSystem.shared.colors.danger.darker.color)
                        .padding(.top, 10)
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .contentViewStyle()
            .onTapGesture {
                isFocused = true
            }
            if let totalDueAmount = viewModel.formattedTotalDueAmount {
                Text(totalDueAmount)
                    .foregroundColor(DesignSystem.shared.colors.text.support.color)
                    .font(.preferredFont(.callout, .regular))
            }
        }
        .animation(.default, value: viewModel.errorMessage)
    }

    private var textField: some View {
        TextField(viewModel.placeholder, text: $viewModel.editedText)
            .multilineTextAlignment(.trailing)
            .keyboardType(.decimalPad)
            .focused($isFocused)
            .onChange(of: isFocused) {
                guard !$0 else {
                    // when text field is focused, reset formatting(e.g., remove grouping separator)
                    viewModel.resetFormattingToInput()
                    return
                }
                viewModel.applyFormattingToInput()
            }
            .onChange(of: viewModel.editedText) { [previousValue = viewModel.editedText] in
                viewModel.textDidChange(text: $0, previousValue: previousValue)
            }
    }

    private var foregroundColor: Color {
        viewModel.errorMessage == nil ? DesignSystem.shared.colors.text.default.color : DesignSystem.shared.colors.danger.darker.color
    }
}

struct AmountInputAreaView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputAreaView(
            title: "Amount",
            initialValue: 0,
            currency: "SAR",
            totalDueAmount: nil,
            state: .init(.invalid)
        )
        .padding()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputAreaView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputViewModel.swift ---
//
//  AmountInputViewModel.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 12/07/2023.
//

import BackbaseDesignSystem

open class AmountInputViewModel: ObservableObject {
    @Published var value: Double?
    @Published var editedText: String = ""
    let placeholder: String
    let currency: String

    private lazy var formatter: NumberFormatter = {
        return formatter()
    }()

    private func formatter(usesGroupingSeparator: Bool = true) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = usesGroupingSeparator
        formatter.locale = DesignSystem.Formatting.numberLocale
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.roundingMode = .halfDown
        formatter.locale = DesignSystem.Formatting.numberLocale
        return formatter
    }

    public init(prefilledValue: Double? = nil, initialValue: Double, currency: String) {
        self.value = prefilledValue
        self.placeholder = DesignSystem.shared.formatting.formatAmount(value: initialValue) ?? "-"
        self.currency = currency
        applyFormattingToInput()
    }

    func resetFormattingToInput() {
        let amount = formatter.number(from: editedText)?.stringValue
        editedText = String.sanitizeAmountForInput(amount: amount) ?? editedText
    }

    func applyFormattingToInput() {
        guard let value else { return }
        let formattedText = formatter.string(from: .init(floatLiteral: value)) ?? ""
        if placeholder != formattedText {
            editedText = formattedText
        } else {
            editedText = ""
        }
    }

    func textDidChange(text: String, previousValue: String) {
        let numericRepresentation = formatter.number(from: text)?.doubleValue
        guard numericRepresentation != value else { return }
        value = numericRepresentation

        var validatedText: String
        if let numericRepresentation {
            let formatString = formatter.string(from: .init(floatLiteral: numericRepresentation)) ?? ""
            validatedText = text.filter(formatString.contains)
        } else {
            validatedText = String(previousValue.filter(text.contains))
        }
        if validatedText.contains("."),
           let substringAfterDot = validatedText.split(separator: ".").last,
           substringAfterDot.count > 2,
           validatedText.last != "." {
            validatedText.removeLast()
        }
        editedText = validatedText
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputView.swift ---
//
//  AmountInputView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 12/07/2023.
//

import SwiftUI
import BackbaseDesignSystem

public struct AmountInputView: View {
    @StateObject private var viewModel: AmountInputViewModel
    @FocusState private var isFocused: Bool
    @State private var currencyLabelWidth: Double = 0
    @Binding private var value: Double
    private let isDisabled: Bool

    public init(initialValue: Double, currency: String, value: Binding<Double>, isDisabled: Bool) {
        self._viewModel = .init(wrappedValue: .init(prefilledValue: value.wrappedValue, initialValue: initialValue, currency: currency))
        self._value = value
        self.isDisabled = isDisabled
    }

    public var body: some View {
        textField
            .padding(DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity)
            .roundedBorder(
                cornerRadius: DesignSystem.shared.cornerRadius.medium,
                backgroundColor: backgroundColor,
                borderColor: borderColor
            )
            .onTapGesture { isFocused = true }
    }

    private var textField: some View {
        TextField("", text: $viewModel.editedText, prompt: placeholderTextView)
            .multilineTextAlignment(.trailing)
            .keyboardType(.decimalPad)
            .focused($isFocused)
            .onChange(of: isFocused) {
                guard !$0 else { return }
                viewModel.applyFormattingToInput()
            }
            .onChange(of: value) {
                if viewModel.value != value {
                    viewModel.value = $0
                    viewModel.applyFormattingToInput()
                }
            }
            .onChange(of: viewModel.editedText) { [previousValue = viewModel.editedText] in
                viewModel.textDidChange(text: $0, previousValue: previousValue)
                value = viewModel.value ?? 0
            }
            .padding(.trailing, DesignSystem.shared.spacer.xs + currencyLabelWidth)
            .overlay {
                HStack {
                    Spacer()
                    Text(viewModel.currency)
                        .background(GeometryReader { proxy in
                            Color.clear.onAppear {
                                currencyLabelWidth = proxy.size.width
                            }
                        })
                }
            }
            .font(.preferredFont(.body, .regular))
            .foregroundColor(foregroundColor)
            .disabled(isDisabled)
    }

    private var placeholderTextView: Text {
        Text(viewModel.placeholder)
            .font(.preferredFont(.body, .regular))
            .foregroundColor(foregroundColor)
    }

    private var backgroundColor: Color {
        if isDisabled {
            return DesignSystem.shared.colors.neutrals.neutral10.color
        }
        return DesignSystem.shared.colors.neutrals.neutral00.color
    }

    private var foregroundColor: Color {
        if isDisabled {
            return DesignSystem.shared.colors.neutrals.neutral40.color
        }
        return DesignSystem.shared.colors.text.support.color
    }

    private var borderColor: Color {
        if isDisabled {
            return DesignSystem.shared.colors.neutrals.neutral40.color
        }
        return DesignSystem.shared.colors.inputBorder.color
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView(
            initialValue: 0,
            currency: "SAR",
            value: .constant(0),
            isDisabled: false
        )
        .padding()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputAreaViewModel.swift ---
//
//  AmountInputAreaViewModel.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 01/05/2023.
//

import Combine
import BackbaseDesignSystem
import Resolver

public enum AmountInputState: Equatable {
    case valid(Double)
    case invalid
}

public protocol AmountValidation {
    func validate(amount: Double) -> String?
}

public final class AmountInputAreaViewModel: AmountInputViewModel {
    let title: String
    @Published public var errorMessage: String?

    var formattedTotalDueAmount: String? {
        guard let totalDueAmount, totalDueAmount > 0 else { return nil }
        let formattedAmount = DesignSystem.shared.formatting.formatAmount(value: totalDueAmount) ?? "-"
        return "\(configuration.strings.editAmountTotalDue) \(formattedAmount) \(currency)"
    }

    private let totalDueAmount: Double?
    private let state: CurrentValueSubject<AmountInputState, Never>
    private var additionalValidations: [AmountValidation]

    @Injected private var configuration: SNBCommon.Configuration
    var cancellables = Set<AnyCancellable>()

    public init(
        title: String,
        initialValue: Double,
        prefilledValue: Double? = nil,
        currency: String,
        totalDueAmount: Double? = nil,
        state: CurrentValueSubject<AmountInputState, Never>,
        additionalValidations: [AmountValidation] = []
    ) {
        self.title = title
        self.totalDueAmount = totalDueAmount
        self.state = state
        self.additionalValidations = additionalValidations
        super.init(
            prefilledValue: prefilledValue,
            initialValue: initialValue,
            currency: currency
        )

        Publishers.CombineLatest(
            $value.removeDuplicates(),
            $editedText.removeDuplicates()
        )
        .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
        .sink { [weak self] value, text in
            self?.validate(amount: value, text: text)
        }
        .store(in: &cancellables)
    }

    public func update(amount: Double) {
        value = amount
        applyFormattingToInput()
    }

    public func update(additionalValidations: [AmountValidation]) {
        self.additionalValidations = additionalValidations
        validate(amount: value, text: editedText)
    }

    private func validate(amount: Double?, text: String) {
        defer { updateState() }
        guard !text.isEmpty else {
            return errorMessage = nil
        }
        guard let amount else {
            return errorMessage = configuration.strings.amountInvalidError
        }
        if amount < 0 {
            errorMessage = configuration.strings.amountNegativeError
        } else if amount == 0 {
            errorMessage = configuration.strings.amountZeroError
        } else {
            errorMessage = nil
        }
        additionalValidations.forEach {
            guard let error = $0.validate(amount: amount) else { return }
            errorMessage = error
        }
    }

    private func updateState() {
        if let value, errorMessage == nil {
            state.send(.valid(value))
        } else {
            state.send(.invalid)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/AmountInputAreaViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/BackbaseDesignSystem+formatAmount.swift ---
//
//  BackbaseDesignSystem+formatAmount.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 17/03/2023.
//

import BackbaseDesignSystem

extension BackbaseDesignSystem.DesignSystem.Formatting {
    public func formatAmount(value: Double) -> String? {
        let options = DesignSystem.Formatting.Options(
            locale: Self.numberLocale,
            formattingStyle: .decimal,
            roundingMode: .halfUp
        )
        return amountFormatter.format(
            amount: .init(value),
            options: options
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AmountInputAreaView/BackbaseDesignSystem+formatAmount.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/Referral.swift ---
//
//  Referral.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import UIKit

public struct Referral {
    public static func build(referral: ReferralModel, shareLink: URL, navigationController: UINavigationController) -> UIViewController {
        let viewModel = ReferralViewModel(with: referral, shareLink: shareLink)
        let viewController = ReferralViewController(viewModel: viewModel)
        return viewController
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/Referral.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralImages.swift ---
//
//  ReferralImages.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import UIKit

extension Referral.Configuration {
    public struct Images {
        public let backgroundImage = UIImage(named: "background-image")
        public let messageIcon = UIImage(named: "refer-icon")
        public let shareIcon = UIImage.named("share-icon", in: .snbCommon)
        public let closeIcon = UIImage.named("close", in: .snbCommon)?.withTintColor(.white)
        public let activityIcon = UIImage(named: "welcomeActivityIcon")
        public var neoIcon = UIImage.named("neo_icon", in: .snbCommon)!
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralImages.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralStrings.swift ---
//
//  ReferralStrings.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

extension Referral.Configuration {
    public struct Strings {
        @Localizable public var title = "referral.header.title"
        @Localizable public var message = "referral.header.message"
        @Localizable public var shareMessage = "loyalty.referral.message"
        @Localizable public var instructionTitle = "referral.instruction.label.title"
        @Localizable public var instructions = "referral.label.instructions"
        @Localizable public var invite = "referral.button.label.title"
        @Localizable public var activityTitle = "marketplace.shareActivity.title"
        @Localizable public var activitySubtitle = "marketplace.shareActivity.subtitle"
        @Localizable public var subjectLine = "loyalty.referral.subjectLine"
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralStrings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralDesign.swift ---
//
//  ReferralDesign.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import UIKit
import BackbaseDesignSystem

extension Referral.Configuration {
    public struct Designs {
        public let titleLabel: Style<UILabel> = { label in
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = ColorConstant.hexColorFEFEFE
            label.font = DesignSystem.shared.fonts.preferredFont(.title1, .medium)
        }

        public let subtitleLabel: Style<UILabel> = { label in
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = ColorConstant.hexColorFEFEFE
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
        }

        public let instructionTitleLabel: Style<UILabel> = { label in
            label.numberOfLines = 0
            label.textColor = ColorConstant.hexColorFEFEFE
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .medium)
        }

        public let instructionsLabel: Style<UILabel> = { label in
            label.numberOfLines = 0
            label.textColor = ColorConstant.hexColorFEFEFE
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
        }

        public let inviteButtonStyle: Style<Button> = { button in
            DesignSystem.shared.styles.primaryButton(button)
            button.tintColor = button.currentTitleColor
        }
    }
}

public extension Referral.Configuration.Designs {
    public struct ColorConstant {
        public static let hexColorFEFEFE = UIColor(hex: "FEFEFE")
        public static let hexColor0E1E21 = UIColor(hex: "0E1E21")
        public static let hexColor7DF5FA = UIColor(hex: "7DF5FA")
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralDesign.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/Models/ReferralModel.swift ---
//
//  ReferralModel.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import Foundation
import LinkPresentation
import Resolver

public struct ReferralModel: Decodable {
    public let referralCode: String
    public let mcdcPoints: Int
    public let title: String
    public let message: String

    public init(referralCode: String, mcdcPoints: Int, title: String, message: String) {
        self.referralCode = referralCode
        self.mcdcPoints = mcdcPoints
        self.title = title
        self.message = message
    }
}

public class ReferralActivityItemSource: NSObject, UIActivityItemSource {
    @LazyInjected public static var configuration: Referral.Configuration

    var icon: UIImage?
    var title: String
    var subtitle: String
    var subjectLine: String?
    var activityData: String

    public init(
        icon: UIImage? = configuration.images.activityIcon,
        title: String = configuration.strings.activityTitle,
        subtitle: String = configuration.strings.activitySubtitle,
        subjectLine: String? = nil,
        activityData: String
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.subjectLine = subjectLine
        self.activityData = activityData
        super.init()
    }

    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        subtitle
    }

    public func activityViewController(_ activityViewController: UIActivityViewController,
                                itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        activityData
    }

    public func activityViewController(_ activityViewController: UIActivityViewController,
                                subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        if activityType == .mail, let subjectLine {
            return subjectLine
        }
        return title
    }

    public func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        if let image = icon {
            metadata.iconProvider = NSItemProvider(object: image)
        }
        metadata.originalURL = URL(fileURLWithPath: subtitle)
        return metadata
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/Models/ReferralModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralConfiguration.swift ---
//
//  ReferralConfiguration.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import Foundation

extension Referral {
    public struct Configuration {
        public let designs = Designs()
        public let strings = Strings()
        public let images = Images()

        public init() {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralViewModel.swift ---
//
//  ReferralViewModel.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import UIKit
import Resolver
import CoreImage.CIFilterBuiltins

public final class ReferralViewModel {
    @LazyInjected private var referralUseCase: ReferralUseCaseProtocol
    @LazyInjected private var configuration: Referral.Configuration
    let referral: ReferralModel
    let shareLink: URL
    @Published var isLoading: Bool = false

    public init(with referral: ReferralModel, shareLink: URL) {
        self.referral = referral
        self.shareLink = shareLink
    }

    func presentReferralShare(from viewController: UIViewController) {
        Task {
            let shareMessage = """
            \(configuration.strings.shareMessage)

            \(shareLink.absoluteString)
            """

            await MainActor.run {
                let source = ReferralActivityItemSource(subjectLine: configuration.strings.subjectLine, activityData: shareMessage)
                let shareActivity = UIActivityViewController(
                    activityItems: [source] as [Any],
                    applicationActivities: nil)
                shareActivity.completionWithItemsHandler = { _, status, _, _ in
                    guard status else {
                        return
                    }
                    viewController.dismiss(animated: true)
                }
                viewController.present(shareActivity, animated: true)
            }
        }
    }

    func makeReferralInstructions(font: UIFont) -> NSAttributedString {
        let instructionSteps = configuration.strings.instructions.components(separatedBy: "\n")
        let baseAttributes = [NSAttributedString.Key.font: font]
        let isRTL = LocaleSelector.shared.isArabic
        let indentation: CGFloat = 20

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: isRTL ? .right : .left, location: indentation, options: [:])]
        paragraphStyle.paragraphSpacing = 4
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = 1
        paragraphStyle.headIndent = indentation

        let resultString = NSMutableAttributedString()
        for (index, instruction) in instructionSteps.enumerated() {
            let indexedInstruction = "\(instruction)\n"
            let attributedString = NSMutableAttributedString(string: indexedInstruction)
            let fullRange = NSRange(location: 0, length: attributedString.length)

            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
            attributedString.addAttribute(.font, value: font, range: fullRange)
            resultString.append(attributedString)
        }
        return resultString
    }

    func generateQRCode() -> UIImage? {
        guard let scaledQRCode = createScaledQRCode(from: shareLink.absoluteString) else { return nil }
        guard let coloredQRCode = applyColors(to: scaledQRCode) else { return nil }
        guard let borderedQRCode = addBorderAndRoundedCorners(to: coloredQRCode, borderWidth: 20, cornerRadius: 32) else { return nil }
        return overlayLogo(on: borderedQRCode)
    }

    private func createScaledQRCode(from string: String) -> CIImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(Data(string.utf8), forKey: "inputMessage")
        return filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
    }

    private func applyColors(to qrCode: CIImage) -> UIImage? {
        let filter = CIFilter.falseColor()
        filter.inputImage = qrCode
        filter.color0 = CIColor(color: UIColor(hex: "#12393B"))
        filter.color1 = CIColor(color: .white)
        guard let img = filter.outputImage else { return nil }
        return UIImage(ciImage: img)
    }

    private func addBorderAndRoundedCorners(to image: UIImage, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIImage? {
        let newSize = CGSize(width: image.size.width + 2 * borderWidth, height: image.size.height + 2 * borderWidth)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        defer { UIGraphicsEndImageContext() }

        let rect = CGRect(origin: .zero, size: newSize)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        UIColor.white.setFill()
        UIRectFill(rect)
        image.draw(in: rect.insetBy(dx: borderWidth, dy: borderWidth))

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    private func overlayLogo(on qrCode: UIImage) -> UIImage? {
        let logo = configuration.images.neoIcon
        let logoSize = CGSize(width: qrCode.size.width * 0.3, height: qrCode.size.height * 0.3)
        let logoOrigin = CGPoint(
            x: (qrCode.size.width - logoSize.width) / 2,
            y: (qrCode.size.height - logoSize.height) / 2
        )

        UIGraphicsBeginImageContextWithOptions(qrCode.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        qrCode.draw(in: CGRect(origin: .zero, size: qrCode.size))
        logo.draw(in: CGRect(origin: logoOrigin, size: logoSize))

        return UIGraphicsGetImageFromCurrentImageContext()
    }

}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralUseCase/ReferralClient.swift ---
//
//  ReferralClient.swift
//  RetailApp
//
//  Created by Amjad Khan on 10/09/23.
//

import Backbase
import ClientCommon
import Resolver

public protocol ReferralClientProtocol {
    func fetchReferralDetails() async throws -> ReferralModel
}

final class ReferralClient: NSObject, DBSClient, ReferralClientProtocol {
    var dataProvider: DBSDataProvider?
    var baseURL: URL

    @available(*, unavailable)
    override init() {
        fatalError("init() not implemented")
    }

    init(baseURL: URL, dataProvider: DBSDataProvider? = Resolver.optional(DBSDataProvider.self)) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }

    func fetchReferralDetails() async throws -> ReferralModel {
        guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }

        let configuration = ReferralClient.Endpoint.fetchDetails
        let request = try RequestBuilder.makeRequest(baseURL: baseURL, configuration: configuration)
        let call = Call<ReferralModel>(dataProvider: dataProvider, request: request)
        let callResponse = try await call.execute()

        guard let responseBody = callResponse.body else { throw CallError.emptyDataResponse }

        return responseBody
    }
}

// MARK: - Endpoint configuration

private extension ReferralClient {

    enum Endpoint: EndpointConfiguration {
        case fetchDetails

        var path: String { "loyalty/referralDetails" }

        var method: HTTPMethod { .get }

        var queryParameters: [URLQueryItem]? {
            return nil
        }

        var body: Encodable? { nil }
    }
}

// MARK: - Client Factory

public enum ReferralClientFactory {
    public static func makeClient() -> ReferralClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("api/loyalty-integration-service/client-api/v1/")
        return ReferralClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralUseCase/ReferralClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralUseCase/ReferralUseCase.swift ---
//
//  ReferralUseCase.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import Backbase
import Resolver
import ClientCommon

public protocol ReferralUseCaseProtocol {
    func fetchReferralDetails() async throws -> ReferralModel
    func generateReferralLink(with referral: ReferralModel) async throws -> URL
}

public protocol ReferralLinkBuildable {
    func generateReferralLink(with referral: ReferralModel) async throws -> URL
}

public final class ReferralUseCase: ReferralUseCaseProtocol {
    private let client: ReferralClientProtocol
    private let linkBuilder: ReferralLinkBuildable

    public init(
        client: ReferralClientProtocol = ReferralClientFactory.makeClient(),
        linkBuilder: ReferralLinkBuildable = Resolver.resolve(ReferralLinkBuildable.self)
    ) {
        self.client = client
        self.linkBuilder = linkBuilder
    }

    public func fetchReferralDetails() async throws -> ReferralModel {
        return try await client.fetchReferralDetails()
    }

    public func generateReferralLink(with referral: ReferralModel) async throws -> URL {
        return try await linkBuilder.generateReferralLink(with: referral)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralUseCase/ReferralUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/SharingView.swift ---
//
//  SharingView.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 07/05/24.
//

import Foundation
import BackbaseDesignSystem
import SNBCommon
import Resolver

final class SharingView: UIView {
    private let code: String
    private let sharingCallback: ((String) -> Void)?
    @Injected private var configuration: SNBCommon.Configuration

    var shareIcon: UIImage? {
        return UIImage.named("share-icon", in: .snbCommon)?.withRenderingMode(.alwaysTemplate)
    }

    var copyIcon: UIImage? {
        return UIImage.named("contentcopy", in: .snbCommon)
    }

    init(code: String, share: ((String) -> Void)? = nil) {
        self.code = code
        self.sharingCallback = share

        super.init(frame: .zero)
        self.addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) lazy var viewTitle: UILabel = {
        let view = UILabel()
        view.font = DesignSystem.shared.fonts.preferredFont(.callout, .regular)
        view.textColor = UIColor(hex: "#FEFEFE")
        view.text = configuration.strings.referralCodeTitle
        return view
    }()

    private(set) lazy var codeLabel: UILabel = {
        let view = UILabel()
        view.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .regular)
        view.textColor = DesignSystem.shared.colors.secondary.default
        view.text = code
        return view
    }()

    private(set) lazy var copyImage: UIImageView = {
        let view = UIImageView()
        view.image = copyIcon
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onCopyTap))
        view.addGestureRecognizer(tap)
        return view
    }()

    private(set) lazy var shareButton: UIButton = {
        let view = Button(type: .custom)
        view.tintColor = DesignSystem.shared.colors.primary.default 
        view.contentMode = .center
        view.setImage(shareIcon, for: .normal)
        view.addTarget(self, action: #selector(onShareTap), for: .touchUpInside)
        return view
    }()

    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#B8E7EA")
        view.layer.cornerRadius = DesignSystem.shared.cornerRadius.medium
        return view
    }()

    private func addSubviews() {
        addSubview(viewTitle)
        addSubview(container)
        container.addSubview(codeLabel)
        container.addSubview(copyImage)

        viewTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }

        addSubview(shareButton)

        shareButton.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.top.equalTo(viewTitle.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(viewTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(48)
            $0.trailing.equalTo(shareButton.snp.leading)
        }

        codeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(copyImage.snp.leading).inset(DesignSystem.shared.spacer.md)
        }

        copyImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }

    @objc private func onCopyTap() {
        UIPasteboard.general.string = code
        self.displayToast(configuration.strings.copytoCliped, with: 1)
    }

    @objc private func onShareTap() {
        sharingCallback?(code)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/SharingView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralViewController.swift ---
//
//  ReferralViewController.swift
//  RetailApp
//
//  Created by Amjad Khan on 04/09/23.
//

import BackbaseDesignSystem
import Combine
import Resolver
import UIKit

public final class ReferralViewController: UIViewController {

    private let viewModel: ReferralViewModel

    @LazyInjected
    private var configuration: Referral.Configuration

    private var cancellables = Set<AnyCancellable>()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        return view
    }()

    private lazy var detailStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let backgroungImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        configuration.designs.titleLabel(view)
        return view
    }()

    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        configuration.designs.subtitleLabel(view)
        return view
    }()

    private lazy var messageIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var instructionsTitleLabel: UILabel = {
        let view = UILabel()
        configuration.designs.instructionTitleLabel(view)
        return view
    }()

    private lazy var instructionsLabel: UILabel = {
        let view = UILabel()
        configuration.designs.instructionsLabel(view)
        return view
    }()

    private(set) lazy var inviteButton: Button = {
        let view = Button()
        configuration.designs.inviteButtonStyle(view)
        view.setImage(configuration.images.shareIcon?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.setTitle(configuration.strings.invite, for: .normal)
        view.addTarget(self, action: #selector(inviteButtonPressed), for: .touchUpInside)
        return view
    }()

    public init(viewModel: ReferralViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        title = nil
        setupView()
        setupNavBar()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        bindSubscriptions()
    }

    private func bindSubscriptions() {
        viewModel.$isLoading.receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.inviteButton.startLoading()
                } else {
                    self?.inviteButton.stopLoading()
                }
            }
            .store(in: &cancellables)
    }

    @objc
    private func inviteButtonPressed(_ sender: UIButton) {
        viewModel.presentReferralShare(from: self)
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = closeBarButtonItem(image: configuration.images.closeIcon)
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.shared.colors.neutrals.neutral00
    }

    private func setupView() {
        view.addSubview(backgroungImageView)
        backgroungImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(inviteButton)
        inviteButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(9)
            $0.height.equalTo(56)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(68)
            $0.bottom.equalTo(inviteButton.snp.top).offset(-36)
        }

        scrollView.addSubview(detailStack)
        detailStack.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }

        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview()
        }

        container.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        container.addSubview(messageIcon)
        messageIcon.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }

        container.addSubview(instructionsTitleLabel)
        instructionsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(messageIcon.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        container.addSubview(instructionsLabel)
        instructionsLabel.snp.makeConstraints {
            $0.top.equalTo(instructionsTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview()
        }
        detailStack.addArrangedSubview(container)
        let sharingView = SharingView(code: viewModel.referral.referralCode) { [weak self] code in
            let source = ReferralActivityItemSource(activityData: code)
            let activity = UIActivityViewController(activityItems: [source], applicationActivities: nil)
            activity.popoverPresentationController?.sourceView = self?.view
            activity.completionWithItemsHandler = { [weak self] _, status, _, _ in
                guard status else {
                    return
                }
                self?.dismiss(animated: true)
            }
            self?.present(activity, animated: true)
        }
        detailStack.addArrangedSubview(sharingView)

        backgroungImageView.image = configuration.images.backgroundImage
        messageIcon.image = viewModel.generateQRCode() ?? configuration.images.messageIcon
        titleLabel.text = configuration.strings.title
        subtitleLabel.text = configuration.strings.message
        instructionsTitleLabel.text = configuration.strings.instructionTitle
        instructionsLabel.attributedText = viewModel.makeReferralInstructions(font: instructionsLabel.font)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Referral/ReferralViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Alert.swift ---
//
//  Alert.swift
//  RetailApp
//
//  Created by Dhaval Panchal on 29/12/22.
//

import UIKit

public struct Alert: Equatable {
    let title: String
    let message: String?
    let actions: [Action]
    let style: Style

    public init(title: String, message: String? = nil, actions: [Alert.Action], style: Alert.Style) {
        self.title = title
        self.message = message
        self.actions = actions
        self.style = style
    }

    public enum Style: Equatable {
        case alert
        case actionSheet
    }

    public struct Action: Equatable {
        public enum Style: Equatable {
            case defaultStyle
            case cancel
            case destructive
        }

        let title: String
        let style: Style
        let action: () -> Void

        public init(title: String, style: Style, action: @escaping () -> Void) {
            self.title = title
            self.style = style
            self.action = action
        }

        public static func == (lhs: Alert.Action, rhs: Alert.Action) -> Bool {
            lhs.title == rhs.title && lhs.style == rhs.style
        }
    }
}

public extension UIViewController {
    func showAlert(_ alert: Alert, animated: Bool = true) {
        let style: UIAlertController.Style
        switch alert.style {
        case .alert:
            style = .alert
        case .actionSheet:
            style = .actionSheet
        }
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: style)
        for action in alert.actions {
            let style: UIAlertAction.Style
            switch action.style {
            case .defaultStyle:
                style = .default
            case .cancel:
                style = .cancel
            case .destructive:
                style = .destructive
            }
            let uiAction = UIAlertAction(title: action.title, style: style) { _ in
                action.action()
            }
            alertController.addAction(uiAction)
        }
        present(alertController, animated: animated)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Alert.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AutomaticHeightTableView.swift ---
//
//  AutomaticHeightTableView.swift
//  SNBCommon
//
//  Created by Grzegorz Pawłowicz on 02/08/2023.
//

import UIKit

public final class AutomaticHeightTableView: UITableView {

    public override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    public override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()

        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AutomaticHeightTableView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/ViewModels/PendingApplicationScreenViewModel.swift ---
//
//  PendingApplicationViewModel.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

import Resolver

final class PendingApplicationScreenViewModel {

    var pendingApplicationModel: PendingApplicationModel
    private var configuration: PendingApplicationScreen.Configuration

    var isReferenceNumberAvailable: Bool {
        return pendingApplicationModel.referenceCode != nil
    }

    init(
        with model: PendingApplicationModel,
        configuration: PendingApplicationScreen.Configuration
    ) {
        pendingApplicationModel = model
        self.configuration = configuration
    }

    public func prepareSubtitle() -> String {
        let maskedPhoneNumber = mask(
            phone: String(pendingApplicationModel.phoneNumber.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).replacingOccurrences(of: " ", with: "").dropFirst())
        )

        return String(format: configuration.strings.subtitle, maskedPhoneNumber)
    }

    private func mask(phone: String, startLimit: Int = 3, endLimit: Int = 3, maskCharacter: Character = "*") -> String {
        let maskedString = String(
            repeating: maskCharacter,
            count: max(0, phone.count - (startLimit + endLimit))
        )

        if LocaleSelector.shared.isArabic {
            return String(phone.suffix(endLimit)) + maskedString + String(phone.prefix(startLimit))
        } else {
            return String(phone.prefix(startLimit)) + maskedString + String(phone.suffix(endLimit))
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/ViewModels/PendingApplicationScreenViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenStrings.swift ---
//
//  PendingApplicationStrings.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

import SNBCommon

extension PendingApplicationScreen {

    struct Strings {

        @Localizable var title = "pendingApplication.title"
        @Localizable var subtitle = "pendingApplication.subtitle"
        @Localizable var applicationDetailsTitle = "pendingApplication.applicationDetails.title"
        @Localizable var referenceNumberTitle = "pendingApplication.referenceNumber.title"

        @Localizable(in: .snbCommon) public var copytoCliped = "common.copiedtoclipboard"
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenStrings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreen.swift ---
//
//  PendingApplication.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

import UIKit

public struct PendingApplicationScreen {
    public static func build(pendingApplication: PendingApplicationModel) -> UIViewController {
        let configuration = PendingApplicationScreen.Configuration()
        let viewModel = PendingApplicationScreenViewModel(
            with: pendingApplication,
            configuration: configuration
        )
        let viewController = PendingApplicationViewController(
            viewModel: viewModel,
            configuration: configuration
        )

        viewController.title = pendingApplication.title
        let sheetPresentationController = viewController.sheetPresentationController
        if #available(iOS 16.0, *) {
            sheetPresentationController?.detents = [.custom(resolver: { $0.maximumDetentValue * 0.8 })]
        } else {
            sheetPresentationController?.detents = [.medium()]
        }
        sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController?.prefersEdgeAttachedInCompactHeight = true
        sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 24.0

        return viewController
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreen.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenConstants.swift ---
//
//  PendingApplicationConstants.swift
//  SNBCommon
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

extension PendingApplicationScreen {

    struct Constants {

        let pendingIconWidth = 112.0
        let pendingIconHeight = 112.0
        let copyIconWidth = 24.0
        let copyIconHeight = 24.0
        let pendingIconTopPadding = 56.0
        let referenceNumberContainerHeight = 75.0
        let callCentreButtonHeight = 56.0
        let callCenterNumber = "920005455"
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenConstants.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenDesign.swift ---
//
//  PendingApplicationDesign.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

import UIKit
import BackbaseDesignSystem

extension PendingApplicationScreen {

    struct Designs {
        public var iconStyle: Style<UIImageView> = { imageView in
            imageView.contentMode = .scaleAspectFit
        }

        public var titleLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.largeTitle, .bold)
            label.textColor = DesignSystem.shared.colors.text.default
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
        }

        public var subtitleLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            label.textColor = DesignSystem.shared.colors.text.support
            label.numberOfLines = 0
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
        }

        public var applicationDetailsLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .medium)
            label.textColor = DesignSystem.shared.colors.text.default
        }

        public var referenceNumberContainerStyle: Style<UIView> = { view in
            view.backgroundColor = DesignSystem.shared.colors.foundation.default
            view.clipsToBounds = true
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 16.0
            view.layer.borderColor = DesignSystem.shared.colors.neutrals.neutral20.cgColor
        }

        public var referenceNumberTitleLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.callout, .medium)
            label.textColor = DesignSystem.shared.colors.text.default
        }

        public var referenceNumberLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
            label.textColor = DesignSystem.shared.colors.text.support
        }

        public var copyImageViewStyle: Style<UIImageView> = { imageView in
            imageView.isUserInteractionEnabled = true
        }

        public var callCentreButtonStyle: Style<Button> = { button in
            DesignSystem.shared.styles.primaryButton(button)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenDesign.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenConfiguration.swift ---
//
//  PendingApplicationConfiguration.swift
//  SNBCommon
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

extension PendingApplicationScreen {

    struct Configuration {

        let designs = Designs()
        let images = Images()
        let strings = Strings()
        let constants = Constants()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenImages.swift ---
//
//  PendingApplicationImages.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

extension PendingApplicationScreen {

    struct Images {

        let icon: UIImage? = .named("teaser-success")
        let contentCopy: UIImage? = .named("contentcopy", in: .snbCommon)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Configuration/PendingApplicationScreenImages.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Models/PendingApplicationModel.swift ---
//
//  PendingApplicationModel.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

public struct PendingApplicationModel {
    let phoneNumber: String
    let referenceCode: String?
    let title: String?

    public init(phoneNumber: String, 
                referenceCode: String?,
                title: String? = nil
    ) {
        self.phoneNumber = phoneNumber
        self.referenceCode = referenceCode
        self.title = title
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Models/PendingApplicationModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Screens/PendingApplicationViewController.swift ---
//
//  PendingApplicationViewController.swift
//  BusinessOnboardingJourney
//
//  Created by Ramazan Abdullayev on 03/06/2024.
//

import UIKit
import Resolver
import SNBCommon
import BackbaseDesignSystem

final class PendingApplicationViewController: UIViewController {

    private let viewModel: PendingApplicationScreenViewModel
    private let configuration: PendingApplicationScreen.Configuration

    private lazy var iconImageView = configure(UIImageView()) {
        configuration.designs.iconStyle($0)
        $0.image = configuration.images.icon
    }

    private lazy var titleLabel = configure(UILabel()) {
        configuration.designs.titleLabelStyle($0)
        $0.text = configuration.strings.title
    }

    private lazy var subtitleLabel = configure(UILabel()) {
        configuration.designs.subtitleLabelStyle($0)
        $0.text = viewModel.prepareSubtitle()
    }

    private lazy var applicationDetailsLabel = configure(UILabel()) {
        configuration.designs.applicationDetailsLabelStyle($0)
        $0.text = configuration.strings.applicationDetailsTitle
    }

    private lazy var referenceNumberContainerView = configure(UIView()) {
        configuration.designs.referenceNumberContainerStyle($0)
    }

    private lazy var referenceNumberTitleLabel = configure(UILabel()) {
        configuration.designs.referenceNumberTitleLabelStyle($0)
        $0.text = configuration.strings.referenceNumberTitle
    }

    private lazy var referenceNumberLabel = configure(UILabel()) {
        configuration.designs.referenceNumberLabelStyle($0)
        $0.text = viewModel.pendingApplicationModel.referenceCode
    }

    private lazy var copyImageView = configure(UIImageView()) {
        configuration.designs.copyImageViewStyle($0)
        $0.image = configuration.images.contentCopy
        $0.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(copyButtonTapped))
        )
    }

    public init(
        viewModel: PendingApplicationScreenViewModel,
        configuration: PendingApplicationScreen.Configuration
    ) {
        self.viewModel = viewModel
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        addSubviews()
        setupUI()
    }

    private func addSubviews() {
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(applicationDetailsLabel)

        view.addSubview(referenceNumberContainerView)
        referenceNumberContainerView.addSubview(referenceNumberTitleLabel)
        referenceNumberContainerView.addSubview(referenceNumberLabel)
        referenceNumberContainerView.addSubview(copyImageView)
    }

    private func setupUI() {
        let spacers = DesignSystem.shared.spacer
        view.backgroundColor = DesignSystem.shared.colors.foundation.default

        iconImageView.snp.makeConstraints {
            $0.top.equalTo(configuration.constants.pendingIconTopPadding)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(configuration.constants.pendingIconWidth)
            $0.height.equalTo(configuration.constants.pendingIconHeight)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(spacers.lg)
            $0.leading.trailing.equalToSuperview().inset(spacers.md)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(spacers.md)
            $0.leading.trailing.equalToSuperview().inset(spacers.md)
        }

        if viewModel.isReferenceNumberAvailable {
            applicationDetailsLabel.snp.makeConstraints {
                $0.top.equalTo(subtitleLabel.snp.bottom).offset(spacers.lg - spacers.sm)
                $0.leading.equalToSuperview().inset(spacers.md)
            }

            referenceNumberContainerView.snp.makeConstraints {
                $0.top.equalTo(applicationDetailsLabel.snp.bottom).offset(spacers.sm)
                $0.leading.trailing.equalToSuperview().inset(spacers.md)
                $0.height.equalTo(configuration.constants.referenceNumberContainerHeight)
            }

            referenceNumberTitleLabel.snp.makeConstraints {
                $0.top.leading.equalToSuperview().inset(spacers.md)
            }

            referenceNumberLabel.snp.makeConstraints {
                $0.top.equalTo(referenceNumberTitleLabel.snp.bottom).offset(spacers.sm)
                $0.leading.equalToSuperview().inset(spacers.md)
            }

            copyImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(spacers.md)
                $0.width.equalTo(configuration.constants.copyIconWidth)
                $0.height.equalTo(configuration.constants.copyIconHeight)
            }
        }
    }

    @objc
    private func copyButtonTapped(_ sender: Button) {
        UIPasteboard.general.string = viewModel.pendingApplicationModel.referenceCode
        view.displayToast(configuration.strings.copytoCliped, with: 1)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/PendingApplicationScreen/Screens/PendingApplicationViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/BadgeView.swift ---
//
//  BadgeView.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 21/08/24.
//

import Foundation
import UIKit
import BackbaseDesignSystem
import SwiftUI

public class BadgeView: UIView {
    public enum Style {
        case small
        case large
        case custom(size: CGFloat, top: CGFloat, leading: CGFloat)
    }

    internal var max: Int = 99
    public var count: Int = 0 {
        didSet {
            refreshViews()
        }
    }
    public var style: Style = .large {
        didSet {
            setUpViews()
        }
    }

    private let label = UILabel()
    private var leadingConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?

    private var hasMaxBeenReached: Bool { count > max }
    private var badgeSize: CGFloat {
        switch style {
        case .small: return 8
        case .large: return 18
        case .custom: return 19
        }
    }
    private var leadingConstraintConstant: CGFloat {
        switch style {
        case .small:
            return -8
        case .large:
            return hasMaxBeenReached ? -12 : -8
        case .custom(let s, let top, let leading):
            return hasMaxBeenReached ? -(leading + 4) : -leading
        }
    }

    private var topConstraintConstant: CGFloat {
        switch style {
        case .small:
            return -2
        case .large:
            return -6
        case .custom(let s, let top, let leading):
            return -top
        }
    }

    public init(style: Style = .large) {
        super.init(frame: .zero)
        self.style = style
        setUpViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    // MARK: - Private

    private func setUpViews() {
        label.removeFromSuperview()

        // Check if Height & Width constaints needs to be added or disabled
        if heightConstraint == nil {
            heightConstraint = heightAnchor.constraint(equalToConstant: badgeSize)
        } else { heightConstraint?.isActive = false }

        if widthConstraint == nil {
            widthConstraint = widthAnchor.constraint(equalToConstant: badgeSize)
        } else { widthConstraint?.isActive = false }

        switch style {
        case .large: setUpLargeBadgeViews()
        case .small: setUpSmallBadgeViews()
        case .custom: setUpLargeBadgeViews()
        }

        isUserInteractionEnabled = false
        backgroundColor = DesignSystem.shared.colors.danger.default
        layer.cornerRadius = badgeSize / 2

        refreshViews()
    }

    private func setUpLargeBadgeViews() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false

        heightConstraint?.constant = badgeSize
        heightConstraint?.isActive = true
        widthConstraint?.constant = badgeSize
        widthConstraint?.isActive = true

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        label.textColor = .white
        label.font = DesignSystem.shared.fonts.preferredFont(.caption2, .regular)
    }

    private func setUpSmallBadgeViews() {
        [widthConstraint, heightConstraint].forEach {
            $0?.constant = badgeSize
            $0?.isActive = true
        }
    }

    public func pinToSuperviewTopRight() {
        guard let superview = superview, leadingConstraint == nil else { return }

        let leadingConstraint = leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: leadingConstraintConstant)
        self.leadingConstraint = leadingConstraint

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstraintConstant),
            leadingConstraint
        ])
    }

    private func refreshViews() {
        let isHidden = count <= 0
        label.text = hasMaxBeenReached ? "\(max)+" : "\(count)"
        leadingConstraint?.constant = leadingConstraintConstant
        self.isHidden = isHidden
    }
}

public struct SwiftUIBadgeView: View {

    @Binding var value: Int
    @State var foreground: Color = .white
    @State var background: Color = DesignSystem.shared.colors.danger.default.color

    private let size = 19.0
    public init(value: Binding<Int>) {
        self._value = value
    }

    public var body: some View {
        ZStack(alignment: .topTrailing) {
                Text(finalValue())
                    .foregroundColor(foreground)
                    .font(DesignSystem.shared.fonts.preferredFont(.caption2, .regular).font)
                    .frame(width: size, height: size)
                    .background(background)
                    .clipShape(Capsule())
        }
        .opacity(value == 0 ? 0 : 1)
    }

    // showing more than 99 might take too much space, rather display something like 99+
    func finalValue() -> String {
        return value < 100 ? "\(value)" : "99+"
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/BadgeView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/OffsetObservingScrollView.swift ---
//
//  OffsetObservingScrollView.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 26/02/2023.
//

import SwiftUI

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

    private let coordinateSpaceName = UUID()

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .fixFlickering()
        .coordinateSpace(name: coordinateSpaceName)
    }
}

private struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: PreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
            })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
}

private extension ScrollView {
    func fixFlickering() -> some View {
        GeometryReader { geometryWithSafeArea in
            GeometryReader { _ in
                ScrollView<AnyView>(axes, showsIndicators: showsIndicators) {
                    AnyView(
                        content
                            .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                            .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                            .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                            .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                    )
                }
            }
            .ignoresSafeArea()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/OffsetObservingScrollView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextFieldView.swift ---
//
//  TextFieldView.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 09/07/24.
//

import BackbaseDesignSystem
import Combine
import SwiftUI

public struct TextFieldView: View {
    public let title: String
    public let optionalText: String?
    public let placeholderText: String
    @Binding public var bindableText: String
    public let backgroundColor: Color
    public let disabled: Bool

    public init(
        title: String,
        optionalText: String? = nil,
        placeholderText: String,
        bindableText: Binding<String>,
        backgroundColor: Color = Color.clear,
        disabled: Bool = false
    ) {
        self.title = title
        self.optionalText = optionalText
        self.placeholderText = placeholderText
        self._bindableText = bindableText
        self.backgroundColor = backgroundColor
        self.disabled = disabled
    }

    private var attributedTitle: AttributedString {
        var attrTitle = AttributedString(title)
        attrTitle.font = DesignSystem.shared.fonts.preferredFont(.body, .medium).font
        attrTitle.foregroundColor = DesignSystem.shared.colors.text.default.color
        return attrTitle
    }

    private var attributedOptionalText: AttributedString {
        if let optionalText {
            var attrOptional = AttributedString(optionalText)
            attrOptional.font = DesignSystem.shared.fonts.preferredFont(.body, .regular).font
            attrOptional.foregroundColor = DesignSystem.shared.colors.text.support.color
            return attrOptional
        }
        return AttributedString()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.sm) {
            Text(attributedTitle + " " + attributedOptionalText)
            TextField(
                "",
                text: $bindableText,
                prompt: Text(placeholderText)
                    .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
                    .foregroundColor(DesignSystem.shared.colors.text.support.color)
            )
            .disabled(disabled)
            .frame(height: 54)
            .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
            .foregroundStyle(DesignSystem.shared.colors.text.support.color)
            .padding(.horizontal, DesignSystem.shared.spacer.sm + DesignSystem.shared.spacer.xs)
            .autocorrectionDisabled()
            .roundedBorder(cornerRadius: DesignSystem.shared.cornerRadius.medium, backgroundColor: backgroundColor)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(
            title: "",
            optionalText: nil,
            placeholderText: "",
            bindableText: .constant("")
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextFieldView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/RatingBarView.swift ---
//
//  RatingBarView.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 05/07/24.
//

import SwiftUI

public struct RatingBarView: View {
    @Binding public var currentRating: Int
    public let highestRating: Int
    public let didSelectRating: ((Int) -> Void)?

    public init(currentRating: Binding<Int>, highestRating: Int, didSelectRating: ((Int) -> Void)?) {
        self._currentRating = currentRating
        self.highestRating = highestRating
        self.didSelectRating = didSelectRating
    }

    public var body: some View {
        HStack(spacing: 16) {
            ForEach(1...highestRating, id: \.self) { index in
                image(for: index)
                    .frame(width: 48, height: 48)
                    .onTapGesture { currentRating = index}
            }
        }
        .onChange(of: currentRating) {
            didSelectRating?($0)
        }
        .animation(.default, value: currentRating)
    }

    private func image(for index: Int) -> some View {
        let name = index > currentRating ? "rating-star-unselected" : "rating-star-selected"
        return Image(name, bundle: .snbCommon)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingBarView(currentRating: .constant(4), highestRating: 5, didSelectRating: nil)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/RatingBarView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+onLoad.swift ---
//
//  View+onLoad.swift
//  SNBCommon
//
//  Created by Dhaval Panchal on 14/07/23.
//

import Foundation
import SwiftUI

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

extension View {
    public func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+onLoad.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/ImageTitleDescriptionRow.swift ---
//
//  ImageTitleDescriptionRow.swift
//  SNBCommon
//
//  Created by Vaibhav Misra on 04/06/24.
//

import BackbaseDesignSystem
import SwiftUI

public struct ImageTitleDescriptionRow: View {
    let image: Image
    let title: String
    let value: String
    let accessibilityPrefix: String

    public init(image: Image, title: String, value: String, accessibilityPrefix: String) {
        self.image = image
        self.title = title
        self.value = value
        self.accessibilityPrefix = accessibilityPrefix
    }

    var fonts: BackbaseDesignSystem.DesignSystem.Fonts {
        return DesignSystem.shared.fonts
    }

    var colors: BackbaseDesignSystem.DesignSystem.Colors {
        return DesignSystem.shared.colors
    }

    public var body: some View {
        HStack(alignment: .top,spacing: DesignSystem.shared.spacer.md) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: DesignSystem.shared.sizer.lg, height: DesignSystem.shared.sizer.lg, alignment: .top)
                .accessibilityLabel("\(accessibilityPrefix)Image")
            VStack(alignment: .leading) {
                Text(title)
                    .font(fonts.preferredFont(.subheadline, .medium).font)
                    .foregroundColor(colors.text.default.color)
                    .accessibilityLabel("\(accessibilityPrefix)Title")
                    .padding(.bottom, DesignSystem.shared.spacer.xs)
                Text(value)
                    .font(fonts.preferredFont(.subheadline, .regular).font)
                    .foregroundColor(colors.text.support.color)
                    .accessibilityLabel("\(accessibilityPrefix)Value")
            }
            Spacer()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/ImageTitleDescriptionRow.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NumberView.swift ---
//
//  NumberView.swift
//  Pods
//
//  Created by Oleg Baidalka on 20.09.2024.
//

import SwiftUI
import BackbaseDesignSystem

public struct NumberView: View {

    let viewHeight = DesignSystem.shared.sizer.xl

    @Binding var number: Int
    public var range: ClosedRange<Int> = 0...10
    public var step: Int = 1
    public var textFont: Font
    public var buttonFont: Font
    public var tint: Color
    public var disabledTint: Color

    private var outline: Color { isEnabled ? tint : disabledTint }
    private var lowerButtonColor: Color { isLowerButtonEnabled ? tint : disabledTint }
    private var upperButtonColor: Color { isUpperButtonEnabled ? tint : disabledTint }

    var isLowerButtonEnabled: Bool { number != range.lowerBound && isEnabled }
    var isUpperButtonEnabled: Bool { number != range.upperBound && isEnabled }

    @Environment(\.isEnabled) var isEnabled

    public init(
        number: Binding<Int>,
        range: ClosedRange<Int> = 0...10,
        step: Int = 1,
        tint: Color = DesignSystem.shared.colors.secondary.default.color,
        disabledTint: Color = DesignSystem.shared.colors.secondary.lightest.color,
        textFont: Font = DesignSystem.shared.fonts.preferredFont(.body, .medium).font,
        buttonFont: Font = DesignSystem.shared.fonts.preferredFont(.largeTitle, .regular).font
    ) {
        _number = number
        self.range = range
        self.step = step
        self.textFont = textFont
        self.buttonFont = buttonFont
        self.tint = tint
        self.disabledTint = disabledTint
    }

    public var body: some View {
        HStack(spacing: 0, content: {
            Button {
                decrease(by: step)
            } label: {
                Text("-").tint(.white)
                    .padding(.init(top: 0, leading: 0, bottom: 3, trailing: 0))
                    .frame(width: 56, height: viewHeight)
            }
            .background(lowerButtonColor)
            .font(buttonFont)
            .disabled(!isLowerButtonEnabled)

            Text("\(number)")
                .padding()
                .font(textFont)
                .frame(width: 100, height: viewHeight)
                .border(outline, width: 1)

            Button {
                increase(by: step)
            } label: {
                Text("+")
                    .tint(.white)
                    .padding(.init(top: 0, leading: 0, bottom: 3, trailing: 0))
                    .frame(width: 56, height: viewHeight)
            }
            .font(buttonFont)
            .background(upperButtonColor)
            .disabled(!isUpperButtonEnabled)
        })
        .clipShape(Capsule())
    }

    func increase(by amount: Int = 1) {
        number = min(number + amount, range.upperBound)
    }

    func decrease(by amount: Int = 1) {
        number = max(number - amount, range.lowerBound)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NumberView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPayment.swift ---
import UIKit
import BackbaseDesignSystem
import Resolver
import Combine
import SnapKit

public struct ResultPayment {
    public enum Status {
        case success(linkAction: (( @escaping () -> Void) -> Void)?)
        case failure(_ linkAction: (( @escaping () -> Void) -> Void)? = nil)
    }

    public static func build(
        configuration: ResultPayment.Configuration = Resolver.resolve(),
        status: Status,
        resultAction: (() -> Void)?,
        doneAction: (() -> Void)? = nil,
        nameText: String? = nil
    ) -> UIViewController {

        let viewModel = viewModel(
            for: status,
            nameText: nameText,
            configuration: configuration,
            resultAction: resultAction,
            doneAction: doneAction
        )
        let viewController = ResultPaymentViewController(configuration: configuration)
        let wrappingNavigationController = NavigationController(rootViewController: viewController,
                                                                style: DesignSystem.shared.styles.navigationController)
        viewController.bind(viewModel: viewModel)
        return wrappingNavigationController
    }

    private static func viewModel(
        for status: Status,
        nameText: String?,
        configuration: ResultPayment.Configuration,
        resultAction: (() -> Void)?,
        doneAction: (() -> Void)?
    ) -> ResultPaymentViewModel {

        let viewModel: ResultPaymentViewModel
        switch status {
        case .success(let linkAction):
            viewModel = .init(
                isSuccess: true,
                linkAction: linkAction,
                resultAction: resultAction,
                doneAction: doneAction,
                image: configuration.images.success.successImage,
                titleText: configuration.strings.success.title,
                subtitleText: configuration.strings.success.subtitle,
                nameText: nameText,
                linkButtonText: configuration.strings.success.linkButton,
                linkButtonImage: configuration.images.success.receiptImage,
                submitButtonText: configuration.strings.success.button
            )
        case .failure(let linkAction):
            viewModel = .init(
                isSuccess: false,
                linkAction: linkAction,
                resultAction: resultAction,
                doneAction: doneAction,
                image: configuration.images.failure.failureImage,
                titleText: configuration.strings.failure.title,
                subtitleText: configuration.strings.failure.subtitle,
                nameText: nameText,
                linkButtonText: configuration.strings.failure.linkButton,
                submitButtonText: configuration.strings.failure.button
            )
        }

        return viewModel
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPayment.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentViewModel.swift ---
import Combine
import UIKit

protocol ResultPaymentViewModelType {
    func bind(input: ResultPaymentViewModelInput) -> ResultPaymentViewModelOutput
}

final class ResultPaymentViewModel: ResultPaymentViewModelType {

    let isSuccess: Bool
    // MARK: - Private variable
    private let linkAction: ((_ completion: @escaping () -> Void) -> Void)?
    private let resultAction: (() -> Void)?
    private let doneAction: (() -> Void)?

    private var subscriptions: Set<AnyCancellable> = []
    private let viewStateSubject: CurrentValueSubject<ResultPaymentViewState, Never>

    private let image: UIImage
    private let titleText: String
    private let subtitleText: String
    private let nameText: String?
    private let submitButtonText: String

    private let linkButtonText: String?
    private let linkButtonImage: UIImage?

    // MARK: - Private methods

    init(
        isSuccess: Bool,
        linkAction: ((@escaping () -> Void) -> Void)? = nil,
        resultAction: (() -> Void)? = nil,
        doneAction: (() -> Void)? = nil,
        image: UIImage,
        titleText: String,
        subtitleText: String,
        nameText: String? = nil,
        linkButtonText: String? = nil,
        linkButtonImage: UIImage? = nil,
        submitButtonText: String
    ) {
        self.isSuccess = isSuccess
        self.linkAction = linkAction
        self.resultAction = resultAction
        self.doneAction = doneAction
        self.image = image
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.nameText = nameText
        self.linkButtonText = linkButtonText
        self.linkButtonImage = linkButtonImage
        self.submitButtonText = submitButtonText
        self.viewStateSubject = .init(.loaded(linkButtonImage: linkButtonImage))

    }

    private func handleInput(_ input: ResultPaymentViewModelInput) {
        input.didTapLink
            .sink(receiveValue: didTapLink)
            .store(in: &subscriptions)
        input.didTapDone
            .sink(receiveValue: didTapDone)
            .store(in: &subscriptions)
    }

    private func didTapLink() {
        /// Success Screen -> Receipt Action
        /// or
        /// Failure Screen -> Done Action
        resultAction?()
        viewStateSubject.send(.loading)
        linkAction? { [weak self] in
            self?.viewStateSubject.send(.loaded(linkButtonImage: self?.linkButtonImage))
        }

    }

    private func didTapDone() {
        /// Success Screen -> Done Action
        /// or
        /// Failure Screen -> TryAgain Action
        doneAction?()
    }

    // MARK: - Internal methods

    func bind(input: ResultPaymentViewModelInput) -> ResultPaymentViewModelOutput {
        handleInput(input)
        return ResultPaymentViewModelOutput(
            viewState: viewStateSubject.eraseToAnyPublisher(),
            image: Just(image).eraseToAnyPublisher(),
            titleText: Just(titleText).eraseToAnyPublisher(),
            subtitleText: Just(subtitleText).eraseToAnyPublisher(),
            nameText: Just(nameText).eraseToAnyPublisher(),
            submitButtonText: Just(submitButtonText).eraseToAnyPublisher(),
            linkButtonText: Just(linkButtonText).eraseToAnyPublisher()
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentStrings.swift ---
extension ResultPayment {
    public struct Strings {
        public var success = Success()
        public var failure = Failure()

        public struct Success {
            @Localizable public var title = "transfers.result.success.title"
            @Localizable public var subtitle = "transfers.result.success.subtitle"
            @Localizable public var nameTitle = ""
            @Localizable public var linkButton = "transfers.result.receipt"
            @Localizable public var button = "button.done"
        }

        public struct Failure {
            @Localizable public var title = "transfers.result.failure.title"
            @Localizable public var subtitle = "transfers.result.failure.subtitle"
            @Localizable public var nameTitle = ""
            @Localizable public var linkButton = "transfers.result.failure.linkButtonTitle"
            @Localizable public var button = "transfers.result.failure.buttonTitle"
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentStrings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentConfiguration.swift ---
import Foundation

extension ResultPayment {

    public struct Configuration {
        /// Design configurations.
        public var design = Design()

        /// String configurations.
        public var strings = Strings()

        /// Images configurations.
        public var images = Images()

        /// Hide Link button
        public var shouldDisplayLinkButton = true

        /// Hide Name Label
        public var shouldShowNameLabel = false

        public init() {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentDesign.swift ---
import BackbaseDesignSystem
import UIKit

extension ResultPayment {

    public struct Design {
        public init() {}

        public var imageCenterOffset: CGFloat = -100.0
        public var imageCenterOffsetWhenName: CGFloat = -160.0
        public var buttonBottomOffset: CGFloat = 60.0
        public var buttonHeight: CGFloat = 56.0
        public var labelHeight: CGFloat = 44.0

        public var linkButton: Style<Button> = { button in
            DesignSystem.shared.styles.linkButton(button)
            button.setTitleColor(
                UIColor(
                    light: DesignSystem.shared.colors.neutrals.neutral00,
                    dark: DesignSystem.shared.colors.neutrals.neutral00
                ),
                for: .normal
            )
            button.normalBorderColor = DesignSystem.shared.colors.neutrals.neutral00
            button.disabledBorderColor = DesignSystem.shared.colors.neutrals.neutral00
            button.layer.borderWidth = 1.0
        }

        public var titleLabel: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.title1, .regular)
            label.textAlignment = .center
            label.textColor = DesignSystem.shared.colors.neutrals.neutral00
        }

        public var subtitleLabel: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            label.textColor = DesignSystem.shared.colors.neutrals.neutral00
            label.numberOfLines = .zero
        }

        public var nameLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            label.backgroundColor = UIColor(hex: "#B8E7EA")
            label.textColor = UIColor(hex: "#1F6469")
            label.layer.masksToBounds = true
            label.layer.cornerRadius = DesignSystem.shared.cornerRadius.medium
            label.numberOfLines = .zero
            label.textAlignment = .center
        }

        public var submitButton: Style<Button> = { button in
            DesignSystem.shared.styles.primaryButton(button)
            button.setTitleColor(
                UIColor(
                    light: DesignSystem.shared.colors.neutrals.neutral100,
                    dark: DesignSystem.shared.colors.neutrals.neutral100
                ),
                for: .normal
            )
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentDesign.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentImages.swift ---
import UIKit

extension ResultPayment {
    public struct Images {
        public var success = Success()
        public var failure = Failure()

        public struct Success {
            public let successImage = UIImage(
                named: "success",
                in: .snbCommon,
                compatibleWith: nil
            ) ?? UIImage()

            public let receiptImage = UIImage(
                named: "receipt",
                in: .snbCommon,
                compatibleWith: nil
            ) ?? UIImage()
        }

        public struct Failure {
            public let failureImage = UIImage(
                named: "failure",
                in: .snbCommon,
                compatibleWith: nil
            ) ?? UIImage()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentImages.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentViewController.swift ---
import UIKit
import Combine
import BackbaseDesignSystem

public final class ResultPaymentViewController: UIViewController {

    // MARK: - Private variable

    private let configuration: ResultPayment.Configuration
    private var viewModel: ResultPaymentViewModel?
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Status Bar

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Views

    private let imageView = UIImageView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var linkButton: Button =  {
        let button = Button()
        configuration.design.linkButton(button)
        button.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        return button
    }()
    private var didTapLinkButtonSubject = PassthroughSubject<Void, Never>()

    private lazy var submitButton: Button = {
        let button = Button()
        configuration.design.submitButton(button)
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return button
    }()
    private var didTapSubmitButtonSubject = PassthroughSubject<Void, Never>()

    // MARK: - Initialization

    init(configuration: ResultPayment.Configuration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle

    public override func loadView() {
        super.loadView()
        configureLayout()
        configureDesign()
        addSupportButton()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeLargeTitlesForNavBar()
    }

    // MARK: - Private methods

    private func configureLayout() {
        view.configureBackgroundView(type: .plain)

        [imageView, titleLabel, subtitleLabel, submitButton].forEach {
            view.addSubview($0)
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
                .offset(
                    configuration.shouldShowNameLabel
                    ? configuration.design.imageCenterOffsetWhenName
                    : configuration.design.imageCenterOffset
                )
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(DesignSystem.shared.spacer.lg)
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            make.centerX.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSystem.shared.spacer.md)
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            make.centerX.equalToSuperview()
        }

        if configuration.shouldShowNameLabel {
            view.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(subtitleLabel.snp.bottom).offset(DesignSystem.shared.spacer.md)
                make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
                make.centerX.equalToSuperview()
                make.height.equalTo(configuration.design.labelHeight)
            }
        }
        if configuration.shouldDisplayLinkButton {
            view.addSubview(linkButton)
            linkButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
                make.height.equalTo(configuration.design.buttonHeight)
                make.bottom.equalTo(submitButton.snp.top).offset(-DesignSystem.shared.spacer.md)
            }
        }

        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
            make.height.equalTo(configuration.design.buttonHeight)
            make.bottom.equalTo(view.safeAreaInsets)
                .inset(configuration.design.buttonBottomOffset)
        }
    }

    private func addSupportButton() {
        guard let isSuccess = viewModel?.isSuccess, !isSuccess else { return }
        addSupportButtonView()
    }

    @objc private func linkTapped() {
        didTapLinkButtonSubject.send()
    }

    @objc private func submitTapped() {
        didTapSubmitButtonSubject.send()
    }

    private func configureDesign() {
        configuration.design.titleLabel(titleLabel)
        configuration.design.subtitleLabel(subtitleLabel)
        configuration.design.nameLabelStyle(nameLabel)
    }

    private func configure(viewModel: ResultPaymentViewModel) {
        handleOutput(
            viewModel.bind(
                input: ResultPaymentViewModelInput(
                    didTapLink: didTapLinkButtonSubject.eraseToAnyPublisher(),
                    didTapDone: didTapSubmitButtonSubject.eraseToAnyPublisher()
                )
            )
        )
    }

    private func handleOutput(_ output: ResultPaymentViewModelOutput) {
        output.image
            .sink { [weak self] in
                self?.imageView.image = $0
            }
            .store(in: &subscriptions)

        output.titleText
            .sink { [weak self] in
                self?.titleLabel.text = $0
            }
            .store(in: &subscriptions)

        output.viewState
            .sink { [weak self] in
                self?.set(state: $0)
            }
            .store(in: &subscriptions)

        output.subtitleText
            .map(formatSubtitleText)
            .sink { [weak self] in
                self?.subtitleLabel.attributedText = $0
            }
            .store(in: &subscriptions)

        output.linkButtonText
            .map {
                $0 == nil
            }
            .sink { [weak self] in
                self?.linkButton.isHidden = $0
            }
            .store(in: &subscriptions)

        output.linkButtonText
            .sink { [weak self] in
                self?.linkButton.setTitle($0, for: .init())
            }
            .store(in: &subscriptions)

        output.submitButtonText
            .sink { [weak self] in
                self?.submitButton.setTitle($0, for: .init())
            }
            .store(in: &subscriptions)

        output.nameText
            .assign(to: \.text, on: nameLabel)
            .store(in: &subscriptions)
    }

    private func formatSubtitleText(_ subtitleText: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        paragraphStyle.alignment = .center

        return NSAttributedString(
            string: subtitleText,
            attributes: [.paragraphStyle: paragraphStyle]
        )
    }

    // MARK: - Internal methods

    func bind(viewModel: ResultPaymentViewModel) {
        self.viewModel = viewModel
        configure(viewModel: viewModel)
    }
}

private extension ResultPaymentViewController {
    func set(state: ResultPaymentViewState) {
        switch state {
        case .loading: setLoadingState()
        case .loaded(let linkButtonImage): setLoadedState(with: linkButtonImage)
        }
    }

    func setLoadingState() {
        linkButton.startLoading()
        linkButton.setImage(nil, for: .normal)
    }

    func setLoadedState(with linkButtonImage: UIImage?) {
        linkButton.stopLoading()
        linkButton.setImage(linkButtonImage, for: .normal)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/ResultPaymentViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorDesign.swift ---
import UIKit
import BackbaseDesignSystem

extension ReceiptError {
    public struct Design {
        public var imageOffset: CGFloat = 64.0

        public var sheetPresentationController: Style<UIViewController> = { viewController in
            guard let sheetPresentationController = viewController.sheetPresentationController else { return }
            if #available(iOS 16.0, *) {
                sheetPresentationController.detents = [.custom(resolver: { $0.maximumDetentValue * 0.5 })]
            } else {
                sheetPresentationController.detents = [.medium()]
            }
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = true
            sheetPresentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = DesignSystem.shared.cornerRadius.large
        }

        public var titleLabel: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.title1, .regular)
            label.textAlignment = .center
            label.textColor = DesignSystem.shared.colors.neutrals.neutral100
        }

        public var subtitleLabel: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            label.textColor = DesignSystem.shared.colors.text.support
            label.numberOfLines = .zero
        }

        public init() {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorDesign.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorImages.swift ---
import UIKit

extension ReceiptError {
    public struct Images {
        public var failureImage = UIImage(
            named: "failure",
            in: .snbCommon,
            compatibleWith: nil
        )!

        public init() {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorImages.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorConfiguration.swift ---
extension ReceiptError {
    public struct Configuration {
        public var design = Design()
        public var strings = Strings()
        public var images = Images()

        public init() { }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorViewController.swift ---
import BackbaseDesignSystem
import SnapKit

final class ReceiptErrorViewController: UIViewController {

    // MARK: - Private variable

    private let configuration: ReceiptError.Configuration

    // MARK: - Status Bar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Views

    private let imageView = UIImageView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Initialization

    init(configuration: ReceiptError.Configuration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
        imageView.image = configuration.images.failureImage
        titleLabel.text = configuration.strings.title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle

    override func loadView() {
        super.loadView()
        setupNavBar()
        configureLayout()
        configureDesign()
    }

    // MARK: - Private methods

    private func setupNavBar() {
        navigationController?.isNavigationBarHidden = true
    }

    private func configureLayout() {
        [imageView, titleLabel, subtitleLabel].forEach(view.addSubview)

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
                .offset(configuration.design.imageOffset)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(DesignSystem.shared.spacer.lg)
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSystem.shared.spacer.md)
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
    }

    private func configureDesign() {
        view.backgroundColor = DesignSystem.shared.colors.neutrals.neutral00
        configuration.design.sheetPresentationController(self)
        configuration.design.titleLabel(titleLabel)
        configuration.design.subtitleLabel(subtitleLabel)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        paragraphStyle.alignment = .center
        subtitleLabel.attributedText = NSAttributedString(
            string: configuration.strings.subtitle,
            attributes: [.paragraphStyle: paragraphStyle]
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorStrings.swift ---
extension ReceiptError {
    public struct Strings {
        @Localizable public var title = "transfers.error.receipt.title"
        @Localizable public var subtitle = "transfers.error.receipt.subtitle"

        public init() { }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptErrorStrings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptError.swift ---
import Resolver

public struct ReceiptError {

    public static func build(
        configuration: ReceiptError.Configuration = Resolver.resolve()
    ) -> UIViewController {
        return ReceiptErrorViewController(configuration: configuration)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Receipt Error/ReceiptError.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Entities/ResultPaymentViewState.swift ---
import UIKit

enum ResultPaymentViewState {
    case loading
    case loaded(linkButtonImage: UIImage?)
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Entities/ResultPaymentViewState.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Entities/ResultPaymentViewModelIO.swift ---
import Combine
import UIKit

struct ResultPaymentViewModelInput {
    let didTapLink: AnyPublisher<Void, Never>
    let didTapDone: AnyPublisher<Void, Never>
}

struct ResultPaymentViewModelOutput {
    let viewState: AnyPublisher<ResultPaymentViewState, Never>
    let image: AnyPublisher<UIImage, Never>
    let titleText: AnyPublisher<String, Never>
    let subtitleText: AnyPublisher<String, Never>
    let nameText: AnyPublisher<String?, Never>
    let submitButtonText: AnyPublisher<String, Never>
    let linkButtonText: AnyPublisher<String?, Never>
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Result Payment/Entities/ResultPaymentViewModelIO.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNickname.swift ---
//
//  SaveNickname.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import UIKit
import BackbaseDesignSystem
import Resolver
import Combine
import SnapKit

public struct SaveNickname {
    enum TransferCaptureError {
        case invalidInput(message: String)
        case alreadyRegisteredAlert(_ beneficiaryId: String?)
        case edgeCase
    }

    enum TransferCaptureViewState {
        case success
        case loading
        case error(error: TransferCaptureError)
    }

    public static func build(
        navigationController: UINavigationController,
        configuration: SaveNickname.Configuration = Resolver.resolve(),
        router: TransferRouterMarker,
        accountId: String,
        validationType: ValidationType,
        completion: @escaping (String?) -> Void
    ) -> UIViewController {
        let viewModel = SaveNicknameViewModel(configuration: configuration,
                                              router: router,
                                              accountId: accountId,
                                              validationType: validationType,
                                              completion: completion)
        return SaveNicknameViewController(viewModel: viewModel)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNickname.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameDesign.swift ---
//
//  SaveNicknameDesign.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import BackbaseDesignSystem
import UIKit

extension SaveNickname {
    public struct Design {

        public init() {}
        let makeTransfer = MakeTransfer()

        public struct MakeTransfer {
            public var scrollView: Style<UIView> = { scrollView in
                scrollView.layer.cornerRadius = DesignSystem.shared.cornerRadius.large
            }

            public var submitButton: Style<Button> = { button in
                DesignSystem.shared.styles.primaryButton(button)
                button.setTitleColor(
                    UIColor(
                        light: DesignSystem.shared.colors.neutrals.neutral100,
                        dark: DesignSystem.shared.colors.neutrals.neutral100
                    ),
                    for: .normal
                )
            }
        }
        public var sheetPresentationController: Style<UIViewController> = { viewController in
            guard let sheetPresentationController = viewController.sheetPresentationController else { return }
            if #available(iOS 16.0, *) {
                sheetPresentationController.detents = [.custom(resolver: { $0.maximumDetentValue * 0.5 })]
            } else {
                sheetPresentationController.detents = [.medium()]
            }
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = true
            sheetPresentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = DesignSystem.shared.cornerRadius.large
        }

        var textInput: Style<TextInput> = { input in
            DesignSystem.shared.styles.textInput(input)
            if let normalStyle = input.normalStyle {
                input.normalStyle = normalStyle <> { textInput in
                    var border = textInput.border
                    border?.color = DesignSystem.shared.colors.inputBorder.cgColor
                    textInput.border = border
                }
            }
            input.textField.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            input.titleLabel.font = DesignSystem.shared.fonts.preferredFont(.body, .medium)
            input.textField.setNaturalTextAlignment()
        }

        public var titleLabelStyle: Style<UILabel> = {
            $0.font = DesignSystem.shared.fonts.preferredFont(.title2, .medium)
            $0.textColor = .black
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameDesign.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameRouter.swift ---
//
//  SaveNicknameRouter.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import Foundation

public protocol TransferRouterMarker {
    func showError(_ type: GenericErrorScreen.Configuration.Option)
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameRouter.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameStrings.swift ---
//
//  SaveNicknameStrings.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

extension SaveNickname {
    public struct Strings {
        public struct SaveNickname {
            @Localizable var title = "beneficiaries.beneficiariesList.noBeneficiaries.title"
            @Localizable var labelTitle = "sadad.addeditnickname.label.title"
            @Localizable var buttonTitle = "sadad.addeditnickname.button.title"
            @Localizable var userExistsError = "neoTransfer.nickname.used.error"
        }
        public init() {}
        let saveNickname = SaveNickname()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameStrings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameViewModel.swift ---
//
//  SaveNicknameViewModel.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import Combine
import Resolver

final class SaveNicknameViewModel: ObservableObject {

    struct Constants {
        let maxLength: Int = 15
    }

    var configuration: SaveNickname.Configuration
    var router: TransferRouterMarker
    private var cancellables = Set<AnyCancellable>()
    private let useCase: SaveNicknameUsecaseProtocol = Resolver.resolve()
    private let accountId: String
    private let validationType: ValidationType
    let viewState = PassthroughSubject<SaveNickname.TransferCaptureViewState, Never>()
    let constants = Constants()

    private let completion: (String?) -> Void

    // MARK: - Initialization
    init(
        configuration: SaveNickname.Configuration,
        router: TransferRouterMarker,
        accountId: String,
        validationType: ValidationType,
        completion: @escaping (String?) -> Void
    ) {
        self.configuration = configuration
        self.router = router
        self.accountId = accountId
        self.validationType = validationType
        self.completion = completion
    }

    func bind() {
        viewState.eraseToAnyPublisher()
    }

    private func handle(error: AccountIDValidationResponse.Error) {
        switch error {
        case .ambiguousAccountsFound, .invalidPhone, .invalid, .notNEO, .ownAccount:
            break
        case .registered:
            viewState.send(
                .error(error: .alreadyRegisteredAlert(nil))
            )
        case .unknown:
            viewState.send(
                .error(error: .edgeCase)
            )
        }
    }
}

extension SaveNicknameViewModel {
    func validateNickname(nickName: String) {
        let accountID  = AccountID.iban(value: self.accountId)
        let request = AccountIDValidationRequest(
            accountID: accountID,
            alias: nickName,
            validationType: self.validationType
        )
        Task {
            await MainActor.run { [weak self] in
                self?.viewState.send(.loading)
            }
            do {
                let response = try await useCase.validateAccountID(
                    request: request
                )
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.viewState.send(.success)
                    completion(nickName)
                }
            } catch let error as AccountIDValidationResponse.Error {
                await MainActor.run { [weak self] in
                    self?.handle(error: error)
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.viewState.send(
                        .error(error: .edgeCase)
                    )
                }
            }
        }
    }

    func showErrorScreen() {
        self.router.showError(.somethingWentWrong)
    }

    func didDismissViewController() {
        completion(nil)
    }
}

extension SaveNicknameViewModel {

    func isLengthAllowed(_ text: String) -> Bool {
        return text.count <= constants.maxLength
    }

    /// Requirement criteria for the nickname field according to the [JIRA ticket](https://backbase.atlassian.net/browse/SNBDBR-13920).
    func isNicknameValid(enteredString: String, completeString: String) -> Bool {
        return !containsSpecialCharacter(enteredString)
    }

    private func containsSpecialCharacter(_ string: String) -> Bool {
        let regex = ".*[^A-Za-z0-9,. \\p{Arabic}].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: string)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameViewController.swift ---
//
//  SaveNicknameViewController.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import UIKit
import BackbaseDesignSystem
import Combine
import Resolver
final class SaveNicknameViewController: UIViewController {

    struct Constants {
        let padding = DesignSystem.shared.sizer.md
        let saveButtonHeight = 56.0
        let nickNameInputTopOffset = 44.0
        let nickNameInputHeight = 95.0
        let titleLabelHeight = 28.0
        let titleLableTopOffset = DesignSystem.shared.sizer.lg * 2
    }

    private let configuration: SaveNickname.Configuration = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: SaveNicknameViewModel
    let constants = Constants()
    var isTextEntered: Bool = false {
        didSet {
            saveButton.isEnabled = isTextEntered
        }
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = configuration.strings.saveNickname.title
        label.numberOfLines = 0
        return label
    }()

    private lazy var nickNameTextInput: TextInput = {
        var input = TextInput()
        input.titleLabel.text = configuration.strings.saveNickname.labelTitle
        input.textField.setNaturalTextAlignment()
        return input
    }()

    private lazy var saveButton: Button =  {
        let button = Button()
        configuration.design.makeTransfer.submitButton(button)
        button.setTitle(configuration.strings.saveNickname.buttonTitle, for: .normal)
        return button
    }()

    // MARK: - Initialization
    init(viewModel: SaveNicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        title = nil
        self.view.backgroundColor = .white
        prepareView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        presentationController?.delegate = self
        nickNameTextInput.textField.delegate = self
        updateIsTextEntered(text: "")
    }

    private func prepareView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(nickNameTextInput)
        self.view.addSubview(saveButton)
        configuration.design.textInput(nickNameTextInput)
        configuration.design.titleLabelStyle(titleLabel)
        addContraints()
    }

    private func addContraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.padding)
            make.top.equalToSuperview().inset(constants.titleLableTopOffset)
            make.height.equalTo(constants.titleLabelHeight)
        }
        nickNameTextInput.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.padding)
            make.top.equalTo(titleLabel.snp.bottom).offset(constants.nickNameInputTopOffset)
            make.height.equalTo(constants.nickNameInputHeight)
        }
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.padding)
            make.height.equalTo(constants.saveButtonHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-constants.padding)
        }
    }

    private func bind() {
        viewModel.bind()
        saveButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self else { return }
                self.validateNickname()
            }
            .store(in: &cancellables)

        viewModel.viewState.sink { [weak self] in
            switch $0 {
            case .success:
                self?.saveButton.isUserInteractionEnabled = true
                self?.saveButton.stopLoading()
            case .error(let error):
                self?.saveButton.isUserInteractionEnabled = true
                self?.saveButton.stopLoading()
                self?.handle(error: error)
            case .loading:
                self?.saveButton.isUserInteractionEnabled = false
                self?.saveButton.startLoading()
            }
        }.store(in: &cancellables)
    }

    private func updateIsTextEntered(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespaces)
        isTextEntered = !trimmedText.isEmpty
    }

    private func validateNickname() {
        let nickName = self.nickNameTextInput.textField.text ?? ""
        let trimmedNickNameText = nickName.trimmingCharacters(in: .whitespaces)
        self.viewModel.validateNickname(nickName: trimmedNickNameText)
    }

    private func handle(error: SaveNickname.TransferCaptureError) {
        switch error {
        case .edgeCase:
            self.dismiss(animated: true)
            self.viewModel.showErrorScreen()
        case .invalidInput:
            break
        case .alreadyRegisteredAlert:
            saveButton.isEnabled = false
            nickNameTextInput.setError(errorMessage: configuration.strings.saveNickname.userExistsError)
        }
    }
}

extension SaveNicknameViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        nickNameTextInput.setError(errorMessage: "")
        let currentString = textField.text ?? ""
        guard let stringRange = Range(range, in: currentString) else { return false }
        let newString = currentString.replacingCharacters(in: stringRange, with: string)
        guard viewModel.isLengthAllowed(newString) else { return false }
        guard viewModel.isNicknameValid(enteredString: string, completeString: newString) else { return false }
        updateIsTextEntered(text: newString)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SaveNicknameViewController: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewModel.didDismissViewController()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameConfiguration.swift ---
//
//  SaveNicknameConfiguration.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import Foundation

extension SaveNickname {

    public struct Configuration {
        /// Design configurations.
        public var design = Design()

        /// String configurations.
        public var strings = Strings()

        public init() {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameUsecase.swift ---
//
//  SaveNicknameUsecase.swift
//  SNBCommon
//
//  Created by Monish Calapatapu on 16/11/23.
//

import ClientCommon

public protocol SaveNicknameUsecaseProtocol {
    func validateAccountID(request: AccountIDValidationRequest) async throws -> AccountIDValidationResponse
}

public final class SaveNicknameUsecase: SaveNicknameUsecaseProtocol {

    private let accountValidateClient: AccountIDValidationClientProtocol

    public init() {
        self.accountValidateClient = SNBCommon.AccountIDValidationClientFactory.makeClient()
    }

    public func validateAccountID(request: AccountIDValidationRequest) async throws -> AccountIDValidationResponse {
        try await accountValidateClient.validateAccountID(request.toDTO).toResponse
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Save Nickname Hub/SaveNicknameUsecase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NavBarButtonItem.swift ---
//
//  NavBarButtonItem.swift
//  SADADPaymentsJourney
//
//  Created by Bhuvan Sharma on 13/03/23.
//

import Resolver
import BackbaseDesignSystem

public enum BarButtonType {
    case back
    case close
    case settings
    case logout
    case preferable(UIImage?)
}

public final class NavBarButtonItem: UIBarButtonItem {
    @LazyInjected private var configuration: SNBCommon.Configuration
    private let didTap: () -> Void

    public init(type: BarButtonType = .back, didTap: @escaping () -> Void) {
        self.didTap = didTap
        super.init()
        switch type {
        case .back:
            image = configuration.images.arrowBack
        case .close:
            image = configuration.images.crossIcon
        case .settings:
            image = configuration.images.settingsIcon
        case .logout:
            image = configuration.images.logout
        case .preferable(let _image):
            image = _image
        }
        tintColor = DesignSystem.shared.colors.primary.onDefault
        style = .plain
        target = self
        action = #selector(buttonTapped)
    }

    @objc private func buttonTapped() {
        didTap()
    }

    public var isDisabled: Bool = false {
        didSet {
            isEnabled = !isDisabled
            let tintColor = self.tintColor ?? DesignSystem.shared.colors.primary.onDefault
            if isDisabled {
                image = image?.withTintColor(tintColor.withAlphaComponent(0.5))
            } else {
                image = image?.withTintColor(tintColor.withAlphaComponent(1))
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NavBarButtonItem.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenErrorViewModel.swift ---
//
//  GenericFullScreenErrorViewModel.swift
//  SNBCommon
//
//  Created by Sudeep George on 11/06/24.
//

import UIKit

public final class GenericFullScreenErrorViewModel {
    var configuration: GenericFullScreenError.Configuration

    init(configuration: GenericFullScreenError.Configuration) {
        self.configuration = configuration
    }

    func controllerDismissed() {
        configuration.router.didDismiss()
    }

    func primaryActionSubmit() {
        configuration.router.didSelectPrimaryActionButton()
    }

    func secondaryActionSubmit() {
        configuration.router.didSelectSecondaryActionButton()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenErrorViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenErrorView.swift ---
//
//  GenericFullScreenErrorView.swift
//  SNBCommon
//
//  Created by Sudeep George on 10/06/24.
//

import BackbaseDesignSystem
import SNBCommon
import SwiftUI

struct GenericFullScreenErrorView: View {
    let viewModel: GenericFullScreenErrorViewModel

    init(viewModel: GenericFullScreenErrorViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: .zero) {
                // Header
                viewModel.configuration.images.headerImage?.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                    .ignoresSafeArea(edges: [.top, .leading, .trailing])
                    .overlay(alignment: .topTrailing, content: {
                        viewModel.configuration.shouldShowCloseButton ?
                            HStack(alignment: .top) {
                                Spacer()
                                viewModel.configuration.images.closeIconImage?.image
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture(perform: { viewModel.controllerDismissed() })
                                    .padding([.trailing, .top], DesignSystem.shared.spacer.md)
                            } : nil
                    })

                // Content
                VStack(spacing: .zero) {
                    // Error Icon
                    HStack(alignment: .center) {
                        viewModel.configuration.images.errorIcon?.image
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, DesignSystem.shared.spacer.md)
                            .padding(.vertical, DesignSystem.shared.spacer.sm)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 3.5 * DesignSystem.shared.spacer.md)
                    .padding(.bottom, DesignSystem.shared.spacer.md)

                    // Text and Body
                    VStack(spacing: DesignSystem.shared.spacer.md) {
                        Text(viewModel.configuration.strings.title ?? "")
                            .font(DesignSystem.shared.fonts.preferredFont(.title1, .bold).font)
                            .foregroundStyle(DesignSystem.shared.colors.text.default.color)
                            .multilineTextAlignment(.center)
                        Text(viewModel.configuration.strings.body ?? "")
                            .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
                            .foregroundStyle(DesignSystem.shared.colors.text.default.color)
                            .multilineTextAlignment(.center)
                    }

                    Spacer()

                    // Action buttons
                    VStack(spacing: DesignSystem.shared.spacer.md) {
                        if viewModel.configuration.actionButtonDisplayMode.hasSecondryButton {
                            Button {
                                viewModel.secondaryActionSubmit()
                            } label: {
                                Text(viewModel.configuration.strings.secondaryActionButtonTitle ?? "")
                                    .font(DesignSystem.shared.fonts.preferredFont(.body, .medium).font)
                                    .foregroundStyle(DesignSystem.shared.colors.text.default.color)
                            }
                            .buttonStyle(.secondary())
                        }
                        if viewModel.configuration.actionButtonDisplayMode.hasPrimaryButton {
                            Button {
                                viewModel.primaryActionSubmit()
                            } label: {
                                Text(viewModel.configuration.strings.primaryActionButtonTitle ?? "")
                                    .font(DesignSystem.shared.fonts.preferredFont(.body, .medium).font)
                                    .foregroundStyle(DesignSystem.shared.colors.text.default.color)
                            }
                            .buttonStyle(.primary())
                        }
                    }
                }
                .padding(.horizontal, DesignSystem.shared.spacer.md)
                .padding(.bottom, 3.25 * DesignSystem.shared.spacer.md)
                .backgroundViewStyle()
                .cornerRadius(24.0, corners: [.topLeft, .topRight])
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
            .background(Color.clear)
            .forceCorrectSementicContentAttribute()
        })
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenErrorView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenError.swift ---
//
//  GenericFullScreenError.swift
//  SNBCommon
//
//  Created by Sudeep George on 10/06/24.
//

import SwiftUI
import UIKit

public enum GenericFullScreenError {
    public static func build(with configuration: GenericFullScreenError.Configuration) -> UIViewController {
        let viewModel = GenericFullScreenErrorViewModel(configuration: configuration)
        return UIHostingController(rootView: GenericFullScreenErrorView(viewModel: viewModel))
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenError.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenError+Configuration.swift ---
//
//  GenericFullScreenError+Configuration.swift
//  SNBCommon
//
//  Created by Sudeep George on 11/06/24.
//

import BackbaseDesignSystem
import Foundation
import Resolver
import RetailJourneyCommon

public extension GenericFullScreenError {
    struct Configuration {
        public var designs = Designs()
        public var strings = Strings()
        public var router = Router()
        public var images = Images()

        public var actionButtonDisplayMode = ActionButtonDisplayMode.none
        public var shouldShowCloseButton = false

        public init() {}

        public static func make(for type: ErrorType) -> Configuration {
            var config = Configuration()
            config.actionButtonDisplayMode = type.actionButtonDisplayMode
            config.strings.title = type.title
            config.strings.body = type.body
            config.strings.primaryActionButtonTitle = type.primaryButtonTitle
            config.strings.secondaryActionButtonTitle = type.secondryButtonTitle
            config.images.errorIcon = type.errorIcon
            config.images.headerImage = type.headerImage
            config.shouldShowCloseButton = true
            return config
        }
    }
}

public extension GenericFullScreenError {
    enum ActionButtonDisplayMode {
        case none, primaryOnly, secondaryOnly, primaryAndSecondary

        var hasPrimaryButton: Bool { return self == .primaryOnly || self == .primaryAndSecondary }
        var hasSecondryButton: Bool { return self == .secondaryOnly || self == .primaryAndSecondary }
    }

    enum ErrorType: Equatable {
        case insufficientBalance
        case custom(
            icon: UIImage,
            title: String,
            body: String?,
            primaryButtonTitle: String?,
            secondryButtonTitle: String?,
            headerImage: UIImage
        )

        var errorIcon: UIImage? {
            switch self {
            case .insufficientBalance: return UIImage.named("genericError_vpnIsActive", in: .snbCommon)
            case let .custom(icon, _, _, _, _, _): return icon
            }
        }

        var title: String? {
            switch self {
            case .insufficientBalance: return LocalizedString(key: "common.error.insufficientBalance.title").value
            case let .custom(_, title, _, _, _, _): return title
            }
        }

        var body: String? {
            switch self {
            case .insufficientBalance: return LocalizedString(key: "common.error.insufficientBalance.body").value
            case let .custom(_, _, body, _, _, _): return body
            }
        }

        var primaryButtonTitle: String? {
            switch self {
            case .insufficientBalance: return LocalizedString(key: "common.addMoney").value
            case let .custom(_, _, _, primaryButtonTitle, _, _): return primaryButtonTitle
            }
        }

        var secondryButtonTitle: String? {
            switch self {
            case .insufficientBalance: return nil
            case let .custom(_, _, _, _, secondryButtonTitle, _): return secondryButtonTitle
            }
        }

        var headerImage: UIImage? {
            switch self {
            case .insufficientBalance: return UIImage.named("headerImage/mountains", in: .snbCommon)
            case let .custom(_, _, _, _, _, headerImage): return headerImage
            }
        }

        var actionButtonDisplayMode: ActionButtonDisplayMode {
            switch (primaryButtonTitle, secondryButtonTitle) {
            case let (primary?, secondry?):
                return .primaryAndSecondary
            case let (primary?, nil):
                return .primaryOnly
            case let (nil, secondry?):
                return .secondaryOnly
            case let (nil, nil):
                return .none
            }
        }
    }

    struct Designs {}

    struct Images {
        public var errorIcon: UIImage?
        public var headerImage: UIImage?
        public var closeIconImage = UIImage(named: "close", in: .snbCommon, with: .none)
    }

    struct Strings {
        public var title: String?
        public var body: String?
        public var primaryActionButtonTitle: String?
        public var secondaryActionButtonTitle: String?
        public init() {}
    }

    struct Router {
        public var didDismiss: (() -> Void) = {}
        public var didSelectPrimaryActionButton: () -> Void = {}
        public var didSelectSecondaryActionButton: () -> Void = {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/GenericFullScreenError/GenericFullScreenError+Configuration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CheckboxView.swift ---
//
//  CheckboxView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 21/02/2023.
//

import SwiftUI
import Resolver

public struct CheckboxView: View {
    public enum Style {
        case rounded, rectangular, lock, rectangularBlack
    }

    @Injected private var configuration: SNBCommon.Configuration
    @Binding private var isSelected: Bool
    private let style: Style

    public init(isSelected: Binding<Bool>, style: Style = .rounded) {
        self._isSelected = isSelected
        self.style = style
    }

    public var body: some View {
        Button {
            withAnimation {
                isSelected.toggle()
            }
        } label: {
            Group {
                switch style {
                case .rectangular:
                    isSelected ? configuration.images.rectangularCheckboxOn.image : configuration.images.rectangularCheckboxOff.image
                case .rounded:
                    isSelected ? configuration.images.roundedCheckboxOn.image : configuration.images.roundedCheckboxOff.image
                case .lock:
                    isSelected ? configuration.images.lock.image : configuration.images.lockOpen.image
                case .rectangularBlack:
                    isSelected ? configuration.images.rectBlackCheckboxOn.image : configuration.images.rectBlackCheckboxOff.image
                }
            }
            .animation(nil, value: isSelected)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CheckboxView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SupportButtonView.swift ---
//
//  SupportButtonView.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 03/09/2024.
//

import SwiftUI

public struct SupportButtonView: View {
    private let viewModel = SupportButtonViewModel()

    public var body: some View {
        HStack(spacing: viewModel.constants.offset) {
            Text(viewModel.strings.supportButton)
                .font(viewModel.constants.font.font)
                .foregroundColor(viewModel.constants.textColor.color)

            viewModel.images.supportIcon?.image
                .resizable()
                .frame(width: viewModel.constants.iconImageViewHeight,
                       height: viewModel.constants.iconImageViewHeight)
        }
        .padding(.vertical, viewModel.constants.buttonVerticalPadding)
        .frame(width: viewModel.containerWidth, height: viewModel.constants.containerHeight)
        .background(viewModel.constants.backgroundColor.color)
        .cornerRadius(viewModel.constants.containerHeight / 2)
        .overlay {
            RoundedRectangle(cornerRadius: viewModel.constants.containerHeight / 2)
                .stroke(viewModel.constants.borderColor.color)
        }
    }

    public init() {}
}

private struct SupportButtonViewModel {
    let constants = SupportButtonConfiguration.Constants()
    let strings = SupportButtonConfiguration.Strings()
    let images = SupportButtonConfiguration.Images()

    var containerWidth: CGFloat {
        let isRTL = Locale.rtlLanguageCodes.contains(Locale.current.languageCode ?? "")
        return isRTL ? constants.containerRTLWidth : constants.containerWidth
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SupportButtonView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Designs.swift ---
//
//  GenericErrorScreen+Designs.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import UIKit
import BackbaseDesignSystem

extension GenericErrorScreen.Configuration {
    public struct Designs {
        public var icon: UIImage?

        public var iconStyle: Style<UIImageView> = { imageView in
            imageView.contentMode = .scaleAspectFit
        }

        public var titleLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.largeTitle, .bold)
            label.textColor = DesignSystem.shared.colors.text.default
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
        }

        public var bodyLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            label.textColor = DesignSystem.shared.colors.text.support
            label.textAlignment = .center
            label.numberOfLines = 0
        }

        public var bodyLabelParagraphStyle = configure(NSMutableParagraphStyle()) { paragraphStyle in
            paragraphStyle.lineSpacing = 5
            paragraphStyle.alignment = .center
        }

        public var exitLabel: Style<UILabel> = {
            $0.textAlignment = .center
            $0.textColor = DesignSystem.shared.colors.text.support
            $0.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
        }

        public var primaryActionButtonStyle: Style<Button> = { button in
            DesignSystem.shared.styles.primaryButton(button)
        }

        public var secondaryActionButtonStyle: Style<Button> = { button in
            DesignSystem.shared.styles.secondaryButton(button)
        }

        public init() { }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Designs.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen.swift ---
//
//  GenericErrorScreen.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import UIKit

public enum GenericErrorScreen {
    public static func build(configuration: Configuration) -> UIViewController {
        let viewModel = GenericErrorScreenViewModel(configuration: configuration)
        let viewController = GenericErrorScreenViewController(viewModel: viewModel, configuration: configuration)
        viewModel.viewController = viewController
        viewController.isModalInPresentation = !configuration.isDismissByDragginEnabled

        let sheetPresentationController = viewController.sheetPresentationController
        sheetPresentationController?.detents = configuration.detents
        sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController?.prefersEdgeAttachedInCompactHeight = true
        sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 24.0

        return viewController
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Strings.swift ---
//
//  GenericErrorScreen+Strings.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

extension GenericErrorScreen.Configuration {
    public struct Strings {
        public var title: String?
        public var body: String?
        public var primaryActionButtonTitle = ""
        public var secondaryActionButtonTitle = ""
        @Localizable var exitLabel = "genericError.appunexpectedoutage.footertitle"

        public init() { }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Strings.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreenViewModel.swift ---
//
//  GenericErrorScreenViewModel.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import BackbaseDesignSystem
import UIKit

public final class GenericErrorScreenViewModel {
    internal unowned var viewController: UIViewController?
    private var configuration: GenericErrorScreen.Configuration
    var isButtonClicked = false

    init(configuration: GenericErrorScreen.Configuration) {
        self.configuration = configuration
    }

    func controllerDismissed() {
        guard let viewController else { return }
        configuration.router.didDismiss()
    }

    func primaryActionSubmit(_ button: Button) {
        isButtonClicked = true
        guard let viewController else { return }
        configuration.router.didSelectPrimaryActionButton(viewController)(button)
    }

    func secondaryActionSubmit(_ button: Button) {
        guard let viewController else { return }
        configuration.router.didSelectSecondaryActionButton(viewController)(button)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreenViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/PresentableContext.swift ---
//
//  PresentableContext.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 02/08/2023.
//

import SwiftUI

public protocol PresentableContext: AnyObject {
    var isContextAvailable: Bool { get set }
}

public final class AlwaysPresentable: PresentableContext {
    public var isContextAvailable: Bool = true
    public init() {}
}

public extension View {
    func presentableContext<Context: PresentableContext>(_ context: Context) -> some View {
        onAppear { context.isContextAvailable = true }
            .onDisappear { context.isContextAvailable = false }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/PresentableContext.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Configuration.swift ---
//
//  GenericErrorScreen+Configuration.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import Resolver
import Foundation
import RetailJourneyCommon

extension GenericErrorScreen {
    public struct Configuration {
        public var designs = Designs()
        public var strings = Strings()
        public var router = Router()

        // Determines what configuration of buttons to use
        public var actionButtonDisplayMode = ActionButtonDisplayOption.none

        // Determines whether the user can dismiss the bottom sheet by dragging it
        public var isDismissByDragginEnabled = true
        public var isExitLabelVisible = false

        // Determines the height of the preseneted sheets
        public var detents: [UISheetPresentationController.Detent] = [.medium()]

        public init() { }

        public static func make(for option: Option) -> Configuration {
            var configuration = Resolver.resolve(Configuration.self)
            configuration.strings.title = option.title.value
            configuration.strings.body = option.body.value
            configuration.designs.icon = option.icon
            configuration.actionButtonDisplayMode = option.actionButtonDisplayMode
            configuration.strings.primaryActionButtonTitle = option.actionButtonTitle.value
            configuration.strings.secondaryActionButtonTitle = option.secondaryActionButtonTitle.value
            return configuration
        }
    }
}

public extension GenericErrorScreen.Configuration {

    enum ActionButtonDisplayOption {
        case none,
             primaryOnly,
             secondaryOnly,
             primaryAndSecondary,
             secondaryAndPrimary
    }

    enum Option: Equatable {

        case noInternetConnection
        case somethingWentWrong
        case loadingFailed
        case somethingWentWrongTryAgain
        case sessionExpired
        case comingSoon
        case isNafathCompleted
        case vpnIsActive
        case deviceLocationDisabled
        case appLocationDisabled
        case newUserRestrictionAttemptFail
        case newUserRestrictionServiceUnavailable
        case accountClosed
        case cardFeatureDisabled
        case unableToShareAccountDetails
        case customFailure(titleKey: String, bodyKey: String, icon: UIImage? = UIImage.named("failure", in: .snbCommon))
        case appUnexpectedOutage
        case completeYourProfile

        var icon: UIImage? {
            switch self {
            case .noInternetConnection:
                return UIImage.named("genericError_noInternet", in: .snbCommon)
            case .somethingWentWrong, .unableToShareAccountDetails, .loadingFailed:
                return UIImage.named("genericError_somethingWentWrong", in: .snbCommon)
            case .sessionExpired:
                return UIImage.named("genericError_sessionExpired", in: .snbCommon)
            case .comingSoon:
                return UIImage.named("logo", in: .snbCommon)
            case .isNafathCompleted:
                return UIImage.named("logo", in: .snbCommon)
            case .vpnIsActive:
                return UIImage.named("genericError_vpnIsActive", in: .snbCommon)
            case .deviceLocationDisabled:
                return UIImage.named("genericError_allowLocation", in: .snbCommon)
            case .appLocationDisabled:
                return UIImage.named("genericError_allowLocation", in: .snbCommon)
            case let .customFailure(_, _, icon):
                return icon
            case .newUserRestrictionAttemptFail, .newUserRestrictionServiceUnavailable,
                    .accountClosed, .somethingWentWrongTryAgain, .cardFeatureDisabled:
                return UIImage.named("failure", in: .snbCommon)
            case .appUnexpectedOutage:
                return UIImage.named("service_unavailable")
            case .completeYourProfile:
                return UIImage.named("logo", in: .snbCommon)
            }
        }

        var title: LocalizedString {
            switch self {
            case .noInternetConnection:
                return LocalizedString(key: "genericError.noInternetConnection.title", in: .snbCommon)
            case .somethingWentWrong, .somethingWentWrongTryAgain:
                return LocalizedString(key: "genericError.somethingWentWrong.title", in: .snbCommon)
            case .sessionExpired:
                return LocalizedString(key: "genericError.sessionExpired.title", in: .snbCommon)
            case .comingSoon:
                return LocalizedString(key: "comingSoon.title", in: .snbCommon)
            case .isNafathCompleted:
                return LocalizedString(key: "genericError.nafathVerificationCompleted.title", in: .main)
            case let .customFailure(titleKey, _, _):
                return LocalizedString(key: titleKey)
            case .vpnIsActive:
                return LocalizedString(key: "genericError.vpnIsActive.title", in: .snbCommon)
            case .deviceLocationDisabled:
                return LocalizedString(key: "genericError.deviceLocationDisabled.title", in: .snbCommon)
            case .appLocationDisabled:
                return LocalizedString(key: "genericError.appLocationDisabled.title", in: .snbCommon)
            case .newUserRestrictionAttemptFail:
                return LocalizedString(key: "new.user.restriction.transfer.attemptfail.title", in: .snbCommon)
            case .newUserRestrictionServiceUnavailable:
                return LocalizedString(key: "new.user.restriction.transfer.service.unavailable.title", in: .snbCommon)
            case .accountClosed:
                return LocalizedString(key: "account.closed.screen.title", in: .snbCommon)
            case .unableToShareAccountDetails:
                return LocalizedString(key: "genericError.accountDetails.share.error.title", in: .snbCommon)
            case .appUnexpectedOutage:
                return LocalizedString(key: "genericError.appunexpectedoutage.title", in: .snbCommon)
            case .cardFeatureDisabled:
                return LocalizedString(key: "cardManagement.service.unavailable.title", in: .main)
            case .loadingFailed:
                return LocalizedString(key: "common.error.loadingFailedTitle", in: .main)
            case .completeYourProfile:
                return LocalizedString(key: "liteOnboarding.completeYourProfile.title", in: .main)
            }
        }

        var body: LocalizedString {
            switch self {
            case .noInternetConnection:
                return LocalizedString(key: "genericError.noInternetConnection.body", in: .snbCommon)
            case .somethingWentWrong, .somethingWentWrongTryAgain:
                return LocalizedString(key: "genericError.somethingWentWrong.body", in: .snbCommon)
            case .sessionExpired:
                return LocalizedString(key: "genericError.sessionExpired.body", in: .snbCommon)
            case .comingSoon:
                return LocalizedString(key: "comingSoon.subTitle", in: .snbCommon)
            case .isNafathCompleted:
                return ""
            case let .customFailure(_, bodyKey, _):
                return LocalizedString(key: bodyKey)
            case .vpnIsActive:
                return LocalizedString(key: "genericError.vpnIsActive.body", in: .snbCommon)
            case .deviceLocationDisabled:
                return LocalizedString(key: "genericError.deviceLocationDisabled.body", in: .snbCommon)
            case .appLocationDisabled:
                return LocalizedString(key: "genericError.appLocationDisabled.body", in: .snbCommon)
            case .newUserRestrictionAttemptFail:
                return LocalizedString(key: "new.user.restriction.transfer.attemptfail.description", in: .snbCommon)
            case .newUserRestrictionServiceUnavailable:
                return LocalizedString(key: "new.user.restriction.transfer.service.unavailable.description", in: .snbCommon)
            case .accountClosed:
                return LocalizedString(key: "account.closed.screen.description", in: .snbCommon)
            case .unableToShareAccountDetails:
                return LocalizedString(key: "genericError.accountDetails.share.error.body", in: .snbCommon)
            case .appUnexpectedOutage:
                return LocalizedString(key: "genericError.appunexpectedoutage.body", in: .snbCommon)
            case .cardFeatureDisabled:
                return LocalizedString(key: "cardManagement.service.unavailable.message", in: .main)
            case .loadingFailed:
                return LocalizedString(key: "common.error.loadingFailedSubtitle", in: .main)
            case .completeYourProfile:
                return LocalizedString(key: "liteOnboarding.completeYourProfile.subtitle", in: .main)
            }
        }

        var actionButtonTitle: LocalizedString {
            switch self {
            case .deviceLocationDisabled, .appLocationDisabled:
                return LocalizedString(key: "genericError.locationActionButtonTitle", in: .snbCommon)
            case .newUserRestrictionAttemptFail, .newUserRestrictionServiceUnavailable:
                return LocalizedString(key: "new.user.restriction.transfer.action", in: .snbCommon)
            case .accountClosed:
                return LocalizedString(key: "account.closed.screen.button.registration", in: .snbCommon)
            case .somethingWentWrongTryAgain:
                return LocalizedString(key: "genericError.actionButtonTitle", in: .snbCommon)
            case .cardFeatureDisabled:
                return LocalizedString(key: "cardManagement.service.unavailable.button.title", in: .main)
            case .isNafathCompleted:
                return LocalizedString(key: "common.button.yes", in: .main)
            case .completeYourProfile:
                return LocalizedString(key: "liteOnboarding.completeYourProfile.buttonTitle", in: .main)
            default:
                return LocalizedString(key: "genericError.actionButtonTitle", in: .snbCommon)
            }
        }

        var secondaryActionButtonTitle: LocalizedString {
            switch self {
            case .isNafathCompleted:
                return LocalizedString(key: "common.button.no", in: .main)
            default:
                return ""
            }
        }

        var actionButtonDisplayMode: GenericErrorScreen.Configuration.ActionButtonDisplayOption {
            switch self {
            case .isNafathCompleted:
                return .secondaryAndPrimary
            default:
                return .none
            }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Configuration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Router.swift ---
//
//  GenericErrorScreen+Router.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import BackbaseDesignSystem
import UIKit

extension GenericErrorScreen.Configuration {
    public struct Router {

        public var didDismiss: (() -> Void) = {}

        public var didSelectPrimaryActionButton: ((UIViewController) -> (Button) -> Void) = { viewController in
            { [weak viewController] _ in
                viewController?.dismiss(animated: true)
            }
        }

        public var didSelectSecondaryActionButton: ((UIViewController) -> (Button) -> Void) = { viewController in
            { [weak viewController] _ in
                viewController?.dismiss(animated: true)
            }
        }

        public init() { }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreen+Router.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreenViewController.swift ---
//
//  GenericErrorScreenViewController.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import UIKit
import BackbaseDesignSystem

public final class GenericErrorScreenViewController: UIViewController {
    private let viewModel: GenericErrorScreenViewModel
    private let configuration: GenericErrorScreen.Configuration

    private lazy var iconImageView = configure(UIImageView()) {
        $0.snp.makeConstraints { $0.size.equalTo(CGSize(width: 111, height: 111)) }
        configuration.designs.iconStyle($0)
        $0.image = configuration.designs.icon
    }

    private lazy var titleLabel = configure(UILabel()) {
        configuration.designs.titleLabelStyle($0)
        $0.text = configuration.strings.title
    }

    private lazy var exitLabel = configure(UILabel()) {
        configuration.designs.exitLabel($0)
        $0.text = configuration.strings.exitLabel
    }

    private lazy var bodyLabel = configure(UILabel()) {
        configuration.designs.bodyLabelStyle($0)

        guard let bodyString = configuration.strings.body else { return }
        $0.attributedText = NSAttributedString(
            string: bodyString,
            attributes: [.paragraphStyle: configuration.designs.bodyLabelParagraphStyle])
    }

    private lazy var primaryActionButton = configure(Button()) {
        $0.snp.makeConstraints { $0.height.equalTo(56) }
        configuration.designs.primaryActionButtonStyle($0)
        $0.setTitle(configuration.strings.primaryActionButtonTitle, for: .normal)
        $0.addTarget(self, action: #selector(primaryActionSubmit(_:)), for: .touchUpInside)
    }

    

    private lazy var secondaryActionButton = configure(Button()) {
        $0.snp.makeConstraints { $0.height.equalTo(56) }
        configuration.designs.secondaryActionButtonStyle($0)
        $0.setTitle(configuration.strings.secondaryActionButtonTitle, for: .normal)
        $0.addTarget(self, action: #selector(secondaryActionSubmit(_:)), for: .touchUpInside)
    }

    public init(viewModel: GenericErrorScreenViewModel, configuration: GenericErrorScreen.Configuration) {
        self.viewModel = viewModel
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        setupUI()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !viewModel.isButtonClicked {
            viewModel.controllerDismissed()
        }
    }

    private func setupUI() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default

        let iconView = UIView()
        iconView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        let mainStack = UIStackView(axis: .vertical)
        mainStack.addArrangedSubview(SpacerView(heightMode: .flexibleBetween(16...46)))

        if configuration.designs.icon != nil {
            mainStack.addArrangedSubview(iconView)
            mainStack.addArrangedSubview(SpacerView(heightMode: .fixed(10)))
        }

        if configuration.strings.title != nil {
            mainStack.addArrangedSubview(titleLabel)
            mainStack.addArrangedSubview(SpacerView(heightMode: .fixed(12)))
        }

        if configuration.strings.body != nil {
            mainStack.addArrangedSubview(bodyLabel)
            mainStack.addArrangedSubview(SpacerView(heightMode: .flexibleMinimum(28)))
        }

        switch configuration.actionButtonDisplayMode {
        case .none:
            break

        case .primaryOnly:
            mainStack.addArrangedSubview(primaryActionButton)

        case .secondaryOnly:
            mainStack.addArrangedSubview(secondaryActionButton)

        case .primaryAndSecondary:
            mainStack.addArrangedSubview(secondaryActionButton)
            mainStack.addArrangedSubview(primaryActionButton, spaceBefore: 16)

        case .secondaryAndPrimary:
            mainStack.addArrangedSubview(primaryActionButton)
            mainStack.addArrangedSubview(secondaryActionButton, spaceBefore: 16)
        }

        view.addSubview(mainStack)

        if configuration.isExitLabelVisible {
            view.addSubview(exitLabel)
            exitLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.equalToSuperview().inset(16)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
            }
            mainStack.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
                $0.bottom.equalTo(exitLabel.snp.top).offset(16)
                $0.leading.trailing.equalToSuperview().inset(16)
            }
        } else {
            mainStack.snp.makeConstraints {
                $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
                $0.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }

    @objc
    private func primaryActionSubmit(_ sender: Button) {
        viewModel.primaryActionSubmit(sender)
    }

    @objc
    private func secondaryActionSubmit(_ sender: Button) {
        viewModel.secondaryActionSubmit(sender)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/GenericErrorScreenViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/ErrorScreenPresenter.swift ---
//
//  ErrorScreenPresenter.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 13/04/2023.
//

import UIKit
import ClientCommon

public protocol ErrorScreenPresenterProtocol {
    func presentErrorSheet(
        on viewController: UIViewController,
        context: PresentableContext,
        error: Error,
        callback: @escaping () async -> Void
    )
    func presentErrorSheet(
        on viewController: UIViewController,
        context: PresentableContext,
        error: Error
    )
    func presentErrorSheet(
        on viewController: UIViewController,
        context: PresentableContext,
        type: GenericErrorScreen.Configuration.Option,
        outsiteDismissCallback: (() async -> Void)?,
        callback: (() async -> Void)?
    )
    func presentErrorSheet(
        on viewController: UIViewController,
        error: Error,
        callback: @escaping () async -> Void
    )

    func presentErrorSheetWithDismissCallback(
        on viewController: UIViewController,
        error: Error,
        callback: @escaping () async -> Void
    )

    func presentErrorSheet(
        on viewController: UIViewController,
        error: Error
    )
    func presentErrorSheet(
        on viewController: UIViewController,
        type: GenericErrorScreen.Configuration.Option,
        callback: (() async -> Void)?
    )
    func presentErrorSheetWithDismissCallback(
        on viewController: UIViewController,
        type: GenericErrorScreen.Configuration.Option,
        dismiss: @escaping (() async -> Void),
        callback: (() async -> Void)?
    )
}

public struct ErrorScreenPresenter: ErrorScreenPresenterProtocol {
    public init() {}

    public func presentErrorSheet(
        on viewController: UIViewController,
        error: Error,
        callback: @escaping () async -> Void
    ) {
        presentErrorSheet(
            on: viewController,
            context: AlwaysPresentable(),
            type: errorOption(for: error),
            outsiteDismissCallback: nil,
            callback: callback
        )
    }

    public func presentErrorSheetWithDismissCallback(
        on viewController: UIViewController,
        error: Error,
        callback: @escaping () async -> Void
    ) {
        presentErrorSheet(
            on: viewController,
            context: AlwaysPresentable(),
            type: errorOption(for: error),
            outsiteDismissCallback: callback,
            callback: nil
        )
    }

    public func presentErrorSheet(
        on viewController: UIViewController,
        error: Error
    ) {
        presentErrorSheet(
            on: viewController,
            context: AlwaysPresentable(),
            type: errorOption(for: error),
            outsiteDismissCallback: nil,
            callback: nil
        )
    }

    public func presentErrorSheetWithDismissCallback(
        on viewController: UIViewController,
        type: GenericErrorScreen.Configuration.Option,
        dismiss: @escaping (() async -> Void),
        callback: (() async -> Void)?
    ) {
        presentErrorSheet(
            on: viewController,
            context: AlwaysPresentable(),
            type: type,
            outsiteDismissCallback: dismiss,
            callback: callback
        )
    }

    public func presentErrorSheet(
        on viewController: UIViewController,
        type: GenericErrorScreen.Configuration.Option,
        callback: (() async -> Void)?
    ) {
        presentErrorSheet(
            on: viewController,
            context: AlwaysPresentable(),
            type: type,
            outsiteDismissCallback: nil,
            callback: callback
        )
    }

    public func presentErrorSheet(
        on viewController: UIViewController,
        context: PresentableContext,
        error: Error,
        callback: @escaping () async -> Void
    ) {
        presentErrorSheet(
            on: viewController,
            context: context,
            type: errorOption(for: error),
            outsiteDismissCallback: nil,
            callback: callback
        )
    }

    public func presentErrorSheet(
        on viewController: UIViewController,
        context: PresentableContext,
        error: Error
    ) {
        presentErrorSheet(
            on: viewController,
            context: context,
            type: errorOption(for: error),
            outsiteDismissCallback: nil,
            callback: nil
        )
    }

    public func presentErrorSheet(
        on viewController: UIViewController,
        context: PresentableContext,
        type: GenericErrorScreen.Configuration.Option,
        outsiteDismissCallback: (() async -> Void)?,
        callback: (() async -> Void)?
    ) {
        guard context.isContextAvailable else { return }
        var configuration = GenericErrorScreen.Configuration.make(for: type)
        configuration.actionButtonDisplayMode = callback != nil ? .primaryOnly : .none
        configuration.router.didDismiss = {
            Task { await outsiteDismissCallback?() }
        }
        configuration.router.didSelectPrimaryActionButton = { viewController in { [weak viewController] _ in
                viewController?.dismiss(animated: true) {
                    Task { await callback?() }
                }
            }
        }
        DispatchQueue.main.async {
            let destination = GenericErrorScreen.build(configuration: configuration)
            viewController.present(destination, animated: true)
        }

    }

    private func errorOption(for error: Error) -> GenericErrorScreen.Configuration.Option {
        if case ClientCommon.ErrorResponse.error(_, _, let callError) = error,
           let callError = callError as? CallError, callError.isInternetConnectionError {
            return .noInternetConnection
        }
        return .somethingWentWrong
    }
}

extension CallError {
    public var isInternetConnectionError: Bool {
        let underlyingError: Error?
        switch self {
        case .nilHTTPResponse(let error), .unsuccessfulHTTPStatusCode(let error):
            underlyingError = error
        case .generalError(let error):
            underlyingError = error
        default: return false
        }
        return (underlyingError as? NSError)?.code == NSURLErrorNotConnectedToInternet
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Generic Error Screen/ErrorScreenPresenter.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/DatePickerInputView.swift ---
//
//  DatePickerInputView.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 25/05/2023.
//

import UIKit
import SwiftUI
import BackbaseDesignSystem
import Resolver

public struct DatePickerInputView: UIViewRepresentable {
    @Injected private var configuration: SNBCommon.Configuration
    @Binding var date: Date?
    let placeholder: String
    var calendar: Calendar = .autoupdatingCurrent
    let dateFormatter: DateFormatter
    let locale: Locale
    private let minimumDate: Date?
    private let maximumDate: Date?

    public init(
        date: Binding<Date?>,
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        placeholder: String,
        calendar: Calendar,
        dateFormatter: DateFormatter,
        locale: Locale
    ) {
        self._date = date
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.placeholder = placeholder
        self.calendar = calendar
        self.dateFormatter = dateFormatter
        self.locale = locale
    }

    public func makeUIView(context: Context) -> DatePickerTextField {
        let textField = DatePickerTextField(
            date: $date,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            calendar: calendar,
            locale: locale,
            frame: .zero
        )
        textField.setNaturalTextAlignment()
        textField.placeholder = placeholder
        if let date = date {
            textField.text = dateFormatter.string(from: date)
        }
        textField.rightView = UIImageView(image: configuration.images.calendarIcon)
        textField.rightViewMode = .always
        return textField
    }

    public func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        if let date = date {
            uiView.text = dateFormatter.string(from: date)
        }
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

public final class DatePickerTextField: ActionsProtectedTextField {
    @Binding var date: Date?
    var calendar: Calendar = .autoupdatingCurrent
    private let locale: Locale
    private let minimumDate: Date?
    private let maximumDate: Date?

    @Injected private var configuration: SNBCommon.Configuration
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.calendar = calendar
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.locale = locale
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = DesignSystem.shared.colors.foundation.default
        return datePicker
    }()
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: configuration.strings.doneButton,
            style: .plain,
            target: self,
            action: #selector(dismissTextField)
        )
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }()

    public init(
        date: Binding<Date?>,
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        calendar: Calendar,
        locale: Locale,
        frame: CGRect
    ) {
        self._date = date
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.calendar = calendar
        self.locale = locale
        super.init(frame: frame)

        inputView = datePicker
        inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        if let date = date.wrappedValue {
            datePicker.date = date
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }

    @objc private func dismissTextField() {
        date = datePicker.date
        resignFirstResponder()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/DatePickerInputView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Styles/PrimaryButtonStyle.swift ---
//
//  PrimaryButtonStyle.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 15/03/2023.
//

import SwiftUI
import BackbaseDesignSystem

public struct PrimaryButtonStyle: ButtonStyle {
    public enum Size {
        case small, big, custom(height: CGFloat = 56.0, padding: CGFloat = DesignSystem.shared.spacer.md)
    }

    let isEnabled: Bool
    let isLoading: Bool
    var size: Size = .big

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(PrimaryButtonStyleModifier(size: size))
            .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
            .background(backgroundColor(isPressed: configuration.isPressed))
            .overlay {
                if isLoading {
                    ZStack {
                        backgroundColor(isPressed: true)
                        ProgressView()
                    }
                }
            }
            .clipShape(Capsule())
            .animation(.default, value: configuration.isPressed)
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        guard isEnabled else {
            return DesignSystem.shared.colors.neutrals.neutral20.color
        }
        return DesignSystem.shared.colors.neutrals.neutral100.color
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        guard isEnabled else {
            return DesignSystem.shared.colors.neutrals.neutral10.color
        }
        if isPressed {
            return DesignSystem.shared.colors.selected.default.color
        }
        return DesignSystem.shared.colors.primary.default.color
    }
}

struct PrimaryButtonStyleModifier: ViewModifier {
    let size: PrimaryButtonStyle.Size

    func body(content: Content) -> some View {
        switch size {
        case .small:
            content
                .padding(.vertical, DesignSystem.shared.spacer.sm)
                .padding(.horizontal, DesignSystem.shared.spacer.md)
                .font(.preferredFont(.subheadline, .medium))
        case .custom(let height, let padding):
            content
                .frame(height: height)
                .padding(.horizontal, padding)
                .font(.preferredFont(.body, .medium))
        case .big:
            content
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .font(.preferredFont(.body, .medium))
        }
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static func primary(isEnabled: Bool = true, isLoading: Bool = false, size: PrimaryButtonStyle.Size = .big) -> Self {
        .init(isEnabled: isEnabled, isLoading: isLoading, size: size)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Styles/PrimaryButtonStyle.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Styles/SecondaryButtonStyle.swift ---
//
//  SecondaryButtonStyle.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 25/03/2023.
//

import SwiftUI
import BackbaseDesignSystem

public struct SecondaryButtonStyle: ButtonStyle {
    public enum Size {
        case small, big
    }

    let isEnabled: Bool
    let isLoading: Bool
    let foregroundColor: UIColor
    let borderColor: UIColor
    var size: Size = .big

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(SecondaryButtonStyleModifier(size: size))
            .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .overlay {
                Capsule()
                    .strokeBorder(borderColor(isPressed: configuration.isPressed), lineWidth: 1)
            }
            .contentShape(Capsule())
            .animation(.default, value: configuration.isPressed)
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        guard !isLoading else {
            return Color.clear
        }
        if isPressed || !isEnabled {
            return foregroundColor.withAlphaComponent(0.3).color
        }
        return foregroundColor.color
    }

    private func borderColor(isPressed: Bool) -> Color {
        if isPressed || !isEnabled {
            return borderColor.withAlphaComponent(0.3).color
        }
        return borderColor.color
    }
}

struct SecondaryButtonStyleModifier: ViewModifier {
    let size: SecondaryButtonStyle.Size

    func body(content: Content) -> some View {
        switch size {
        case .small:
            content
                .font(.preferredFont(.subheadline, .medium))
                .frame(height: 28)
                .padding(.horizontal, DesignSystem.shared.spacer.md)
        case .big:
            content
                .font(.preferredFont(.body, .medium))
                .frame(height: 56)
                .frame(maxWidth: .infinity)
        }
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static func secondary(
        isEnabled: Bool = true,
        isLoading: Bool = false,
        foregroundColor: UIColor = DesignSystem.shared.colors.text.support,
        borderColor: UIColor = DesignSystem.shared.colors.text.support,
        size: SecondaryButtonStyle.Size = .big
    ) -> Self {
        .init(
            isEnabled: isEnabled,
            isLoading: isLoading,
            foregroundColor: foregroundColor,
            borderColor: borderColor,
            size: size)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Styles/SecondaryButtonStyle.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SearchTextField.swift ---
//
//  SearchTextField.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 21/02/2023.
//

import SwiftUI
import BackbaseDesignSystem
import Resolver

public struct SearchTextField: View {
    @Injected private var configuration: SNBCommon.Configuration
    @FocusState private var searchFocus: Bool
    private let placeholder: String
    @Binding private var searchText: String

    public init(placeholder: String, searchText: Binding<String>) {
        self.placeholder = placeholder
        self._searchText = searchText
    }

    public var body: some View {
        TextField(
            "",
            text: $searchText,
            prompt: Text(placeholder).foregroundColor(DesignSystem.shared.colors.text.disabled.color)
        )
        .focused($searchFocus)
        .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
        .foregroundColor(DesignSystem.shared.colors.text.default.color)
        .padding(.leading, 36)
        .frame(height: 36)
        .background(Color(red: 118/255, green: 118/255, blue: 128/255, opacity: 0.12)) // component specific
        .cornerRadius(DesignSystem.shared.cornerRadius.medium)
        .overlay(
            Image(systemName: "magnifyingglass")
                .foregroundColor(DesignSystem.shared.colors.neutrals.neutral60.color)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
        )
        .roundedBorder(cornerRadius: 10)
        .contentShape(Rectangle())
        .onTapGesture { searchFocus = true }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(configuration.strings.doneButton) { searchFocus = false }
            }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SearchTextField.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+cornerRadius.swift ---
//
//  View+cornerRadius.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 26/02/2023.
//

import SwiftUI

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+cornerRadius.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SpacerView.swift ---
//
//  SpacerView.swift
//  SNBCommon
//
//  Created by Gabriel Rodrigues Minucci on 20/02/2023.
//

import UIKit

/// Creates a spacer with fixed or flexible constraints on each axis
public final class SpacerView: UIView {
    public enum SpacingMode {
        case flexible
        case flexibleMinimum(CGFloat)
        case flexibleBetween(ClosedRange<CGFloat>)
        case fixed(CGFloat)
    }

    public init(widthMode: SpacingMode = .flexible, heightMode: SpacingMode = .flexible) {
        super.init(frame: .zero)

        setupWidthSpacing(with: widthMode)
        setupHeightSpacing(with: heightMode)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupWidthSpacing(with mode: SpacingMode) {
        switch mode {
        case .flexible:
            return

        case let .flexibleMinimum(width):
            snp.makeConstraints { $0.width.greaterThanOrEqualTo(width) }

        case let .flexibleBetween(range):
            snp.makeConstraints {
                $0.width.greaterThanOrEqualTo(range.lowerBound)
                $0.width.lessThanOrEqualTo(range.upperBound)
            }

        case let .fixed(width):
            snp.makeConstraints { $0.width.equalTo(width) }
        }
    }

    private func setupHeightSpacing(with mode: SpacingMode) {
        switch mode {
        case .flexible:
            return

        case let .flexibleMinimum(height):
            snp.makeConstraints { $0.height.greaterThanOrEqualTo(height) }

        case let .flexibleBetween(range):
            snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(range.lowerBound)
                $0.height.lessThanOrEqualTo(range.upperBound)
            }

        case let .fixed(height):
            snp.makeConstraints { $0.height.equalTo(height) }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SpacerView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CardContentView.swift ---
//
//  CardContentView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 06/03/2023.
//

import UIKit
import SnapKit
import BackbaseDesignSystem

public final class CardContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    public func makeDefaultConstraints(topInset: CGFloat = DesignSystem.shared.spacer.sm) {
        guard let superview else {
            return assertionFailure("CardContentView was not added to the view hierarchy")
        }
        snp.makeConstraints {
            $0.top.equalTo(superview.safeAreaLayoutGuide).inset(topInset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CardContentView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AvatarView.swift ---
//
//  AvatarView.swift
//  RetailApp
//
//  Created by Rafael Nascimento on 19/04/2023.
//

import UIKit
import BackbaseDesignSystem
import SwiftUI
import Resolver

public struct AvatarView: View {
    @Injected private var configuration: SNBCommon.Configuration
    private let size: UIKitAvatarView.Size

    public init(size: UIKitAvatarView.Size = .default) {
        self.size = size
    }

    public var body: some View {
        Image(uiImage: AvatarLocalImageManager.shared.getSavedImage() ?? configuration.images.avatar)
            .resizable()
            .frame(width: size.rawValue, height: size.rawValue)
            .clipShape(Circle())
    }
}

/// View that can show a user’s profile image
/// It can be shown in 3 different sizes, small, default and large.
public final class UIKitAvatarView: UIView {
    @Injected private var configuration: SNBCommon.Configuration

    /// Defines the size of the avatar view from `large`, `small` and `default` options
    public enum Size: CGFloat {
        /// The size of the avatar is 60x60
        case `default` = 60
        /// The size of the avatar is 80x80
        case large = 80
        /// The size of the avatar is 40x40
        case small = 40
        /// The size of the avatar is 32x32
        case xsmall = 32
    }

    /// Method to be called when the trait collection changed for the button.
    public var onTraitCollectionDidChange: ((UITraitCollection?) -> Void)?

    /// Set the size of the avatar view from `large`, `small` and `default` options
    public var size: Size = .default {
        didSet {
            constraints.forEach { $0.isActive = false }
            setupView()
        }
    }

    // The image to display
    public var image: UIImage? {
        didSet { imageView.image = image }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = DesignSystem.CornerRadiusTypes.max(roundedCorners: .allCorners).calculateFor(layer).radius
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        onTraitCollectionDidChange?(previousTraitCollection)
    }

    /// Initialize and return an avatar view
    /// - Parameters:
    ///   - size: Defines the size of the avatar view using `Size` enum
    ///   - style: Defines the style of the avatar using `Style` enum
    public init(size: Size = .default) {
        super.init(frame: .zero)
        self.size = size
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var imageView: CustomAlignmentImageView = {
        let imageView = CustomAlignmentImageView()
        imageView.horizontalAlignment = .center
        imageView.verticalAlignment = .top
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}

private extension UIKitAvatarView {
    func setupView(with defaultImage: UIImage? = UIImage.named("avatar", in: .snbCommon)) {
        // TODO: Remove this when the Avatar Image is connected to the BE
        image = AvatarLocalImageManager.shared.getSavedImage() ?? defaultImage
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.rawValue),
            heightAnchor.constraint(equalToConstant: size.rawValue)
        ])
        configureImageView()
    }

    func configureImageView() {
        subviews.forEach { $0.removeFromSuperview() }
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AvatarView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NavBarHiddenHostingController.swift ---
//
//  NavBarHiddenHostingController.swift
//  PrepaidOnboardingJourney
//
//  Created by Sudeep George on 03/07/24.
//

import SwiftUI

public class NavBarHiddenHostingController<ContentView>: UIHostingController<ContentView> where ContentView: View {
    private var isNavigationBarHidden: Bool?
    override public init(rootView: ContentView) {
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationBarHidden = navigationController?.isNavigationBarHidden
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let isNavigationBarHidden, !isNavigationBarHidden else {
            return
        }
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: false)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NavBarHiddenHostingController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/FullScreenProgressView.swift ---
//
//  FullScreenProgressView.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 07/03/2023.
//

import SwiftUI
import BackbaseDesignSystem

public struct FullScreenProgressView: View {
    private let backgroundColor: Color
    public init(backgroundColor: Color = DesignSystem.shared.colors.foundation.default.color) {
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            ProgressView()
                .tint(DesignSystem.shared.colors.neutrals.neutral50.color)
                .padding()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/FullScreenProgressView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SupportButton.swift ---
//
//  SupportButton.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 30/08/2024.
//

import BackbaseDesignSystem
import UIKit

public struct SupportButtonConfiguration {
    public struct Constants {
        let backgroundColor = DesignSystem.shared.colors.neutrals.neutral60
        let borderColor = DesignSystem.shared.colors.primary.default
        let borderWidth = 1.0
        let buttonVerticalPadding = 16.0
        let containerHeight = 26.0
        let containerRTLWidth = 93.0
        let containerSwiftUITop = 36.0
        let containerWidth = 86.0
        let iconImageViewHeight = 16.0
        let iconImageViewTrailing = 8.0
        let font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
        let offset = 4.0
        let textColor = DesignSystem.shared.colors.primary.onDefault
        let titleLableLeading = 8.0

        public let viewTrailing = 36.0

        public init() {}
    }

    public struct Strings {
        @Localizable(in: .snbCommon) var supportButton = "common.buttons.support"
    }

    public struct Images {
        var supportIcon = UIImage.named("supportIcon", in: .snbCommon)
    }
}

public class SupportButton: UIButton {
    private let constants = SupportButtonConfiguration.Constants()
    private let strings = SupportButtonConfiguration.Strings()
    private let images = SupportButtonConfiguration.Images()

    private let iconImageView = UIImageView()
    private let titleLable = UILabel()
    private let container = UIView()

    var icon: UIImage?

    private var isRTL: Bool {
        UIView.isRTL(for: semanticContentAttribute)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

private extension SupportButton {
    func setupView() {
        titleLable.text = strings.supportButton
        iconImageView.image = images.supportIcon
        configureSubviews()
        applyStyles()
        applyConstraints()
    }

    func configureSubviews() {
        container.addSubview(titleLable)
        container.addSubview(iconImageView)
        addSubview(container)
    }

    func applyStyles() {
        isUserInteractionEnabled = true
        container.isUserInteractionEnabled = false
        backgroundColor = constants.backgroundColor
        layer.borderWidth = constants.borderWidth
        layer.borderColor = constants.borderColor.cgColor
        titleLable.textColor = constants.textColor
        titleLable.font = constants.font
        contentHorizontalAlignment = .leading
    }

    func applyConstraints() {
        let containerWidth: CGFloat = isRTL ? constants.containerRTLWidth : constants.containerWidth
        container.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(constants.containerHeight)
            make.width.equalTo(containerWidth)
        }

        titleLable.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(constants.titleLableLeading)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(constants.offset)
            make.trailing.equalToSuperview().inset(constants.iconImageViewTrailing)
            make.height.width.equalTo(constants.iconImageViewHeight)
            make.centerY.equalToSuperview()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/SupportButton.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/ProgressWithBackground.swift ---
//
//  ProgressWithBackground.swift
//  SNBCommon
//
//  Created by Dhaval Panchal on 20/06/23.
//

import SwiftUI
import BackbaseDesignSystem
import Resolver

public struct ProgressWithBackground: View {
    public enum BackgroundType {
        case solid
        case semiTransparent
    }

    struct Constants {
        static let transparentOpacity = 0.4
    }

    let backgroundType: BackgroundType
    let title: String?

    public init(backgroundType: BackgroundType = .solid, title: String? = nil) {
        self.backgroundType = backgroundType
        self.title = title
    }

    public var body: some View {
        ZStack {
            (
                backgroundType == .solid
                ? DesignSystem.shared.colors.surfacePrimary.default.color
                : DesignSystem.shared.colors.highlight.foundation.withAlphaComponent(Constants.transparentOpacity).color
            )
            .ignoresSafeArea()

            VStack {
                ProgressView()
                    .tint(DesignSystem.shared.colors.neutrals.neutral50.color)
                    .controlSize(.large)
                    .padding()
                if let title {
                    getTitle(title)
                }
            }
        }
    }

    private func getTitle(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.preferredFont(.body, .regular))
            .foregroundColor(DesignSystem.shared.colors.neutrals.neutral00.color)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/ProgressWithBackground.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NoSearchResultsView/UIKitNoSearchResultsView.swift ---
//
//  UIKitNoSearchResultsView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 28/05/2023.
//

import UIKit
import SnapKit
import Resolver
import BackbaseDesignSystem

public final class UIKitNoSearchResultsView: UIView {
    public lazy var textTitle = configuration.strings.noSearchResultsTitle {
        didSet { titleLabel.text = textTitle }
    }
    public lazy var textDescription = configuration.strings.noSearchResultsDescription {
        didSet { configuration.styles.noSearchResultsDescription((descriptionLabel, textDescription)) }
    }

    private lazy var stackView = configure(UIStackView()) {
        $0.spacing = DesignSystem.shared.spacer.sm
        $0.axis = .vertical
    }
    private lazy var iconView = configure(UIImageView()) {
        $0.image = configuration.images.noSearchResultsIcon
        $0.contentMode = .scaleAspectFit
    }
    private lazy var titleLabel = configure(UILabel()) {
        $0.text = textTitle
        configuration.styles.noSearchResultsTitle($0)
    }
    private lazy var descriptionLabel = configure(UILabel()) {
        configuration.styles.noSearchResultsDescription(($0, textDescription))
    }

    @Injected private var configuration: SNBCommon.Configuration

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = DesignSystem.shared.colors.foundation.default
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.xl)
            $0.bottom.equalToSuperview().inset(DesignSystem.shared.spacer.xl).priority(.medium)
        }
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(titleLabel, spaceBefore: 22)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(UIView())

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().priority(.medium)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NoSearchResultsView/UIKitNoSearchResultsView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NoSearchResultsView/NoSearchResultsView.swift ---
//
//  NoSearchResultsView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 28/05/2023.
//

import SwiftUI
import Resolver

public struct NoSearchResultsView: UIViewRepresentable {
    private var textTitle: String?
    private var textDescription: String?

    public init(textTitle: String? = nil, textDescription: String? = nil) {
        self.textTitle = textTitle
        self.textDescription = textDescription
    }

    public func makeUIView(context: Context) -> UIKitNoSearchResultsView {
        UIKitNoSearchResultsView()
    }

    public func updateUIView(_ uiView: UIKitNoSearchResultsView, context: Context) {
        if let textTitle {
            uiView.textTitle = textTitle
        }
        if let textDescription {
            uiView.textDescription = textDescription
        }
    }
}

struct NoSearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoSearchResultsView()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/NoSearchResultsView/NoSearchResultsView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextEditorView.swift ---
//
//  TextEditorView.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 06/07/24.
//

import BackbaseDesignSystem
import Combine
import SwiftUI

public struct TextEditorView: View {
    public let title: String
    public let optionalText: String?
    public let placeholderText: String
    @Binding public var bindableText: String
    public let characterLimit: Int
    public let showRemainingChars: Bool
    public let backgroundColor: Color
    public let lineLimit: Int
    public let disabled: Bool

    public init(
        title: String,
        optionalText: String? = nil,
        placeholderText: String,
        bindableText: Binding<String>,
        characterLimit: Int,
        showRemainingChars: Bool = false,
        backgroundColor: Color = Color.clear,
        lineLimit: Int = 4,
        disabled: Bool = false
    ) {
        self.title = title
        self.optionalText = optionalText
        self.placeholderText = placeholderText
        self._bindableText = bindableText
        self.characterLimit = characterLimit
        self.showRemainingChars = showRemainingChars
        self.backgroundColor = backgroundColor
        self.lineLimit = lineLimit
        self.disabled = disabled
    }

    private var attributedTitle: AttributedString {
        var attrTitle = AttributedString(title)
        attrTitle.font = DesignSystem.shared.fonts.preferredFont(.body, .medium).font
        attrTitle.foregroundColor = DesignSystem.shared.colors.text.default.color
        return attrTitle
    }

    private var attributedOptionalText: AttributedString {
        if let optionalText {
            var attrOptional = AttributedString(optionalText)
            attrOptional.font = DesignSystem.shared.fonts.preferredFont(.body, .regular).font
            attrOptional.foregroundColor = DesignSystem.shared.colors.text.support.color
            return attrOptional
        }
        return AttributedString()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.sm) {
            Text(attributedTitle + " " + attributedOptionalText)
            if #available(iOS 16.0, *) {
                textEditorForiOS16AndAbove
            } else {
                textEditorForiOS15AndBelow
            }
            if showRemainingChars {
                Text(characterCountText)
                    .monospacedDigit()
                    .font(DesignSystem.shared.fonts.preferredFont(.callout, .regular).font)
                    .foregroundStyle(DesignSystem.shared.colors.text.support.color)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    @available(iOS 16.0, *)
    private var textEditorForiOS16AndAbove: some View {
        TextField(
            "",
            text: $bindableText,
            prompt: Text(placeholderText)
                .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
                .foregroundColor(DesignSystem.shared.colors.text.support.color),
            axis: .vertical
        )
        .disabled(disabled)
        .lineSpacing(4)
        .lineLimit(lineLimit, reservesSpace: true)
        .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
        .foregroundStyle(DesignSystem.shared.colors.text.support.color)
        .padding(.all, DesignSystem.shared.spacer.sm + DesignSystem.shared.spacer.xs)
        .autocorrectionDisabled()
        .roundedBorder(cornerRadius: DesignSystem.shared.cornerRadius.medium, backgroundColor: backgroundColor)
    }

    private var textEditorForiOS15AndBelow: some View {
        ZStack(alignment: .leading) {
            if bindableText.isEmpty {
                TextEditor(text: .constant(placeholderText))
                    .frame(height: 112)
                    .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
                    .foregroundStyle(DesignSystem.shared.colors.text.support.color)
                    .lineSpacing(4)
                    .padding(.all, DesignSystem.shared.spacer.sm)
                    .disabled(true)
            }
            TextEditor(text: $bindableText)
                .disabled(disabled)
                .frame(height: 112)
                .font(DesignSystem.shared.fonts.preferredFont(.body, .regular).font)
                .foregroundStyle(DesignSystem.shared.colors.text.support.color)
                .lineSpacing(4)
                .padding(.all, DesignSystem.shared.spacer.sm)
                .autocorrectionDisabled()
                .transparentScrollingBackground(publisher: bindableText)
                .roundedBorder(cornerRadius: DesignSystem.shared.cornerRadius.medium, backgroundColor: backgroundColor)
        }
    }

    private var characterCountText: String {
        String("\(bindableText.count)/\(characterLimit)")
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(
            title: "",
            optionalText: nil,
            placeholderText: "",
            bindableText: .constant(""),
            characterLimit: 0,
            showRemainingChars: false
        )
    }
}

internal extension View {

    /**
     This is a workaround for adding placeholder to TextEditor until we get view modifier from SwiftUI. And It works only in iOS 16 and above versions.
     The lower versions iOS 15 and below will have TextEditor background with a less opacity which makes the placeholder text color a bit dim and cursor with slightly visible.
     Remember this points before using this view modifier.
     */
    func transparentScrollingBackground(publisher: String) -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return opacity(publisher.isEmpty ? 0.1 : 1)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextEditorView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AddToAppleWalletButton.swift ---
//
//  AddToAppleWalletButton.swift
//  SNBCommon
//
//  Created by Vaibhav Misra on 04/06/24.
//

import BackbaseDesignSystem
import PassKit
import SwiftUI

public struct AddToAppleWalletButton: UIViewRepresentable {
    let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public func makeUIView(context: Context) -> PKAddPassButton {
        let button = PKAddPassButton(addPassButtonStyle: .black)
        let didTapAppleWalletButtonAction = UIAction { uiAction in
            action()
        }
        button.addAction(didTapAppleWalletButtonAction, for: .touchUpInside)
        return button
    }

    public func updateUIView(_ uiView: PKAddPassButton, context: Context) { }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/AddToAppleWalletButton.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+shadow.swift ---
//
//  View+shadow.swift
//  SNBCommon
//
//  Created by Vaibhav Misra on 28/08/24.
//

import SwiftUI
import BackbaseDesignSystem

public extension View {

    func customShadow(style: DesignSystem.ShadowStyle) -> some View {
        var shadowStyle: DesignSystem.Shadow
        switch style {
        case .none:
            shadowStyle = DesignSystem.shared.shadows.none
        case .small:
            shadowStyle = DesignSystem.shared.shadows.small
        case .medium:
            shadowStyle = DesignSystem.shared.shadows.medium
        case .large:
            shadowStyle = DesignSystem.shared.shadows.large
        case .xLarge:
            shadowStyle = DesignSystem.shared.shadows.xLarge
        @unknown default:
            fatalError("Unsupported Shadow style")
        }
        return shadow(
            color: shadowStyle.color.color.opacity(Double(shadowStyle.opacity)),
            radius: shadowStyle.radius,
            x: shadowStyle.offset.width,
            y: shadowStyle.offset.height
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/View+shadow.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/HostingController+barStyle.swift ---
//
//  HostingController+barStyle.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 01/03/2023.
//

import BackbaseDesignSystem
import SwiftUI
import UIKit

open class HostingController<ContentView>: UIHostingController<HostingController.HostView<ContentView>> where ContentView: View {
    private let barStyle: UIStatusBarStyle

    public override var preferredStatusBarStyle: UIStatusBarStyle { barStyle }

    public init(rootView: ContentView, barStyle: UIStatusBarStyle) {
        self.barStyle = barStyle
        super.init(rootView: HostView(view: rootView))
    }

    @available(*, unavailable)
    @MainActor required dynamic public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public struct HostView<V>: View where V: View {
       let view: V
       public var body: some View {
            view.forceCorrectSementicContentAttribute()
        }
    }
}

extension UIViewController {
    public func makeNavigationBarTransparent() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()

        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: DesignSystem.shared.colors.surfacePrimary.default,
            .font: DesignSystem.shared.fonts.preferredFont(.largeTitle, .medium)
        ]
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: DesignSystem.shared.colors.surfacePrimary.default,
            .font: DesignSystem.shared.fonts.preferredFont(.body, .medium)
        ]
        standardAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        standardAppearance.titleTextAttributes = titleTextAttributes

        navigationItem.standardAppearance = standardAppearance
        navigationItem.compactAppearance = standardAppearance
        navigationItem.scrollEdgeAppearance = standardAppearance
        navigationItem.compactScrollEdgeAppearance = standardAppearance
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/HostingController+barStyle.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CustomAlignmentImageView.swift ---
//
//  CustomAlignmentImageView.swift
//  RetailApp
//
//  Created by Rafael Nascimento on 19/04/2023.
//

import UIKit

/// This view allows it's UIImage to have more complex alignment
/// Horizontal Alignment and Vertical Alignment
public final class CustomAlignmentImageView: UIImageView {
    public enum HorizontalAlignment {
        case left, center, right
    }

    public enum VerticalAlignment {
        case top, center, bottom
    }

    // MARK: Public Properties

    public var horizontalAlignment: HorizontalAlignment = .center
    public var verticalAlignment: VerticalAlignment = .center

    public override var image: UIImage? {
        didSet {
            updateContentsRect()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateContentsRect()
    }

    private func updateContentsRect() {
        var contentsRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))

        guard let imageSize = image?.size else {
            layer.contentsRect = contentsRect
            return
        }

        let viewBounds = bounds
        let imageViewFactor = viewBounds.size.width / viewBounds.size.height
        let imageFactor = imageSize.width / imageSize.height

        if imageFactor > imageViewFactor {
            // Image is wider than the view, so height will match
            let scaledImageWidth = viewBounds.size.height * imageFactor
            var xOffset: CGFloat = 0.0

            if case .left = horizontalAlignment {
                xOffset = -(scaledImageWidth - viewBounds.size.width) / 2
            } else if case .right = horizontalAlignment {
                xOffset = (scaledImageWidth - viewBounds.size.width) / 2
            }

            contentsRect.origin.x = xOffset / scaledImageWidth
        } else {
            let scaledImageHeight = viewBounds.size.width / imageFactor
            var yOffset: CGFloat = 0.0

            if case .top = verticalAlignment {
                yOffset = -(scaledImageHeight - viewBounds.size.height) / 2
            } else if case .bottom = verticalAlignment {
                yOffset = (scaledImageHeight - viewBounds.size.height) / 2
            }

            contentsRect.origin.y = yOffset / scaledImageHeight
        }

        layer.contentsRect = contentsRect
    }

}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/CustomAlignmentImageView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreen.swift ---
//
//  GenericErrorScreen.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import UIKit

public enum LogoutScreen {
    public static func build(configuration: Configuration) -> UIViewController {
        let viewModel = LogoutScreenViewModel(configuration: configuration)
        let viewController = LogoutScreenViewController(viewModel: viewModel, configuration: configuration)
        viewModel.viewController = viewController
        let sheetPresentationController = viewController.sheetPresentationController
        if #available(iOS 16.0, *) {
            sheetPresentationController?.detents = [.custom(resolver: { context in
                return 300 // your custom height
            })]
        } else {
            sheetPresentationController?.detents = [.medium()]
        }

        sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController?.prefersEdgeAttachedInCompactHeight = true
        sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 24.0

        return viewController
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreen.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreenViewModel.swift ---
//
//  LogoutScreenViewModel.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import UIKit

public final class LogoutScreenViewModel {
    internal unowned var viewController: UIViewController?
    private var configuration: LogoutScreen.Configuration

    init(configuration: LogoutScreen.Configuration) {
        self.configuration = configuration
    }

    func primaryActionSubmit() {
        guard let viewController else { return }
        configuration.router.didSelectPrimaryActionButton(viewController)()
    }

    func secondaryActionSubmit() {
        guard let viewController else { return }
        configuration.router.didSelectSecondaryActionButton(viewController)()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreenViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreenViewController.swift ---
//
//  LogoutScreenViewController.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import UIKit
import BackbaseDesignSystem

public final class LogoutScreenViewController: UIViewController {
    private let viewModel: LogoutScreenViewModel
    private let configuration: LogoutScreen.Configuration

    private lazy var titleLabel = configure(UILabel()) {
        configuration.designs.titleLabelStyle($0)
        $0.text = configuration.strings.title
    }

    private lazy var bodyLabel = configure(UILabel()) {
        configuration.designs.bodyLabelStyle($0)
        $0.attributedText = NSAttributedString(
            string: configuration.strings.message,
            attributes: [.paragraphStyle: configuration.designs.bodyLabelParagraphStyle])
    }

    private lazy var primaryActionButton = configure(Button()) {
        $0.snp.makeConstraints { $0.height.equalTo(56) }
        configuration.designs.primaryActionButtonStyle($0)
        $0.setTitle(configuration.strings.yesButton, for: .normal)
        $0.addTarget(self, action: #selector(primaryActionSubmit(_:)), for: .touchUpInside)
    }

    private lazy var secondaryActionButton = configure(Button()) {
        $0.snp.makeConstraints { $0.height.equalTo(56) }
        configuration.designs.secondaryActionButtonStyle($0)
        $0.setTitle(configuration.strings.noButton, for: .normal)
        $0.addTarget(self, action: #selector(secondaryActionSubmit(_:)), for: .touchUpInside)
    }

    public init(viewModel: LogoutScreenViewModel, configuration: LogoutScreen.Configuration) {
        self.viewModel = viewModel
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default

        let mainStack = UIStackView(axis: .vertical)

        let stack = UIStackView(axis: .vertical)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(SpacerView(heightMode: .fixed(12)))

        stack.addArrangedSubview(bodyLabel)
        stack.addArrangedSubview(SpacerView(heightMode: .fixed(16)))

        let upperView = UIView()
        upperView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        mainStack.addArrangedSubview(upperView)
        mainStack.addArrangedSubview(secondaryActionButton)
        mainStack.addArrangedSubview(primaryActionButton, spaceBefore: 22)

        view.addSubview(mainStack)
        mainStack.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    @objc
    private func primaryActionSubmit(_ sender: Button) {
        viewModel.primaryActionSubmit()
    }

    @objc
    private func secondaryActionSubmit(_ sender: Button) {
        viewModel.secondaryActionSubmit()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreenViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreen+Configuration.swift ---
//
//  LogoutScreen+Configuration.swift
//  ActiveLabel
//
//  Created by Gabriel Rodrigues Minucci on 10/04/2023.
//

import Resolver
import Foundation
import RetailJourneyCommon
import BackbaseDesignSystem

extension LogoutScreen {
    public struct Configuration {
        public var designs = Designs()
        public var strings = Strings()
        public var router = Router()
        public init() { }

    }
}

public extension LogoutScreen.Configuration {
    struct Strings {
        @Localizable var title = "common.logout.title"
        @Localizable var message = "common.logout.message"
        @Localizable var noButton = "common.button.no"
        @Localizable var yesButton = "common.button.yes"

        public init() {}
    }
}

public extension LogoutScreen.Configuration {
    public struct Designs {

        public var titleLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.largeTitle, .bold)
            label.textColor = DesignSystem.shared.colors.text.default
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
        }

        public var bodyLabelStyle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
            label.textColor = DesignSystem.shared.colors.text.support
            label.textAlignment = .center
            label.numberOfLines = 0
        }

        public var bodyLabelParagraphStyle = configure(NSMutableParagraphStyle()) { paragraphStyle in
            paragraphStyle.lineSpacing = 5
            paragraphStyle.alignment = .center
        }

        public var primaryActionButtonStyle: Style<Button> = { button in
            DesignSystem.shared.styles.primaryButton(button)
        }

        public var secondaryActionButtonStyle: Style<Button> = { button in
            DesignSystem.shared.styles.secondaryButton(button)
        }

        public init() { }
    }
}

extension LogoutScreen.Configuration {
    public struct Router {

        public var didDismiss: (() -> Void) = {}

        public var didSelectPrimaryActionButton: ((UIViewController) -> () -> Void) = { viewController in { [weak viewController] in
                viewController?.dismiss(animated: true)
            }
        }

        public var didSelectSecondaryActionButton: ((UIViewController) -> () -> Void) = { viewController in { [weak viewController] in
                viewController?.dismiss(animated: true)
            }
        }

        public init() { }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/LogoutScreen/LogoutScreen+Configuration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextInputView/TextInputView.swift ---
//
//  TextInputView.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 23/03/23.
//

import SwiftUI
import BackbaseDesignSystem
import Resolver

public struct TextInputView<FocusValue: Equatable>: View {
    private let title: String?
    private let titleFont: Font
    @Binding private var value: String
    private let errorMessage: String?
    private let isLoading: Bool
    private let maxLength: Int?
    private let isSecureTextEntry: Bool
    private let copyPasteActionsDisabled: Bool
    private let focusState: EquatableFocusState<FocusValue>
    private let didTapReturnButton: () -> Void
    private let shouldChangeCharsIn: ((String, NSRange) -> Bool)?
    private var didEndEditing: (() -> Void)?
    private var shouldBeginEditing: (() -> Bool)?
    private var disabled: Bool
    private let configuration: (UITextField) -> Void
    private let textPasteConfiguration: ((UITextField) -> String?)?

    @Injected private var journeyConfig: SNBCommon.Configuration
    @State private var isSecureTextEnabled: Bool

    public init(
        title: String? = nil,
        titleFont: Font = .preferredFont(.body, .medium),
        value: Binding<String>,
        errorMessage: String? = nil,
        isLoading: Bool = false,
        maxLength: Int? = nil,
        isSecureTextEntry: Bool = false,
        copyPasteActionsDisabled: Bool = false,
        focusState: EquatableFocusState<FocusValue> = .init(binding: .constant(false), equals: true),
        didTapReturnButton: @escaping () -> Void = {},
        shouldChangeCharsIn: ((String, NSRange) -> Bool)? = nil,
        didEndEditing: (() -> Void)? = nil,
        shouldBeginEditing: (() -> Bool)? = nil,
        disabled: Bool = false,
        configuration: @escaping (UITextField) -> Void = { _ in },
        textPasteConfiguration: ((UITextField) -> String?)? = nil
    ) {
        self.title = title
        self.titleFont = titleFont
        self._value = value
        self.errorMessage = errorMessage
        self.isLoading = isLoading
        self.maxLength = maxLength
        self.isSecureTextEntry = isSecureTextEntry
        self.copyPasteActionsDisabled = copyPasteActionsDisabled
        self.focusState = focusState
        self.didTapReturnButton = didTapReturnButton
        self.shouldChangeCharsIn = shouldChangeCharsIn
        self.didEndEditing = didEndEditing
        self.shouldBeginEditing = shouldBeginEditing
        self.disabled = disabled
        self.configuration = configuration
        self.textPasteConfiguration = textPasteConfiguration
        self._isSecureTextEnabled = .init(initialValue: isSecureTextEntry)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.xs + 2) {
            if let title {
                Text(title)
                    .font(titleFont)
                    .foregroundColor(DesignSystem.shared.colors.text.default.color)
            }
            HStack {
                UITextFieldView(
                    text: $value,
                    copyPasteActionsDisabled: copyPasteActionsDisabled,
                    isSecureTextEntry: isSecureTextEnabled,
                    focusState: focusState,
                    didTapReturnButton: didTapReturnButton,
                    shouldChangeCharsIn: shouldChangeCharsIn,
                    didEndEditing: didEndEditing,
                    shouldBeginEditing: shouldBeginEditing,
                    configuration: configuration, 
                    textPasteConfiguration: textPasteConfiguration
                )
                .onChange(of: value) { newValue in
                    guard let maxLength else { return }
                    value = String(newValue.prefix(maxLength))
                }
                .font(.preferredFont(.body, .regular))
                .foregroundColor(DesignSystem.shared.colors.text.default.color)
                if isLoading {
                    ProgressView()
                        .tint(DesignSystem.shared.colors.neutrals.neutral50.color)
                }
                if isSecureTextEntry {
                    Button {
                        isSecureTextEnabled.toggle()
                    } label: {
                        isSecureTextEnabled ? journeyConfig.images.showPasswordIcon.image : journeyConfig.images.hidePasswordIcon.image
                    }
                }
            }
            .padding(DesignSystem.shared.spacer.md)
            .roundedBorder(
                cornerRadius: DesignSystem.shared.cornerRadius.medium,
                backgroundColor: backgroundColor,
                borderColor: inputBorderColor
            )
            .disabled(disabled)
            .padding(.top, 6)
            if let errorMessage {
                Text(errorMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.preferredFont(.footnote, .regular))
                    .foregroundColor(DesignSystem.shared.colors.danger.darker.color)
                    .padding(.top, DesignSystem.shared.spacer.sm)
            }
        }
        .animation(.default, value: isSecureTextEntry)
    }

    private var inputBorderColor: Color {
        if errorMessage != nil {
            return DesignSystem.shared.colors.danger.default.color
        } else if disabled {
            return DesignSystem.shared.colors.neutrals.neutral20.color
        } else {
            return DesignSystem.shared.colors.inputBorder.color
        }
    }

    private var backgroundColor: Color {
        disabled ? DesignSystem.shared.colors.neutrals.neutral10.color : DesignSystem.shared.colors.surfacePrimary.default.light.color
    }
}

public struct EquatableFocusState<Value: Equatable> {
    let binding: Binding<Value?>
    let value: Value

    public init(binding: Binding<Value?>, equals value: Value) {
        self.binding = binding
        self.value = value
    }
}

struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputView(
            title: "Title",
            value: .constant(""),
            errorMessage: nil,
            isLoading: false
        )
        .padding()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextInputView/TextInputView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextInputView/UITextFieldView.swift ---
//
//  UITextFieldView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 26/04/2023.
//

import SwiftUI
import UIKit

struct UITextFieldView<FocusValue: Equatable>: UIViewRepresentable {
    @Binding var text: String
    var copyPasteActionsDisabled: Bool = false
    var isSecureTextEntry: Bool = false
    var focusState: EquatableFocusState<FocusValue>
    var didTapReturnButton: () -> Void = {}
    var shouldChangeCharsIn: ((String, NSRange) -> Bool)?
    var didEndEditing: (() -> Void)?
    var shouldBeginEditing: (() -> Bool)?
    var configuration: (UITextField) -> Void = { _ in }
    var textPasteConfiguration: ((UITextField) -> String?)?

    func makeUIView(context: Context) -> UITextField {
        let textField = copyPasteActionsDisabled ? ActionsProtectedTextField() : UITextField()
        textField.delegate = context.coordinator
        textField.pasteDelegate = textPasteConfiguration != nil ? context.coordinator : nil
        textField.setNaturalTextAlignment()
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldEditingChanged), for: .editingChanged)
        textField.semanticContentAttribute = .forceLeftToRight
        configuration(textField)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecureTextEntry
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        if focusState.binding.wrappedValue == focusState.value, !uiView.isFirstResponder {
            DispatchQueue.main.async { uiView.becomeFirstResponder() }
        } else if focusState.binding.wrappedValue == nil, uiView.isFirstResponder {
            DispatchQueue.main.async { uiView.resignFirstResponder() }
        }
    }

    func makeCoordinator() -> Coordinator<FocusValue> {
        Coordinator($text, focusState, didTapReturnButton, shouldChangeCharsIn, didEndEditing, shouldBeginEditing, textPasteConfiguration)
    }

    final class Coordinator<FocusValue: Equatable>: NSObject, UITextFieldDelegate, UITextPasteDelegate {
        private var text: Binding<String>
        private let focusState: EquatableFocusState<FocusValue>
        private let didTapReturnButton: () -> Void
        var shouldChangeCharsIn: ((String, NSRange) -> Bool)?
        var didEndEditing: (() -> Void)?
        var shouldBeginEditing: (() -> Bool)?
        var didBecomeFirstResponder: Bool = false
        var textPasteConfiguration: ((UITextField) -> String?)?

        init(
            _ text: Binding<String>,
            _ focusState: EquatableFocusState<FocusValue>,
            _ didTapReturnButton: @escaping () -> Void,
            _ shouldChangeCharsIn: ((String, NSRange) -> Bool)? = nil,
            _ didEndEditing: (() -> Void)? = nil,
            _ shouldBeginEditing: (() -> Bool)? = nil,
            _ textPasteConfiguration: ((UITextField) -> String?)? = nil
        ) {
            self.text = text
            self.focusState = focusState
            self.didTapReturnButton = didTapReturnButton
            self.shouldChangeCharsIn = shouldChangeCharsIn
            self.didEndEditing = didEndEditing
            self.shouldBeginEditing = shouldBeginEditing
            self.textPasteConfiguration = textPasteConfiguration
        }

        @objc func textFieldEditingChanged(_ textField: UITextField) {
            text.wrappedValue = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            didTapReturnButton()
            return true
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async { self.focusState.binding.wrappedValue = self.focusState.value }
        }

        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            DispatchQueue.main.async { self.focusState.binding.wrappedValue = nil }
            return true
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let shouldChangeCharsIn = self.shouldChangeCharsIn else { return true }
            return shouldChangeCharsIn(string, range)
        }

        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            guard let shouldBeginEditing = self.shouldBeginEditing else { return true }
            return shouldBeginEditing()
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            didEndEditing?()
        }
        
        func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, transform item: UITextPasteItem) {
            guard let textField = textPasteConfigurationSupporting as? UITextField else { return }
            
            guard let result = textPasteConfiguration?(textField) else { return item.setNoResult() }
            
            item.setResult(string: result)
        }
    }
}

open class ActionsProtectedTextField: UITextField {
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard
            action != #selector(paste(_:)),
            action != #selector(copy(_:)),
            action != #selector(cut(_:)) else {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

extension UITextField {
    private var isRTL: Bool {
        UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
    }

    public func setNaturalTextAlignment() {
        textAlignment = isRTL ? .right : .left
    }

    public func setNaturalInvertedTextAlignment() {
        textAlignment = isRTL ? .left : .right
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/TextInputView/UITextFieldView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Loading View/LoadingViewController.swift ---
//
//  LoadingViewController.swift
//  NeoTransferJourney
//
//  Created by Nihal Khokhari on 15/09/23.
//

import BackbaseDesignSystem
import UIKit

public final class LoadingViewController: UIViewController {

    public enum ViewControllerType {
        case progressStep
        case usual

        var labelCenterYOffset: CGFloat {
            switch self {
            case .progressStep:
                return -81.0
            case .usual:
                return 0
            }
        }
    }

    struct Constants {
        static let opacity = 0.4
        static let labelHeight = 22.0
        static let labelTop = 8.0
        static let spinnerAccessibilityId = "loadingView.spinner"
        static let labelAccessibilityId = "loadingView.label"

        @Localizable static var label = "loadingView.label.text"
    }

    public let type: ViewControllerType

    private var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.color = .white
        view.hidesWhenStopped = true
        view.accessibilityIdentifier = Constants.spinnerAccessibilityId
        view.startAnimating()
        return view
    }()

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.label
        label.textColor = .white
        label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
        label.accessibilityIdentifier = Constants.labelAccessibilityId
        return label
    }()

    public init(type: ViewControllerType = .usual) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(loadingView)

        view.backgroundColor = .black.withAlphaComponent(Constants.opacity)

        loadingView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.top.equalTo(loadingView.snp.bottom).offset(Constants.labelTop)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(type.labelCenterYOffset)
            $0.height.equalTo(Constants.labelHeight)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UI Components/Loading View/LoadingViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AddReviewManager/AddReviewManager.swift ---
//
//  AddReviewManager.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 11/07/24.
//

import Resolver

public final class AddReviewManager {

    public static let shared = AddReviewManager()

    private init() {
        lastReviewedDate = UserDefaults.lastReviewedDate
    }

    // Local date variable to avoid querying UserDefaults for every check
    private var lastReviewedDate: Date? {
        didSet { UserDefaults.lastReviewedDate = lastReviewedDate }
    }
    private(set) var isAllowed: Bool = false
    private(set) var frequency: UInt = 4 // In months. Default 4

    public var canRequestReview: Bool {
        guard isAllowed else { return false }
        guard let lastDate = lastReviewedDate else { return true }
        guard let months = Calendar.current.dateComponents(
            [.month],
            from: lastDate,
            to: Date()
        ).month
        else { return false }
        return months >= frequency
    }

    public class func setAllowed(_ isAllowed: Bool) {
        shared.isAllowed = isAllowed
    }

    public class func isEnabled() -> Bool {
        shared.isAllowed
    }

    public class func requestReview(completion: @escaping () -> Void) {
        guard shared.canRequestReview else { return completion() }
        Resolver.optional(DeeplinkNavigatable.self)?.navigate(to: .addReview)
        shared.lastReviewedDate = Date()
    }

    public class func reset() {
        shared.lastReviewedDate = nil
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AddReviewManager/AddReviewManager.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/DeeplinkNavigatable.swift ---
//
//  DeeplinkNavigatable.swift
//  SNBCommon
//
//  Created by Gabriel Rodrigues Minucci on 05/04/2023.
//

import Foundation

public protocol DeeplinkNavigatable {
    func navigate(to destination: DeeplinkDestination)
}

public enum DeeplinkDestination {
    case deviceRegistrationPasswordInput(accountIdentifier: String?)
    case homeDashboard
    case cardsDashboard
    case transfersDashboard
    case bills
    case moreMenu
    case microloan
    case lending
    case lendingWithGetStarted
    case notifications
    case ekycUpdate
    case addMoney
    case suggestions(rating: Int?, review: String?)
    case addReview
    case support
    case onboarding
    case lifeStyle(code: String? = nil, gamesModule: Bool = false)
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/DeeplinkNavigatable.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/AppLanguageManager.swift ---
//
//  AppLanguageManager.swift
//  SNBCommon
//
//  Created by Nihal Khokhari on 07/11/23.
//

public enum AppLanguage {
    case arabic
    case english
}

public struct AppLanguageManager {
    public static func currentLanguage() -> AppLanguage {
        return LocaleSelector.shared.isArabic ? .arabic : .english
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/AppLanguageManager.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/UserSegmentationProvider.swift ---
//
//  UserSegmentationProvider.swift
//  SNBCommon
//
//  Created by Gabriel Rodrigues Minucci on 24/05/2024.
//

import Foundation

public protocol UserSegmentationProvider {
    /// App main theme
    var appTheme: UserSegmentationModel.AppTheme { get }

    /// Tabbar navigation options available
    var bottomBarNavigationOptions: [UserSegmentationModel.BottomBarNavigationOption] { get }

    /// Home dashboard quick actions available
    var dashboardQuickActions: [UserSegmentationModel.DashboardQuickAction] { get }

    /// Home dashboard widget tiles available
    var dashboardWidgetTiles: [UserSegmentationModel.DashboardWidgetTile] { get }

    /// Clear any locally store data related to user segmentation
    func clearLocalData()
}

public enum UserSegmentationModel {
    public enum AppTheme: String {
        case `default`
        case youth
        case expat

        public init?(rawValue: String) {
            switch rawValue {
            case Self.default.rawValue: self = .default
            case Self.youth.rawValue: self = .youth
            case Self.expat.rawValue: self = .expat
            default: return nil
            }
        }
    }

    public enum DashboardQuickAction: String {
        case exchange
        case transactions
        case addMoney = "add_money"
        case discover

        public init?(rawValue: String) {
            switch rawValue {
            case Self.exchange.rawValue: self = .exchange
            case Self.transactions.rawValue: self = .transactions
            case Self.addMoney.rawValue: self = .addMoney
            case Self.discover.rawValue: self = .discover
            default: return nil
            }
        }
    }

    public enum DashboardWidgetTile {
        case openBanking
        case mcdcBanner
        case microfinanceBanner
        case loyalty
        case marketplace
        case engageBanner(Int)

        public init?(rawValue: String) {
            switch rawValue {
            case Self.openBanking.rawValue: self = .openBanking
            case Self.mcdcBanner.rawValue: self = .mcdcBanner
            case Self.microfinanceBanner.rawValue: self = .microfinanceBanner
            case Self.loyalty.rawValue: self = .loyalty
            case Self.marketplace.rawValue: self = .marketplace
            case let value where value.hasPrefix("de_dashboard_"):
                guard let slot = Self.getEngageBannerSlot(from: value) else {
                    return nil
                }
                self = .engageBanner(slot)
            default: return nil
            }
        }

        public var rawValue: String {
            switch self {
            case .openBanking: return "open_banking"
            case .mcdcBanner: return "mcdc_banner"
            case .microfinanceBanner: return "microfinance_banner"
            case .loyalty: return "loyalty"
            case .marketplace: return "marketplace"
            default: return ""
            }
        }

        static func getEngageBannerSlot(from spaceId: String) -> Int? {
            guard let slotString = spaceId.components(separatedBy: "_").last,
                  let slot = Int(slotString) else {
                return nil
            }
            return slot
        }
    }

    public enum BottomBarNavigationOption: String, CaseIterable {
        case cards
        case transfersHub = "transfers_hub"
        case dashboard
        case bills
        case more

        public init?(rawValue: String) {
            switch rawValue {
            case Self.cards.rawValue: self = .cards
            case Self.transfersHub.rawValue: self = .transfersHub
            case Self.dashboard.rawValue: self = .dashboard
            case Self.bills.rawValue: self = .bills
            case Self.more.rawValue: self = .more
            default: return nil
            }
        }

        public var index: Int {
            return BottomBarNavigationOption.allCases.firstIndex(of: self) ?? 0
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/UserSegmentationProvider.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/LifestyleManagerInterfaceProtocol.swift ---
//
//  LifestyleManagerInterfaceProtocol.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 13/12/24.
//

import Foundation

public protocol LifestyleManagerInterfaceProtocol {
    func buildEntryPointForGames() -> UIViewController?
    func buildEntryPointForHealth() -> UIViewController?
    func buildEntryPointForLightUserGame() -> UIViewController?
    func navigateToLeaderboardJoin(withInvitationCode: String) -> UIViewController?
    var isLifeStyleEnabled: Bool { get }
    var isEntertainmentEnabled: Bool { get }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/LifestyleManagerInterfaceProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/JWTProvider.swift ---
//
//  JWTProvider.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 29/02/2024.
//

import Backbase
import Resolver

public final class JWTProvider {

    public class var decodedDict: [String: Any]? {
        let parts = jwt.components(separatedBy: ".")
        guard parts.count == 3 else { return nil }
        return getDecodedJWTPart(payload: parts[1])
    }

    public class var deviceId: String? {
        decodedDict?[Constants.deviceId] as? String
    }
}

private extension JWTProvider {

    struct Constants {
        static let authorization = "Authorization"
        static let bearerPart = "Bearer "
        static let deviceId = "device_id"
    }

    class var jwt: String {
        let tokens = Backbase.authClient().tokens()
        return tokens[Constants.authorization]?.replacingOccurrences(of: Constants.bearerPart, with: "") ?? ""
    }

    class func getDecodedJWTPart(payload: String) -> [String: Any]? {
        let payloadPaddingString = getBase64StringWithPadding(encodedString: payload)
        guard let payloadData = Data(base64Encoded: payloadPaddingString) else {
            fatalError("payload could not converted to data")
        }
            return try? JSONSerialization.jsonObject(
            with: payloadData,
            options: []) as? [String: Any]
    }

    class func getBase64StringWithPadding(encodedString: String) -> String {
        var stringTobeEncoded = encodedString.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let paddingCount = encodedString.count % 4
        for _ in 0..<paddingCount {
            stringTobeEncoded += "="
        }
        return stringTobeEncoded
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/JWTProvider.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/RUMProvider.swift ---
//
//  RUMProvider.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 02/01/2024.
//

import Foundation

public final class RUMProvider {

    private enum URLQueryItemKeys: String {
        case currentFlow
        case mfaOperation
    }

    public enum CurrentFlow: String {
        case beneficiaries = "beneficiary-choice"
        case billPayments = "bill-payment"
        case cardDetails = "card-status"
        case cardSpendingLimits = "card-spending-limits"
        case cardPin = "card-pin"
        case cardReplaceCancel = "cancel-card"
        case cardPhysical = "activate-card"
        case cardLock = "manage-card"
        case forgotPassword = "forgot-password"
        case internationalTransfers = "international-transfer-management"
        case loyalty
        case marketPlace = "marketplace"
        case neoTransfer = "neo-transfer"
        case onboarding
        case quickTransfer = "quick-transfer-management"
        case registration
        case requestMoneySent = "request-money"
        case requestMoneyReceived = "rtp-transfer"
        case resetPasswordCard = "reset-password-card"
        case resetPasswordNafath = "reset-password-nafath"
        case retailAccountAndTransactions = "account-and-transactions"
        case transferBetweenMyAccounts = "own-transfer"
    }

    public enum MfaOperation: String {
        case cardVerify = "card-verification"
        case forgotPassword = "input-required"
        case ivrInitiate = "ivr-initiate"
        case ivrVerify = "ivr-verify"
        case nafathVerify = "verify-number"
        case passwordVerification = "password-verification"
        case updatePassword = "update-password"
    }

    public static let currentFlowKey = URLQueryItemKeys.currentFlow.rawValue
    public static let mfaOperationKey = URLQueryItemKeys.mfaOperation.rawValue

    public static let currentFlow = UserDefaults.standard.string(forKey: currentFlowKey)

    public class var currentFlowPart: String? {
        guard let currentFlow = UserDefaults.standard.string(forKey: currentFlowKey) else {
            return nil
        }
        return "&\(currentFlowKey)=\(currentFlow)"
    }

    public class var currentFlowQueryItem: URLQueryItem? {
        guard let currentFlow = UserDefaults.standard.string(forKey: currentFlowKey) else {
            return nil
        }
        return URLQueryItem(name: currentFlowKey, value: currentFlow)
    }

    public static let keysToBeUpdated = [currentFlowKey, mfaOperationKey]

    public class func setCurrentFlow(with value: CurrentFlow) {
        UserDefaults.standard.set(value.rawValue, forKey: currentFlowKey)
    }

    public class func removeCurrentFlow() {
        UserDefaults.standard.removeObject(forKey: currentFlowKey)
    }

    public class func mfaOperationPart(with value: MfaOperation) -> String {
        "&\(mfaOperationKey)=\(value.rawValue)"
    }

    public class func queryItems(mfaOperationType: MfaOperation) -> [URLQueryItem] {
        var queryItems = [mfaOperationQueryItem(with: mfaOperationType)]
        if let currentFlowQueryItem {
            queryItems.append(currentFlowQueryItem)
        }
        return queryItems
    }

    public class func queryItems(mfaOperationValue: String?) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        if let mfaOperationValue {
            queryItems.append(mfaOperationQueryItem(mfaOperationValue))
        }
        if let currentFlowQueryItem {
            queryItems.append(currentFlowQueryItem)
        }
        return queryItems
    }

    private class func mfaOperationQueryItem(with value: MfaOperation) -> URLQueryItem {
        URLQueryItem(name: mfaOperationKey, value: value.rawValue)
    }

    private class func mfaOperationQueryItem(_ value: String?) -> URLQueryItem {
        URLQueryItem(name: mfaOperationKey, value: value)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/RUMProvider.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/AmountFieldValidator.swift ---
//
//  AmountFieldValidator.swift
//  RetailCardsManagementJourney
//
//  Created by Sudeep George on 14/07/24.
//

import BackbaseDesignSystem
import Foundation

public protocol AmountFieldValidatorProtocol {
    func validate(_: String?, currencyCode: String) -> Result<Void, AmountFieldValidator.Error>
}

public struct AmountFieldValidator: AmountFieldValidatorProtocol {
    public init() {}
    public enum Error: Swift.Error {
        case osError
        case multipleDecimalSeparators
        case tooManyFractionalDigits
        case notADecimal
    }

    public func validate(_ valueText: String?, currencyCode: String) -> Result<Void, Error> {
        let firstError = checks(forText: valueText, currencyCode: currencyCode).first(where: {
            if case .failure = $0 {
                return true
            } else {
                return false
            }
        })

        if let firstError {
            return firstError
        } else {
            return .success(())
        }
    }
}

private extension AmountFieldValidator {
    func checks(forText text: String?, currencyCode: String) -> [Result<Void, Error>] {
        return [
            checkForMultipleDecimalSeparators,
            checkForAmountOfDecimalDigits,
            checkForDecimalNumber
        ].map { $0(text, currencyCode) }
    }

    // MARK: - Single decimal separators

    var checkForMultipleDecimalSeparators: (String?, String) -> Result<Void, AmountFieldValidator.Error> {
        return { text, _ in
            guard let text = text else { return .success(()) }
            guard !text.isEmpty else { return .success(()) }
            guard let decimalSeparator = DesignSystem.Formatting.numberLocale.decimalSeparator else {
                return .failure(.osError)
            }

            if text.components(separatedBy: decimalSeparator).count > 2 {
                return .failure(.multipleDecimalSeparators)
            }

            return .success(())
        }
    }

    // MARK: - Maximum digits after the decimal separator

    var checkForAmountOfDecimalDigits: (String?, String) -> Result<Void, AmountFieldValidator.Error> {
        return { text, _ in
            guard let text = text else { return .success(()) }
            guard !text.isEmpty else { return .success(()) }
            if let decimalSeparator = DesignSystem.Formatting.numberLocale.decimalSeparator {
                return .success(())
            }

            return .failure(.osError)
        }
    }

    var checkForDecimalNumber: (String?, String) -> Result<Void, AmountFieldValidator.Error> {
        return { text, _ in
            guard let text = text else { return .success(()) }
            guard let decimalSeparator = DesignSystem.Formatting.numberLocale.decimalSeparator else {
                return .failure(.osError)
            }
            let separator = DesignSystem.Formatting.numberLocale.groupingSeparator ?? ""
            let amount = text.replacingOccurrences(of: separator, with: "").replacingOccurrences(of: decimalSeparator, with: "")
            guard !amount.isEmpty else { return .success(()) }
            guard Self.decimalNumberFormatter.number(from: amount) != nil else {
                return .failure(.notADecimal)
            }

            return .success(())
        }
    }

    private static var decimalNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = DesignSystem.Formatting.numberLocale
        return numberFormatter
    }()
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/AmountFieldValidator.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/KeychainItem.swift ---
//
//  KeychainItem.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 29/02/2024.
//

import Foundation
import Security

@propertyWrapper
public struct KeychainTokenItem {
    public enum TokenType {
        case firebaseToken
    }

    private let tokenType: TokenType

    private var baseDictionary: [String: AnyObject] {
        [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String: tokenType.description as AnyObject]
    }

    private var query: [String: AnyObject] {
        baseDictionary.adding(key: kSecMatchLimit as String, value: kSecMatchLimitOne)
    }

    public init(tokenType: TokenType) {
        self.tokenType = tokenType
    }

    public var wrappedValue: String? {
        get {
            do {
                return try read()
            } catch {
                return nil
            }
        }
        set {
            if let value = newValue {
                do {
                    if try read() == nil {
                        try add(value)
                    } else {
                        try update(value)
                    }
                } catch {
                    print("ERROR: `KeychainTokenItem` failed to set value into \(tokenType.description)")
                }
            } else {
                try? delete()
            }
        }
    }

    private func delete() throws {
        let status = SecItemDelete(baseDictionary as CFDictionary)
        guard status != errSecItemNotFound else { return }
        try throwIfNotZero(status)
    }

    private func read() throws -> String? {
        let query = self.query.adding(key: kSecReturnData as String, value: true as AnyObject)
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status != errSecItemNotFound else { return nil }
        try throwIfNotZero(status)
        guard let data = result as? Data, let string = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidData
        }
        return string
    }

    private func update(_ secret: String) throws {
        let dictionary: [String: AnyObject] = [
            kSecValueData as String: secret.data(using: String.Encoding.utf8)! as AnyObject
        ]
        try throwIfNotZero(SecItemUpdate(baseDictionary as CFDictionary, dictionary as CFDictionary))
    }

    private func add(_ secret: String) throws {
        let dictionary = baseDictionary.adding(key: kSecValueData as String, value: secret.data(using: .utf8)! as AnyObject)
        try throwIfNotZero(SecItemAdd(dictionary as CFDictionary, nil))
    }
}

extension KeychainTokenItem.TokenType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .firebaseToken:
            return "firebaseToken"
        }
    }
}

private func throwIfNotZero(_ status: OSStatus) throws {
    guard status != 0 else { return }
    throw KeychainError.keychainError(status: status)
}

public enum KeychainError: Error {
    case invalidData
    case keychainError(status: OSStatus)
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/KeychainItem.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/FetchState.swift ---
//
//  FetchState.swift
//  RetailApp
//
//  Created by Konrad Siemczyk on 16/12/2022.
//

import Foundation

public enum FetchState<Value> {
    case idle
    case loading
    case loaded(Value)
    case error(Error)
}

public extension FetchState {
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }

    var value: Value? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }

    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/FetchState.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/AttributedStringBuilder.swift ---
//
//  AttributedStringBuilder.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 15/02/2023.
//

import UIKit

public final class AttributedStringBuilder {
    private var attributes: [NSAttributedString.Key: Any]

    public init() {
        self.attributes = [:]
    }

    public func font(_ font: UIFont) -> Self {
        attributes[.font] = font
        return self
    }

    public func foregroundColor(_ color: UIColor) -> Self {
        attributes[.foregroundColor] = color
        return self
    }

    public func paragraphStyle(
        font: UIFont,
        lineHeight: Double? = nil,
        textAlignment: NSTextAlignment? = nil,
        minimumLineHeight: CGFloat? = nil
    ) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        if let textAlignment {
            paragraphStyle.alignment = textAlignment
        }
        if let lineHeight {
            paragraphStyle.lineSpacing = lineHeight - font.lineHeight
        }
        if let minimumLineHeight {
            paragraphStyle.minimumLineHeight = minimumLineHeight
        }
        attributes[.paragraphStyle] = paragraphStyle
        return self.font(font)
    }

    public func build(text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: attributes)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/AttributedStringBuilder.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/JWTUtilities.swift ---
//
//  JWTUtilities.swift
//  RetailApp
//
//  Created by Aman Prajapati on 25/10/23.
//

import Foundation
import Backbase

public struct JWTUtilities {

    // MARK: - Private
    private let authorizationKey = "Authorization"

    public init() {}

    public func jwtValue(key: String) -> Any? {
        guard let decodedJwt = jwtDecode() else { return nil }
        return decodedJwt[key]
    }

    private func jwtDecode() -> [String: Any]? {

        let tokens = Backbase.authClient().tokens()
        if tokens.count > 0 && tokens[authorizationKey] != nil, let token = tokens[authorizationKey] {
            let tokenSplit: [String] = token.components(separatedBy: ".")
            guard tokenSplit.indices.contains(1) else {
                return nil
            }

            var tokenBody = tokenSplit[1]
            if tokenBody.count % 4 != 0 {
                let padlen = 4 - tokenBody.count % 4
                tokenBody.append(contentsOf: repeatElement("=", count: padlen))
            }
            guard let data = Data(base64Encoded: tokenBody) else {
                return nil
            }

            do {
                let decodedJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                return decodedJson
            } catch {
                return nil
            }
        }
        return nil
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/JWTUtilities.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/ConfigurationClosure.swift ---
//
//  ConfigurationClosure.swift
//  RetailApp
//
//  Created by Rafael Nascimento on 11/11/2022.
//

import Foundation

/// Provides a configuration closure to easilly modify the target object
///
/// The idea of the configuration closure is to reduce the boilerplate code caused by having self-executing closures.
/// They are usually found when doing view code and can increase the code size with not much addition to readability
///
/// Usage:
/// ```
/// lazy var titleLabel = configure(UILabel) {
///     $0.title = "My title"
///     $0.textColor = .red
/// }
/// ```
///
public func configure<T>(_ object: T, with closure: (inout T) -> Void) -> T {
    var object = object
    closure(&object)
    return object
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/ConfigurationClosure.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/LocationServicesChecking.swift ---
//
//  LocationServicesChecking.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 24/08/24.
//

public protocol LocationServicesChecking {
    var isDeviceLocationServicesEnabled: Bool { get }
    var isAppLocationPermissionGranted: Bool { get }
    var userGeoLocation: UserGeoLocation { get }
}

public enum UserGeoLocation {
    case notDetermined, KSA, outsideKSA
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/LocationServicesChecking.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/CommonStyles.swift ---

//  CommonStylesyle.swift
//  SNBCommon
//
//  Created by Sudeep George on 29/08/24.
//

import BackbaseDesignSystem
import SwiftUI

public struct CommonStyles {
    public static var backgroundView: Style<UIView> = { view in
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
    }

    public static var contentView: Style<UIView> = { view in
        view.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        view.layer.cornerRadius = DesignSystem.shared.cornerRadius.large
        DesignSystem.shared.styles.shadow(.small)(view.layer)
    }

    public static var segmentControlStyle: Style<UISegmentedControl> = { view in
        view.backgroundColor = .clear
        view.selectedSegmentTintColor = DesignSystem.shared.colors.surfacePrimary.default
        view.setTitleTextAttributes(
            [
                NSAttributedString.Key.font: DesignSystem.shared.fonts.preferredFont(.footnote, .medium),
                NSAttributedString.Key.foregroundColor: DesignSystem.shared.colors.text.default
            ],
            for: .selected
        )
        view.setTitleTextAttributes(
            [
                NSAttributedString.Key.font: DesignSystem.shared.fonts.preferredFont(.footnote, .regular),
                NSAttributedString.Key.foregroundColor: DesignSystem.shared.colors.text.default
            ],
            for: .normal
        )
        view.layer.borderColor = DesignSystem.shared.colors.surfaceSecondary.default.cgColor
        view.layer.borderWidth = 1
    }
}

public extension View {
    func backgroundViewStyle() -> some View {
        background(DesignSystem.shared.colors.foundation.default.color)
    }

    func contentViewStyle() -> some View {
        cornerRadius(DesignSystem.shared.cornerRadius.large)
            .background(DesignSystem.shared.colors.surfacePrimary.default.color
                .cornerRadius(DesignSystem.shared.cornerRadius.large)
                .customShadow(style: .small)
            )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/CommonStyles.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/Variant.swift ---
//
//  Untitled.swift
//  Pods
//
//  Created by Aman Prajapati on 05/11/24.
//

import Foundation

public struct Variants {
   public static let configuration: [String: Any] = {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }
        return infoDictionary
    }()
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/Variant.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/NetworkChecking.swift ---
//
//  NetworkChecking.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 25/07/2023.
//

public protocol NetworkChecking {
    var isConnected: Bool { get }
    var isVPNConnected: Bool { get }
    func updateVPNStatusCompletion(completion: @escaping (Bool) -> Void)
    func updateNetworkStatusCompletion(completion: @escaping (Bool) -> Void)
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/NetworkChecking.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/Localizable.swift ---
//
//  Localizable.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 14/02/2023.
//

import Foundation

public typealias Localizable = SNBCommon.Localizable

extension SNBCommon {
    @propertyWrapper
    public struct Localizable {
        public var wrappedValue: String {
            didSet { wrappedValue = NSLocalizedString(wrappedValue, comment: "") }
        }

        public init(wrappedValue: String, in bundles: Bundle?...) {
            self.wrappedValue = wrappedValue.getLocalized(in: bundles)
        }
    }
}

extension String {
    public func localized(in bundles: Bundle?..., attributes: CVarArg...) -> String {
        String(format: getLocalized(in: bundles), arguments: attributes)
    }

    public func localized(in bundles: Bundle?...) -> String {
        getLocalized(in: bundles)
    }

    fileprivate func getLocalized(in bundles: [Bundle?]) -> String {
        let bundles = ([.main] + bundles).compactMap { $0 }
        return bundles
            .compactMap { bundle -> String? in
                let localizedString = bundle.localizedString(forKey: self, value: self, table: nil)
                return localizedString == self ? nil : localizedString
            }
            .first ?? self
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Utils/Localizable.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Binding.swift ---
//
//  Binding.swift
//  RetailApp
//
//  Created by Aleh Pachtovy on 01/04/2023.
//

import SwiftUI

public extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Binding.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+dismissKeyboard.swift ---
//
//  View+dismissKeyboard.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 25/05/2023.
//

import SwiftUI
import UIKit

public extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+dismissKeyboard.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UICollectionView+lastIndexPath.swift ---
//
//  UICollectionView+lastIndexPath.swift
//  RetailApp
//
//  Created by Gabriel Rodrigues Minucci on 27/11/2022.
//

import UIKit

public extension UICollectionView {
    var lastIndexPath: IndexPath {
        let section = max(numberOfSections - 1, 0)
        let item = max(numberOfItems(inSection: section) - 1, 0)
        return IndexPath(item: item, section: section)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UICollectionView+lastIndexPath.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UILabel+Extension.swift ---
//
//  UILabel+Extension.swift
//  SNBCommon
//
//  Created by Dhaval Panchal on 26/03/23.
//

import UIKit

public extension UILabel {
    func setText(
        _ text: String, lineHeight: CGFloat = 20,
        textColor: UIColor? = nil, font: UIFont? = nil,
        textAlignment: NSTextAlignment? = nil
    ) {
        attributedText = AttributedStringBuilder()
            .foregroundColor(textColor ?? self.textColor)
            .paragraphStyle(
                font: font ?? self.font,
                lineHeight: lineHeight,
                textAlignment: textAlignment ?? self.textAlignment
            )
            .build(text: text)
    }
}

public extension UILabel {
    var isRTL: Bool {
        UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
    }

    func setInvertedNaturalTextAlignment() {
        textAlignment = isRTL ? .left : .right
    }

    func setNaturalTextAlignment() {
        textAlignment = isRTL ? .right : .left
    }
}

public extension UITextView {
    func setText(
        _ text: String, lineHeight: CGFloat = 20,
        textColor: UIColor? = nil, font: UIFont? = nil,
        textAlignment: NSTextAlignment? = nil
    ) {
        var stringAttributes: [NSAttributedString.Key: Any] = [:]
        stringAttributes[.foregroundColor] = textColor ?? self.textColor
        let currentFont: UIFont? = font ?? self.font
        let alignment: NSTextAlignment? = textAlignment ?? self.textAlignment
        if let currentFont {
            let paragraphStyle = NSMutableParagraphStyle()
            if let alignment {
                paragraphStyle.alignment = alignment
            }
            paragraphStyle.lineSpacing = lineHeight - currentFont.lineHeight
            stringAttributes[.paragraphStyle] = paragraphStyle
            stringAttributes[.font] = currentFont
        }
        attributedText = NSAttributedString(string: text, attributes: stringAttributes)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UILabel+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UISearchBar+Combine.swift ---
//
//  UISearchTextField+Combine.swift
//  SNBCommon
//
//  Created by Basistyi, Yevhen on 09/03/2023.
//

import UIKit
import Combine

public extension UISearchTextField {
    func search<T>(
        in array: [T],
        by keyPaths: [KeyPath<T, String>],
        on event: UIControl.Event = .editingChanged
    ) -> AnyPublisher<[T], Never> {
        publisher(for: event)
            .compactMap { searchTextField in
                guard let query = searchTextField.text, !query.isEmpty else {
                    return array
                }
                for path in keyPaths {
                    let filteredArray = array.filter {
                        $0[keyPath: path].localizedCaseInsensitiveContains(query)
                    }
                    if !filteredArray.isEmpty {
                        return filteredArray
                    }
                }
                return []
            }
            .eraseToAnyPublisher()
    }

    func hasNoResults<T>(_ filteredList: AnyPublisher<[T], Never>) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            filteredList,
            publisher(for: .editingChanged).map { $0.text ?? "" }
        )
        .map { items, searchText in items.isEmpty && !searchText.isEmpty }
        .prepend(false)
        .eraseToAnyPublisher()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UISearchBar+Combine.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UINavigationController+interactivePopGestureRecognizer.swift ---
//
//  UINavigationController+interactivePopGestureRecognizer.swift
//  RetailApp
//
//  Created by Konrad Siemczyk on 19/01/2023.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isContainMultipleVC = viewControllers.count > 1
        if let visibleVC = visibleViewController as? InteractivePopGestureProtocol {
            return isContainMultipleVC && visibleVC.isPopGestureEnabled
        }
        return isContainMultipleVC
    }
}

public protocol InteractivePopGestureProtocol where Self: UIViewController {
    var isPopGestureEnabled: Bool { get set }
}

public protocol InactivePopGestureProtocol: InteractivePopGestureProtocol {}

// swiftlint:disable unused_setter_value
extension InactivePopGestureProtocol {
    public var isPopGestureEnabled: Bool {
        get { false }
        set {}
    }
}
// swiftlint:enable unused_setter_value

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UINavigationController+interactivePopGestureRecognizer.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIView+Extension.swift ---
//
//  UIView+Extension.swift
//  SNBCommon
//
//  Created by Jhanvi Mandalia on 23/05/23.
//

import UIKit
import BackbaseDesignSystem

public extension UIView {

    /// Adds toast view to show temporary message.
    ///
    /// - Parameters:
    ///   - message: a short message to be displayed on the toast
    ///   - delay: toast will disappear after specified delay in Seconds.
    func displayToast(_ message: String, with delay: Int) {
        guard let window: UIWindow = UIApplication.shared.delegate?.window ?? nil else {
            return
        }

        let padding = 10.0
        let cornerRadius = 4.0
        let backgroundAlpha = 0.79
        let topOffset = 200
        let bottomOffset = -100
        let toastViewTag = -2021

        if let toast = window.subviews.first(where: { $0.tag == toastViewTag }) {
            toast.removeFromSuperview()
        }

        let toastView = UIView()
        window.addSubview(toastView)
        toastView.backgroundColor = DesignSystem.shared.colors.highlight.foundation.withAlphaComponent(backgroundAlpha)
        toastView.layer.cornerRadius = cornerRadius
        toastView.alpha = 0
        toastView.tag = toastViewTag

        let messageLabel = UILabel()
        messageLabel.textColor = DesignSystem.shared.colors.neutrals.neutral00
        messageLabel.textAlignment = .center
        messageLabel.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        toastView.addSubview(messageLabel)

        toastView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(padding)
            make.trailing.lessThanOrEqualToSuperview().offset(padding)
            make.top.greaterThanOrEqualToSuperview().offset(topOffset)
            make.bottom.equalToSuperview().offset(bottomOffset)
        }

        messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.top.bottom.equalToSuperview().inset(padding)
            make.width.lessThanOrEqualToSuperview().offset(-padding * 2)
        }

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIView+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIViewController+halfSheetPresentation.swift ---
//
//  UIViewController+halfSheetPresentation.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 18/03/2023.
//

import UIKit

public extension UIViewController {
    func halfSheetPresentation(cornerRadius: CGFloat = 24, heightRatio: CGFloat = 0.55, isGrabberVisible: Bool = false) {
        guard let presentation = sheetPresentationController else { return }

        presentation.preferredCornerRadius = cornerRadius
        presentation.prefersGrabberVisible = isGrabberVisible
        if #available(iOS 16.0, *) {
            presentation.detents = [.custom { context in
                context.maximumDetentValue * heightRatio
            }]
        } else {
            presentation.detents = [.medium()]
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIViewController+halfSheetPresentation.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Notification.Name+Extension.swift ---
//
//  Notification.Name+Extension.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 24/08/23.
//

import Foundation
import Combine

public extension Notification.Name {
    typealias Name = Notification.Name
    static let onPaymentTransactionDone = Name("on-Payment-Transaction-Done")
    static let onQuickLimitUpdateDone = Name("on-Quick-Limit-Update-Done")
    static let onTransactionsProductFetchDone = Name("on-Transactions-Product-Fetch-Done")
    static let onNeoLimitUpdateDone = Name("on-NEO-Limit-Update-Done")
    static let onNeoLocaleChangeDone = Name("on-NEO-Locale-Change-Done")
    static let onUpdatedLimitCalled = Name("on-NEO-Limit-Update-Called")
    static let onRefreshNeedLoyaltyDashboard = Name("on-Loyalty-Dashboard-Refresh-Needed")
    static let onOpenBankingConsentResultReceived = Name("onOpenBankingConsentResultReceived")
    static let onRefreshExternalAccountsTriggered = Name("onRefreshExternalAccountsTriggered")
    static let onOpenBankingConsentUpdate = Name("onOpenBankingConsentUpdate")
    static let onNafathVerificationClose = Name("onNafathVerificationClose")
    static let onExternalAccountNicknameUpdate = Name("onExternalAccountNicknameUpdate")
    static let onBusinessOnboardingInitialCallFail = Name("onBusinessOnboardingInitialCallFail")
    static let onCurrencySelected = Name("onCurrencySelected")
    static let onChangeOfPreviousSelectedCurrency = Name("onChangeOfPreviousSelectedCurrency")
    static let onBiometricEnrolmentFailure = Name("onBiometricEnrolmentFailure")
    static let onComplaintAdded = Name("onComplaintAdded")
    static let onAddReviewClosed = Name("onAddReviewClosed")
    static let onWaterCupAdded = Name("onWaterCupAdded")
    static let onCompletedRegistration = Name("onCompletedRegistration")
}

public extension Notification.Name {
    var publisher: AnyPublisher<Notification, Never> {
        NotificationCenter.default.publisher(for: self)
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    func post(_ object: Any? = nil) {
        NotificationCenter.default.post(name: self, object: object)
    }
}

public extension NotificationCenter {
    func observe(_ name: Notification.Name, queue: OperationQueue = .main, callback: @escaping (Notification) -> Void) {
        addObserver(forName: name, object: nil, queue: queue) { callback($0) }
    }

    func post(_ name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        post(name: name, object: object, userInfo: userInfo)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Notification.Name+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+draggablePresentation.swift ---
//
//  View+draggablePresentation.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 10/03/2023.
//

import SwiftUI
import BackbaseDesignSystem
import Combine

public extension View {
    func draggablePresentation() -> some View {
        modifier(DragHandleModifier())
            .modifier(AdaptsToKeyboardModifier())
    }
}

private struct DragHandleModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: DesignSystem.shared.spacer.md) {
            dragHandleView
            content
        }
        .background(DesignSystem.shared.colors.foundation.default.color)
    }

    private var dragHandleView: some View {
        Capsule()
            .frame(width: 48, height: 4)
            .foregroundColor(DesignSystem.shared.colors.surfaceDisabled.default.color)
            .padding(.top, DesignSystem.shared.spacer.md)
    }
}

/// SwiftUI bug fix to layout views after keyboard dismissal in sheet presentation
private struct AdaptsToKeyboardModifier: ViewModifier {
    @State private var currentHeight: CGFloat = 0

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, currentHeight)
                .onAppear {
                    NotificationCenter.Publisher(center: .default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: .default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                        }
                        .map { rect in
                            rect.height - geometry.safeAreaInsets.bottom
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

                    NotificationCenter.Publisher(center: .default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { _ in .zero }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                }
                .animation(.easeOut(duration: 0.15), value: currentHeight)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+draggablePresentation.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIApplication+Extenstions.swift ---
//
//  UIApplication+Extenstions.swift
//  SNBCommon
//
//  Created by Basistyi, Yevhen on 05/05/2023.
//

import UIKit

public extension UIApplication {
    func topMostViewController() -> UIViewController? {
        var topViewController: UIViewController?
        for scene in connectedScenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows where window.isKeyWindow {
                    topViewController = window.rootViewController
                }
            }
        }
        return topViewController?.topViewController()
    }

    func dismissAllControllers() {
        var topViewController: UIViewController?
        for scene in connectedScenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows where window.isKeyWindow {
                    topViewController = window.rootViewController
                }
            }
        }
        if let navigation = topViewController as? UINavigationController {
            navigation.dismissIfPresented()
            navigation.popToRootViewController(animated: false)
        } else {
            topViewController?.dismissIfPresented()
        }
    }

    func findViewController<T>(to viewControllerType: T.Type) -> UIViewController? {
        var viewControllerToFind: UIViewController?
        for scene in connectedScenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows where window.isKeyWindow {

                    // UITabBarController
                    if let tabbar = window.rootViewController as? UITabBarController {
                        if let viewController = (tabbar.selectedViewController as? UINavigationController)?.viewControllers.first(
                            where: {type(of: $0) == viewControllerType
                            }) {
                            viewControllerToFind = viewController
                        }
                    }
                    // UINavigationController
                    else if let navigation = window.rootViewController as? UINavigationController {
                        if let viewController = navigation.viewControllers.first(
                            where: {type(of: $0) == viewControllerType}) {
                            viewControllerToFind = viewController
                        }
                    } else {
                        viewControllerToFind = window.rootViewController?.topViewController()
                    }
                }
            }
        }
        return viewControllerToFind
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIApplication+Extenstions.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIViewController+Extension.swift ---
//
//  UIViewController+Extension.swift
//  RetailApp
//
//  Created by Mahesh Dhumpeti on 23/11/22.
//

import Resolver
import UIKit

public extension UIViewController {
    func topViewController() -> UIViewController? {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topViewController()
            }
            return tab.topViewController()
        }
        return self.presentedViewController?.topViewController()
    }
}

extension UIViewController {

    @objc open func dismissIfPresented() {
        dismiss(animated: true)
    }

    @objc open func popIfPushed() {
        navigationController?.popViewController(animated: true)
    }

    // Close bar button item
    public func closeBarButtonItem(image: UIImage?) -> UIBarButtonItem {
        return UIBarButtonItem(image: image, style: .plain,
                     target: self, action: #selector(dismissIfPresented))
    }

    // Back bar button item
    public func backBarButtonItem(image: UIImage?) -> UIBarButtonItem {
        return UIBarButtonItem(image: image, style: .plain,
                              target: self, action: #selector(popIfPushed))
    }
}

public extension UIViewController {

    struct ActionableTitle {
        let title: String
        let action: () -> Void

        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
    }

    func presentActionSheet(
        title: String? = nil,
        message: String? = nil,
        actions: ActionableTitle...,
        cancel: String
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { actionableTitle in
            alert.addAction(UIAlertAction(title: actionableTitle.title, style: .default, handler: { _ in
                actionableTitle.action()
            }))
        }
        alert.addAction(UIAlertAction(title: cancel, style: .cancel))
        present(alert, animated: true)
    }
}

public extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

public extension UIViewController {
    func addSupportButtonView() {
        let supportButton = SupportButton()
        view.addSubview(supportButton)
        let action = UIAction { _ in
            Resolver.optional(DeeplinkNavigatable.self)?.navigate(to: .support)
        }
        supportButton.addAction(action, for: .touchUpInside)
        supportButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(SupportButtonConfiguration.Constants().viewTrailing)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

public extension UIViewController {
    func removeLargeTitlesForNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

public extension UIViewController {
    func backBarButton() -> UIBarButtonItem? {
        if let leftBarButtonItem = navigationItem.leftBarButtonItem {
            return leftBarButtonItem
        }
        if #available(iOS 16.0, *),
           let backButton = navigationItem.leadingItemGroups.first?.barButtonItems.first {
            return backButton
        }
        if let backButton = navigationItem.backBarButtonItem {
            return backButton
        }
        return navigationItem.leftBarButtonItems?.first
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIViewController+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/CALayer+applyShadow.swift ---
//
//  CALayer+applyShadow.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 14/02/2023.
//

import UIKit
import BackbaseDesignSystem

public extension CALayer {
    /// Apply shadow to the layer
    /// - parameter color: The color of the layer’s shadow. Default value: neutral00 from the design system
    /// - parameter opacity: The opacity of the layer’s shadow. Default value: 0.12
    /// - parameter x: The x offset (in points) of the layer’s shadow. Default value: 0
    /// - parameter y: The y offset (in points) of the layer’s shadow. Default value: 4
    /// - parameter blur: The blur radius (in points) used to render the layer’s shadow. Default value: 9
    func applyShadow(
        color: UIColor = DesignSystem.shared.colors.surfacePrimary.default,
        opacity: Float = 0.12,
        x: CGFloat = 0,
        y: CGFloat = 4,
        blur: CGFloat = 9
    ) {
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
        masksToBounds = false
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/CALayer+applyShadow.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/String+Extension.swift ---
//
//  String+Extension.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 06/08/23.
//

import Foundation

public extension String {
    func substring(_ range: Range<Int>) -> String? {
        guard range.lowerBound >= 0,
              range.lowerBound < range.upperBound else { return nil }
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let limitIndex = index(self.startIndex, offsetBy: count)
        guard let endIndex = index(
            self.startIndex,
            offsetBy: range.upperBound,
            limitedBy: limitIndex
        ) else {
            return nil
        }
        let range = startIndex..<endIndex
        return String(self[range])
    }

    var isNumeric: Bool {
        filter { !$0.isNumber }.isEmpty
    }

    var isAlphanumeric: Bool {
        filter { !$0.isNumber && !$0.isLetter }.isEmpty
    }

    var formattedIban: String {
        String(
            self
                .replacingOccurrences(of: " ", with: "")
                .enumerated()
                .flatMap { $0 > 0 && $0 % 4 == 0 ? [" ", $1] : [$1] }
        )
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/String+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/DateFormatter+Extension.swift ---
//
//  DateFormatter+Extension.swift
//  RetailApp
//
//  Created by Mahesh Dhumpeti on 30/11/22.
//

import Foundation

public extension DateFormatter {

    public static let mmmmdyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()

    public static let hhmmssa: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter
    }()

    public static func formatter(for dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/DateFormatter+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+Keyboard.swift ---
//
//  View+Keyboard.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 13/07/2023.
//

import Combine
import SwiftUI

public
extension View {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }

    func onKeyboardVisibilityChanged(perform: @escaping (Bool) -> Void) -> some View {
        onReceive(keyboardPublisher, perform: perform)
    }

    func bindWithKeyboardVisibility(bindable: Binding<Bool>) -> some View {
        modifier(KeyboardObserverModifier(bindable: bindable))
    }
}

struct KeyboardObserverModifier: ViewModifier {
    @Binding var bindable: Bool

    func body(content: Content) -> some View {
        content
            .onKeyboardVisibilityChanged { bindable = !$0 }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+Keyboard.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+RTL.swift ---
//
//  View+RTL.swift
//  NeoTransferJourney
//
//  Created by Nihal Khokhari on 15/09/23.
//

public extension UIView {
    static func isRTL(for semanticContentAttribute: UISemanticContentAttribute) -> Bool {
        UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+RTL.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Combine+UIControl.swift ---
//
//  Combine+UIKit.swift
//  RetailApp
//
//  Created by Basistyi, Yevhen on 21/11/2022.
//

import UIKit
import Combine

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.
public protocol CombineCompatible {}

extension UIControl: CombineCompatible {}

public extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        UIControlPublisher(control: self, events: events)
    }
}

/// A custom `Publisher` to work with custom `UIControlSubscription`.
public struct UIControlPublisher<Control: UIControl>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never

    let control: Control
    let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }

    public func receive<S>(subscriber: S) where S: Subscriber,
                                                S.Failure == UIControlPublisher.Failure,
                                                S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

/// A custom subscription to capture UIControl target events.
final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demmand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
    }

    func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Combine+UIControl.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIView+configureBackgroundView.swift ---
//
//  UIView+configureBackgroundView.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 14/02/2023.
//

import UIKit
import SnapKit
import Resolver

/// Background types:
/// - pattern: for navigation screens - with pattern background
/// - plain: for modal presentation - just a gradient
public enum BackgroundScreenType {
    case pattern
    case plain
}

public extension UIView {
    /// Adds background view as the further back subview to match SNB DV designs.
    ///
    /// - Parameters:
    ///   - type: Either **pattern** or **plain**. Default value: **pattern**.
    func configureBackgroundView(type: BackgroundScreenType = .pattern) {
        let restorationIdentifier = "background-view-identifier"

        subviews
            .filter { $0.restorationIdentifier == restorationIdentifier }
            .forEach { $0.removeFromSuperview() }

        let configuration: SNBCommon.Configuration? = Resolver.optional()
        let backgroundView: UIView
        switch type {
        case .pattern:
            backgroundView = UIImageView(image: configuration?.images.patternBackground)
        case .plain:
            backgroundView = UIImageView(image: configuration?.images.gradientBackground)
        }
        backgroundView.restorationIdentifier = restorationIdentifier
        addSubview(backgroundView)
        sendSubviewToBack(backgroundView)
        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

public extension UIView {
    /// Convenience method that configures background view (**configureBackgroundView**) with a given type,
    /// adds a card style container view and applies constraints.
    ///
    /// - Parameters:
    ///   - backgroundType: Either **pattern** or **plain**. Default value: **pattern**.
    /// - Returns: CardContentView instance, added to a view hierarchy.
    @discardableResult
    func configureDefaultCardContentView(backgroundType: BackgroundScreenType = .pattern) -> UIView {
        configureBackgroundView(type: backgroundType)
        let cardContentView = CardContentView()
        addSubview(cardContentView)
        cardContentView.makeDefaultConstraints()
        return cardContentView
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIView+configureBackgroundView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIStackView+Extension.swift ---
//
//  UIStackView+Extension.swift
//  RetailApp
//
//  Created by Gabriel Rodrigues Minucci on 16/11/2022.
//

import UIKit
import SnapKit

public extension UIStackView {
    convenience init(
        arrangedSubviews: [UIView] = [],
        axis: NSLayoutConstraint.Axis = .horizontal,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }

    /// Adds an arranged subview with custom insets to the target UIStackView
    ///
    /// In order to get this behavior this methods wraps the subview inside a container view and set the insets within
    /// it's container. Sometimes we may need to do some changes to the direct arranged subview (for example to hide it),
    /// in this case this should be done in the container view.
    ///
    /// - Parameters:
    ///   - subview: The arranged subview to be added
    ///   - insets: Custom insets to set to the arranged subview
    /// - Returns: The container view containing the arranged subview with configured insets
    @discardableResult
    func addArrangedSubview(_ subview: UIView, insets: UIEdgeInsets) -> UIView {
        let containerView = UIView()
        containerView.addSubview(subview)
        subview.snp.makeConstraints { $0.edges.equalToSuperview().inset(insets) }
        addArrangedSubview(containerView)
        return containerView
    }

    /// Adds a spacing between last view and newly added arranged subview
    ///
    /// The spacing will follow the UIStackView axis. For vertical stacks the space will be added above new view, if horizontal
    /// the spacing will be added at the left side of the new view
    ///
    /// - Parameters:
    ///  - subview: The arranged subview to be added
    ///  - spaceBefore: The spacing between last view and view to be added
    func addArrangedSubview(_ subview: UIView, spaceBefore: CGFloat) {
        let lastViewBeforeAddition = arrangedSubviews.last
        addArrangedSubview(subview)

        guard let safeLastViewBeforeAddition = lastViewBeforeAddition else { return }
        setCustomSpacing(spaceBefore, after: safeLastViewBeforeAddition)
    }

    /// Removes all views in stack’s array of arranged subviews.
    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UIStackView+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UserDefaults+Extension.swift ---
//
//  UserDefaults+Extension.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 24/07/24.
//

import Foundation

@propertyWrapper
public struct LocalStorage<Value> {
    let key: String
    let defaultValue: Value?
    var container: UserDefaults = .standard

    public var wrappedValue: Value? {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            if let newValue {
                container.set(newValue, forKey: key)
            } else {
                container.removeObject(forKey: key)
            }
        }
    }
}

public extension UserDefaults {

    /** Always follow the key pattern like `<feature>.<label>` */

    @LocalStorage(key: "AddReview.lastReviewedDate", defaultValue: nil)
    static var lastReviewedDate: Date?
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UserDefaults+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Dictionary+Extension.swift ---
//
//  Dictionary+Extension.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 29/02/2024.
//

extension Dictionary {
    public func adding(key: Key, value: Value) -> Dictionary {
        var copy = self
        copy[key] = value
        return copy
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Dictionary+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/DesignSystem+Extension.swift ---
//
//  DesignSystem+Extension.swift
//  RetailApp
//
//  Created by Divine Dube on 26/10/2023.
//

import Foundation
import BackbaseDesignSystem

public extension DesignSystem.Formatting {
    /// The app requires all amount values to be in western arabic numerals (0-9) regardless of currently set locale and region
    /// This includes input and displayed amounts
    /// This a singleton so do not modify rather copy
    /// Use this only for UITextField not to display numbers ei UIlabels
    static let numberFormatter: NumberFormatter = { // Convert to var
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Self.numberLocale
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()

    /// Use this to format dates to display
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = numberLocale
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    /// This is the locale for all numbers displayed on the app be it dates, transaction amounts, input fields because these values should appear in english format
    static let numberLocale = Locale(identifier: "en_US")

    ///  Use this to always display numbers in X,XX.XX SAR regardless of either ar or en locale as required by bank
    ///  wrap in lazy property in your confinguration for better perfomance
    var displayNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = DesignSystem.Formatting.numberLocale
        numberFormatter.numberStyle = .currencyISOCode
        numberFormatter.positiveFormat = "#,##0.00 ¤"
        numberFormatter.negativeFormat = "-#,##0.00 ¤"
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.roundingMode = .down
        return numberFormatter
    }

    static func preferredLocalisedText(en: String, ar: String) -> String {
        switch AppLanguageManager.currentLanguage() {
        case .arabic: return ar
        case .english: return en
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/DesignSystem+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/TimeZone+Extension.swift ---
//
//  TimeZone+Extension.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 27/08/2024.
//

public extension TimeZone {
    init?(iso8601String: String) {
        let timeZoneString = String(iso8601String.suffix(6))
        let sign = String(timeZoneString.prefix(1))

        guard ["+", "-"].contains(sign) else {
            return nil
        }

        let fullTimeString = timeZoneString.filter("0123456789".contains)

        guard fullTimeString.count == 4 else {
            return nil
        }

        guard let hours = Int(sign + fullTimeString.prefix(2)),
              let minutes = Int(sign + fullTimeString.suffix(2)) else {
            return nil
        }

        self.init(secondsFromGMT: hours * 3600 + minutes * 60)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/TimeZone+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Collection+safeSubscript.swift ---
//
//  Collection+Extension.swift
//  RetailApp
//
//  Created by Gabriel Rodrigues Minucci on 18/11/2022.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/Collection+safeSubscript.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/CGSize+Extension.swift ---
//
//  CGSize+Extension.swift
//  SNBCommon
//
//  Created by Cisowski Łukasz on 05/05/2023.
//

import Foundation

public extension CGSize {
    static func equal(_ size: CGFloat) -> CGSize {
        CGSize(width: size, height: size)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/CGSize+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UITextField+Extension.swift ---
//
//  UITextField+Extension.swift
//  RetailCardsManagementJourney
//
//  Created by Sudeep George on 14/07/24.
//

public extension UITextField {
    func setInvertedNaturalTextAlignment() {
        textAlignment = UIView.isRTL(for: semanticContentAttribute) ? .left : .right
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UITextField+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/PrimaryButton+AfterContent.swift ---
//
//  PrimaryButton+AfterContent.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 25/06/24.
//

import BackbaseDesignSystem
import SwiftUI

public extension View {
    func primaryButton(
        title: String,
        show: Bool = true,
        disabled: Bool = false,
        loading: Bool = false,
        topSpacing: CGFloat = DesignSystem.shared.spacer.lg,
        horizontalPadding: CGFloat = DesignSystem.shared.spacer.md,
        action: @escaping () -> Void
    ) -> some View {
        modifier(PrimaryButtonModifier(
            title: title,
            show: show,
            disabled: disabled,
            loading: loading,
            topSpacing: topSpacing,
            horizontalPadding: horizontalPadding,
            action: action))
    }
}

struct PrimaryButtonModifier: ViewModifier {
    let title: String
    let show: Bool
    let disabled: Bool
    let loading: Bool
    let topSpacing: CGFloat
    let horizontalPadding: CGFloat
    let action: () -> Void

    func body(content: Content) -> some View {
        VStack {
            content
            if show {
                Spacer()
                    .frame(height: topSpacing)
                Button(action: action) {
                    Text(title)
                }
                .buttonStyle(.primary(isEnabled: !disabled, isLoading: loading))
                .padding(.horizontal, horizontalPadding)
                .disabled(disabled || loading)
            }
            Spacer()
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/PrimaryButton+AfterContent.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/CharacterSet+Extension.swift ---
//
//  CharacterSet+Extension.swift
//  SNBCommon
//
//  Created by Divine Dube on 22/05/2024.
//

import Foundation

extension CharacterSet {
    public static var arabicCharacters: CharacterSet {
        guard let arabicCharsUnicodeStart = UnicodeScalar(0x0600),
              let arabicCharsUnicodeEnd = UnicodeScalar(0x06FF)
        else {
            return CharacterSet()
        }
        return CharacterSet(charactersIn: arabicCharsUnicodeStart...arabicCharsUnicodeEnd)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/CharacterSet+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/String+Encryption.swift ---
//
//  String+Encryption.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 06/08/23.
//

import Backbase
import Foundation
import Security
import BackbaseDesignSystem

public extension String {
    private var trimedPublicKey: String? {
        guard let regExp = try? NSRegularExpression(pattern: "(-----BEGIN.*?-----)|(-----END.*?-----)|\\s+") else { return nil }

        let fullRange = NSRange(location: 0, length: self.count)

        return regExp.stringByReplacingMatches(in: self, options: [], range: fullRange, withTemplate: "")
    }

    private var base64Encoded: String? { data(using: .utf8)?.base64EncodedString() }

    func encrypt(with publicKey: String?) -> String? {
        guard let publicKey = publicKey?.trimedPublicKey, let data = Data(base64Encoded: publicKey) else {
            return nil
        }

        let attributes: CFDictionary = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits: 2048,
            kSecReturnPersistentRef: true as NSObject
        ] as CFDictionary

        var error: Unmanaged<CFError>?
        guard let secKey = SecKeyCreateWithData(data as CFData, attributes, &error) else {
            Backbase.logError(self, message: error.debugDescription)
            return nil
        }
        return encryptToBase64(with: secKey)
    }

    private func encryptToBase64(with publicKey: SecKey) -> String? {
        var error: Unmanaged<CFError>?
        guard let data = data(using: .utf8),
              let encryptedData = SecKeyCreateEncryptedData(publicKey, .rsaEncryptionPKCS1, data as CFData, &error) as? Data
        else {
            Backbase.logError(self, message: error.debugDescription)
            return nil
        }

        return encryptedData.base64EncodedString()
    }
}

public extension String {
    /// Used remove groupingSelector and auto appended .00 at the end of UITextField text when we beginEditing
    /// assumming the the amount is already is formated  for example in this format: 1,000,000.00
    static func sanitizeAmountForInput(amount: String?) -> String? {
        let numberLocale = DesignSystem.Formatting.numberLocale
        let groupingSeparator = numberLocale.groupingSeparator ?? " "
        return amount?.replacingOccurrences(of: groupingSeparator, with: "")
            .replacingOccurrences(of: ".00", with: "")
    }

    var containsSpecialCharacters: Bool {
        let regex = ".*[^A-Za-z0-9,. \\p{Arabic}].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }

    var containsDecimalNumbers: Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        return CharacterSet(charactersIn: self).isSubset(of: allowedCharacters)
    }

    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/String+Encryption.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+Extension.swift ---
//
//  View+Extension.swift
//  SNBCommon
//
//  Created by Divine Dube on 16/11/2023.
//

import SwiftUI

struct LocaleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .environment(\.layoutDirection, LocaleSelector.shared.isArabic ? .rightToLeft : .leftToRight)
    }
}

extension View {
    public func forceCorrectSementicContentAttribute() -> some View {
        modifier(LocaleViewModifier())
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/View+Extension.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UINavigationController+popToRootViewController.swift ---
//
//  UINavigationController+popToRootViewController.swift
//  SNBCommon
//
//  Created by Amjad Khan on 17/07/23.
//

import UIKit

public extension UINavigationController {
    public func popToRootViewControllerWithHandler(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }

    public func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let viewController = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(viewController, animated: animated)
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Extensions/UINavigationController+popToRootViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SNBUserStoredInfo/SNBUserStoredInfo.swift ---
//
//  SNBUserStoredInfo.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 07/11/23.
//

import Foundation
import Backbase
public class SNBUserStoredInfo {
    public static let shared = SNBUserStoredInfo()
    public var userName: String?
    public var fullname: String?
    public var userId: String? {
        let storage = Backbase.registered(plugin: EncryptedStorage.self) as? EncryptedStorage
        return storage?.storageComponent.getItem("authenticationUseCase.storedAccountIDKey")
    }
    private init() {}
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SNBUserStoredInfo/SNBUserStoredInfo.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/WebImageLoader/ImageLoader.swift ---
//
//  ImageLoader.swift
//  LoyaltyJourney
//
//  Created by Aman Prajapati on 28/07/23.
//

import Foundation

public enum ImageLoadingError: Error {
    case invalidData
}

public protocol ImageCacheProtocol {
    func getImage(forKey key: String) -> UIImage?
}
public class ImageCache: ImageCacheProtocol {
    public static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private init() {
       cache.totalCostLimit = 20 * 1024 * 1024 // 20MB limit
    }
    public func getImage(forKey key: String) -> UIImage? {
       return cache.object(forKey: key as NSString)
    }

    func cacheImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

public final class ImageLoader {

    public static let shared = ImageLoader()
    private let imageCache = ImageCache.shared
    private var loadingTasks: [URLSessionDataTask] = []

    // Loads an image from the given URL asynchronously
    public func loadImage(withURL url: URL) async throws -> UIImage? {
        // Check if the image is already cached
        if let cachedImage = imageCache.getImage(forKey: url.absoluteString) {
            return cachedImage
        }

        // Load data asynchronously from the URL
        let data = try await loadData(withURL: url)

        // Convert the loaded data to an image
        guard let image = UIImage(data: data) else {
            throw ImageLoadingError.invalidData
        }

        // Cache the image for future use
        imageCache.cacheImage(image, forKey: url.absoluteString)

        return image
    }

    // Cancels image loading for a specific URL
    public func cancelImageLoading(forURL url: URL) {
        // Find the tasks that match the provided URL
        let tasksToCancel = loadingTasks.filter { $0.originalRequest?.url == url }

        // Cancel each matching task
        tasksToCancel.forEach { $0.cancel() }

        // Remove the canceled tasks from the loadingTasks array
        loadingTasks.removeAll { tasksToCancel.contains($0) }
    }

    // Loads data asynchronously from the URL using URLSession
    private func loadData(withURL url: URL) async throws -> Data {
        // Perform the data loading task
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let urlSession = URLSession(configuration: config)
        let (data, _) = try await urlSession.data(from: url)
        return data
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/WebImageLoader/ImageLoader.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/RTL/LocaleSelector.swift ---
//
//  LocalSelector.swift
//  SNBCommon
//
//  Created by Dharmesh Patel on 26/10/23.
//

import Foundation
import RetailLocaleSelectorJourney
import BackbaseDesignSystem
import Resolver
import UIKit

public class LocaleSelector {

    @LazyInjected var useCase: LocaleSelectorUseCase

    public static let shared = LocaleSelector()

    private enum Strings {
        enum LocaleSelector {
            @Localizable static var alertMessage = "localeSelector.change.alert.message"
            @Localizable static var alertTitle = "localeSelector.change.alert.title"
            @Localizable static var alertOk = "homeScreen.alerts.options.confirm"
            @Localizable static var alertCancel = "authentication.alerts.options.cancel"
        }
    }

    private init() {}

    public var isArabic: Bool {
        preferredLanguageCode == "ar"
    }

    public var apiHeaderLocale: String {
        if isArabic {
            return "ar"
        } else {
            return "en"
        }
    }

    public var apiHeaderLocaleWithRegion: String {
        let (localeId, defaultRegionId): (String, String) = isArabic ? ("ar", "SA") : ("en", "US")
        let regionId: String
        if #available(iOS 16, *) {
            regionId = Locale.current.region?.identifier ?? defaultRegionId
        } else {
            regionId = Locale.current.regionCode ?? defaultRegionId
        }
        return localeId + "-" + regionId
    }

    public func changeLocale() {
        showRestartAppAlert()
    }

    public func updateSemanticContentAttribute() {
        if isArabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UIScrollView.appearance().semanticContentAttribute = .forceRightToLeft
            TextInput.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
            UISearchBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textAlignment = .right
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            TextArea.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UIScrollView.appearance().semanticContentAttribute = .forceLeftToRight
            TextInput.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
            UISearchBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textAlignment = .left
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            TextArea.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }

    // MARK: - Private helper functions

    private var preferredLanguageCode: String {
        if let preferredLanguage = Bundle.main.preferredLocalizations.first,
           preferredLanguage.lowercased().hasPrefix("ar") {
            return "ar"
        }
        return "en"
    }

    private func showRestartAppAlert() {
        let alert = UIAlertController(
            title: Strings.LocaleSelector.alertTitle,
            message: Strings.LocaleSelector.alertMessage,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: Strings.LocaleSelector.alertCancel, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: Strings.LocaleSelector.alertOk, style: .destructive) { [weak self] action in
            self?.changeAppLocale()
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        viewController.topViewController()?.present(alert, animated: true)
    }

    private func changeAppLocale() {
        if let locale = useCase.supportedLocales.first(where: {$0.identifier != preferredLanguageCode}) {
            useCase.savedLocale = locale
            UserDefaults.standard.set([locale.identifier], forKey: "AppleLanguages")
            NotificationCenter.default.post(name: .onNeoLocaleChangeDone, object: nil)
            closeApp()
        }
    }

    private func closeApp() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            exit(EXIT_SUCCESS)
        })
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/RTL/LocaleSelector.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SupportedCurrencies/SupportedCurrency.swift ---
//
//  SupportedCurrency.swift
//  SNBCommon
//
//  Created by Rafael Nascimento on 25/04/2023.
//

import Foundation

// TODO: Use this enum on:
// Currency Selector
// Payment between my account - Payment Currency
// And other util classes
public enum SupportedCurrency: String, Decodable {
    case AAA
    case AED
    case AUD
    case BHD
    case CAD
    case HKD
    case EGP
    case EUR
    case GBP
    case INR
    case JPY
    case JOD
    case KWD
    case MAD
    case OMR
    case SAR
    case SGD
    case TRY
    case QAR
    case USD
    case CHF

    // swiftlint:disable cyclomatic_complexity
    public init?(withCountryCode countryCode: String) {
        switch countryCode {
        case "AA": self = .AAA
        case "SA": self = .SAR
        case "US": self = .USD
        case "EU": self = .EUR
        case "GB": self = .GBP
        case "AE": self = .AED
        case "AU": self = .AUD
        case "BH": self = .BHD
        case "CA": self = .CAD
        case "HK": self = .HKD
        case "EG": self = .EGP
        case "IN": self = .INR
        case "JP": self = .JPY
        case "JO": self = .JOD
        case "KW": self = .KWD
        case "MA": self = .MAD
        case "OM": self = .OMR
        case "QA": self = .QAR
        case "SG": self = .SGD
        case "CH": self = .CHF
        case "TR": self = .TRY
        default: return nil
        }
    }
    // swiftlint:enable cyclomatic_complexity
}

extension SupportedCurrency {
    // swiftlint:disable cyclomatic_complexity
    public var title: String? {
        switch self {
        case .AAA:
            return "homescreen.allAccountsSectionTitle".localized(in: .main)
        case .AED:
            return "currencySelector.emirati.dirham".localized(in: .main)
        case .AUD:
            return "currencySelector.australian.dollar".localized(in: .main)
        case .BHD:
            return "currencySelector.bahraini.dinar".localized(in: .main)
        case .CAD:
            return "currencySelector.canadian.dollar".localized(in: .main)
        case .HKD:
            return "currencySelector.hong.kong.dollar".localized(in: .main)
        case .EGP:
            return "currencySelector.egyptian.pound".localized(in: .main)
        case .EUR:
            return "currencySelector.euro".localized(in: .main)
        case .GBP:
            return "currencySelector.pound.sterling".localized(in: .main)
        case .INR:
            return "currencySelector.indian.rupee".localized(in: .main)
        case .JPY:
            return "currencySelector.japanese.yen".localized(in: .main)
        case .JOD:
            return "currencySelector.jordanian.dinar".localized(in: .main)
        case .KWD:
            return "currencySelector.kuwait.dirham".localized(in: .main)
        case .MAD:
            return "currencySelector.moroccan.dirham".localized(in: .main)
        case .OMR:
            return "currencySelector.omani.riyal".localized(in: .main)
        case .SAR:
            return "homeScreen.defaultCurrency.label.title".localized(in: .main)
        case .SGD:
            return "currencySelector.singapore.dollar".localized(in: .main)
        case .TRY:
            return "currencySelector.turkish.lira".localized(in: .main)
        case .QAR:
            return "currencySelector.qatari.riyal".localized(in: .main)
        case .USD:
            return "currencySelector.united.states.dollar".localized(in: .main)
        case .CHF:
            return "currencySelector.swiss.franc".localized(in: .main)
        }
    }
    // swiftlint:enable cyclomatic_complexity
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SupportedCurrencies/SupportedCurrency.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AssetProvider/BankLogoProvider.swift ---
//
//  BankLogoProvider.swift
//  BeneficiariesJourney
//
//  Created by Mahesh Dhumpeti on 28/03/23.
//

import UIKit

public class BankLogoProvider {
    public static let shared = BankLogoProvider()
    /// Passing empty string will return placeholder image
    public func getLogo(with bankCode: String) -> UIImage {
        guard let logo = UIImage.named(bankCode.uppercased(), in: .snbCommon) else {
            return UIImage.named("placeholder_bank_logo", in: .snbCommon)!
        }
        return logo
    }

    /// Passing empty string will return placeholder image
    public func getProviderLogos(with bankCode: String) -> UIImage {
        guard !bankCode.isEmpty,
              let logo = UIImage.named(bankCode.uppercased(), in: .snbCommon) else {
            return UIImage.named("placeholder_bank_logo", in: .snbCommon)!
        }
        return logo
    }

    public func getProviderBanner(with bankCode: String) -> UIImage? {
        guard !bankCode.isEmpty,
              let logo = UIImage.named("Provider_\(bankCode.uppercased())", in: .snbCommon) else {
            return nil
        }
        return logo
    }

    private init() {
        // No code required here
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AssetProvider/BankLogoProvider.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AssetProvider/CountryFlagProvider.swift ---
//
//  CountryFlagProvider.swift
//  SNBCommon
//
//  Created by Arthur Alves on 05/04/2023.
//

import UIKit

public class CountryFlagProvider {
    public static let shared = CountryFlagProvider()

    /// Code can be:
    /// `country code` ISO Alpha 2
    /// `currency code` ISO 4217
    public func getFlag(with code: String) -> UIImage? {
        guard let flag = UIImage.named(code.uppercased(), in: .snbCommon) else {
            return UIImage.named("placeholder_country_flag", in: .snbCommon)
        }
        return flag
    }

    private init() {}
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AssetProvider/CountryFlagProvider.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReaderViewController.swift ---
//
//  PDFReaderViewController.swift
//  SNBCommon
//
//  Created by Arthur Alves on 30/03/2023.
//

import UIKit
import PDFKit
import BackbaseDesignSystem
import LinkPresentation

final class PDFReaderViewController: UIViewController {
    // MARK: - Status Bar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Initialization

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: PDFReaderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.configureDefaultCardContentView(backgroundType: .pattern)
        addSubviews()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let attributes: [NSAttributedString.Key: Any] = [
            .font: DesignSystem.shared.fonts.preferredFont(.body, .medium),
            .foregroundColor: DesignSystem.shared.colors.text.default.dark
        ]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = attributes
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        view.endEditing(true)
    }

    // MARK: - Private properties

    private lazy var pdfView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "pdfReaderViewController.pdfView"
        return view
    }()

    private var viewModel: PDFReaderViewModel
}

extension PDFReaderViewController {
    func addSubviews() {
        view.addSubview(pdfView)
    }

    func bind() {
        viewModel.$pdfDocument
            .compactMap { $0 }
            .sink { [weak self] pdfDoc in
                self?.update(with: pdfDoc)
            }.store(in: &viewModel.cancellables)

        viewModel.$title
            .sink { [weak self] screenTitle in
                self?.title = screenTitle
            }.store(in: &viewModel.cancellables)

        viewModel.$fileURL
            .compactMap { $0 }
            .sink { [weak self] fileURL in
                self?.presentShareActivity(with: fileURL)
            }.store(in: &viewModel.cancellables)

        viewModel.$screenProperties
            .sink { [weak self] screenProperties in
                guard let self else { return }
                self.setupNavBar(with: screenProperties)
                screenProperties.pdfViewStyle?(self.pdfView)
            }.store(in: &viewModel.cancellables)
    }

    // MARK: - Private

    private func setupNavBar(with screenConfig: ScreenProperties) {
        let closeView = UIImageView(image: screenConfig.closeImage)
        closeView.tintColor = .white
        screenConfig.closeButtonHeight.flatMap { size in
            closeView.snp.makeConstraints { make in
                make.width.height.equalTo(size)
            }
        }

        let closeGesture = UITapGestureRecognizer(
            target: viewModel,
            action: #selector(viewModel.closeTapped)
        )
        closeView.addGestureRecognizer(closeGesture)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeView)

        let shareView = UIImageView(image: screenConfig.shareImage)
        shareView.tintColor = .white
        screenConfig.shareIconSize.flatMap { size in
            shareView.snp.makeConstraints { make in
                make.width.height.equalTo(size)
            }
        }

        let shareGesture = UITapGestureRecognizer(
            target: viewModel,
            action: #selector(viewModel.shareTapped)
        )
        shareView.addGestureRecognizer(shareGesture)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareView)
        screenConfig.navigationItemStyle?(navigationItem)
    }

    private func update(with document: PDFDocument) {
        pdfView.document = document
        pdfView.goToFirstPage(nil)
        adjustPDFSize()

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            self.pdfView.autoScales = true
            self.pdfView.maxScaleFactor = 4.0
            self.pdfView.minScaleFactor = self.pdfView.scaleFactorForSizeToFit
        }
    }

    private func adjustPDFSize() {
        pdfView.snp.removeConstraints()
        pdfView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(DesignSystem.shared.spacer.lg)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func presentShareActivity(with fileURL: URL) {
        pdfView.document?.write(to: fileURL)
        let source = PDFActivityItemSource(fileURL: fileURL)
        let activityViewController = UIActivityViewController(activityItems: [source], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true)
    }
}

class PDFActivityItemSource: NSObject, UIActivityItemSource {
    @Localizable private var title = "marketplace.shareActivity.title"
    @Localizable private var subtitle = "neoTransfer.invite.share.subtitle"
    private lazy var icon = UIImage.named("welcomeActivityIcon", in: .snbCommon)
    let fileURL: URL

    init(fileURL: URL) {
        self.fileURL = fileURL
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        fileURL
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        itemForActivityType
        activityType: UIActivity.ActivityType?
    ) -> Any? {
        fileURL
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        metadata.url = fileURL
        metadata.originalURL = URL(fileURLWithPath: subtitle)
        if let image = icon {
            metadata.iconProvider = NSItemProvider(object: image)
        }
        return metadata
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReaderViewController.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReader.swift ---
//
//  PDFReader.swift
//  SNBCommon
//
//  Created by Arthur Alves on 30/03/2023.
//

import UIKit

public struct PDFReader {
    public static func build(model: PDFReader.PDFModel, configuration: PDFReader.Configuration) -> UIViewController {
        let viewModel = PDFReaderViewModel(model: model, configuration: configuration)
        let viewController = PDFReaderViewController(viewModel: viewModel)
        return viewController
    }
}

public extension PDFReader {
    struct PDFModel {
        let data: Data?
        let url: URL?
        let title: String?
        let closeAction: (() -> Void)?

        /// Initialize PDF properties
        /// - Parameters:
        ///   - data: PDF as Data
        ///   - url: PDF as URL
        ///   - title: Title inside screen, if nil, key is taken from `Strings`
        ///   - closeAction: Callback for close action
        public init(data: Data? = nil, url: URL? = nil, title: String?, closeAction: (() -> Void)?) {
            self.data = data
            self.url = url
            self.title = title
            self.closeAction = closeAction
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReader.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReaderConfiguration.swift ---
//
//  PDFReaderConfiguration.swift
//  SNBCommon
//
//  Created by Arthur Alves on 30/03/2023.
//

import PDFKit
import BackbaseDesignSystem

public extension PDFReader {
    struct Configuration {
        public var showShareActivityOnLoad: Bool
        public var design: Design
        public var strings: Strings
        public var closeAction: (() -> Void)?

        public init(
            showShareActivityOnLoad: Bool = false,
            design: Design = Design(),
            strings: Strings = Strings()
        ) {
            self.showShareActivityOnLoad = showShareActivityOnLoad
            self.design = design
            self.strings = strings
        }
    }
}

extension PDFReader.Configuration {
    public struct Design {
        public var shareImage: UIImage = UIImage.named("share-icon", in: .snbCommon)!
        public var closeImage: UIImage = UIImage(systemName: "xmark.circle")!

        public var closeButtonHeight: CGFloat = 25
        public var shareIconSize: CGFloat = 25

        public var navigationItemStyle: Style<UINavigationItem> = { item in
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: DesignSystem.shared.colors.primary.onDefault,
                .font: DesignSystem.shared.fonts.preferredFont(.largeTitle, .regular)
            ]

            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: DesignSystem.shared.colors.primary.onDefault,
                .font: DesignSystem.shared.fonts.preferredFont(.body, .medium)
            ]
            appearance.largeTitleTextAttributes = largeTitleTextAttributes
            appearance.titleTextAttributes = titleTextAttributes
            appearance.configureWithTransparentBackground()

            item.standardAppearance = appearance
            item.compactAppearance = appearance
            item.scrollEdgeAppearance = appearance
            item.compactScrollEdgeAppearance = appearance
        }

        public var pdfViewStyle: Style<PDFView> = { view in
            view.backgroundColor = .white
            view.pageShadowsEnabled = false
            view.displayMode = .singlePageContinuous
            view.displayDirection = .vertical
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 0
            view.autoScales = true
            view.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        public init() {}
    }
}

extension PDFReader.Configuration {
    public struct Strings {
        @Localizable public var pdfScreenTitle = "pdfreader.title"
        public init() {}
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReaderConfiguration.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReaderViewModel.swift ---
//
//  PDFReaderViewModel.swift
//  SNBCommon
//
//  Created by Arthur Alves on 30/03/2023.
//

import Foundation
import Combine
import PDFKit
import BackbaseDesignSystem

typealias ScreenProperties = PDFReaderViewModel.ScreenProperties

internal final class PDFReaderViewModel {
    @Published var fileURL: URL?
    @Published var pdfDocument: PDFDocument?
    @Published var title: String = ""
    @Published var screenProperties = ScreenProperties()
    var cancellables = Set<AnyCancellable>()

    init(model: PDFReader.PDFModel, configuration: PDFReader.Configuration) {
        self.model = model
        self.configuration = configuration
        self.title = model.title ?? configuration.strings.pdfScreenTitle
        self.screenProperties = ScreenProperties(
            shareImage: configuration.design.shareImage,
            closeImage: configuration.design.closeImage,
            navigationItemStyle: configuration.design.navigationItemStyle,
            pdfViewStyle: configuration.design.pdfViewStyle,
            closeButtonHeight: configuration.design.closeButtonHeight,
            shareIconSize: configuration.design.shareIconSize
        )

        setupLoadingPDF()
        fetchPDF(from: model)
    }

    // MARK: - Private properties

    private func setupLoadingPDF() {
        guard let path = Bundle.snbCommon.path(forResource: "pdfreader_loading", ofType: "pdf") else { return }
        let url = URL(fileURLWithPath: path)
        if let pdf = PDFDocument(url: url) {
            pdfDocument = pdf
        }
    }

    private func fetchPDF(from model: PDFReader.PDFModel) {
        DispatchQueue.global(qos: .background).async {
            if let data = model.data {
                if let pdfDocument = PDFDocument(data: data) {
                    self.present(pdfDocument: pdfDocument)
                }
            }
            if let url = model.url {
                if let pdfDocument = PDFDocument(url: url) {
                    self.present(pdfDocument: pdfDocument)
                }
            }
        }
    }

    private func present(pdfDocument: PDFDocument) {
        DispatchQueue.main.async {
            self.pdfDocument = pdfDocument
            if self.configuration.showShareActivityOnLoad {
                self.shareTapped()
            }
        }
    }

    private var model: PDFReader.PDFModel
    private let configuration: PDFReader.Configuration
}

extension PDFReaderViewModel {
    @objc func shareTapped() {
        let temporaryFolder = FileManager.default.temporaryDirectory
        let fileName: String
        if let title = model.title, !title.isEmpty {
            fileName = title + ".pdf"
        } else {
            fileName = ""
        }
        let temporaryFileURL = temporaryFolder.appendingPathComponent(fileName)
        fileURL = temporaryFileURL
    }

    @objc func closeTapped() {
        model.closeAction?()
    }
}

extension PDFReaderViewModel {
    public struct ScreenProperties {
        public var shareImage: UIImage?
        public var closeImage: UIImage?
        public var navigationItemStyle: Style<UINavigationItem>?
        public var pdfViewStyle: Style<PDFView>?
        public var closeButtonHeight: CGFloat?
        public var shareIconSize: CGFloat?
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/PDFReader/PDFReaderViewModel.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AvatarImageManager/AvatarLocalImageManager.swift ---
//
//  AvatarLocalImageManager.swift
//  RetailApp
//
//  Created by Rafael Nascimento on 19/04/2023.
//

import UIKit

// This class is a helper that allows to save and retrieve the user avatar image saved locally
// This is a temporary class and should be deleted once the User Avatar Story to connect to the BE is done

// TODO: Remove this when the Avatar Image is connected to the BE

public class AvatarLocalImageManager {
    public static let shared = AvatarLocalImageManager()
    let avatarImageFileName = "avatar.png"

    public func save(_ image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }

        guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false) as NSURL else {
            return false
        }

        removeAvatarImageIfSaved()

        do {
            try data.write(to: directory.appendingPathComponent(avatarImageFileName)!)
            return true
        } catch {
            return false
        }
    }

    public func getSavedImage() -> UIImage? {
        if let directory = try? FileManager.default.url(for: .documentDirectory,
                                                          in: .userDomainMask,
                                                          appropriateFor: nil,
                                                          create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(avatarImageFileName).path)
        }
        return nil
    }

    public func removeAvatarImageIfSaved() {
        guard let imagePath = path(for: avatarImageFileName) else {
            return
        }
        try? FileManager.default.removeItem(at: imagePath)
    }

    private func path(for imageName: String) -> URL? {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return directory?.appendingPathComponent(imageName)
    }

    private init() {}
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/AvatarImageManager/AvatarLocalImageManager.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Protocols/URLOpenerProtocol.swift ---
//
//  URLOpenerProtocol.swift
//  OpenBankingJourney
//
//  Created by Mahesh Dhumpeti on 01/05/24.
//

import Foundation

public protocol URLOpenerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any]) async -> Bool
}

extension UIApplication: URLOpenerProtocol {}

public struct URLOpener {
    private let application: URLOpenerProtocol

    public init(application: URLOpenerProtocol) {
        self.application = application
    }

    public func openUrl(url: URL) async {
        if application.canOpenURL(url) {
            await application.open(url, options: [:])
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Protocols/URLOpenerProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Protocols/Reusable.swift ---
//
//  Reusable.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 14/02/2023.
//

import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    // https://forums.swift.org/t/relying-on-string-describing-to-get-the-name-of-a-type/16391
    static var reuseIdentifier: String { NSStringFromClass(self) }
}

// MARK: - Table View convenience methods

public extension UITableView {
    func register<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell, Cell: Reusable {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func registerHeaderFooterView<View>(_ view: View.Type) where View: UITableViewHeaderFooterView, View: Reusable {
        register(view, forHeaderFooterViewReuseIdentifier: view.reuseIdentifier)
    }

    func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell, Cell: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Cell class \(cellType.reuseIdentifier) is not registered in \(description)")
        }
        return cell
    }

    func dequeue<HeaderFooter>(_ type: HeaderFooter.Type) -> HeaderFooter where HeaderFooter: UITableViewHeaderFooterView,
                                                                                HeaderFooter: Reusable {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as? HeaderFooter else {
            fatalError("HeaderFooter class \(type.reuseIdentifier) is not registered in \(description)")
        }
        return cell
    }
}

// MARK: Collection View convenience methods

public extension UICollectionView {
    func register<Cell>(_ cellType: Cell.Type) where Cell: UICollectionViewCell, Cell: Reusable {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func registerSupplementaryView<View>(_ viewType: View.Type, kind: String) where View: UICollectionReusableView, View: Reusable {
        register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewType.reuseIdentifier)
    }

    func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell, Cell: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Cell class \(cellType.reuseIdentifier) is not registered in \(description)")
        }
        return cell
    }

    func dequeueSupplementaryView<View>(
        _ viewType: View.Type,
        kind: String,
        for indexPath: IndexPath
    ) -> View where View: UICollectionReusableView, View: Reusable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        ) as? View else {
            fatalError("Supplementary View class \(viewType.reuseIdentifier) is not registered in \(description)")
        }
        return view
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Protocols/Reusable.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Protocols/Coordinator.swift ---
//
//  Coordinator.swift
//  SNBCommon
//
//  Created by Konrad Siemczyk on 18/06/2023.
//

import Foundation

public protocol Coordinator: AnyObject {
    associatedtype CompletionResult: Any = Void
    typealias Completion = (CompletionResult) -> Void

    var onFinished: Completion? { get set }
    func start()
}

public extension Coordinator {
    func finishFlow() where CompletionResult == Void {
        onFinished?(())
    }

    func finishFlow(result: CompletionResult) {
        onFinished?(result)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/Protocols/Coordinator.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/AppleWalletUseCaseService/AppleWalletModels.swift ---
//
//  AppleWalletModels.swift
//  RetailCardsManagementJourney
//
//  Created by Gabriel Rodrigues Minucci on 01/04/2023.
//

import Foundation

public enum DeviceWalletStatus {
    case ready, notSupported
}

public enum CardWalletStatus {
    case eligible, digitizedButEligible, digitized, ineligible
}

public struct CardProvisioningRequest: Encodable {
    let nonce: String
    let nonceSignature: String
    let certificates: [String]
    let cardType: String?

    public init(nonce: String, nonceSignature: String, certificates: [String], cardType: String? = nil) {
        self.nonce = nonce
        self.nonceSignature = nonceSignature
        self.certificates = certificates
        self.cardType = cardType
    }
}

public struct CardProvisioningResponse: Decodable {
    public let encryptedPassData: String
    public let wrappedKey: String
    public let activationCode: String

    public init(encryptedPassData: String, wrappedKey: String, activationCode: String) {
        self.encryptedPassData = encryptedPassData
        self.wrappedKey = wrappedKey
        self.activationCode = activationCode
    }
}

public enum WalletError: Error {
    case generic
    case noInternet
    case failedToCreatePaymentPassRequestConfiguration
    case failedToCreatePaymentPassViewController
    case missingCardForAddToWalletOperation
    case applePay(Error)
    case notSupported
}

public protocol AppleWalletCard {
    var identifier: String { get }
    var type: String { get }
    var maskedNumber: String { get }
    var name: String { get }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/AppleWalletUseCaseService/AppleWalletModels.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/AppleWalletUseCaseService/AppleWalletUseCaseProtocol.swift ---
//
//  Untitled.swift
//  Pods
//
//  Created by Vaibhav Misra on 14/10/24.
//

import Foundation
import PassKit

public protocol AppleWalletUseCaseProtocol {
    var isInAppProvisioningEnabled: Bool { get set }
    func getWalletStatus() -> DeviceWalletStatus
    func getCardWalletStatus(card: AppleWalletCard) -> CardWalletStatus
    func openCardInWallet(card: AppleWalletCard)
    func addCardToWallet(
        card: AppleWalletCard,
        originViewController: UIViewController,
        completion: @escaping (UIViewController?, Result<PKSecureElementPass, WalletError>) -> Void
    )
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/AppleWalletUseCaseService/AppleWalletUseCaseProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBUserService/UseCase/SNBUserServiceUseCase.swift ---
//
//  SNBUserServiceUseCase.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 08/01/24.
//

import Foundation
import Resolver

public protocol SNBUserServiceUseCaseProtocol {
    func deleteAccount() async throws
}

public final class SNBUserServiceUseCase: SNBUserServiceUseCaseProtocol {
    private let client: SNBUserServiceClientProtocol

    public init(client: SNBUserServiceClientProtocol = SNBUserServiceClientFactory.makeClient()) {
        self.client = client
    }

    public func deleteAccount() async throws {
        try await client.deleteAccount()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBUserService/UseCase/SNBUserServiceUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBUserService/Client/SNBUserServiceClient.swift ---
//
//  SNBUserServiceClient.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 08/01/24.
//

import Foundation
import Resolver

public protocol SNBUserServiceClientProtocol {
    func deleteAccount() async throws
}

final class SNBUserServiceClient: BaseDBSClient, SNBUserServiceClientProtocol {
    func deleteAccount() async throws {
        return try await performRequest(endpoint: Endpoint.delete)
    }
}

// MARK: - Endpoint configuration
private extension SNBUserServiceClient {
    private enum Endpoint: EndpointConfiguration {
        case delete

        var path: String {
            switch self {
            case .delete:  return "users/me"
            }
        }

        var method: HTTPMethod { .delete }
        var queryParameters: [URLQueryItem]? { nil }
        var body: Encodable? { nil }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBUserService/Client/SNBUserServiceClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBUserService/Client/SNBUserServiceClientFactory.swift ---
//
//  SNBUserServiceClientFactory.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 08/01/24.
//

import Backbase
import Resolver

public enum SNBUserServiceClientFactory {
    public static func makeClient() -> SNBUserServiceClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("/api/common-user-service/client-api/v2")
        return SNBUserServiceClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBUserService/Client/SNBUserServiceClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBTransactionRefreshService/UseCase/SNBTransactionRefreshServiceUseCase.swift ---
//
//  SNBTransactionRefreshServiceUseCase.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 27/08/23.
//

import Foundation
import Resolver

public protocol SNBTransactionRefreshServiceUseCaseProtocol {
    func refreshTransactions() async throws
}

public final class SNBTransactionRefreshServiceUseCase: SNBTransactionRefreshServiceUseCaseProtocol {
    private let client: SNBTransactionRefreshServiceClientProtocol

    public init(client: SNBTransactionRefreshServiceClientProtocol = SNBTransactionRefreshServiceClientFactory.makeClient()) {
        self.client = client
    }
    public func refreshTransactions() async throws {
        try await client.refreshTransactions()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBTransactionRefreshService/UseCase/SNBTransactionRefreshServiceUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBTransactionRefreshService/Client/SNBTransactionRefreshServiceClientFactory.swift ---
//
//  SNBTransactionRefreshServiceClientFactory.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 27/08/23.
//

import Backbase
import Resolver

public enum SNBTransactionRefreshServiceClientFactory {
    public static func makeClient() -> SNBTransactionRefreshServiceClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("api/transaction-refresh-service/client-api/v1")
        return SNBTransactionRefreshServiceClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBTransactionRefreshService/Client/SNBTransactionRefreshServiceClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBTransactionRefreshService/Client/SNBTransactionRefreshServiceClient.swift ---
//
//  SNBTransactionRefreshServiceClient.swift
//  SNBCommon
//
//  Created by Bhuvan Sharma on 27/08/23.
//

import Foundation
import Resolver

public protocol SNBTransactionRefreshServiceClientProtocol {
    func refreshTransactions() async throws
}

final class SNBTransactionRefreshServiceClient: BaseDBSClient, SNBTransactionRefreshServiceClientProtocol {
    func refreshTransactions() async throws {
        return try await performRequest(endpoint: Endpoint.refresh)
    }
}

// MARK: - Endpoint configuration
private extension SNBTransactionRefreshServiceClient {
    private enum Endpoint: EndpointConfiguration {
        case refresh

        var path: String {
            switch self {
            case .refresh:  return "transaction/refresh"
            }
        }

        var method: HTTPMethod { .get }
        var queryParameters: [URLQueryItem]? { nil }
        var body: Encodable? { nil }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBTransactionRefreshService/Client/SNBTransactionRefreshServiceClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/RequestMoneyCountService/UseCase/RequestMoneyServiceUseCase.swift ---
//
//  RequestMoneyServiceUseCase.swift
//  ActiveLabel
//
//  Created by Bhuvan Sharma on 21/08/24.
//

import Foundation
import Resolver

public protocol RequestMoneyServiceUseCaseProtocol {
    func getCount() async throws -> String?
}

public final class RequestMoneyServiceUseCase: RequestMoneyServiceUseCaseProtocol {
    private let client: RequestMoneyServiceClientProtocol

    public init(client: RequestMoneyServiceClientProtocol = RequestMoneyServiceClientFactory.makeClient()) {
        self.client = client
    }
    public func getCount() async throws -> String? {
        let response = try await client.fetchRequestCount()
        return response.count == "0" ? nil : response.count
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/RequestMoneyCountService/UseCase/RequestMoneyServiceUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/RequestMoneyCountService/Client/RequestMoneyServiceClient.swift ---
//
//  RequestMoneyServiceClient.swift
//  ActiveLabel
//
//  Created by Bhuvan Sharma on 21/08/24.
//

import Foundation
import Resolver

public protocol RequestMoneyServiceClientProtocol {
    func fetchRequestCount() async throws -> RequestMoneyCountResponseDTO
}

final class RequestMoneyServiceClient: BaseDBSClient, RequestMoneyServiceClientProtocol {
    func fetchRequestCount() async throws -> RequestMoneyCountResponseDTO {
        return try await performRequest(endpoint: Endpoint.count(status: "PENDING"))
    }
}

// MARK: - Endpoint configuration
private extension RequestMoneyServiceClient {
    private enum Endpoint: EndpointConfiguration {
        case count(status: String)

        var path: String {
            switch self {
            case .count:
                return "v1/rtp-requests/received/count"
            }
        }
        var method: HTTPMethod { .get }
        var queryParameters: [URLQueryItem]? {
            switch self {
            case .count(let status):
                return [URLQueryItem(name: "status", value: status)]
            }
        }
        var body: Encodable? { nil }
    }
}

public struct RequestMoneyCountResponseDTO: Decodable {
    var count: String
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/RequestMoneyCountService/Client/RequestMoneyServiceClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/RequestMoneyCountService/Client/RequestMoneyServiceClientFactory.swift ---
//
//  RequestMoneyServiceClientFactory.swift
//  ActiveLabel
//
//  Created by Bhuvan Sharma on 21/08/24.
//

import Foundation
import Backbase
import Resolver

public enum RequestMoneyServiceClientFactory {
    public static func makeClient() -> RequestMoneyServiceClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("api/request-money-integration-service/client-api")
        return RequestMoneyServiceClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/RequestMoneyCountService/Client/RequestMoneyServiceClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/UseCase/DeviceManagementServiceUseCaseProtocol.swift ---
//
//  DeviceManagementServiceUseCaseProtocol.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 26/02/2024.
//

public protocol DeviceManagementServiceUseCaseProtocol {
    func pushTokens() async throws
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/UseCase/DeviceManagementServiceUseCaseProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/UseCase/DeviceManagementServiceUseCase.swift ---
//
//  DeviceManagementServiceUseCase.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 26/02/2024.
//

public final class DeviceManagementServiceUseCase: DeviceManagementServiceUseCaseProtocol {
    private let client: DeviceManagementServiceClientProtocol

    public init(client: DeviceManagementServiceClientProtocol = DeviceManagementServiceClientFactory.makeClient()) {
        self.client = client
    }

    public func pushTokens() async throws {
        try await client.pushTokens()
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/UseCase/DeviceManagementServiceUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/DeviceManagementServiceClient.swift ---
//
//  DeviceManagementServiceClient.swift
//  ActiveLabel
//
//  Created by Aleh Pachtovy on 26/02/2024.
//

private struct Constants {
    static var platform = "ios"
}

final class DeviceManagementServiceClient: BaseDBSClient, DeviceManagementServiceClientProtocol {
    @KeychainTokenItem(tokenType: .firebaseToken) private var firebaseToken: String?

    func pushTokens() async throws {
        guard let deviceId = JWTProvider.deviceId,
              let firebaseToken else {
            return
        }
        try await performRequest(endpoint: Endpoint.pushTokens(deviceId: deviceId, token: firebaseToken))
    }
}

// MARK: - Endpoint configuration
private extension DeviceManagementServiceClient {
    private enum Endpoint: EndpointConfiguration {
        case pushTokens(deviceId: String, token: String)

        var path: String {
            switch self {
            case .pushTokens(let deviceId, _):
                return "\(deviceId)/push-tokens"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .pushTokens: return .put
            }
        }

        var queryParameters: [URLQueryItem]? {
            switch self {
            case .pushTokens: return nil
            }
        }

        var body: Encodable? {
            switch self {
            case .pushTokens(_, let token):
                return PushTokensRequestDTO(platform: Constants.platform, token: token)
            }
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/DeviceManagementServiceClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/DeviceManagementServiceClientProtocol.swift ---
//
//  DeviceManagementServiceClientProtocol.swift
//  ActiveLabel
//
//  Created by Aleh Pachtovy on 26/02/2024.
//

public protocol DeviceManagementServiceClientProtocol {
    func pushTokens() async throws
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/DeviceManagementServiceClientProtocol.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/DeviceManagementServiceClientFactory.swift ---
//
//  DeviceManagementServiceClientFactory.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 26/02/2024.
//

import Backbase

public enum DeviceManagementServiceClientFactory {
    public static func makeClient() -> DeviceManagementServiceClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("api/device-management-service/client-api/v1/users/me/devices/")
        return DeviceManagementServiceClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/DeviceManagementServiceClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/PushTokensRequestDTO.swift ---
//
//  PushTokensRequestDTO.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 26/02/2024.
//

public struct PushTokensRequestDTO: Codable {
    let platform: String
    let token: String
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/DeviceManagementService/Client/PushTokensRequestDTO.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBCryptoService/UseCase/SNBCryptoServiceUseCase.swift ---
//
//  SNBCryptoServiceUseCase.swift
//  RetailApp
//
//  Created by Bhuvan Sharma on 06/08/23.
//

import Foundation
import Resolver

public protocol SNBCryptoServiceUseCaseProtocol {
    func getEncrypted(of nationalId: String) async throws -> String?
}

public final class SNBCryptoServiceUseCase: SNBCryptoServiceUseCaseProtocol {
    private let client: SNBCryptoServiceClientProtocol

    public init(client: SNBCryptoServiceClientProtocol = SNBCryptoServiceClientFactory.makeClient()) {
        self.client = client
    }
    public func getEncrypted(of value: String) async throws -> String? {
        do {
            let response = try await client.fetchPublicKey()
            return value.encrypt(with: response.publicKey)
        } catch {
            return nil
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBCryptoService/UseCase/SNBCryptoServiceUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBCryptoService/Client/SNBCryptoServiceClientFactory.swift ---
//
//  SNBCryptoServiceClientFactory.swift
//  RetailApp
//
//  Created by Bhuvan Sharma on 06/08/23.
//

import Backbase
import Resolver

public enum SNBCryptoServiceClientFactory {
    public static func makeClient() -> SNBCryptoServiceClientProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("api/snb-crypto-service/client-api/v1")
        return SNBCryptoServiceClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBCryptoService/Client/SNBCryptoServiceClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBCryptoService/Client/SNBCryptoServiceClient.swift ---
//
//  SNBCryptoServiceClient.swift
//  RetailApp
//
//  Created by Bhuvan Sharma on 06/08/23.
//

import Foundation
import Resolver

public protocol SNBCryptoServiceClientProtocol {
    func fetchPublicKey() async throws -> SNBCryptoServicePublicKeyResponseDTO
}

final class SNBCryptoServiceClient: BaseDBSClient, SNBCryptoServiceClientProtocol {
    func fetchPublicKey() async throws -> SNBCryptoServicePublicKeyResponseDTO {
        return try await performRequest(endpoint: Endpoint.publicKey)
    }
}

// MARK: - Endpoint configuration
private extension SNBCryptoServiceClient {
    private enum Endpoint: EndpointConfiguration {
        case publicKey

        var path: String {
            switch self {
            case .publicKey:  return "public-key"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .publicKey: return .get
            }
        }

        var queryParameters: [URLQueryItem]? {
            switch self {
            case .publicKey: return nil
            }
        }

        var body: Encodable? {
            switch self {
            case .publicKey: return nil
            }
        }
    }
}

public struct SNBCryptoServicePublicKeyResponseDTO: Decodable {
    var publicKey: String
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBCryptoService/Client/SNBCryptoServiceClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBLifeStyleMoreService/UseCase/SNBLifeStyleMoreServiceUseCase.swift ---
//
//  SNBLifeStyleMoreServiceUseCaseProtocol.swift
//  ActiveLabel
//
//  Created by MMohammadJaber on 09/10/2024.
//

import Foundation
import Resolver

public protocol SNBLifeStyleMoreServiceUseCaseProtocol {
    func getItemsInfo() async throws -> SNBLifeStyleMoreResponseDTO?
}

public final class SNBLifeStyleMoreServiceUseCase: SNBLifeStyleMoreServiceUseCaseProtocol {
    private let client: SNBLifeStyleMoreServiceClientProtocol

    public init(client: SNBLifeStyleMoreServiceClientProtocol = SNBLifeStyleMoreServiceClientFactory.makeClient()) {
        self.client = client
    }
    public func getItemsInfo() async throws -> SNBLifeStyleMoreResponseDTO? {
        let response = try await client.fetchItemsInfo()
        return response
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBLifeStyleMoreService/UseCase/SNBLifeStyleMoreServiceUseCase.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBLifeStyleMoreService/Client/SNBLifeStyleMoreServiceClientFactory.swift ---
//
//  SNBLifeStyleMoreServiceClientFactory.swift
//  Pods
//
//  Created by MMohammadJaber on 09/10/2024.
//

import Foundation
import Backbase
import Resolver

public enum SNBLifeStyleMoreServiceClientFactory {
    public static func makeClient() -> SNBLifeStyleMoreServiceClientProtocol {
        guard let baseUrl = Backbase.configuration().custom["lifestyleBaseUrl"] as? String, let serverURL = URL(string: baseUrl) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }
        let requestURL = serverURL.appendingPathComponent("/proxy/GamesMetadata/Module")
        return SNBLifeStyleMoreServiceClient(baseURL: requestURL)
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBLifeStyleMoreService/Client/SNBLifeStyleMoreServiceClientFactory.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBLifeStyleMoreService/Client/SNBLifeStyleMoreServiceClient.swift ---
//
//  SNBLifeStyleMoreServiceClient.swift
//  Pods
//
//  Created by MMohammadJaber on 09/10/2024.
//

import Foundation
import Resolver

public protocol SNBLifeStyleMoreServiceClientProtocol {
    func fetchItemsInfo() async throws -> SNBLifeStyleMoreResponseDTO
}

final class SNBLifeStyleMoreServiceClient: BaseDBSClient, SNBLifeStyleMoreServiceClientProtocol {
    func fetchItemsInfo() async throws -> SNBLifeStyleMoreResponseDTO {
        return try await performRequest(endpoint: Endpoint.info(status: "PENDING"))
    }
}

// MARK: - Endpoint configuration
private extension SNBLifeStyleMoreServiceClient {
    private enum Endpoint: EndpointConfiguration {
        case info(status: String)

        var path: String {
            switch self {
            case .info:
                return "apps.json"
            }
        }
        var method: HTTPMethod { .get }
        var queryParameters: [URLQueryItem]? {
            switch self {
            case .info(let status):
                return []
            }
        }
        var body: Encodable? { nil }
    }
}

public typealias SNBLifeStyleMoreResponseDTO = [String: String]

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/UseCases/SNBLifeStyleMoreService/Client/SNBLifeStyleMoreServiceClient.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/LimitManagement/LimitManagementPresentable.swift ---
//
//  LimitManagementPresentable.swift
//  SNBCommon
//
//  Created by Mahesh Dhumpeti on 30/05/24.
//

import Foundation
import Resolver
import BackbaseDesignSystem

public enum LimitUpdateFrom {
    case quickTransfer
    case neoTransfer
    case splitBills
    case none
}

public protocol LimitManagementPresentable {
    func navigate(navigationController: UINavigationController, editRequestFrom: LimitUpdateFrom)
}

public protocol LimitExceedErrorProtocol {
    var currency: String { get }
    var limit: Double { get }
    var limitConsumption: Double { get }
    var period: String? { get }
}

public extension LimitExceedErrorProtocol {
    // SNBDBR-19951: common limit exceed inline error based on period returned from BE
    public var limitExceedError: String? {
        guard let configuration = Resolver.optional(SNBCommon.Configuration.self),
              let period else {
            return nil
        }
        if period.caseInsensitiveCompare("Day") == .orderedSame {
            return configuration.strings.dailyLimitExceeded
        } else if period.caseInsensitiveCompare("Month") == .orderedSame {
            return configuration.strings.monthlyLimitExceeded
        }
        return nil
    }

    // SNBDBR-19951: common limit exceed alert message based on period returned from BE
    public var limitExceedAlertMessage: String? {
        guard let configuration = Resolver.optional(SNBCommon.Configuration.self),
              let period else {
            return nil
        }
        let formattedAmount = DesignSystem.shared.formatting.formatAmount(value: (limit - limitConsumption)) ?? ""
        let availableAmount =  "\(formattedAmount) \(currency)"
        if period.caseInsensitiveCompare("Day") == .orderedSame {
            return String(format: configuration.strings.dailyLimitExceededMessage, availableAmount)
        } else if period.caseInsensitiveCompare("Month") == .orderedSame {
            return String(format: configuration.strings.monthlyLimitExceededMessage, availableAmount)
        }
        return nil
    }
}

public protocol SubLimitExceedErrorProtocol {
    var subLimitType: String? { get }
    var subLimitPeriod: String? { get }
}

public extension SubLimitExceedErrorProtocol {
    // SNBDBR-28212, SNBDBR-28259: common sub limit exceed inline error based on period and payment type returned from BE
    public var subLimitExceedError: String? {
        guard let configuration = Resolver.optional(SNBCommon.Configuration.self),
              let type = subLimitType else {
            return nil
        }
        switch type.lowercased() {
        case "PaymentSadad".lowercased() where subLimitPeriod?.caseInsensitiveCompare("Day") == .orderedSame:
            return configuration.strings.sadadDailyLimitError
        case "PaymentSadad".lowercased() where subLimitPeriod?.caseInsensitiveCompare("Month") == .orderedSame:
            return configuration.strings.sadadMonthlyLimitError
        case "PaymentSadad".lowercased():
            return configuration.strings.sadadLimitError
        case "PaymenteGift".lowercased() where subLimitPeriod?.caseInsensitiveCompare("Day") == .orderedSame:
            return configuration.strings.marketplaceDailyLimitError
        case "PaymenteGift".lowercased() where subLimitPeriod?.caseInsensitiveCompare("Month") == .orderedSame:
            return configuration.strings.marketplaceMonthlyLimitError
        case "PaymenteGift".lowercased():
            return configuration.strings.marketplaceLimitError
        default:
            return nil
        }
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/LimitManagement/LimitManagementPresentable.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SwiftUI/UIViewControllerRepresentable/GenericErrorView.swift ---
//
//  GenericErrorView.swift
//  SNBCommon
//
//  Created by Aleh Pachtovy on 13/04/2023.
//

import SwiftUI

public struct GenericErrorView: UIViewControllerRepresentable {

    public typealias UIViewControllerType = GenericErrorScreenViewController

    let configuration: GenericErrorScreen.Configuration

    public init(configuration: GenericErrorScreen.Configuration) {
        self.configuration = configuration
    }

    public func makeUIViewController(context: Context) -> GenericErrorScreenViewController {
        let viewModel = GenericErrorScreenViewModel(configuration: configuration)
        let viewController = GenericErrorScreenViewController(viewModel: viewModel,
                                         configuration: configuration)
        viewModel.viewController = viewController
        return viewController
    }

    public func updateUIViewController(_ uiViewController: GenericErrorScreenViewController, context: Context) {}
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SwiftUI/UIViewControllerRepresentable/GenericErrorView.swift ---

// --- Start of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SwiftUI/SwiftUI+UIKit+Conversion.swift ---
//
//  SwiftUI+UIKit+Conversion.swift
//  SADADPaymentsJourney
//
//  Created by Konrad Siemczyk on 21/02/2023.
//

import UIKit
import SwiftUI
import BackbaseDesignSystem

public extension UIColor {
    var color: Color {
        Color(self)
    }
}

public extension UIImage {
    var image: Image {
        Image(uiImage: self)
    }
}

public extension UIFont {
    var font: Font {
        Font(self)
    }
}

public extension Font {
    static func preferredFont(_ style: UIFont.TextStyle, _ weight: UIFont.Weight) -> Font {
        DesignSystem.shared.fonts.preferredFont(style, weight).font
    }
}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SwiftUI/SwiftUI+UIKit+Conversion.swift ---
