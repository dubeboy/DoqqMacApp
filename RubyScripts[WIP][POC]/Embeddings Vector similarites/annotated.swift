/**
 Returns the navigation type for a given Deeplink string.

 - parameter deeplinkString: The Deeplink string to determine the navigation type for.
 - returns: The `DismissCardType` enum value representing the navigation type, or nil if no matching string is found.


/**
Dismisses the view controller.

- See Also: `UINavigationController`
*/
func dismiss() {
    navigationController?.dismiss(animated: true)
}


/**
* Invoked when the button is tapped.
*
* - parameter redirectionType: The type of card to dismiss. If `nil`, no action will be taken.
*/
func didTapOnButton(redirectionType: DiscoverCardsJourney.Configuration.DismissCardType?) {
    if let thisType = redirectionType {
        closeAction?(thisType)
}


/// Loads the view.
///
/// - Warning: This method is called by Apple's UINib autoreleased loading. The implementation should not depend on the lifetime of any presented "content" since the underlying UI may be reloaded from `@IBDesignables`.
func loadView() {
    super.loadView()
    view.configureBackgroundView(type: .plain)
}


/// **viewDidLoad**
///
/// Called when the view is loaded.
///
/// - SeeAlso: `super.viewDidLoad()`
public override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    addConstraints()
    self.viewDidLoadPublisher.send()
}


/**
* Binds the close button's touch up inside event to a closure that calls the view model when the button is tapped.
*
* - Returns: None
*/
func bind() {
    closeButton.publisher(for: .touchUpInside)
        .sink { [weak self] _ in self?.viewModel.didTapCloseButton() }
}


/// Sets up the progress bar manager with the given number of segments.
///
/// - parameter segmentCount: The number of segments for the progress bar.
func setupProgressbar(segmentCount: Int) {
    progressBarManager = StoryProgressBarManager(parentView: view,
                                                 segmentCount: segmentCount,
                                                 parentViewController: self)
}


/**
 Adds constraints to the views.
 */
func addConstraints() {
    /**
     Adds the collectionView as a subview to the view.
     */
    view.addSubview(collectionView)

    /**
     Adds the closeButton as a subview to the view.
     */
    view.addSubview(closeButton)

    /**
     Adds the activityView as a subview to the view.
     */
    view.addSubview(activityView)

    /**
     Sets the constraints for the closeButton.
     */
    closeButton.snp.makeConstraints { make in
        /**
         Sets the height and width of the closeButton to 24.0 points.
         */
        make.height.width.equalTo(24.0)

        /**
         Pins the trailing edge of the closeButton to the super view's trailing edge, with an offset of the spacer value from the DesignSystem shared instance.
         */
        make.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.md)

        /**
         Sets the top edge of the closeButton 28.0 points below the safe area layout guide.
         */
        make.top.equalTo(view.safeAreaLayoutGuide).offset(28.0)
    }
}


/// Shows a generic error message.
func showGenericError() {
    /// Checks if the view model is connected to the internet.
    guard viewModel.isInternetConnected else {
        return
    }
    
    /// Calls the view model's showErrorWithRetry function with the current view controller.
    self.viewModel.showErrorWithRetry(viewController: self)
}


/**
* Returns the number of items in the given section.
*
* - parameter collectionView: The UICollectionView object that requested this information.
* - parameter section: The section for which to return the number of items.
* - returns: The number of items in the specified section.
*/
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    cards.count
}


/**
 Returns a `UICollectionViewCell` instance for the given `indexPath`.

 - parameter collectionView: The `UICollectionView` that this method is being called from.
 - parameter indexPath: The index path of the cell to be returned.

 - returns: A `DiscoverCardCollectionViewCell` instance, or a default `UICollectionReusableView` if no reusable cell can be dequeued.


/**
 Scrolls the view and updates the progress bar.
 
 - parameter scrollView: The scroll view that triggered this function.
 */
func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if let collectionView = scrollView as? UICollectionView {
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        progressBarManager.progressBar?.animateToSegment(currentIndex)
    }
}


/**
* Called when the view is about to appear.
*
* This method is called before the receiver's `view` appears on screen. This can be useful for preparing the view for display, such as setting up animations or loading data.
*
* :param: animated If true, the view will be animating when it appears. Otherwise, it will not.
*/
public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    progressBarManager?.startStoryAnimations()
    collectionView.reloadData()
}


/**
 Resets animations managed by the `progressBarManager` when the view disappears.

 - parameter animated: Whether the view disappearance is animated.
 */
func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    progressBarManager?.resetAnimations()
}


/**
Pauses the progress bar animation.

- Returns: None
*/
func pauseProgressBarAnimation() {
    progressBarManager?.pauseProgressBarAnimation()
}


/**
Resumes the progress bar animation.

- Note: This method should only be called when the progress bar is paused or stopped.
*/
func resumeProgressBarAnimation() {
    progressBarManager?.resumeProgressBarAnimation()
}


/// Sets up the constraints for the progress bar.
///
/// - Parameter parentView: The view that will be used as the anchor for the constraints.

func setupConstraints(parentView: UIView) {
    NSLayoutConstraint.activate([
        progressBar!.heightAnchor.constraint(equalToConstant: 3), // Adjust segment height
        progressBar!.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
        progressBar!.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
        progressBar!.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 8)
    ])
}


/**
 Starts the story animations.

- Returns: None
 */
func startStoryAnimations() {
    progressBar?.startProgress()
}


/**
Resets animations.

- See also: `progressBar?.resetAnimations()`


/// Animates the progress bar to the next segment.
///
/// - Returns: None
func animateToNextSegment() {
    progressBar?.animateToNextSegment()
}


/**
 Animates the progress bar to its previous state.

 - Note: This method assumes that the `progressBar` property is properly set before calling this method.
 */
func animateToPreviousSegment() {
    progressBar?.animateToPreviousSegment()
}


/**
 Animates the UI to the specified segment.

 - parameter segmentIndex: The index of the target segment.
 */
func animateToSegment(_ segmentIndex: Int) {
    progressBar?.animateToSegment(segmentIndex)
}


/**
Pauses the progress bar animation.

- Returns: None
*/
func pauseProgressBarAnimation() {
    progressBar?.pauseAnimation()
}


/**
Resumes the progress bar animation.

- Returns: None
*/
func resumeProgressBarAnimation() {
    progressBar?.resumeAnimation()
}


/**
 Handles all segment animations finished.
 
 - See Also: `DispatchQueue.main.async`
 */
func handleAllSegmentAnimationsFinished() {
    DispatchQueue.main.async { [weak self] in
        if let presentedViewController = self?.parentViewController?.presentedViewController {
            presentedViewController.dismiss(animated: true) { [weak self] in
                self?.parentViewController?.dismiss(animated: true)
            }
        }
}


/**
 Sets up the UI components.

- Returns: None
 */
func setUp() {
    /**
     Adds the `loadingImage` to the superview.
     */
    addSubview(loadingImage)

    /**
     Configures the constraints for the `loadingImage`.
     */
    loadingImage.snp.makeConstraints {
        /**
         Aligns the leading, trailing, top, and bottom edges of the `loadingImage`
         to those of its superview.
         */
        $0.leading.trailing.top.bottom.equalToSuperview()
    }
}


/**
Loads an image from the given URL.

- Note: Cancels any ongoing network task before making a new request.
- Precondition: `urlString` must not be nil or empty.
*/
func loadImage() {
    task?.cancel()
    guard let urlStr = urlString, let url = URL(string: urlStr) else {
        loadingImage.stopAnimating()
        image = defaultImage
        return
    }
}


/**
 Fetches a list of cards.

- Returns: A list of cards.
 */
func getCards() {
    self.state.send(.loading)
    Task { [weak self] in
        do {
            guard let cards = try await self?.useCase.getCards() else { return }
            // ... (rest of the code)
        }
    }
}


/**
Dismisses the view controller.

- See also: `router`
*/
func didTapCloseButton() {
    router.dismiss()
}


/// Displays an error screen with a retry option.
///
/// - parameter viewController: The view controller to present the error screen on.

```swift
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
```


/**
 Returns the output of binding with given input.

 - parameter input: The input to bind.
 - returns: The output of binding.
 */
func bind(input: DiscoverCardsViewModelInput) -> DiscoverCardsViewModelOutput {
    input.viewDidLoad.sink { [weak self] in
        self?.getCards()
    }
}


/**
 Called after the view's new supervisor is set.

 - Inherited from `UIView`
 */
func didMoveToSuperview() {
    super.didMoveToSuperview()

    // Call startProgress when the view is added to its superview (e.g., when the ViewController is presented)
    startProgress()
}


/**
Sets up the user interface for the view.

- Returns: N/A
- Discussion: This method configures the background color, clipping boundaries, and corner radius of the view.
*/
func setupUI() {
    backgroundColor = .clear
    clipsToBounds = true
    layer.cornerRadius = self.segmentHeight / 2
}


/**
Starts the progress animation.

- Warning: This function should only be called when there are no animations currently in progress.
*/
func startProgress() {
    // Check if animation is already in progress
    guard !isAnimating else { return }
}


/// Animate the next segment with remaining time
///
/// - Parameter remainingTime: The remaining time to animate, default is 7.0 seconds (60 frames per second)
func animateNextSegmentWithRemainingTime(_ remainingTime: TimeInterval = 7.0) {
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
}


/**
 Animates the next segment.

 - SeeAlso: `animateNextSegmentWithRemainingTime()`
 */
func animateNextSegment() {
    pausedProgress = 0 // set this when other than current pause segment selected
    animateNextSegmentWithRemainingTime()
}


/**
 Animates to the previous segment.

- Important: This function assumes that `currentSegment` is greater than 0.
- Complexity: O(1)
- Time complexity: O(1)

```swift
func animateToPreviousSegment() {
    guard currentSegment > 0 else {
        return
    }
}
```
*/


/**
 Animates the view to the next segment.

- Note: This method will only work if there are more than one segments.
 */
func animateToNextSegment() {
    guard currentSegment < segmentCount - 1 else {
        return
    }
}


/**
 Animates the view to a new segment.

 - parameter segmentIndex: The index of the target segment.
 */
func animateToSegment(_ segmentIndex: Int) {
    currentSegment = segmentIndex
    progress = 0
    setNeedsDisplay()
    updateProgress()
}


/**
 Resets animations.

 - Current segment is reset to the first one.
 - Progress is reset to zero.
 - Animating flag is set to false.
 - The view is marked as needing a display update.
 - Animation for next segment starts.
 */
func resetAnimations() {
    currentSegment = 0
    progress = 0
    isAnimating = false
    setNeedsDisplay()
    animateNextSegment()
}


/**
 Cancels the ongoing animation.

- Note: This method should only be called when the view controller is no longer in a state where it needs to animate.
 */
func cancelAnimation() {
    // Cancel ongoing animation
    animationCancellable?.cancel()
    isAnimating = false
}


/**
Pauses the animation.

- Warning: This method should only be called when the animation is currently animating.
*/
func pauseAnimation() {
    guard isAnimating else { return }
}


/**
Resumes the animation.

- Returns: Void
*/
func resumeAnimation() {
    guard !isAnimating, isPaused else { return }
}


/**
 Updates the progress by animating the next segment.

- See also: `animateNextSegment()`
*/
func updateProgress() {
    animateNextSegment()
}


/**
 Draws the shape.

 - parameter rect: The rectangle in which to draw the shape.
 */
func draw(_ rect: CGRect) {
    super.draw(rect)

    guard segmentCount > 0 else { return }
}


/**
 Activates the view.

 - Description:
     This method sets the isHidden property to false and starts animating the activity indicator.
 */
func activate() {
    isHidden = false
    activityIndicator.startAnimating()
}


/**
 Deactivates the view.

 - Important: This method should only be called when the view is visible.

 - Discussion: When a view is deactivated, it will no longer be accessible until it's activated again.
*/
func deactivate() {
    isHidden = true
}


/**
Sets up the layout for the view.

- Parameters:
    None

- Returns:
    None

- Note:
    This method sets up the layout by adding a subview and setting its constraints.
*/
func setUpLayout() {
    addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { make in
        make.center.equalToSuperview()
    }
}


/**
 Sets up the subviews.

 - See Also: `addSubview(_:)`
 */
func setUpSubviews() {
    let spacer1 = UIView()
    let spacer2 = UIView()
    [messageLabel, spacer1, imageView, spacer2, button].forEach {
        addSubview($0)
    }
}


/**
* Invoked when the button is tapped.
*
* - parameter indexPath: The index path of the cell where the button was tapped.
*/
public func didTapButton(at indexPath: IndexPath?) {
}


/**
 * Invoked when the region is tapped.
 *
 * @param sender The tap gesture recognizer that triggered this method.
 */
public func didTapRegion(sender: UITapGestureRecognizer) {
    if sender == regionTapGestureRecognizer {
        let location = sender.location(in: previousCard)
        if previousCard.bounds.contains(location) {
            previousCardTapped?(indexPath)
        }
}


/**
 Handles a long press gesture recognition.

 - parameter gesture: The UILongPressGestureRecognizer that triggered this function.
 */
func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
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


/**
 Configures the UI components with the provided `DiscoverCard` information.

- Parameters:
    - card: The `DiscoverCard` object containing the data to configure the UI with.
*/
func configure(card: DiscoverCard) {
    messageLabel.text = card.description
    imageView.urlString = card.imageURLString
    button.setTitle(card.buttonTitle, for: .normal)
}


/// Get cards
///
/// - Returns: `DiscoverCardsResponse`
func getCards() async throws -> DiscoverCardsResponse {
    try await client.requestCards().toResponse
}


/**
Request cards.

- Returns:
    - throws: An error indicating that the request failed.
    - returns: `DiscoverCardsResponseDTO` if successful.
*/
func requestCards() async throws -> DiscoverCardsResponseDTO {
    let endpointConfiguration = Endpoint.getStories
    guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }
}


/**
Returns a `DiscoverCardsClientProtocol` instance.

- returns: A `DiscoverCardsClientProtocol` instance, if the `serverURL` is valid.
*/
func makeClient() -> DiscoverCardsClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Validates an account ID.

 - parameter requestObject: The request object containing the account ID to be validated.
 - returns: A response object indicating the result of the validation.
 */
func validateAccountID(_ requestObject: AccountIDValidationRequestDTO) async throws -> AccountIDValidationResponseDTO {
    do {
        if requestObject.customerType == .NEO {
            return try await performRequest(
                endpoint: Endpoint.validateNeoAccountID(requestObject: requestObject)
            )
        }
    }
}


/**
 Fetches beneficiary details for the given request ID.

- parameter requestId: The unique identifier of the request.
- returns: An `AccountIDValidationResponseDTO` containing the beneficiary details, if the operation was successful. If an error occurred during the execution, it throws a corresponding error.

@throws Any error that occurs during the execution.
*/
func getBeneficiaryDetails(_ requestId: String) async throws -> AccountIDValidationResponseDTO {
    try await performRequest(
        endpoint: Endpoint.getBeneficiary(requestId: requestId)
    )
}


/**
Makes an instance of `AccountIDValidationClientProtocol`.

- returns: An instance of `AccountIDValidationClientProtocol`.
*/
func makeClient() -> AccountIDValidationClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Encodes the account information to the given encoder.

 - parameter encoder: The encoder to use for encoding.
 - throws: If an error occurs during encoding.
 */
func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    switch accountID {
    case .accountNumber(let value):
        try container.encode(value, forKey: .accountNumber)
    case .iban(let value):
        try container.encode(value, forKey: .iban)
    case .phoneNumber(let value):
        try container.encode(value, forKey: .phoneNumber)
    }
}


/**
 Fetches a receipt.

- parameter requestObject: The receipt request object.
- returns: The receipt response object.
- throws: An error if there is no data provider or if the fetch fails.
*/
func fetchReceipt(_ requestObject: ReceiptRequest) async throws -> ReceiptResponse {
    let endpointConfiguration = Endpoint.receipt(requestObject: requestObject, service: service)
    guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }
}


/**
 - Returns: `UserRestrictionErrorResponse?` if the function is successful, `nil` otherwise.
 */


/**
 Performs a request on the specified endpoint.

- parameter endpoint: The endpoint configuration for the request.
- throws: If there is an error performing the request.
- returns: `NoResponse` indicating that no response is expected from this method.
*/
func performRequest(endpoint: EndpointConfiguration) async throws -> NoResponse {
    try await performRequest(endpoint: endpoint) as NoResponse
}


/**
Returns whether the first error in the `errors` array matches the given error code.

- parameter errorCode: The error code to check for.
- returns: Whether the first error in the `errors` array has a key matching the given error code's raw value.
*/
func has(errorCode: ErrorKey) -> Bool {
    errors.first { $0.key == code.rawValue }
}


/**
Executes the given `request` and calls the `completionHandler` with the response data.

- parameter request: The URLRequest to be executed.
- parameter completionHandler: An optional closure that will be called when the request is completed. It takes three parameters: the URLResponse, the received Data, and an Error (if any).

```swift
func execute(_ request: URLRequest, completionHandler: ((URLResponse?, Data?, Error?) -> Void)? = nil) {
    let session = URLSession(configuration: Backbase.securitySessionConfiguration())
    var mutableRequest = request

    extraHeaders.forEach { key, value in
        mutableRequest.allHTTPHeaderFields?[key] = value
    }
}
```


/// Executes the client request.
///
/// - Returns: The response from the server, which can be an instance of any type `T` that conforms to the `ClientCommon.Response` protocol.
func execute() async throws -> ClientCommon.Response<T> {
    try await withCheckedThrowingContinuation { continuation in
        execute { result in
            continuation.resume(with: result)
        }
}


/**
 Returns a formatted string representation of the title with the given target.

 - parameter target: The target for which the title is being formatted.
 - returns: A string representing the title with the given target.
 */
func title(with target: String) -> String {
    String(format: title, target)
}


/**
Returns a string description of the object, formatted according to the given `target`.

- parameter target: The target for which to generate the description.
- returns: A string describing the object.
*/
func description(with target: String) -> String {
    String(format: description, target)
}


/// Dismisses the presented controller.
///
/// - Parameter: None
func dismiss() {
    controller?.dismiss(animated: true, completion: nil)
}


/// Presents a `UIImagePickerController` with the specified `SourceType`.
///
/// - Parameters:
///   - parent: The view controller that will present the image picker.
///   - sourceType: The type of media to allow the user to select (e.g. camera or photo library).
func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
    let controller = UIImagePickerController()
    controller.delegate = self
    controller.sourceType = sourceType
    self.controller = controller
    DispatchQueue.main.async {
        viewController.present(controller, animated: true, completion: nil)
    }
}


/**
Shows an alert.

- parameter targetName: The name of the target.
- parameter completion: A closure that is called when the action sheet is dismissed. The Boolean value indicates whether the user tapped the "OK" or "Cancel" button. Default is `nil`.

```swift
func showAlert(targetName: TargetName, completion: ((Bool) -> Void)?)
    {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
```

Note: I added the triple slash comments (`/**`) to indicate that this is documentation for a Swift function. The rest of the code remains the same as you provided.


/// Requests access to the camera.
///
/// - Returns: None
func cameraAccessRequest() {
    if delegate == nil { return }
}


/**
 Requests authorization for the app to access the user's photo gallery.

 - Note: This function is called when the user needs to grant access to their photo library.
 */
func photoGalleryAccessRequest() {
    PHPhotoLibrary.requestAuthorization {[weak self] result in
        guard let self else { return }
}


/**
 Cancels the image picker controller when the cancel button is clicked.

 - parameter picker: The `UIImagePickerController` instance.
 */
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    delegate?.cancelButtonDidClick(on: self)
}


/**
- Returns: Whether prepaid origination is disabled.
*/
func prepaidOriginationDisabled() -> Bool {
    if disabledCardfeatures == nil || disabledCardfeatures?.prepaidOriginationDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/**
Prepaid View Details Disabled

This function determines whether the prepaid view details are disabled.

- returns: A boolean indicating whether the prepaid view details are disabled.
*/
func prepaidViewDetailsDisabled() -> Bool {
    if disabledCardfeatures == nil || disabledCardfeatures?.prepaidViewDetailsDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/**
- Returns: `true` if prepaid Apple Wallet is disabled, otherwise `false`.
*/
func prepaidAppleWalletDisabled() -> Bool {
    if disabledCardfeatures == nil || disabledCardfeatures?.prepaidAppleWalletDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/**
 Fetches restrictions for new users.

- throws: Throws an error if there is a problem fetching the data.
- returns: N/A
*/
func fetchRestrictions() async throws {
    let usecase = NewUserRestrictionUseCase()
    let response = try await usecase.fetchFeaturePermissionsForNewUsers()
    transferFeatures = response.disabledPayments
    disabledCardfeatures = response.disabledCards
}


/**
 Refreshes restrictions.

- Important: This function runs asynchronously.
*/
func refreshRestrictions() {
    Task {
        try? await fetchRestrictions()
    }
}


/**
Returns whether local transfers are disabled.

- returns: `Bool` indicating whether local transfers are disabled.
*/
func isLocalTransferDisabled() -> Bool {
    if let transferFeatures, transferFeatures.isLocalTransferDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/**
Returns whether request money feature is disabled.

- returns: `Bool` indicating whether request money feature is disabled.
*/
func isRequestMoneyDisabled() -> Bool {
    if let transferFeatures, transferFeatures.isRequestMoneyDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/**
Returns whether quick pay is disabled.

- returns: `Bool` indicating whether quick pay is disabled.
*/
func isQuickPayDisabled() -> Bool {
    if let transferFeatures, transferFeatures.isQuickPayDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/**
Returns whether international transfers are disabled.

- Returns: Whether international transfers are disabled.
*/
func isInternationalTransferDisabled() -> Bool {
    if let transferFeatures, transferFeatures.isInternationalTransferDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/// Returns whether MCDC (Mastercard Contactless Dynamic Currency Conversion) is disabled.
///
/// - returns: `true` if MCDC is disabled, `false` otherwise.

func isMCDCDisabled() -> Bool {
    if let disabledCardfeatures, disabledCardfeatures.isMCDCDisabled == "true" {
        refreshRestrictions()
        return true
    }
}


/// Fetches feature permissions for new users.
///
/// - returns: `RestrictionFeatureResponse` if the operation was successful, or an error if not.

func fetchFeaturePermissionsForNewUsers() async throws -> RestrictionFeatureResponse {
    try await client.fetchFeaturePermissionsForNewUsers()
}


/**
 Fetches feature permissions for new users.

- Returns: A `RestrictionFeatureResponse` object containing the feature flags.
 */
func fetchFeaturePermissionsForNewUsers() async throws -> RestrictionFeatureResponse {
    return try await performRequest(endpoint: Endpoint.featureFlags)
}


/**
 Creates a new client instance.

 - returns: An instance of `NewUserRestrictionClientProtocol` that can be used to make API calls.
 */
func makeClient() -> NewUserRestrictionClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Makes the body of a view.

 - parameter configuration: Configuration for the view.
 - returns: A SwiftUI View that represents the body of the view.
 */
func makeBody(configuration: Self.Configuration) -> some View {
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


/**
 Returns a view with a patterned background.

 - returns: `some View`
 */
func withPatternBackground() -> some View {
    modifier(CardPatternBackgroundModifier())
}


/**
 Returns a view with a plain background.

 - returns: A `some View` representing the modified view.
 */
func withPlainBackground() -> some View {
    modifier(CardPlainBackgroundModifier())
}


/**
Returns a `some View` representing a container card view with the specified top offset.

- parameter topOffset: The distance from the top edge of the screen to start drawing the content. Defaults to the spacer small value defined in DesignSystem.

- returns: A `some View` that can be used as the parent of other views.
*/
func withContainerCardView(topOffset: CGFloat = DesignSystem.shared.spacer.sm) -> some View {


/**
 Returns a view with a container card view.

 The `withContainerCardView` function creates a view with a container card view that contains the provided top content. The top content is offset from the top of the screen by the specified `additionalTopOffset`. The view also ignores safe area edges for the bottom edge.

 - Parameters:
    - topView: A closure that returns the top content to be displayed.
    - additionalTopOffset: An optional parameter specifying the additional offset from the top of the screen. Default is 0.

 - Returns: A `some View` that represents the container card view with the provided top content.

 @inlinable
 @available(iOS 14, macOS 11, tvOS 15, watchOS 8)
 */
func withContainerCardView<ContentView: View>(topView: () -> ContentView, additionalTopOffset: CGFloat = 0) -> some View {
    let containerCardView = ContainerBackgroundView()
        .safeAreaInset(edge: .top, content: topView)
        .padding(.top, additionalTopOffset)
        .ignoresSafeArea(edges: .bottom)
    return modifier(CardPatternBackgroundModifier(backgroundOverlay: containerCardView))
}


/// Returns a `some View` that wraps the given `content` with a background image modifier.
///
/// - Parameter content: The view to wrap with the background image modifier.
/// - Returns: A `some View` that applies the background image modifier to the given `content`.
func body(content: Content) -> some View {
    content
        .modifier(
            BackgroundImageViewModifier(
                image: commonConfiguration.images.patternBackground.image,
                backgroundOverlay: backgroundOverlay
            )
        )
}


/**
 Modifies the given `content` with a background image.

- parameter content: The content to be modified.
- returns: A `some View` that wraps the given `content` with a background image.
*/
func body(content: Content) -> some View {
    content
        .modifier(BackgroundImageViewModifier(image: commonConfiguration.images.gradientBackground.image))
}


/**
 Returns a view with the given content wrapped in a background that can be customized.

 - parameter content: The content to be displayed.
 - returns: A `some View` representing the wrapped content.
 */
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


/// A view that applies a scrollable card background to its content.
///
/// This function takes a builder closure as an argument, which is used to create the content of the card. The resulting content is then wrapped in a `ScrollableCardBackgroundModifier` to apply the scrollable card background.

public func withScrollableCardBackground<TopView: View>(@ViewBuilder topView: @escaping () -> TopView) -> some View {
    modifier(ScrollableCardBackgroundModifier(topView: topView))
}


/// Creates a scrollable card background.
///
/// - Parameters:
///   - topOffset: The offset from the top of the screen. Defaults to `DesignSystem.shared.spacer.sm`.
/// - Returns: A view with the scrollable card background modifier.
@available(iOS 13, macOS 10.15, watchOS 7, tvOS 14, *)
func withScrollableCardBackground(topOffset: CGFloat = DesignSystem.shared.spacer.sm) -> some View {
    modifier(ScrollableCardBackgroundModifier(topOffset: topOffset))
}


/**
 Returns a `some View` that displays the given `content` within an offset-observable scroll view.

 - parameter content: The view to be displayed.
 - returns: A `some View` that wraps the given `content` and applies offset-observable scroll view behavior.
 */
func body(content: Content) -> some View {
    GeometryReader { proxy in
        OffsetObservingScrollView(offset: $scrollViewOffset) {
            content
                .frame(minHeight: scrollViewContentMinHeight(container: proxy))
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: proxy.safeAreaInsets.bottom)
                }
    }


/**
@brief Calculates the minimum height of a scroll view content.

@param container The geometry proxy of the scroll view.
@return The calculated minimum height.
*/
func scrollViewContentMinHeight(container: GeometryProxy) -> CGFloat {
    container.size.height - topViewOffset - pinnedContentHeight - DesignSystem.shared.spacer.md
}


/// Returns a `NumberFormatter` with the specified configuration.
///
/// - parameter usesGroupingSeparator: Whether to use grouping separators. Default is true.
///
/// - returns: A configured `NumberFormatter`.
func formatter(usesGroupingSeparator: Bool = true) -> NumberFormatter {
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


/**
 Resets formatting to input state by sanitizing the current text.

- parameter None
- returns None
*/
func resetFormattingToInput() {
    let amount = formatter.number(from: editedText)?.stringValue
    editedText = String.sanitizeAmountForInput(amount: amount) ?? editedText
}


/**
 Applies formatting to the input.

 - Note: This function should be used when formatting is required for a specific input.
 */
func applyFormattingToInput() {
    guard let value else { return }
}


/**
* A method called when the input text changes.
*
* - parameter text: The current input text.
* - parameter previousValue: The previous value of the input text.
*/
public func textDidChange(text: String, previousValue: String) {
    let numericRepresentation = formatter.number(from: text)?.doubleValue
    guard numericRepresentation != value else { return }
}


/**
Updates the value of the property with the provided `amount`.

- parameter amount: The new value to set.
*/
func update(amount: Double) {
    value = amount
    applyFormattingToInput()
}


/**
 Updates the additional validations with a new array of `AmountValidation` instances.

 - parameter additionalValidations: The new set of validation rules to apply.
 */
func update(additionalValidations: [AmountValidation]) {
    self.additionalValidations = additionalValidations
    validate(amount: value, text: editedText)
}


/// Validates an amount and a text.
///
/// - parameter amount: The amount to be validated. Can be `nil`.
/// - parameter text: The text to be validated.
func validate(amount: Double?, text: String) {
    defer { updateState() }
}


/**
Updates the state of the application.

- Important: This function should only be called when the `state` property is not nil.
- Note: If an error occurs during the update process, it will be handled internally by this method.


/// Formats an `Double` value as a human-readable currency string.
///
/// - parameter value: The value to be formatted.
/// - returns: A localized, decimal-formatted string representation of the value, or `nil` if there's an error.

func formatAmount(value: Double) -> String? {


/// Builds a `ReferralViewController` with the given `referral`, `shareLink`, and `navigationController`.

/// - Parameters:
///   - referral: The referral model to use.
///   - shareLink: The URL to share.
///   - navigationController: The navigation controller to present the view controller with.

/// - Returns: A new instance of `ReferralViewController` configured with the given parameters.


/// Returns the placeholder item for the given `activityViewController`.

/**
 - parameter activityViewController: The UIActivityViewController for which to return a placeholder item.
 - returns: An optional Any object representing the placeholder item.


/**
 Returns the link metadata for the given activity view controller.

 - parameter activityViewController: The UIActivityViewController to generate metadata for.
 - returns: An LPLinkMetadata object representing the link metadata, or nil if no metadata could be generated.


/**
Present a referral share sheet from the given view controller.

- Parameters:
    - viewController: The view controller to present the share sheet from.
*/
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
                // todo: implement completion handler behavior
            }
        }
    }
}


/**
 Makes referral instructions with specified font.

 - parameter font: The font to use for the instruction steps.
 - returns: A NSAttributedString containing the referral instructions.
 */
func makeReferralInstructions(font: UIFont) -> NSAttributedString {


/**
Generates a QR code from the share link.

- returns: A `UIImage` representing the generated QR code, or `nil` if the creation fails.
*/
func generateQRCode() -> UIImage? {
    guard let scaledQRCode = createScaledQRCode(from: shareLink.absoluteString) else { return nil }
}


/**
 Creates a scaled QR code from the given string.

 - parameter from: The input string to generate the QR code from.
 - returns: A `CIImage` representation of the QR code, or `nil` if an error occurs.


/**
 Applies colors to the QR code image.

 - parameter qrCode: The CIImage representing the QR code.
 - returns: A UIImage with the applied colors, or nil if the output image is invalid.
 */
func applyColors(to qrCode: CIImage) -> UIImage? {
    let filter = CIFilter.falseColor()
    filter.inputImage = qrCode
    filter.color0 = CIColor(color: UIColor(hex: "#12393B"))
    filter.color1 = CIColor(color: .white)
    guard let img = filter.outputImage else { return nil }
}


/**
 Adds a border and rounded corners to the specified `image`.

 - parameter image: The input image.
 - parameter borderWidth: The width of the border to be added.
 - parameter cornerRadius: The radius of the rounded corners.

 - returns: A new `UIImage` with the border and rounded corners, or `nil` if an error occurs.
 */
func addBorderAndRoundedCorners(to image: UIImage, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIImage? {
    let newSize = CGSize(width: image.size.width + 2 * borderWidth, height: image.size.height + 2 * borderWidth)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
    defer { UIGraphicsEndImageContext() }
}


/// Overlay the Neo icon on top of a QR code image.
///
/// :param: qrCode The QR code image to overlay with the Neo icon.
/// :return: The resulting image with the Neo icon overlaid on top of the QR code, or `nil` if an error occurs.

```swift
func overlayLogo(on qrCode: UIImage) -> UIImage? {
    let logo = configuration.images.neoIcon
    let logoSize = CGSize(width: qrCode.size.width * 0.3, height: qrCode.size.height * 0.3)
    let logoOrigin = CGPoint(
        x: (qrCode.size.width - logoSize.width) / 2,
        y: (qrCode.size.height - logoSize.height) / 2
    )

    UIGraphicsBeginImageContextWithOptions(qrCode.size, false, 0)
    defer { UIGraphicsEndImageContext() }
```


/**
 Fetches referral details.

- Returns:
    - `ReferralModel`: The fetched referral model.
- Throws:
    - `CallError.missingDataProvider`: If the data provider is missing.
*/


/**
 Creates a client instance.

 - returns: A `ReferralClientProtocol` instance.
 */
func makeClient() -> ReferralClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Fetches referral details asynchronously.

- returns: `ReferralModel` object containing the fetched data.
- throws: Any errors that occur during the fetching process.

@throws
*/
func fetchReferralDetails() async throws -> ReferralModel {
    return try await client.fetchReferralDetails()
}


/**
 Generates a referral link with the given `referral` model.

 - parameter referral: The referral model to use for generating the link.
 - returns: A URL representing the generated referral link.
 - throws: An error if there is an issue generating the link.
 */
func generateReferralLink(with referral: ReferralModel) async throws -> URL {
    return try await linkBuilder.generateReferralLink(with: referral)
}


/**
 Adds subviews to the current view.

 - See Also: `viewTitle`, `container`, `codeLabel`, `copyImage`
 */
func addSubviews() {
    addSubview(viewTitle)
    addSubview(container)
    container.addSubview(codeLabel)
    container.addSubview(copyImage)

    viewTitle.snp.makeConstraints { 
        $0.top.equalToSuperview()
        $0.height.equalTo(30)
        $0.leading.equalToSuperview().inset(DesignSystem.shared.spacer.md)
    }
}


/**
Copies the given `code` string to the clipboard.

- Important: This function requires the `UIPasteboard` and `self` (the current view controller) as dependencies.
- Parameters:
    - code: The string that should be copied to the clipboard.
*/
func onCopyTap() {
    UIPasteboard.general.string = code
    self.displayToast(configuration.strings.copytoCliped, with: 1)
}


/**
 Shares the content with the given `code`.

 - parameter code: The shareable code.
 */
func onShareTap(code: String) {


/**
 Loads the view.

 - See Also: `super.loadView()`
 */
func loadView() {
    super.loadView()
    title = nil
    setupView()
    setupNavBar()
}


/// Initializes the view controller.
///
/// - See also: `super.viewDidLoad()`
func viewDidLoad() {
    super.viewDidLoad()
    bindSubscriptions()
}


/**
* Binds the `isLoading` property of the view model to the UI.
*
* - parameter: None
*
* - returns: None
*/
func bindSubscriptions() {
    viewModel.$isLoading.receive(on: DispatchQueue.main)
        .sink { [weak self] isLoading in
            if isLoading {
                self?.inviteButton.startLoading()
            }
}


/**
Invites the user when the button is pressed.

- Parameters:
    - sender: The UIButton that was pressed.

- See Also:
    - `viewModel`
 */
func inviteButtonPressed(_ sender: UIButton) {
    viewModel.presentReferralShare(from: self)
}


/**
Sets up the navigation bar with a left button.

- Returns: None
*/
func setupNavBar() {
    navigationItem.leftBarButtonItem = closeBarButtonItem(image: configuration.images.closeIcon)
    navigationItem.leftBarButtonItem?.tintColor = DesignSystem.shared.colors.neutrals.neutral00
}


/**
 Sets up the view.

- Note: This method adds the background image view to the main view and constrains it to all edges.
*/
func setupView() {
    view.addSubview(backgroungImageView)
    backgroungImageView.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }
}


/**
 Returns whether two `Alert.Action` instances are equal.

 - parameter lhs: The left-hand side `Alert.Action`.
 - parameter rhs: The right-hand side `Alert.Action`.
 - returns: A boolean indicating whether the two actions are equal.
 */
func == (lhs: Alert.Action, rhs: Alert.Action) -> Bool {
    lhs.title == rhs.title && lhs.style == rhs.style
}


/**
Shows an alert with the given `Alert` object.

- Parameters:
    - alert: The `Alert` object to show.
    - animated: A boolean indicating whether the alert should be presented animatedly. Default is true.

- Note: This method uses a `UIAlertController` behind the scenes, and its behavior may change based on the platform it's running on.

*/
func showAlert(_ alert: Alert, animated: Bool = true) {
    let style: UIAlertController.Style
    switch alert.style {
        case .alert:
            style = .alert
        case .actionSheet:
            style = .actionSheet
    }
}


/**
 Prepares a subtitle for the application.

- returns: A string representing the prepared subtitle.
*/
func prepareSubtitle() -> String {
    let maskedPhoneNumber = mask(
        phone: String(pendingApplicationModel.phoneNumber.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).replacingOccurrences(of: " ", with: "").dropFirst()
    )
)

    return String(format: configuration.strings.subtitle, maskedPhoneNumber)
}


/**
 Masks a given phone number by replacing all characters except the first `startLimit` and last `endLimit` characters with `maskCharacter`.

 - parameter phone: The original phone number.
 - parameter startLimit: The number of characters to keep at the beginning of the phone number (default is 3).
 - parameter endLimit: The number of characters to keep at the end of the phone number (default is 3).
 - parameter maskCharacter: The character to use for masking (default is "*").

 - returns: A string representing the masked phone number.
 */
func mask(phone: String, startLimit: Int = 3, endLimit: Int = 3, maskCharacter: Character = "*") -> String {
    let maskedString = String(
        repeating: maskCharacter,
        count: max(0, phone.count - (startLimit + endLimit))
    )

    if LocaleSelector.shared.isArabic {
        return String(phone.suffix(endLimit)) + maskedString + String(phone.prefix(startLimit))
    }
}


/**
 Builds a `UIViewController` for the given pending application.

- parameter pendingApplication: The pending application model.
- returns: A `UIViewController` instance.
*/
func build(pendingApplication: PendingApplicationModel) -> UIViewController {
    let configuration = PendingApplicationScreen.Configuration()
    let viewModel = PendingApplicationScreenViewModel(with: pendingApplication, configuration: configuration)
    let viewController = PendingApplicationViewController(viewModel: viewModel, configuration: configuration)

    viewController.title = pendingApplication.title
    let sheetPresentationController = viewController.sheetPresentationController
    if #available(iOS 16.0, *) {
        sheetPresentationController?.detents = [.custom(resolver: { $0.maximumDetentValue * 0.8 })]


/**
 Loads the view.

 - Overview:
 This function loads the view and sets up its UI.
 
 - Discussion:
 The function first calls the superclass's implementation of loadView(). Then, it adds subviews using the `addSubviews()` function. Finally, it sets up the UI using the `setupUI()` function.
 */
func loadView() {
    super.loadView()
    addSubviews()
    setupUI()
}


/**
 Adds subviews to the main view.

 - Important: This method must be called after the view hierarchy is set up.
 */
func addSubviews() {
    view.addSubview(iconImageView)
    view.addSubview(titleLabel)
    view.addSubview(subtitleLabel)
    view.addSubview(applicationDetailsLabel)

    view.addSubview(referenceNumberContainerView)
    referenceNumberContainerView.addSubview(referenceNumberTitleLabel)
    referenceNumberContainerView.addSubview(referenceNumberLabel)
    referenceNumberContainerView.addSubview(copyImageView)
}


/**
 Sets up the UI of the view.

- See Also: `DesignSystem.shared.spacer`
- See Also: `DesignSystem.shared.colors.foundation.default`

func setupUI() {
    let spacers = DesignSystem.shared.spacer
    view.backgroundColor = DesignSystem.shared.colors.foundation.default

    iconImageView.snp.makeConstraints { 
        $0.top.equalTo(configuration.constants.pendingIconTopPadding)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(configuration.constants.pendingIconWidth)
        $0.height.equalTo(configuration.constants.pendingIconHeight)
    }
}


/**
 Copies the reference code to the clipboard.

 - parameter sender: The button that was tapped.
 */
func copyButtonTapped(_ sender: UIButton) {
    UIPasteboard.general.string = viewModel.pendingApplicationModel.referenceCode
    view.displayToast(configuration.strings.copytoCliped, with: 1)
}


/**
Sets up views for the component.

- See Also: `removeFromSuperview()`, `heightConstraint`
*/
func setUpViews() {
    label.removeFromSuperview()
    
    // Check if Height & Width constraints needs to be added or disabled
    if heightConstraint == nil {
        heightConstraint = heightAnchor.constraint(equalToConstant: badgeSize)
    }
}


/**
Sets up large badge views.
*/
func setUpLargeBadgeViews() {
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
}


/**
Sets up small badge views by setting the width and height constraints.

- parameter None
- returns None
*/
func setUpSmallBadgeViews() {
    [widthConstraint, heightConstraint].forEach {
        $0?.constant = badgeSize
        $0?.isActive = true
    }
}


/**
Pin the view to the top right of its super view.

- warning: This method assumes a constraint named "leadingConstraint" exists.
- important: The view must have a valid `superview` property set.

- parameter: None
*/
func pinToSuperviewTopRight() {
    guard let superview = superview, leadingConstraint == nil else { return }
}


/// Refreshes the views based on the current state of the counter.
///
/// - Important: This function updates the text of the label, the constant of the leading constraint, and the visibility of the view itself.
///
func refreshViews() {
    let isHidden = count <= 0
    label.text = hasMaxBeenReached ? "\(max) +" : "\(count)"
    leadingConstraint?.constant = leadingConstraintConstant
    self.isHidden = isHidden
}


/**
 Returns a string representation of the value.

 If the value is less than 100, it returns a string in the format `"value"`. Otherwise, it returns the string `"99+"`.

 - returns: A string representing the final value.
 */
func finalValue() -> String {
    return value < 100 ? "\(value)" : "99+"
}


/**
 Reduces a `CGPoint` value using a closure.

 - parameter value: The initial value to be reduced.
 - parameter nextValue: A closure that takes no arguments and returns the next value to be reduced.
 */
func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }


/**
 Fixes flickering issues by using GeometryReader and safe area insets.

 - Returns: A `some View` that prevents flickering.
 */
func fixFlickering() -> some View {
    GeometryReader { geometryWithSafeArea in
        GeometryReader { _ in
            ScrollView<AnyView>(axes: /* axes */, showsIndicators: /* showsIndicators */) {
                AnyView(
                    content
                        .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                        .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                        .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                        .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                )
            }
        }
    }
}


/**
 Returns a SwiftUI View representing the rating star at the given index.

 - parameter index: The index of the rating star to display.
 - returns: A `some View` representing the rating star at the given index. If the index is greater than the current rating, an unselected star is returned; otherwise, a selected star is returned.
 */
func image(for index: Int) -> some View {
    let name = index > currentRating ? "rating-star-unselected" : "rating-star-selected"
    return Image(name, bundle: .snbCommon)
}


/**
 Returns a view that runs the given `content` with an optional `action` to be executed on load.

 - parameter content: The content to display.
 - returns: A view representing the given content, which will execute the provided action when loaded.
 */
func body(content: Content) -> some View {
    content.onAppear {
        if didLoad == false {
            didLoad = true
            action?()
        }
}


/**
Loads the view.

- parameter perform: An optional closure to be executed after the view has loaded.
- returns: The view with the load completion handler applied.
*/
func onLoad(perform action: (() -> Void)? = nil) -> some View {


/**
Increases the current value by a specified amount, up to the upper bound of the range.

- parameter by: The amount to increase the value by. Default is 1.
*/
func increase(by amount: Int = 1) {
    number = min(number + amount, range.upperBound)
}


/**
Decreases the value of `number` by a specified amount.

- parameter by: The amount to subtract from `number`. Defaults to 1.
*/
func decrease(by amount: Int = 1) {
    number = max(number - amount, range.lowerBound)
}


/**
 Handles user input from the `ResultPaymentViewModelInput` model.

 - parameter input: The input model containing the user's actions.
 */
func handleInput(_ input: ResultPaymentViewModelInput) {
    input.didTapLink
        .sink(receiveValue: didTapLink)
        .store(in: &subscriptions)
    input.didTapDone
        .sink(receiveValue: didTapDone)
        .store(in: &subscriptions)
}


/// - Returns the success or failure action for the tapped link.
func didTapLink() {
    /// Success Screen -> Receipt Action
    /// or
    /// Failure Screen -> Done Action
    resultAction?
    
    viewStateSubject.send(.loading)
    
    linkAction? { [weak self] in
        self?.viewStateSubject.send(.loaded(linkButtonImage: self?.linkButtonImage))
    }
}


/**
 - Description: Success Screen -> Done Action
   or
   Failure Screen -> TryAgain Action
 - Parameter: none
 - Returns: none
 */
func didTapDone() {
    /// Success Screen -> Done Action
    /// or
    /// Failure Screen -> TryAgain Action
    doneAction?()
}


/// - Returns the output for the given input.
///
/// - parameter input: The input to process.
///
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


/**
 Loads the view.

 - SeeAlso: `super.loadView()`, `configureLayout()`, `configureDesign()`, `addSupportButton()`
 */
func loadView() {
    super.loadView()
    configureLayout()
    configureDesign()
    addSupportButton()
}


/**
Called when the view is about to appear.
The view controller's view is presented to the user.

- parameter animated: If true, the transition will be animated. Otherwise, it will not be.
*/
func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    removeLargeTitlesForNavBar()
}


/**
Configures the layout of the view.
*/
func configureLayout() {
    /**
    Configures the background view of the view.
    */
    view.configureBackgroundView(type: .plain)

    /**
    Adds each subview to the view.
    */
    [imageView, titleLabel, subtitleLabel, submitButton].forEach {
        /**
        Adds a subview to the view.
        @param $0 The subview to add.
        */
        view.addSubview($0)
    }
}


/**
 Adds a support button.

- Note: This function will only execute if the `isSuccess` property of the view model is false.
 */
func addSupportButton() {
    guard let isSuccess = viewModel?.isSuccess, !isSuccess else { return }
}


/**
Taps the link button.

- Warning: This method sends a signal through the `didTapLinkButtonSubject` observable sequence.
*/
func linkTapped() {
    didTapLinkButtonSubject.send()
}


/**
 Submits the form when the submit button is tapped.

 - Important: Must be called on the main thread.
 */
func submitTapped() {
    didTapSubmitButtonSubject.send()
}


/**
Configures the design of the UI components.

- Parameter titleLabel: The title label to be configured.
- Parameter subtitleLabel: The subtitle label to be configured.
- Parameter nameLabel: The name label to be configured.

*/
func configureDesign() {
    configuration.design.titleLabel(titleLabel)
    configuration.design.subtitleLabel(subtitleLabel)
    configuration.design.nameLabelStyle(nameLabel)
}


/**
 Configures the view model.

- parameter viewModel: The result payment view model.
*/
func configure(viewModel: ResultPaymentViewModel) {
    handleOutput(
        viewModel.bind(
            input: ResultPaymentViewModelInput(
                didTapLink: didTapLinkButtonSubject.eraseToAnyPublisher(),
                didTapDone: didTapSubmitButtonSubject.eraseToAnyPublisher()
            )
        )
    )
}


/**
 Handles the specified `output` from the `ResultPaymentViewModel`.

- parameter output: The output to be handled.

*/
func handleOutput(_ output: ResultPaymentViewModelOutput) {
    output.image
        .sink { [weak self] in
            self?.imageView.image = $0
        }
}


/// Formats the given subtitle text with a centered alignment and a customized line height.
///
/// - parameter subtitleText: The text to be formatted.
/// - returns: An attributed string representation of the formatted subtitle text.

func formatSubtitleText(_ subtitleText: String) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.19
    paragraphStyle.alignment = .center

    return NSAttributedString(
        string: subtitleText,
        attributes: [.paragraphStyle: paragraphStyle]
    )
}


/**
Binds a `ResultPaymentViewModel` instance to the view.

- parameter viewModel: The `ResultPaymentViewModel` instance to be bound.
*/
func bind(viewModel: ResultPaymentViewModel) {
    self.viewModel = viewModel
    configure(viewModel: viewModel)
}


/// Sets the UI state based on the provided `state` value.
///
/// - parameter state: The new state to set, which can be either `.loading`, `.loaded(linkButtonImage:)`, or other future states.

func set(state: ResultPaymentViewState) {
    switch state {
    case .loading:
        setLoadingState()
    case .loaded(let linkButtonImage):
        setLoadedState(with: linkButtonImage)
    }
}


/// Sets the loading state of the link button.

/**
- func setLoadingState()
*/
func setLoadingState() {
    linkButton.startLoading()
    linkButton.setImage(nil, for: .normal)
}


/**
Sets the loaded state of a UI button.

- parameter linkButtonImage: The image to be displayed on the button.
- seeAlso: stopLoading()
*/
func setLoadedState(with linkButtonImage: UIImage?) {
    linkButton.stopLoading()
    linkButton.setImage(linkButtonImage, for: .normal)
}


/**
 Loads the view.

 - Inherited from `UIViewController`
 */
func loadView() {
    super.loadView()
    setupNavBar()
    configureLayout()
    configureDesign()
}


/**
Sets up the navigation bar.

- Returns: None
*/
func setupNavBar() {
    navigationController?.isNavigationBarHidden = true
}


/**
 Configures the layout for the view.

- SeeAlso: `imageView`, `titleLabel`, `subtitleLabel`
 */
func configureLayout() {
    [imageView, titleLabel, subtitleLabel].forEach { $0.addSubview($0) }

    imageView.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.top.equalToSuperview().offset(configuration.design.imageOffset)
    }
}


/**
 Configures the design of the view.

 - Attention: This method should only be called after the view has been fully set up.
 */
func configureDesign() {
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


/**
 * Binds the current state of the view.
 *
 * @return A publisher that erases the current view state.
 */
func bind() {
    viewState.eraseToAnyPublisher()
}


/**
 * Handles the specified error.
 *
 * - Parameter error: The error to handle.
 */
func handle(error: AccountIDValidationResponse.Error) {
    switch error {
    case .ambiguousAccountsFound, .invalidPhone, .invalid, .notNEO, .ownAccount:
        break
    case .registered:
        viewState.send(.error(error: .alreadyRegisteredAlert(nil)))
    case .unknown:
        viewState.send(.error(error: .edgeCase))
    }
}


/// Validates the given nickname for a specific account ID.
///
/// - parameter nickName: The nickname to be validated.
public func validateNickname(nickName: String) {
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
    }
}


/**
Shows an error screen.

- SeeAlso: `router.showError(_:)`
*/
func showErrorScreen() {
    self.router.showError(.somethingWentWrong)
}


/**
 Dismisses the view controller.

 - Note: This method is called after the view controller has been dismissed.
 */
func didDismissViewController() {
    completion(nil)
}


/**
 Returns whether the given text length is allowed.

 - parameter text: The text to check.
 - returns: True if the text length is within the allowed limit, false otherwise.
 */
func isLengthAllowed(_ text: String) -> Bool {
    return text.count <= constants.maxLength
}


/// Returns whether the entered string is a valid nickname.
///
/// - parameter enteredString: The string to check for validity.
/// - parameter completeString: The complete string that contains special characters, used for comparison purposes.
/// - returns: `true` if the entered string does not contain any special characters, `false` otherwise.

func isNicknameValid(enteredString: String, completeString: String) -> Bool {
    return !containsSpecialCharacter(enteredString)
}


/**
Returns a boolean indicating whether the given string contains any special characters.

- parameter string: The input string to check.
- returns: `true` if the string contains any special characters, `false` otherwise.
*/
func containsSpecialCharacter(_ string: String) -> Bool {
    let regex = ".*[^A-Za-z0-9,. \\p{Arabic}]"
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: [ "SELF": string ])
}


/**
 Loads the view.

 - SeeAlso: `super.loadView()`
 */
func loadView() {
    super.loadView()
    title = nil
    self.view.backgroundColor = .white
    prepareView()
}


/**
* Called when the view is about to appear.
*
* This method is called after the controller's view has been loaded into memory and the view hierarchy has been set up.
*
* :nodoc:
*/
func viewDidLoad() {
    super.viewDidLoad()
    bind()
    presentationController?.delegate = self
    nickNameTextInput.textField.delegate = self
    updateIsTextEntered(text: "")
}


/**
 Prepares the view by adding subviews and configuring their styles.

 - See Also: `addConstraints()`
 */
func prepareView() {
    self.view.addSubview(titleLabel)
    self.view.addSubview(nickNameTextInput)
    self.view.addSubview(saveButton)
    configuration.design.textInput(nickNameTextInput)
    configuration.design.titleLabelStyle(titleLabel)
    addContraints()
}


/**
 Adds constraints to the `titleLabel`.
 */
func addConstraints() {
    titleLabel.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().inset(constants.padding)
        make.top.equalToSuperview().inset(constants.titleLableTopOffset)
        make.height.equalTo(constants.titleLabelHeight)
    }
}


/// Binds the UI components to the view model.

/**
- Returns: None
*/

func bind() {
    viewModel.bind()
    saveButton.publisher(for: .touchUpInside)
        .sink { [weak self] _ in
            guard let self else { return }
}


/**
 Updates the `isTextEntered` property based on the provided text.

 - parameter text: The input text to check.
 */
func updateIsTextEntered(text: String) {
    let trimmedText = text.trimmingCharacters(in: .whitespaces)
    isTextEntered = !trimmedText.isEmpty
}


/**
 Validates the nickname.

- Note: This method is intended to be used as a part of the nickname validation process.
- Complexity: O(1)
- Time complexity: O(1)

- parameter self: The object that this function is a part of.
- returns: None
*/
func validateNickname() {
    let nickName = self.nickNameTextInput.textField.text ?? ""
    let trimmedNickNameText = nickName.trimmingCharacters(in: .whitespaces)
    self.viewModel.validateNickname(nickName: trimmedNickNameText)
}


/**
 Handles the error that occurred during nickname transfer capture.

 - parameter error: The TransferCaptureError that occurred.
 */
func handle(error: SaveNickname.TransferCaptureError) {
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


/**
 Called when a text field is about to change its contents.

 - parameter textField: The text field that is being edited.
 - parameter range: The range of characters that should be replaced with the given `string`.
 - parameter string: The new string that will replace the old characters in the specified `range`.

 :return: Whether the replacement should happen. If you return `false`, the change won't be made.

 - See also: https://developer.apple.com/documentation/uikit/uitextfielddelegate/1618041-textfield
 */
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    nickNameTextInput.setError(errorMessage: "")
    let currentString = textField.text ?? ""
    guard let stringRange = Range(range, in: currentString) else { return false }
}


/**
 Returns whether the text field should resign its first responder status.

 - parameter textField: The text field that called this function.
 - returns: Whether the text field should resign its first responder status.


/**
Called when the presented view controller is dismissed.

- parameter presentationController: The presentation controller that was used to present the view controller.
*/
func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {


/**
 Validates an account ID using the provided client.

 - parameter request: The request containing the account ID to be validated.
 - returns: A response indicating the result of the validation.
 */
public func validateAccountID(request: AccountIDValidationRequest) async throws -> AccountIDValidationResponse {
    try await accountValidateClient.validateAccountID(request.toDTO).toResponse
}


/**
Called when the button is tapped.

- Important: This method is called after the button has been tapped.
- Purpose: To handle the button tap event.
*/
func buttonTapped() {
    didTap()
}


/**
 Dismisses the current view controller.

 - See also: `configuration.router.didDismiss()`
 */
func controllerDismissed() {
    configuration.router.didDismiss()
}


/**
Submits the primary action.

- See Also: `configuration.router.didSelectPrimaryActionButton()`
*/
func primaryActionSubmit() {
    configuration.router.didSelectPrimaryActionButton()
}


/**
 Submits the secondary action button.

 - See also: `configuration.router.didSelectSecondaryActionButton`
 */
func secondaryActionSubmit() {
    configuration.router.didSelectSecondaryActionButton()
}


/**
 Builds a `UIViewController` with the provided `configuration`.

- parameter configuration: The configuration to use for building the view controller.
- returns: A `UIViewController` instance.
*/
func build(with configuration: GenericFullScreenError.Configuration) -> UIViewController {
    let viewModel = GenericFullScreenErrorViewModel(configuration: configuration)
    return UIHostingController(rootView: GenericFullScreenErrorView(viewModel: viewModel))
}


/// - Returns: A `Configuration` object with the specified parameters.

```swift
func make(for type: ErrorType) -> Configuration {
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
```


/**
 Builds a `UIViewController` with the provided configuration.

 - parameter configuration: The configuration for the view controller.
 - returns: A `UIViewController` instance configured according to the given configuration.
 */
func build(configuration: Configuration) -> UIViewController {
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


/**
dismisses the controller when the user taps the done button

- parameter None
- returns None
*/
func controllerDismissed() {
    guard let viewController else { return }
}


/**
Submits the primary action when the specified `button` is clicked.

- Parameters:
    - button: The button whose action is being submitted.
*/
func primaryActionSubmit(_ button: Button) {
    isButtonClicked = true
    guard let viewController else { return }
}


/**
Secondary action submit handler.

- Parameter button: The button that triggered the submission.
*/
func secondaryActionSubmit(_ button: Button) {
    guard let viewController else { return }
}


/**
 Presents a given `Context` as a `View`.

- Parameter context: The context to be presented.
- Returns: A `some View` that presents the given context.
*/
func presentableContext<Context: PresentableContext>(_ context: Context) -> some View {
    onAppear { context.isContextAvailable = true }
}


/**
 Makes a configuration for the given `Option`.

 - parameter option: The option to make the configuration for.
 - returns: A configured `Configuration` instance.
 */
func make(for option: Option) -> Configuration {
    var configuration = Resolver.resolve(Configuration.self)
    configuration.strings.title = option.title.value
    configuration.strings.body = option.body.value
    configuration.designs.icon = option.icon
    configuration.actionButtonDisplayMode = option.actionButtonDisplayMode
    configuration.strings.primaryActionButtonTitle = option.actionButtonTitle.value
    configuration.strings.secondaryActionButtonTitle = option.secondaryActionButtonTitle.value
    return configuration
}


/**
 Loads the view.

- See Also: `setupUI`
 */
func loadView() {
    super.loadView()
    setupUI()
}


/// Called when the view has disappeared from its superview.

/**
- parameter animated: If `true`, the view was displayed or removed using an animation.
*/
func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if !viewModel.isButtonClicked {
        viewModel.controllerDismissed()
    }
}


/**
 Sets up the UI components.
 */
func setupUI() {
    /**
     Sets the background color of the view to the foundation default color from the design system.
     */
    view.backgroundColor = DesignSystem.shared.colors.foundation.default
    
    /**
     Creates an icon view and adds it as a subview to the main view.
     */
    let iconView = UIView()
    
    /**
     Adds the icon image view to the icon view.
     */
    iconView.addSubview(iconImageView)
    
    /**
     Configures the constraints for the icon image view within the icon view.
     */
    iconImageView.snp.makeConstraints {
        $0.top.bottom.equalToSuperview()
        $0.centerX.equalToSuperview()
    }
}


/**
Primary action submit handler.

- parameter sender: The button that triggered the submission.
*/
func primaryActionSubmit(_ sender: Button) {
    viewModel.primaryActionSubmit(sender)
}


/**
 Submits the secondary action for the given button.

 - Parameters:
   - sender: The button that was clicked to trigger this action.
*/
func secondaryActionSubmit(_ sender: UIButton) {


/**
Returns the configuration option for a given error.

- parameter error: The error to determine the configuration option for.
- returns: The configuration option for the error.


/// Creates a `DatePickerTextField` with the given context.
///
/// - Parameter context: The context for creating the view.
/// - Returns: A `DatePickerTextField` instance.
func makeUIView(context: Context) -> DatePickerTextField {
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
}


/**
 Updates the `DatePickerTextField` with the specified `date`.

 - parameter uiView: The `DatePickerTextField` to update.
 - parameter context: The current context.
 */
func updateUIView(_ uiView: DatePickerTextField, context: Context) {
    if let date = date {
        uiView.text = dateFormatter.string(from: date)
    }
}


/// Initializes the date picker delegate function.
///
/// - Parameter sender: The sender of the event.
func datePickerDidSelect(_ sender: UIDatePicker) {
    date = sender.date
}


/**
Dismisses the text field.

- Returns: None
*/
func dismissTextField() {
    date = datePicker.date
    resignFirstResponder()
}


/**
Makes the body of the view.

- Parameters:
    - configuration: The configuration for this view.
- Returns: A `some View` that represents the content of this view.
*/
func makeBody(configuration: Configuration) -> some View {
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
}


/**
 Returns the foreground color based on whether the button is pressed or not.

 - parameter isPressed: A boolean indicating whether the button is pressed.
 - returns: The foreground color to use.
 */
func foregroundColor(isPressed: Bool) -> Color {
    guard isEnabled else {
        return DesignSystem.shared.colors.neutrals.neutral20.color
    }
}


/// Returns the background color of a button, taking into account whether it's pressed or not.
///
/// - parameter isPressed: Whether the button is currently pressed or not
/// - returns: The background color of the button

func backgroundColor(isPressed: Bool) -> Color {
    guard isEnabled else {
        return DesignSystem.shared.colors.neutrals.neutral10.color
    }
}


/**
 * This function takes in a `Content` and returns a `some View`.
 *
 * The returned view is configured based on the provided size.
 *
 * - If the size is `.small`, the content is padded with vertical space equal to the small spacer value,
 *   horizontal space equal to the medium spacer value, and font set to subheadline with medium weight.
 *
 * - If the size is `.custom(height: let height, padding: let padding)`, the content is framed to the specified
 *   height and padded with the specified padding. The font is set to body with medium weight.
 *
 * - If the size is `.big`, the content is framed to a height of 56 points and maximum width infinity. The
 *   font is set to body with medium weight.
 */
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


/**
 Initializes a new instance of the receiver with the specified properties.

 - parameter isEnabled: A boolean indicating whether the button is enabled. Defaults to true.
 - parameter isLoading: A boolean indicating whether the button is loading. Defaults to false.
 - parameter size: The size of the button. Defaults to .big.

 - returns: The initialized receiver.
 */
func primary(isEnabled: Bool = true, isLoading: Bool = false, size: PrimaryButtonStyle.Size = .big) -> Self {
    .init(isEnabled: isEnabled, isLoading: isLoading, size: size)
}


/**
 Makes the body of the view.

 - parameter configuration: The configuration for the view.
 - returns: A `some View` representing the body of the view.
 */
func makeBody(configuration: Configuration) -> some View {
    configuration.label
        .modifier(SecondaryButtonStyleModifier(size: size))
        .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
}


/**
Sets the foreground color of a control based on whether it's pressed.

- parameter isPressed: Whether the control is pressed.
- returns: The foreground color to use for the control. If the control is not loaded, this function returns a clear color.
*/
func foregroundColor(isPressed: Bool) -> Color {


/**
 * Returns the border color of the view, taking into account whether the button is pressed or not.
 *
 * - parameter isPressed: Whether the button is currently pressed.
 * - returns: A `Color` object representing the border color.
 */
func borderColor(isPressed: Bool) -> Color {
    if isPressed || !isEnabled {
        return borderColor.withAlphaComponent(0.3).color
    }
}


/**
 - Parameters:
   - content: The content to be displayed.

 - Returns: A `some View` that displays the given content.
 */
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


/// Creates a `View` with the specified corner radius for the given corners.
///
/// - parameter radius: The radius of the corners.
/// - parameter corners: A set of corners to apply the corner radius to.
/// - returns: A `View` that clips its content to the specified corner radius.

func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {


/// Returns a `Path` object representing the given rectangle with rounded corners.
///
/// - parameter rect: The rectangular area to be drawn.
///
/// - returns: A `Path` object that can be used to draw the specified rectangle with rounded corners.

```swift
func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
        roundedRect: rect,
        byRoundingCorners: corners,
        cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
}
```


/**
 Sets up the width spacing for a view with the given `mode`.

 - parameter mode: The mode to use for setting up the width spacing.
 */
func setupWidthSpacing(with mode: SpacingMode) {
    switch mode {
    case .flexible:
        return
    case let .flexibleMinimum(width):
        snp.makeConstraints { $0.width.greaterThanOrEqualTo(width) }
}


/// Sets up height spacing with the specified mode.
///
/// - Parameter with: The mode of height spacing to use.
public func setupHeightSpacing(with mode: SpacingMode) {
    switch mode {
    case .flexible:
        return
    case let .flexibleMinimum(height):
        snp.makeConstraints { $0.height.greaterThanOrEqualTo(height) }
}


/**
Called to ask the view to lay out its subviews.
*/
func layoutSubviews() {
    super.layoutSubviews()

    /**
     Sets the corner radius of the CALayer.
     */
    layer.cornerRadius = 24
    
    /**
     Sets the masked corners of the CALayer.
     - Parameters:
       - .layerMaxXMinYCorner: The top-right corner
       - .layerMinXMinYCorner: The bottom-left corner
     */
    layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
}


/**
 Makes default constraints for the CardContentView.

 - parameter topInset: The top inset to use. Defaults to `DesignSystem.shared.spacer.sm`.
 */
func makeDefaultConstraints(topInset: CGFloat = DesignSystem.shared.spacer.sm) {
    guard let superview else {
        return assertionFailure("CardContentView was not added to the view hierarchy")
    }
}


/**
 * Layouts the subviews.
 */
public override func layoutSubviews() {
    super.layoutSubviews()
    imageView.layer.cornerRadius = DesignSystem.CornerRadiusTypes.max(roundedCorners: .allCorners).calculateFor(layer).radius
}


/**
 Called when the trait collection changes.
 
 - parameter previousTraitCollection: The trait collection that was previously active. May be `nil` if the trait collection is changing for the first time, or if the change is to a new trait collection without a previous one (e.g., from compact to regular size class).
 */
func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {


/// Sets up the view with a default image or an image fetched from the local image manager.
///
/// - Parameters:
///   - defaultImage: The default image to use if no saved image is found. Defaults to "avatar" in .snbCommon.
///
/// - Returns: Void
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


/**
 Configures the image view.

- Warning: This method removes all subviews from the image view.
 */
func configureImageView() {
    subviews.forEach { $0.removeFromSuperview() }
}


/**
`viewWillAppear(_:)`
Called just before the view controller's view is about to be covered by another view.

- Parameters:
  - animated: A flag indicating whether the transition will be performed with an animation.

*/
func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    isNavigationBarHidden = navigationController?.isNavigationBarHidden
    navigationController?.setNavigationBarHidden(true, animated: false)
}


/**
* Called when the view controller's view will disappear.
*
* :param:animated If true, the view controller's view was animated off screen. Otherwise, it was hidden immediately.
*/
func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    guard let isNavigationBarHidden, !isNavigationBarHidden else {
        return
    }
}


/// Sets the corner radius of the view based on its height.
///
/// - Warning: This method is called whenever the view's subviews change, so it should be efficient to avoid performance issues.

```swift
func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height / 2
}
```


/**
 Sets up the view by configuring its UI components.

 - See Also: `titleLable`, `iconImageView`, `strings`, `images`
 */
func setupView() {
    titleLable.text = strings.supportButton
    iconImageView.image = images.supportIcon
    configureSubviews()
    applyStyles()
    applyConstraints()
}


/// Configures the subviews for this view.
///
/// - Note: This method should be called after the views have been set up in the storyboard or programmatically.
- (void)configureSubviews {
    [container addSubview:titleLable];
    [container addSubview:iconImageView];
    [self addSubview:container];
}


/**
Applies the styles to the view.

- See Also: `constants`
*/
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


/**
 Applies constraints to the container view.

- Returns: None
*/
func applyConstraints() {
    let containerWidth: CGFloat = isRTL ? constants.containerRTLWidth : constants.containerWidth
    container.snp.makeConstraints { make in
        make.top.leading.bottom.trailing.equalToSuperview()
        make.height.equalTo(constants.containerHeight)
        make.width.equalTo(containerWidth)
    }
}


/**
 Returns a SwiftUI `View` that displays the given text.

 - parameter text: The text to be displayed.
 - returns: A SwiftUI `View` that displays the given text.
 */
func getTitle(_ text: String) -> some View {
    Text(text)
        .multilineTextAlignment(.center)
        .font(.preferredFont(.body, .regular))
        .foregroundColor(DesignSystem.shared.colors.neutrals.neutral00.color)
}


/**
Sets up the view with a foundation color background and adds a stack view as its subview.

- Returns: None
*/
func setupView() {
    backgroundColor = DesignSystem.shared.colors.foundation.default
    addSubview(stackView)
    stackView.snp.makeConstraints {
        $0.top.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.xl)
        $0.bottom.equalToSuperview().inset(DesignSystem.shared.spacer.xl).priority(.medium)
    }
}


/**
 Creates a new `UIKitNoSearchResultsView`.

 - parameter context: The current SwiftUI rendering context.
 - returns: A new instance of `UIKitNoSearchResultsView`.
 */
func makeUIView(context: Context) -> UIKitNoSearchResultsView {
    UIKitNoSearchResultsView()
}


/**
 Updates the specified `uiView` with the provided `textTitle`.

 - parameter uiView: The `UIKitNoSearchResultsView` to update.
 - parameter context: The context in which this method is being called.

```swift
func updateUIView(_ uiView: UIKitNoSearchResultsView, context: Context) {
    if let textTitle {
        uiView.textTitle = textTitle
    }
}
```


/// Returns a `some View` representing a scrolling background with transparency.
///
/// - parameter publisher: The publisher of the data to be scrolled.
func transparentScrollingBackground(publisher: String) -> some View {
    if #available(iOS 16.0, *) {
        return scrollContentBackground(.hidden)
    }
}


/// - Returns: A `PKAddPassButton` instance.

```swift
func makeUIView(context: Context) -> PKAddPassButton {
    let button = PKAddPassButton(addPassButtonStyle: .black)
    let didTapAppleWalletButtonAction = UIAction { uiAction in
        action()
    }
}
```


/**
 Updates the specified `PKAddPassButton` instance.

 - Parameters:
    - uiView: The `PKAddPassButton` to be updated.
    - context: A `Context` that provides information about the current state of the interface.


/// - Returns: some View

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
}


/// Makes the navigation bar transparent.
///
/// - Parameters: None
/// - Returns: Void
func makeNavigationBarTransparent() {
    let standardAppearance = UINavigationBarAppearance()
    standardAppearance.configureWithTransparentBackground()

    let largeTitleTextAttributes: [NSAttributedString.Key : Any] = [
        .foregroundColor: DesignSystem.shared.colors.surfacePrimary.default,
        .font: DesignSystem.shared.fonts.preferredFont(.largeTitle, .medium)
    ]

    let titleTextAttributes: [NSAttributedString.Key : Any] = [
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


/**
 * Updates the subviews' positions.
 */
func layoutSubviews() {
    super.layoutSubviews()
    updateContentsRect()
}


/**
Updates the contents rectangle of the view.

- Returns: None
*/
func updateContentsRect() {
    var contentsRect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))

    guard let imageSize = image?.size else {
        layer.contentsRect = contentsRect
        return
    }
}


/**
 Builds a `UIViewController` instance with the given configuration.

 - parameter configuration: The configuration to use for building the view controller.
 - returns: A `UIViewController` instance configured with the provided `configuration`.

```swift
func build(configuration: Configuration) -> UIViewController {
    let viewModel = LogoutScreenViewModel(configuration: configuration)
    let viewController = LogoutScreenViewController(viewModel: viewModel, configuration: configuration)
    viewModel.viewController = viewController
    let sheetPresentationController = viewController.sheetPresentationController
    if #available(iOS 16.0, *) {
        sheetPresentationController?.detents = [.custom(resolver: { context in
            return 300 // your custom height
        })]
    }
}
```


/**
Submits the primary action.

- Returns: None
*/
func primaryActionSubmit() {
    guard let viewController else { return }
}


/**
 * Secondary action submit function.
 *
 * @param none
 */
func secondaryActionSubmit() {
    guard let viewController else { return }
}


/**
Loads the view.

- See also: `super.loadView()`, `setupUI()`
*/
func loadView() {
    super.loadView()
    setupUI()
}


/**
 Sets up the UI for the view.

- Warning: This function should be called on the main thread.
- Author: [Your Name]
- Version: 1.0
*/
func setupUI() {
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
}


/**
* Primary action submit handler.
*
* @param sender The button that triggered the submission.
*/
func primaryActionSubmit(_ sender: Button) {
    viewModel.primaryActionSubmit()
}


/**
 Submits the secondary action.

 - parameter sender: The button that triggered the submission.
 */
func secondaryActionSubmit(_ sender: Button) {
    viewModel.secondaryActionSubmit()
}


/// Creates a `UITextField` instance with the given context.
///
/// - Parameter context: The context to use when creating the view.
/// - Returns: A configured `UITextField` instance.
public func makeUIView(context: Context) -> UITextField {
    let textField = copyPasteActionsDisabled ? ActionsProtectedTextField() : UITextField()
    textField.delegate = context.coordinator
    textField.pasteDelegate = textPasteConfiguration != nil ? context.coordinator : nil
    textField.setNaturalTextAlignment()
    textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldEditingChanged), for: .editingChanged)
    textField.semanticContentAttribute = .forceLeftToRight
    configuration(textField)
    return textField


/**
 Updates the given `UITextField` based on the provided context.

 - Parameters:
    - uiView: The text field to update.
    - context: The context in which the text field should be updated.

 */
func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
    uiView.isSecureTextEntry = isSecureTextEntry
    uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    if focusState.binding.wrappedValue == focusState.value, !uiView.isFirstResponder {
        DispatchQueue.main.async { uiView.becomeFirstResponder() }
    }
}


/**
 Returns a coordinator for the `makeCoordinator` method.

 - returns: A `Coordinator<FocusValue>` object.
 */
func makeCoordinator() -> Coordinator<FocusValue> {
    Coordinator($text, focusState, didTapReturnButton, shouldChangeCharsIn, didEndEditing, shouldBeginEditing, textPasteConfiguration)
}


/**
 Called when the user finishes editing a field.

 - Parameters:
    - textField: The UITextField that triggered this call.
 */
func textFieldEditingChanged(_ textField: UITextField) {
    self.text.wrappedValue = textField.text ?? ""
}


/**
 Returns true if the user tapped the "return" button on a text field. Called when the user taps the "return" key or the "done" button.

 - parameter textField: The text field that was interacted with.
 - returns: Whether the return key was pressed. If this method is implemented, returning false will prevent the keyboard from dismissing and the text field's delegate methods from being called.
 */
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    didTapReturnButton()
    return true
}


/// Called when the text field begins editing.
///
/// - Parameter textField: The text field that began editing.
func textFieldDidBeginEditing(_ textField: UITextField) {
    DispatchQueue.main.async { 
        self.focusState.binding.wrappedValue = self.focusState.value }
}


/**
 Ends the editing of a text field.

 - parameter textField: The text field whose editing is being ended.
 - returns: `true` if the editing was ended, `false` otherwise.
 */
func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    DispatchQueue.main.async { self.focusState.binding.wrappedValue = nil }
}


/// Returns `true` if the text field should allow the specified characters to be inserted or deleted.
///
/// - Parameters:
///   - textField: The text field that is about to receive the new characters.
///   - range: The current range of characters in the text field.
///   - replacementString: The string of characters that will replace some of the characters in the text field.
/// - Returns: `true` if the text field should allow the specified characters to be inserted or deleted; otherwise, `false`.

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let shouldChangeCharsIn = self.shouldChangeCharsIn else { return true }
}


/// Returns `true` if the editing of the text field should begin.
///
/// - parameter textField: The text field that is about to start editing.
/// - returns: A boolean indicating whether the editing of the text field should begin.

func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    guard let shouldBeginEditing = self.shouldBeginEditing else { return true }
}


/**
 Called when the text field's editing session has ended.

 - parameter textField: The text field whose editing session has ended.
 */
func textFieldDidEndEditing(_ textField: UITextField) {
    didEndEditing?()
}


/**
Pastes the given text paste configuration supporting.

- parameter textPasteConfigurationSupporting: The text paste configuration supporting.
- parameter item: The text paste item to be pasted.
*/
func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, transform item: UITextPasteItem) {
    guard let textField = textPasteConfigurationSupporting as? UITextField else { return }
}


/**
Returns whether the receiver can perform the specified action with the given sender.

- parameter action: The selector of the action to check.
- parameter sender: The object that sent the action message (nil for a default action).

- returns: `true` if the action can be performed, `false` otherwise.
*/
func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    guard
        action != #selector(paste(_:)),
        action != #selector(copy(_)),
        action != #selector(cut(_)) else {
        return false
    }
}


/**
Sets the natural text alignment based on whether the text is right-to-left (RTL) or left-to-right (LTR).

- Note: The `textAlignment` property is used to align the text in a `UITextView` or similar control.
- Parameter: None
- Returns: None
*/
func setNaturalTextAlignment() {
    textAlignment = isRTL ? .right : .left
}


/**
 Sets the natural inverted text alignment based on the RTL flag.

- Warning: This function modifies the `textAlignment` property.
- Complexity: O(1)

```
func setNaturalInvertedTextAlignment() {
    textAlignment = isRTL ? .left : .right
}
```

**Parameters**

* None

**Returns**

* None


/**
* `viewDidLoad()`
*
* This method is called when the view controller's view has finished loading.
*
* - See Also: `super.viewDidLoad()`, `label`, `loadingView`, `Constants.opacity`
*/
func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(label)
    view.addSubview(loadingView)
    
    view.backgroundColor = .black.withAlphaComponent(Constants.opacity)
    
    loadingView.snp.makeConstraints {
        $0.centerX.equalToSuperview()
    }
}


/**
Sets whether the action is allowed.

- parameter isAllowed: Whether the action is allowed.
*/
func setAllowed(_ isAllowed: Bool) {
    shared.isAllowed = isAllowed
}


/**
Returns whether the feature is enabled or not.

- returns: A boolean indicating whether the feature is enabled.


/**
 Requests a review from the user.

 - parameter completion: A closure to be executed when the review is requested.
 */
func requestReview(completion: @escaping () -> Void) {
    guard shared.canRequestReview else { return completion() }
}


/**
Resets the last reviewed date.

- Returns: None
*/
func reset() {
    shared.lastReviewedDate = nil
}


/// Returns the current language.
///
/// - Returns: The current language, either `.arabic` or `.english`.
public enum AppLanguage {
    case arabic
    case english
}

func currentLanguage() -> AppLanguage {
    /**
     * Returns the current language.
     *
     * @return The current language, either .arabic or .english.
     */
    return LocaleSelector.shared.isArabic ? .arabic : .english
}


/**
 Returns the engagement banner slot for a given space ID.

 - parameter from: The space ID.
 - returns: An optional integer representing the engagement banner slot. If no valid slot is found, `nil` is returned.

```swift
func getEngageBannerSlot(from spaceId: String) -> Int? {
    guard let slotString = spaceId.components(separatedBy: "_").last,
          let slot = Int(slotString) else {
        return nil
    }
}
```


/**
 Returns the decoded JWT part.

 - parameter payload: The encoded JWT part.
 - returns: The decoded JWT part as a dictionary of strings and any objects. If decoding fails, it returns `nil`.
 */
func getDecodedJWTPart(payload: String) -> [String: Any]? {
    let payloadPaddingString = getBase64StringWithPadding(encodedString: payload)
    guard let payloadData = Data(base64Encoded: payloadPaddingString) else {
        fatalError("payload could not converted to data")
    }
}


/**
Returns a base64 string with padding.

- parameter encodedString: The input string to be encoded.
- returns: A base64 string with padding.
*/
func getBase64StringWithPadding(encodedString: String) -> String {
    var stringTobeEncoded = encodedString.replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    let paddingCount = encodedString.count % 4
    for _ in 0..<paddingCount {
        stringTobeEncoded += "="
    }
}


/**
Sets the current flow.

- parameter with: The new current flow.
*/
func setCurrentFlow(with value: CurrentFlow) {
    UserDefaults.standard.set(value.rawValue, forKey: currentFlowKey)
}


/**
 Removes the current flow from user defaults.

 - See also: `currentFlowKey`
 */
func removeCurrentFlow() {
    UserDefaults.standard.removeObject(forKey: currentFlowKey)
}


/**
 * Returns a string representing the MFA operation part.
 *
 * - parameter with: The MFA operation to be included in the string.
 * - returns: A string representing the MFA operation part.
 */
func mfaOperationPart(with value: MfaOperation) -> String {
    "&\(mfaOperationKey)=\(value.rawValue)"
}


/// - Returns: A list of URL query items.
///
func queryItems(mfaOperationType: MfaOperation) -> [URLQueryItem] {
    var queryItems = [mfaOperationQueryItem(with: mfaOperationType)]
    if let currentFlowQueryItem {
        queryItems.append(currentFlowQueryItem)
    }
}


/**
Query items based on the given MFA operation value.

- parameter mfaOperationValue: The MFA operation value to use for querying.
- returns: An array of URL query items representing the queried values.
*/
func queryItems(mfaOperationValue: String?) -> [URLQueryItem] {
    var queryItems = [URLQueryItem]()
    if let mfaOperationValue {
        queryItems.append(mfaOperationQueryItem(mfaOperationValue))
    }
}


/**
 - Returns: A `URLQueryItem` representing the specified `MfaOperation`.
 */
func mfaOperationQueryItem(with value: MfaOperation) -> URLQueryItem {
    URLQueryItem(name: mfaOperationKey, value: value.rawValue)
}


/**
Returns a `URLQueryItem` for the given MFA operation value.

- parameter value: The value of the MFA operation.
- returns: A `URLQueryItem` representing the MFA operation query item.

func mfaOperationQueryItem(_ value: String?) -> URLQueryItem {
    URLQueryItem(name: mfaOperationKey, value: value)
}


/**
 Validates the given `valueText` with the provided `currencyCode`.

 - parameter valueText: The text to be validated.
 - parameter currencyCode: The currency code to validate against.

 - returns: A `Result` containing a `.success` case if validation passes, or a `.failure` case if an error occurs. The error can be any type that conforms to the `Error` protocol.

 - see: checks(forText:currencyCode:) for more information on the validation logic.
 */
func validate(_ valueText: String?, currencyCode: String) -> Result<Void, Error> {
    let firstError = checks(forText: valueText, currencyCode: currencyCode).first(where: {
        if case .failure = $0 {
            return true
        }
    })
}


/**
 - Returns an array of results from the given text and currency code.
 
 - The array contains the results from running the following checks on the input:
   - `checkForMultipleDecimalSeparators`: Checks if there are multiple decimal separators in the text.
   - `checkForAmountOfDecimalDigits`: Checks the amount of decimal digits in the text.
   - `checkForDecimalNumber`: Checks if the text is a decimal number.

- parameter text: The input text to be checked.
- parameter currencyCode: The input currency code.
 
- returns: An array of results where each result is a tuple containing either an empty value or an error.
 */
func checks(forText text: String?, currencyCode: String) -> [Result<Void, Error>] {
    return [
        checkForMultipleDecimalSeparators,
        checkForAmountOfDecimalDigits,
        checkForDecimalNumber
    ].map { $0(text, currencyCode) }
}


/**
 Deletes a Keychain item.

 - throws: An error if the deletion fails.
 */
func delete() throws {
    let status = SecItemDelete(baseDictionary as CFDictionary)
    guard status != errSecItemNotFound else { return }
}


/**
 Returns the contents of the keychain item as a string, if found.
 
 - returns: The contents of the keychain item as a string, or `nil` if not found. Throws an error if there is a problem reading from the keychain.
 */
func read() throws -> String? {
    let query = self.query.adding(key: kSecReturnData as String, value: true as AnyObject)
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    guard status != errSecItemNotFound else { return nil }
}


/**
 Updates a Secret Item with the given `secret` string.

 - throws: An error if the update fails.
 - parameter secret: The new secret value to update the item with.
 */
func update(_ secret: String) throws {
    let dictionary: [String: AnyObject] = [
        kSecValueData as String: secret.data(using: String.Encoding.utf8)! as AnyObject
    ]
    try throwIfNotZero(SecItemUpdate(baseDictionary as CFDictionary, dictionary as CFDictionary))
}


/**
 Adds a secret to the keychain.

 - parameter secret: The secret to be stored in the keychain.
 - throws: An error if the operation fails.
 */
func add(_ secret: String) throws {
    let dictionary = baseDictionary.adding(key: kSecValueData as String, value: secret.data(using: .utf8)! as AnyObject)
    try throwIfNotZero(SecItemAdd(dictionary as CFDictionary, nil))
}


/**
 Throws an error if the given `OSStatus` is not equal to zero.

- parameter status: The `OSStatus` value to check.
- throws: An error if the status code is not zero.
*/
func throwIfNotZero(_ status: OSStatus) throws {
    guard status != 0 else { return }
}


/**
Sets the font of the receiver.

- parameter font: The font to use.
- returns: The receiver, for chaining calls.
*/
func font(_ font: UIFont) -> Self {
    attributes[.font] = font
    return self
}


/**
Sets the foreground color of the attributed string.

- parameter color: The new foreground color.
- returns: `Self` to enable method chaining.
*/
func foregroundColor(_ color: UIColor) -> Self {
    attributes[.foregroundColor] = color
    return self
}


/**
 Builds an attributed string from the given text.

 - parameter text: The text to build the attributed string from.
 - returns: An attributed string containing the given text with the specified attributes.
 */
func build(text: String) -> NSAttributedString {
    NSAttributedString(string: text, attributes: attributes)
}


/// Returns the JWT value associated with the given key.
///
/// - parameter key: The key for which to retrieve the JWT value.
/// - returns: The JWT value if found, `nil` otherwise.
func jwtValue(key: String) -> Any? {
    guard let decodedJwt = jwtDecode() else { return nil }
}


/// Decodes a JWT token.
///
/// - returns: The decoded JSON dictionary, or `nil` if the token is invalid.

```swift
func jwtDecode() -> [String : Any]? {
    let tokens = Backbase.authClient().tokens()
    if tokens.count > 0 && tokens[authorizationKey] != nil, let token = tokens[authorizationKey] {
        let tokenSplit: [String] = token.components(separatedBy: ".")
        guard tokenSplit.indices.contains(1) else {
            return nil
        }
    }
}
```


/**
Configure an object by applying a closure to it.

- parameter object: The object to be configured.
- parameter closure: A closure that takes the object as an inout parameter and returns nothing.
- returns: The configured object.
*/
func configure<T>(_ object: T, with closure: (inout T) -> Void) -> T {
    var object = object
    closure(&object)
    return object
}


/**
- Returns: A `some View` representing the background style.
*/
func backgroundViewStyle() -> some View {
    background(DesignSystem.shared.colors.foundation.default.color)
}


/**
 - Returns: A `some View` representing the content view with a large corner radius, surface primary background color, and small custom shadow.
 */


/**
Returns a localized string based on the provided `bundles` and `attributes`.

- parameter bundles: A variable-length argument of `Bundle` objects to search for the localized string.
- parameter attributes: A variable-length argument of values that should be formatted into the localized string.

- returns: The localized string, formatted with the provided `attributes`.
*/
func localized(in bundles: Bundle?, _ bundles: Bundle..., attributes: CVarArg...) -> String {
    String(format: getLocalized(in: bundles), arguments: attributes)
}


/**
Returns the localized string.

- parameter in: The bundle(s) to search for the localized string.
- returns: The localized string.
*/
func localized(in bundles: Bundle?...) -> String {
    getLocalized(in: bundles)
}


/// Returns the localized string for the given key from the first bundle that contains a localization for it.
///
/// - parameter in bundles: The bundles to search for the localized string, with the main bundle as the default.
/// - returns: The localized string, or an empty string if none is found.

func getLocalized(in bundles: [Bundle?]) -> String {
    let bundles = ([.main] + bundles).compactMap { $0 }


/**
Returns a binding that unwraps the wrapped value if it is not nil, 
or returns the default value.

- parameter defaultValue: The default value to return if the wrapped value is nil.
- returns: A binding that returns the wrapped value if it is not nil, or the default value.
*/
func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
    Binding<T>(
        get: { self.wrappedValue ?? defaultValue }
)


/**
Dismisses the keyboard.

- Important: This method should be called on the main thread.
*/
func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}


/// Sets the text alignment to inverted natural alignment.
///
/// - Important: This method should be called after determining whether the text is RTL (Right-To-Left) or LTR (Left-To-Right).
///
/// - Parameters:
///   None
///
/// - Returns:
///   None
///
func setInvertedNaturalTextAlignment() {
    textAlignment = isRTL ? .left : .right
}


/**
Sets the natural text alignment based on whether the text is right-to-left (RTL) or left-to-right (LTR).

- parameter None
- returns None
*/
func setNaturalTextAlignment() {
    textAlignment = isRTL ? .right : .left
}


/**
 Returns a publisher that emits whether the given `filteredList` has any results.

 - parameter filteredList: A publisher that emits an array of type `T`.

 - returns: A publisher that emits a boolean value indicating whether the `filteredList` is empty.
 */
func hasNoResults<T>(_ filteredList: AnyPublisher<[T], Never>) -> AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(
        filteredList,
        publisher(for: .editingChanged).map { $0.text ?? "" }
    )
}


/// Called when the view is about to appear.
/**
 - Overview: This method is called when the view controller's view is about to appear.
 
 - Parameters:
 - None
 
 - Returns: None
 */
func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
}


/**
 Returns whether the gesture should begin.

 - parameter gestureRecognizer: The gesture recognizer.
 - returns: `true` if the gesture should begin, `false` otherwise.
 */
func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    let isContainMultipleVC = viewControllers.count > 1
    if let visibleVC = visibleViewController as? InteractivePopGestureProtocol {
        return isContainMultipleVC && visibleVC.isPopGestureEnabled
    }
}


/**
Displays a toast notification with the given message after the specified delay.

- parameter message: The message to be displayed in the toast.
- parameter delay: The delay in seconds before the toast is displayed.

- Note: This method will only work if there's an active window available.
*/
func displayToast(_ message: String, with delay: Int) {
    guard let window: UIWindow = UIApplication.shared.delegate?.window ?? nil else {
        return
    }
}


/**
 Presents a half-sheet view controller.

 - parameter cornerRadius: The corner radius of the presented view (default 24).
 - parameter heightRatio: The height ratio of the presented view (default 0.55).
 - parameter isGrabberVisible: Whether the grabber should be visible or not (default false).

 - precondition: The sheet presentation controller must exist.
 */
func halfSheetPresentation(cornerRadius: CGFloat = 24, heightRatio: CGFloat = 0.55, isGrabberVisible: Bool = false) {
    guard let presentation = sheetPresentationController else { return }
}


/**
 Posts a notification with the specified object.

 - parameter object: The object to be posted (default is `nil`).
 */
public func post(_ object: Any? = nil) {
    NotificationCenter.default.post(name: .self, object: object)
}


/// Observes the given `name` notification and executes the provided `callback` function when it is received.
///
/// - Parameters:
///   - name: The name of the notification to observe.
///   - queue: The operation queue on which the observation should be performed. Defaults to `.main`.
///   - callback: A closure that takes a `Notification` object as its argument, and is called when the observed notification is received.
///
/// - Returns: None
func observe(_ name: Notification.Name, queue: OperationQueue = .main, callback: @escaping (Notification) -> Void) {


/// Posts a notification to the default center.
///
/// - parameter name: The name of the notification to post.
/// - parameter object: The notification's object. Defaults to `nil`.
/// - parameter userInfo: A dictionary containing user information about the notification. Defaults to `nil`.
func post(_ name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {\n
    post(name: name, object: object, userInfo: userInfo)\n
}


/**
 Returns a `some View` that is draggable.

 - returns: A `some View` that can be dragged.
 */
func draggablePresentation() -> some View {
    modifier(DragHandleModifier())
        .modifier(AdaptsToKeyboardModifier())
}


/// Returns a `some View` that stacks the given content with a drag handle.
///
/// - parameter content: The content to be stacked.
/// - returns: A `some View` representing the stacked content.


/**
 Returns a `some View` that applies the given content and adds padding to the bottom based on the current height.

 - parameter content: The content to be applied.
 - returns: A `some View` that represents the input content with added padding.
 */
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
    }


/**
 Returns the top-most view controller.
 
 - returns: The top-most view controller, or `nil` if no view controllers are found.
 */
func topMostViewController() -> UIViewController? {
    var topViewController: UIViewController?

    for scene in connectedScenes {
        if let windowScene = scene as? UIWindowScene {
            for window in windowScene.windows where window.isKeyWindow {
                topViewController = window.rootViewController
            }
        }
    }

    return topViewController
}


/**
 Dismisses all controllers.

- Note:
    - This method is intended to be used on the main thread.
 */
func dismissAllControllers() {
    var topViewController: UIViewController?

    for scene in connectedScenes {
        if let windowScene = scene as? UIWindowScene {
            for window in windowScene.windows where window.isKeyWindow {
                topViewController = window.rootViewController
            }
        }
    }
}


/**
 Finds the topmost view controller of a given type from the connected scenes.

 - parameter to: The type of view controller to find.
 - returns: The topmost view controller of the given type, or nil if not found.
 */
func findViewController<T>(to viewControllerType: T.Type) -> UIViewController? {
    var viewControllerToFind: UIViewController?
    for scene in connectedScenes {
        if let windowScene = scene as? UIWindowScene {
            for window in windowScene.windows where window.isKeyWindow {

                // UITabBarController
                if let tabbar = window.rootViewController as? UITabBarController {
                    if let viewController = (tabbar.selectedViewController as? UINavigationController)?.viewControllers.first(where: { type(of: $0) == viewControllerType }) {
                        return viewController
                    }
                }
            }
        }
    }
    return nil
}


/**
 Returns the topmost view controller in the UI stack.

 - returns: The topmost view controller, or `nil` if there is no presented view controller.
 */
func topViewController() -> UIViewController? {
    if self.presentedViewController == nil {
        return self
    }
}


/**
Dismissing a presented view controller if one is presented.

- Returns: None
*/
func dismissIfPresented() {
    dismiss(animated: true)
}


/**
 Pops the top view controller if it was pushed.

 - Returns: None
 */
func popIfPushed() {
    navigationController?.popViewController(animated: true)
}


/// Creates a `UIBarButtonItem` with the given `image`.
///
/// - parameter image: The image to display on the button.
/// - returns: A new `UIBarButtonItem` instance.
func closeBarButtonItem(image: UIImage?) -> UIBarButtonItem {
    return UIBarButtonItem(image: image, style: .plain,
                             target: self, action: #selector(dismissIfPresented))
}


/**
 Returns a back bar button item with the specified image.

 - parameter image: The image to use for the back button.
 - returns: A back bar button item.
 */
func backBarButtonItem(image: UIImage?) -> UIBarButtonItem {
    return UIBarButtonItem(image: image, style: .plain,
                            target: self, action: #selector(popIfPushed))
}


/**
Adds a child view controller.

- parameter child: The child view controller to be added.
*/
func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
}


/**
 Removes the object from its parent.

 - Note: This method should only be called if there is a parent set.
 */
func remove() {
    guard parent != nil else {
        return
    }
}


/**
Adds a support button view to the current view.
*/
func addSupportButtonView() {
    /**
    Creates a new instance of SupportButton and adds it as a subview to the current view.
    */
    let supportButton = SupportButton()
    
    /**
    Adds the support button as a subview to the current view.
    */
    view.addSubview(supportButton)
    
    /**
    Creates a UIAction that navigates to the support deeplink when triggered.
    */
    let action = UIAction { _ in
        Resolver.optional(DeeplinkNavigatable.self)?.navigate(to: .support)
    }
}


/**
 Removes large titles from the navigation bar.

 - Note: This method should be called in a place where `navigationController` is not nil.
 */
func removeLargeTitlesForNavBar() {
    navigationController?.navigationBar.prefersLargeTitles = false
}


/**
Returns the back bar button item.
 
- returns: The back bar button item, or nil if not set.


/**
 Returns a substring of the string, defined by the given range.

 - parameter range: The range of indices to extract as a substring.
 - returns: The extracted substring, or `nil` if the range is invalid (i.e., lower bound is not within the valid range).
 */
func substring(_ range: Range<Int>) -> String? {
    guard range.lowerBound >= 0,
          range.lowerBound < range.upperBound else { return nil }
}


/// Returns a DateFormatter instance configured with the given date format.
///
/// - parameter dateFormat: The desired date format string.
/// - returns: A DateFormatter instance with the specified date format.

func formatter(for dateFormat: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    return formatter
}


/**
 Defines a view that receives keyboard visibility changes and performs the specified action.

 - parameter perform: A closure that takes a `Bool` as an argument, indicating whether the keyboard is visible or not. This closure will be called whenever the keyboard visibility changes.
 - returns: The view that can be used in SwiftUI views.
 */
func onKeyboardVisibilityChanged(perform: @escaping (Bool) -> Void) -> some View {


/**
 Marks the view's content as bound to a keyboard visibility binding.

 The provided `binding` is used to observe the presence or absence of the keyboard.
 When the keyboard is visible, the binding's value will be `false`, and when it's not,
 the binding's value will be `true`.

 - Parameter bindable: A binding that provides the state of the keyboard visibility.
 - Returns: A view modifier that observes the provided binding and updates the view accordingly.
 */
func bindWithKeyboardVisibility(bindable: Binding<Bool>) -> some View {
    modifier(KeyboardObserverModifier(bindable: bindable))
}


/**
 Returns a view that wraps the given `content` with an additional modifier.
 
 - parameter content: The content to be wrapped in a view.
 
 - returns: A `some View` that can be used as part of a SwiftUI view hierarchy.
 */
func body(content: Content) -> some View {
    content
        .onKeyboardVisibilityChanged { bindable = !$0 }
}


/**
Returns whether the given `semanticContentAttribute` indicates a right-to-left layout direction.

- parameter semanticContentAttribute: The semantic content attribute to check.
- returns: `true` if the layout direction is right-to-left, `false` otherwise.
*/
func isRTL(for semanticContentAttribute: UISemanticContentAttribute) -> Bool {
    UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
}


/**
 Returns a `UIControlPublisher` that publishes the specified events from this control.

 - parameter events: The events to publish.
 - returns: A `UIControlPublisher` that publishes the specified events.
 */
func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
    UIControlPublisher(control: self, events: events)
}


/// Request a demand.
///
/// - parameter demmand: The demand being requested.
func request(_ demmand: Subscribers.Demand) {
    // We do nothing here as we only want to send events when they occur.
    // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
}


/**
 Cancels the subscription.

 - Note: This method sets `subscriber` to `nil`, effectively unsubscribing from any event notifications.
 */
func cancel() {
    subscriber = nil
}


/**
Invokes the `receive(_:)` method on the subscriber, passing `control` as the argument.

- parameter control: The value to be received by the subscriber.
*/
func eventHandler() {
    _ = subscriber?.receive(control)
}


/// Configures the background view for a screen.
///
/// - Parameters:
///   - type: The type of background view to configure. Defaults to `.pattern`.
func configureBackgroundView(type: BackgroundScreenType = .pattern) {
    let restorationIdentifier = "background-view-identifier"
    
    subviews
        .filter { $0.restorationIdentifier == restorationIdentifier }


/**
 Configures the default card content view with a background and adds it to this view.

 - parameter backgroundType: The type of background to use. Default is `.pattern`.

 - returns: The configured card content view.
 */
func configureDefaultCardContentView(backgroundType: BackgroundScreenType = .pattern) -> UIView {
    configureBackgroundView(type: backgroundType)
    let cardContentView = CardContentView()
    addSubview(cardContentView)
    cardContentView.makeDefaultConstraints()
    return cardContentView
}


/**
 Adds the specified arranged subview to this view with the given insets.

 - parameter subview: The subview to be added.
 - parameter insets: The edge inset to apply to the subview.

 - returns: This view.


/**
 Adds a new arranged subview to the end of the views array with a specified space before.

 - parameter subview: The view to be added.
 - parameter spaceBefore: The space before the newly added subview.


/**
 Removes all arranged subviews from the view hierarchy.

 - Complexity: O(n)
 */
func removeArrangedSubviews() {
    arrangedSubviews.forEach {
        removeArrangedSubview($0)
        $0.removeFromSuperview()
    }
}


/**
 Adds a new key-value pair to the dictionary.

 - parameter key: The key for the new pair.
 - parameter value: The value for the new pair.
 - returns: A new dictionary with the added pair, or the original dictionary if it already contains the key.

 - warning: This method creates a copy of the original dictionary and modifies the copy. This means that any changes made to the returned dictionary will not affect the original dictionary.

 - seealso: `remove(key:)`
 */


/**
 Returns the preferred localized text based on the current language.

 - parameter en: The English text.
 - parameter ar: The Arabic text.
 - returns: The preferred localized text.
 */
func preferredLocalisedText(en: String, ar: String) -> String {
    switch AppLanguageManager.currentLanguage() {
    case .arabic: return ar
    case .english: return en
    }
}


/**
 Returns a new `CGSize` with the same width and height as the input `size`.

 - parameter size: The size to use for both the width and height.
 - returns: A new `CGSize` with the same dimensions as the input `size`.
 */
func equal(_ size: CGFloat) -> CGSize {
    CGSize(width: size, height: size)
}


/**
Sets the text alignment to inverted natural text alignment.

- Note: This method uses the `semanticContentAttribute` property to determine the direction of the text. It sets the `textAlignment` property based on whether the text is right-to-left (RTL) or left-to-right (LTR).

- Parameters:
    - None

- Returns:
    - None
*/
func setInvertedNaturalTextAlignment() {
    textAlignment = UIView.isRTL(for: semanticContentAttribute) ? .left : .right
}


/**
 Creates a `VStack` with the provided `content` and optional additional elements.

 - Parameters:
    - content: The view to be displayed at the top of the stack.
    - show: A flag indicating whether the additional elements should be displayed. Defaults to `false`.

 Returns: A `some View` representing the resulting UI.
 */
func body(content: Content) -> some View {
    VStack {
        content
        if show {
            Spacer()
                .frame(height: topSpacing)
            Button(action: action) {
                Text(title)
            }
        }
}


/**
 Encrypts the input using a public key.

 - parameter publicKey: The public key to use for encryption. May be `nil`.

 - returns: The encrypted result as a base64-encoded string, or `nil` if the input was invalid.
 */
func encrypt(with publicKey: String?) -> String? {
    guard let publicKey = publicKey?.trimedPublicKey, let data = Data(base64Encoded: publicKey) else {
        return nil
    }
}


/// Encrypts the given string to base64 using the provided public key.
///
/// - parameter publicKey: The public key used for encryption.
///
/// - returns: The encrypted data as a base64 encoded string, or `nil` if an error occurs.


/// Sanitizes the input amount string by removing grouping separators and decimal places.
///
/// - parameter amount: The input amount string to sanitize.
///
/// - returns: The sanitized amount string, or nil if the input was nil.

```swift
func sanitizeAmountForInput(amount: String?) -> String? {
    let numberLocale = DesignSystem.Formatting.numberLocale
    let groupingSeparator = numberLocale.groupingSeparator ?? " "
    return amount?.replacingOccurrences(of: groupingSeparator, with: "")
        .replacingOccurrences(of: ".00", with: "")
}
```


/**
 Returns a string with leading and trailing whitespace characters removed.

 - returns: A string with no whitespace characters at the beginning or end.
 */
func trimmed() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
}


/// Returns the given `content` wrapped in a `some View`.
///
/// - Parameter content: The view to be wrapped.
/// - Returns: A `some View` that represents the given `content`.
func body(content: Content) -> some View {
    return content
        .environment(\.layoutDirection, LocaleSelector.shared.isArabic ? .rightToLeft : .leftToRight)
}


/**
 Returns a `some View` with the correct semantic content attribute forced.

 - returns: `some View`
 */
func forceCorrectSematicContentAttribute() -> some View {
    modifier(LocaleViewModifier())
}


/// Pops to the root view controller with an optional animation and completion handler.

/**
- Parameters:
  - animated: A boolean indicating whether the transition should be animated. Default is `true`.
  - completion: The block of code to execute after the transition is completed.
*/
public func popToRootViewControllerWithHandler(animated: Bool = true, completion: @escaping () -> Void) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    self.popToRootViewController(animated: animated)
    CATransaction.commit()
}


/**
 Pop the topmost view controller of the specified class from the navigation stack.

 - parameter ofClass: The class of the view controller to pop.
 - parameter animated: A boolean indicating whether the popping should be animated. Defaults to `true`.

 - returns: None
 */
func popToViewController(ofClass: AnyClass, animated: Bool = true) {\n        if let viewController = viewControllers.last(where: { $0.isKind(of: ofClass) }) {\n            self.popToViewController(viewController, animated: animated)\n        }\n    }


/**
 Returns the image stored in the cache for the given key.

 - parameter key: The unique identifier of the image.
 - returns: The cached image, or `nil` if it's not found.


/**
Caches the given `UIImage` for the specified `key`.

- Parameters:
    - image: The `UIImage` to be cached.
    - key: The unique identifier for the cached image.

- Discussion: This method caches the provided `image` using a shared cache store. The `key` parameter is used to uniquely identify the cached image, allowing for fast retrieval of the same image later on.
*/


/**
 Loads an image from a given URL and returns it as an `UIImage?` optional.

 - parameter withURL: The URL of the image to load.
 - returns: The loaded image, or `nil` if the image could not be loaded.
 */
func loadImage(withURL url: URL) async throws -> UIImage? {
    // Check if the image is already cached
    if let cachedImage = imageCache.getImage(forKey: url.absoluteString) {
        return cachedImage
    }
}


/**
 Cancels image loading for a given URL.

 - parameter forURL: The URL to cancel loading for.
 */
func cancelImageLoading(forURL url: URL) {
    // Find the tasks that match the provided URL
    let tasksToCancel = loadingTasks.filter { $0.originalRequest?.url == url }
}


/**
 Loads data from the specified URL.

 - parameter withURL: The URL to load data from.
 - returns: The loaded data. Throws an error if the data cannot be loaded.
 */
func loadData(withURL url: URL) async throws -> Data {
    // Perform the data loading task
    let config = URLSessionConfiguration.default
    config.urlCache = nil
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    let urlSession = URLSession(configuration: config)
    let (data, _) = try await urlSession.data(from: url)
    return data


/**
Changes the locale.

- Returns: None
*/
func changeLocale() {
    showRestartAppAlert()
}


/// Updates the semantic content attribute to force right-to-left layout.
///
/// - Note: This method should only be called when the app is running in an Arabic locale.
func updateSemanticContentAttribute() {
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
}


/**
 Shows an alert with the option to restart the app.

 - Important: This method assumes that `Strings.LocaleSelector` contains localized strings for the title and message of the alert, as well as the cancel and ok button titles.
 */
func showRestartAppAlert() {
    let alert = UIAlertController(
        title: Strings.LocaleSelector.alertTitle,
        message: Strings.LocaleSelector.alertMessage,
        preferredStyle: .alert
    )
    let cancelAction = UIAlertAction(title: Strings.LocaleSelector.alertCancel, style: .cancel, handler: nil)
    let okAction = UIAlertAction(title: Strings.LocaleSelector.alertOk, style: .destructive) { [weak self] action in
        self?.changeAppLocale()
    }
}


/**
Changes the app's locale.

- Important: This method should only be called when the user's preferred language has changed.
*/
func changeAppLocale() {
    if let locale = useCase.supportedLocales.first(where: {$0.identifier != preferredLanguageCode}) {
        // Your code here
    }
}


/**
Closes the app.

- Important: This method is not officially supported by Apple and may cause unexpected behavior or crashes.
*/
func closeApp() {
    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
        exit(EXIT_SUCCESS)
    })
}


/// Returns the logo for a given bank code.
///
/// - parameter withBankCode: The bank code to retrieve the logo for.
/// - returns: A `UIImage` representing the logo, or a placeholder if none is found.

func getLogo(with bankCode: String) -> UIImage {
    guard let logo = UIImage.named(bankCode.uppercased(), in: .snbCommon) else {
        return UIImage.named("placeholder_bank_logo", in: .snbCommon)!
    }
}


/**
 Returns a logo for the given bank code.

 - parameter with: The bank code to get the logo for.
 - returns: A `UIImage` representing the provider's logo. If no logo is found, it will return a placeholder logo.

 */
func getProviderLogos(with bankCode: String) -> UIImage {
    guard !bankCode.isEmpty,
          let logo = UIImage.named(bankCode.uppercased(), in: .snbCommon) else {
        return UIImage(named: "placeholder_bank_logo", in: .snbCommon, compatibleWith: nil)!
    }
}


/**
 Returns a provider banner image for the given bank code.

 - parameter with: The bank code to retrieve the provider banner for.
 - returns: A `UIImage` representing the provider banner, or `nil` if no image is found.


/**
 Returns a `UIImage` for the given country code, or a default placeholder if no matching flag is found.

 - parameter with: The country code to look up.
 - returns: A `UIImage` representing the flag for the specified country code, or `nil` if no match is found.
 */
func getFlag(with code: String) -> UIImage? {
    guard let flag = UIImage.named(code.uppercased(), in: .snbCommon) else {
        return UIImage.named("placeholder_country_flag", in: .snbCommon)
    }
}


/**
Initializes the view.

- See Also: `super.viewDidLoad()`
*/
func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.configureDefaultCardContentView(backgroundType: .pattern)
    addSubviews()
    bind()
}


/**
* Called when the view is about to become visible.
*
* - parameter animated: A boolean indicating whether the transition will be animated or not.
*/
func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationItem.largeTitleDisplayMode = .never
    let attributes: [NSAttributedString.Key : Any] = [
        .font: DesignSystem.shared.fonts.preferredFont(.body, .medium),
        .foregroundColor: DesignSystem.shared.colors.text.default.dark
    ]

    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.titleTextAttributes = attributes
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
}


/// Called when the view will disappear.
///
/// - parameter animated: If true, the view was presented modally with a transition and is being dismissed. If false, the view was hidden without a transition.
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    view.endEditing(true)
}


/**
 Adds subviews.

 - Discussion:
 This method adds the `pdfView` as a subview of the `view`.

 - See Also: `view`
 */
func addSubviews() {
    view.addSubview(pdfView)
}


/**
* Binds the view model's `pdfDocument` property.
*
* :nodoc:
*/
func bind() {
    viewModel.$pdfDocument
        .compactMap { $0 }
}


/**
 Sets up the navigation bar with the given screen configuration.

 - parameter screenConfig: The screen properties to use for setup.
 */
func setupNavBar(with screenConfig: ScreenProperties) {
    let closeView = UIImageView(image: screenConfig.closeImage)
    closeView.tintColor = .white
    screenConfig.closeButtonHeight.flatMap { size in
        closeView.snp.makeConstraints { make in
            make.width.height.equalTo(size)
        }
    }
}


/// Updates the `pdfView` with a new `document` and adjusts its size accordingly.
///
/// - Parameter document: The PDF document to be displayed.
func update(with document: PDFDocument) {
    pdfView.document = document
    pdfView.goToFirstPage(nil)
    adjustPDFSize()

    DispatchQueue.main.async { [weak self] in
        guard let self else { return }
    }
}


/**
 Adjusts the PDF view size.
 
 - Description:
 The function adjusts the PDF view size by removing any existing constraints and then adding new ones. The new constraints set the top of the PDF view to be offset from the safe area layout guide, with the leading, trailing, and bottom edges aligned to their respective superview boundaries.
 
 - Parameters: None
 */


/**
 Presents a share sheet for the given PDF file.

 - parameter fileURL: The URL of the PDF file to share.
 */
func presentShareActivity(with fileURL: URL) {
    pdfView.document?.write(to: fileURL)
    let source = PDFActivityItemSource(fileURL: fileURL)
    let activityViewController = UIActivityViewController(activityItems: [source], applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    self.present(activityViewController, animated: true)
}


/**
 Returns the placeholder item to display when the user selects an activity.

 - parameter activityViewController: The UIActivityViewController presenting the activities.
 - returns: The placeholder item.
 */
func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {


/**
    - parameter activityViewController: The UIActivityViewController for which to generate the link metadata.
    
    - returns: An LPLinkMetadata object representing the link metadata, or nil if an error occurred.
*/
func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
    let metadata = LPLinkMetadata()
    metadata.title = title
    metadata.url = fileURL
    metadata.originalURL = URL(fileURLWithPath: subtitle)
    if let image = icon {
        metadata.iconProvider = NSItemProvider(object: image)
    }
}


/**
 Builds a `UIViewController` for displaying a PDF document.

 - parameter model: The `PDFModel` representing the PDF document to be displayed.
 - parameter configuration: The `Configuration` object containing settings for the PDF viewer.

 - returns: A `UIViewController` instance configured with the provided model and configuration.


/**
Sets up the loading PDF.

- Returns: None
*/
func setupLoadingPDF() {
    guard let path = Bundle.main.path(forResource: "pdfreader_loading", ofType: "pdf") else { return }
}


/**
Fetches a PDF from the given `model`.

- parameter model: The `PDFReader.PDFModel` containing the PDF data.
*/
func fetchPDF(from model: PDFReader.PDFModel) {
    DispatchQueue.global(qos: .background).async {
        if let data = model.data {
            if let pdfDocument = PDFDocument(data: data) {
                self.present(pdfDocument: pdfDocument)
            }
        }
    }
}


/**
 Presents a given `PDFDocument`.

- parameter pdfDocument: The `PDFDocument` to present.
*/
func present(pdfDocument: PDFDocument) {
    DispatchQueue.main.async {
        self.pdfDocument = pdfDocument
        if self.configuration.showShareActivityOnLoad {
            self.shareTapped()
        }
}


/// Shares the document when the "Share" button is tapped.
///
/// - Returns: None
func shareTapped() {
    let temporaryFolder = FileManager.default.temporaryDirectory
    let fileName: String
    if let title = model.title, !title.isEmpty {
        fileName = title + ".pdf"
    }
}


/**
Closes the action.

- Returns: Nothing.
*/
func closeTapped() {
    model.closeAction?
}


/**
 Saves the given `image` to a file.

 - parameter image: The image to be saved.
 - returns: A boolean indicating whether the save was successful. If an error occurs, `false` is returned.

*/
func save(_ image: UIImage) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
}


/**
 Returns the saved image.

 - returns: The saved image, or nil if it's not found.
 */
func getSavedImage() -> UIImage? {
    if let directory = try? FileManager.default.url(for: .documentDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: false) {
        return UIImage(contentsOfFile: URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(avatarImageFileName).path)
    }
}


/// Removes the avatar image if it is saved.
///
/// - Returns: None
func removeAvatarImageIfSaved() {
    guard let imagePath = path(for: avatarImageFileName) else {
        return
    }
}


/**
 Returns a URL for an image with the given name stored in the app's document directory.

 - parameter imageName: The name of the image
 - returns: A URL to the image file, or nil if the image does not exist
 */
func path(for imageName: String) -> URL? {
    let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    return directory?.appendingPathComponent(imageName)
}


/**
Opens a given URL.

- Parameters:
    - url: The URL to be opened.
- Throws:
    - Error: If the app is unable to open the URL.
- Note: This function requires the `UIApplicationOpenExternalURLs` key in the app's info.plist file.
*/
func openUrl(url: URL) async {
    if application.canOpenURL(url) {
        await application.open(url, options: [:])
    }
}


/**
 Registers a reusable cell for use in the collection view.

 - parameter cellType: The type of cell to be registered.
 */
func register<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell, Cell: Reusable {
    register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
}


/**
 Registers a custom `UITableViewHeaderFooterView` subclass for reuse.

 - parameter view: The type of the custom `UITableViewHeaderFooterView` subclass to register.
 - note: The view must conform to both `UITableViewHeaderFooterView` and `Reusable`.
 */
func registerHeaderFooterView<View>(_ view: View.Type) where View: UITableViewHeaderFooterView, View: Reusable {
    register(view, forHeaderFooterViewReuseIdentifier: view.reuseIdentifier)
}


/**
 Dequeues a reusable cell of the specified type at the given index path.

 - parameter cellType: The type of cell to dequeue.
 - parameter indexPath: The index path of the cell to dequeue.
 - returns: The dequeued cell, or nil if no cell is available.
 */
func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell, Cell: Reusable {\n
    guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {\n
        fatalError("Cell class \(cellType.reuseIdentifier) is not registered in \(description)")\n
    }\n


/**
 Registers the given `cellType` for use in this collection view.

 - parameter cellType: The type of cell to register.
 */
func register<Cell>(_ cellType: Cell.Type) where Cell: UICollectionViewCell, Cell: Reusable {
    register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
}


/**
 Registers a supplementary view of the specified type and kind.

 - parameter viewType: The type of supplementary view to register.
 - parameter kind: The kind of supplementary view to register (e.g., "header", "footer", etc.).

 - Complexity: O(1)
 */
func registerSupplementaryView<View>(_ viewType: View.Type, kind: String) where View: UICollectionReusableView, View: Reusable {
    register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewType.reuseIdentifier)
}


/**
 Dequeues a reusable cell instance with the given type and forIndexPath.

 - parameter cellType: The type of the cell to dequeue.
 - parameter indexPath: The IndexPath where the cell was dequeued from.
 
 - returns: The dequeued cell, or nil if there is no registered cell that matches the requested type.
 */
func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell, Cell: Reusable {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
        fatalError("Cell class \(cellType.reuseIdentifier) is not registered in \(description)")
    }
}


/**
 Finishes the flow.

- Parameter onFinished: The closure to call when the flow is finished.
*/


/**
 Finishes the flow.

- parameter result: The result of the flow.
*/
func finishFlow(result: CompletionResult) {
    onFinished?(result)
}


/**
 Deletes the account.

- Throws: An error if the deletion fails.
*/
public func deleteAccount() async throws {
    try await client.deleteAccount()
}


/**
 Deletes an account.

 - Returns: An empty value.
 - Throws: Any error that occurs during the request.
 */
func deleteAccount() async throws {
    return try await performRequest(endpoint: .delete)
}


/**
 Returns a `SNBUserServiceClientProtocol` instance.

 - returns: A `SNBUserServiceClientProtocol` instance.
 */
func makeClient() -> SNBUserServiceClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Refreshes transactions.

- Throws: An error if the transaction refresh fails.
*/
func refreshTransactions() async throws {
    try await client.refreshTransactions()
}


/**
 Creates a client instance.

 - returns: A `SNBTransactionRefreshServiceClientProtocol` object.
 */
func makeClient() -> SNBTransactionRefreshServiceClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
Refreshes transactions.

- Returns: The result of the request.
- Throws: An error if the request fails.
*/
func refreshTransactions() async throws {
    return try await performRequest(endpoint: .refresh)
}


/**
 Fetches the count from the client and returns it as a string. If the count is 0, returns nil.

- returns: The count as a string, or nil if the count is 0.
*/
func getCount() async throws -> String? {
    let response = try await client.fetchRequestCount()
    return response.count == "0" ? nil : response.count
}


/**
 Fetches the request count.

- returns: `RequestMoneyCountResponseDTO` The response from the API.
- throws: An error if something goes wrong with the network request or parsing the response.
*/
func fetchRequestCount() async throws -> RequestMoneyCountResponseDTO {
    return try await performRequest(endpoint: Endpoint.count(status: "PENDING"))
}


/**
Makes a client.

- returns: A `RequestMoneyServiceClientProtocol` instance.
*/
func makeClient() -> RequestMoneyServiceClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/// Pushes tokens.
///
/// - Throws: Error if there is an issue pushing the tokens.
func pushTokens() async throws {
    try await client.pushTokens()
}


/**
Pushes tokens.

- Throws: An error if the device ID or Firebase token is missing.
*/
func pushTokens() async throws {
    guard let deviceId = JWTProvider.deviceId,
          let firebaseToken else {
        return
    }
}


/**
Creates a client for device management.

- returns: A `DeviceManagementServiceClientProtocol` instance.
*/
func makeClient() -> DeviceManagementServiceClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Fetches the public key from the client and encrypts the given value with it.

 - parameter value: The value to be encrypted.
 - returns: The encrypted value, or nil if an error occurs.
 */
func getEncrypted(of value: String) async throws -> String? {
    do {
        let response = try await client.fetchPublicKey()
        return value.encrypt(with: response.publicKey)
    }
}


/**
 Creates a new instance of `SNBCryptoServiceClientProtocol`.

 - returns: A new instance of `SNBCryptoServiceClientProtocol`.
 */
func makeClient() -> SNBCryptoServiceClientProtocol {
    guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Fetches the public key.

- returns: `SNBCryptoServicePublicKeyResponseDTO` if successful, or an error if something went wrong.
*/
public func fetchPublicKey() async throws -> SNBCryptoServicePublicKeyResponseDTO {
    return try await performRequest(endpoint: Endpoint.publicKey)
}


/**
 Returns a `SNBLifeStyleMoreResponseDTO` representing the items info, or `nil` if an error occurred.

 - returns: `SNBLifeStyleMoreResponseDTO?` - The items info.
 */
func getItemsInfo() async throws -> SNBLifeStyleMoreResponseDTO? {
    let response = try await client.fetchItemsInfo()
    return response
}


/**
 Returns a `SNBLifeStyleMoreServiceClientProtocol` instance.

 - returns: A configured client object.
 */
func makeClient() -> SNBLifeStyleMoreServiceClientProtocol {
    guard let baseUrl = Backbase.configuration().custom["lifestyleBaseUrl"] as? String, let serverURL = URL(string: baseUrl) else {
        fatalError("Invalid or no serverURL found in the SDK configuration.")
    }
}


/**
 Fetches the items info.

- Returns: `SNBLifeStyleMoreResponseDTO` that represents the fetched items info.
- Throws: Any error that occurs during the request.
*/
func fetchItemsInfo() async throws -> SNBLifeStyleMoreResponseDTO {
    return try await performRequest(endpoint: Endpoint.info(status: "PENDING"))
}


/**
 Creates a `GenericErrorScreenViewController` instance with the given context and configuration.

 - parameter context: The context to use for creating the view controller.
 - returns: A newly created `GenericErrorScreenViewController` instance.
 */
func makeUIViewController(context: Context) -> GenericErrorScreenViewController {
    let viewModel = GenericErrorScreenViewModel(configuration: configuration)
    let viewController = GenericErrorScreenViewController(viewModel: viewModel, configuration: configuration)
    viewModel.viewController = viewController
    return viewController
}


/**
 Updates the UI view controller.

 - parameter uiViewController: The `GenericErrorScreenViewController` to update.
 - parameter context: The context in which the update is being performed.
 */
func updateUIViewController(_ uiViewController: GenericErrorScreenViewController, context: Context) {}


/**
 Returns the preferred font for the given text style and weight.

 - parameter style: The text style to determine the preferred font for.
 - parameter weight: The font weight to determine the preferred font for.
 - returns: The preferred font for the given text style and weight.
 */
func preferredFont(_ style: UIFont.TextStyle, _ weight: UIFont.Weight) -> Font {
    DesignSystem.shared.fonts.preferredFont(style, weight).font
}



}

// --- End of: /Users/divinedube/Developer/Work/ios-snb-dv-neo/SNBCommon/Sources/SwiftUI/SwiftUI+UIKit+Conversion.swift ---
