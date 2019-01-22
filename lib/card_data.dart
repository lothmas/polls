final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath: 'images/createVoteBack1.jpg',
    pageNumber: 1
  ),
  new CardViewModel(
      backdropAssetPath: 'images/createVoteBack2.jpg',
    pageNumber: 2
  ),
  new CardViewModel(
      backdropAssetPath: 'images/createVoteBack2.jpg',
    pageNumber: 3
  ),
];

class CardViewModel {
  final String backdropAssetPath;
  final int pageNumber;

  CardViewModel({
    this.backdropAssetPath,
    this.pageNumber
  });
}
