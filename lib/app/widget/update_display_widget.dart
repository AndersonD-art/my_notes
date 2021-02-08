import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/app/controller/home_controller.dart';
import 'package:minhas_anotacoes/app/model/annotation_model.dart';

class UpadateDisplayWidget extends StatelessWidget {
  final HomeProvider homeProvider = HomeProvider();

  final AnnotationModel annotation;

  UpadateDisplayWidget({Key key, this.annotation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textUpSave = _displayRegistrationScreen(annotation: annotation);
    return Container(
      child: SingleChildScrollView(
        reverse: true,
        child: AlertDialog(
          title: Text('$textUpSave anotação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: homeProvider.titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Título',
                  hintText: 'Digite o título...',
                ),
              ),
              TextField(
                controller: homeProvider.descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição...',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: -10.0),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: -30.0),
              ),
              onPressed: () {
                homeProvider.saveUpdateAnnotation(
                    annotationSelected: annotation);

                Navigator.pop(context);
              },
              child: Text(textUpSave),
            ),
          ],
        ),
      ),
    );
  }

  _displayRegistrationScreen({AnnotationModel annotation}) {
    String textSaveUpadate = "";
    if (annotation == null) {
      homeProvider.titleController.text = "";
      homeProvider.descriptionController.text = "";
      textSaveUpadate = "Salvar";
    } else {
      homeProvider.titleController.text = annotation.title;
      homeProvider.descriptionController.text = annotation.description;
      textSaveUpadate = "Atualizar";
    }
    return textSaveUpadate;
  }
}
