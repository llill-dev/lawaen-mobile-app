class GetOffersParams {
  final List<String> offerTypeIds;
  final int page;
  final int limit;

  GetOffersParams({required this.offerTypeIds, required this.page, required this.limit});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    for (final id in offerTypeIds) {
      map[id] = true;
    }
    map['page'] = page;
    map['limit'] = limit;

    return map;
  }
}
