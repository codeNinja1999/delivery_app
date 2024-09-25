class CatalogFilter {
  final String? id;
  final String? page;
  final String? pageSize;
  final String? price;
  final String? serviceName;
  final String? country;
  final String? city;
  final String? neighborhood;
  final int? postalCode;
  final String? language;

  CatalogFilter({
    this.id,
    this.page,
    this.pageSize,
    this.price,
    this.serviceName,
    this.city,
    this.country,
    this.language,
    this.postalCode,
    this.neighborhood,
  });
}
