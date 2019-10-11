class Paginated<M> {
  int page;

  int numPerPage;

  int totalPages;

  List<M> items;

  Paginated({
    this.page,
    this.numPerPage,
    this.totalPages,
    this.items,
  });
}
