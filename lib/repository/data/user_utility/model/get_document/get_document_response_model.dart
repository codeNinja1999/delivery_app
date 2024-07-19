class GetDocumentResponseModel {
  GetDocumentResponseModel({
    this.documentImageList,
  });

  final DocumentImageListModel? documentImageList;

  factory GetDocumentResponseModel.fromJson(Map<String, dynamic> json) =>
      GetDocumentResponseModel(
        documentImageList: DocumentImageListModel.fromJson(json["imgUrlList"]),
      );
}

class DocumentImageListModel {
  DocumentImageListModel({
    this.front,
    this.back,
    this.selfie,
  });

  final String? front;
  final String? back;
  final String? selfie;

  factory DocumentImageListModel.fromJson(Map<String, dynamic> json) =>
      DocumentImageListModel(
        front: json["FRONT"],
        back: json["BACK"],
        selfie: json["SELFIE"],
      );
}
