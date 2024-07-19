part of 'id_selection_bloc.dart';

abstract class IdSelectionEvent {}

class GetIdCatalog extends IdSelectionEvent {}

class IdDocumentSubscription extends IdSelectionEvent {}

class DocumentTypeChanged extends IdSelectionEvent {
  final Catalog documentType;
  DocumentTypeChanged(this.documentType);
}
