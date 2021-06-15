import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/app/model/annotation_model.dart';
import 'package:minhas_anotacoes/app/repository/annotation_repository.dart';

var _db = AnnotationRepository();

class HomeController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  recoverAnnotation() async {
    List annotationRecover = await _db.toRecoverAnnotation();

    List<AnnotationModel> listTemp = <AnnotationModel>[];
    for (var item in annotationRecover) {
      AnnotationModel annotation = AnnotationModel.fromMap(item);
      listTemp.add(annotation);
    }

    return listTemp;
  }

  saveUpdateAnnotation({AnnotationModel? annotationSelected}) async {
    String title = titleController.text;
    String description = descriptionController.text;
    AnnotationModel annotation = AnnotationModel(
        title: title,
        description: description,
        date: DateTime.now().toString());
    if (annotationSelected == null) {
      await _db.saveAnnotation(annotation);
    } else {
      AnnotationModel annotationUpdate = AnnotationModel(
          title: title,
          id: annotationSelected.id,
          description: description,
          date: DateTime.now().toString());
      await _db.updateAnnotation(annotationUpdate);
    }

    titleController.clear();
    descriptionController.clear();
  }

  removeAnnotation(int id) async {
    await _db.removeAnnotation(id);
  }
}
