class GetOffersParams {
  final List<String> offerTypeIds;

  GetOffersParams(this.offerTypeIds);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    for (final id in offerTypeIds) {
      map[id] = true;
    }
    return map;
  }
}
