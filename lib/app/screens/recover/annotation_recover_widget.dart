import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:minhas_anotacoes/app/controller/home_controller.dart';
import 'package:minhas_anotacoes/app/model/annotation_model.dart';
import 'package:minhas_anotacoes/app/widget/animation/fancy_fab_widget.dart';
import 'package:minhas_anotacoes/app/screens/recover/widget/update_display_widget.dart';

class AnnotationRecover extends StatefulWidget {
  @override
  _AnnotationRecoverState createState() => _AnnotationRecoverState();
}

class _AnnotationRecoverState extends State<AnnotationRecover> {
  HomeProvider homeProvider = HomeProvider();
  UpadateDisplayWidget upadateDisplayWidget = UpadateDisplayWidget();

  List<AnnotationModel> annotations = <AnnotationModel>[];

  @override
  void initState() {
    super.initState();
    _recoverAnnotation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: annotations.length == 0
                ? Center(
                    child: Text('Nenhuma tarefa'),
                  )
                : ListView.builder(
                    itemCount: annotations.length,
                    itemBuilder: (context, index) {
                      final annotation = annotations[index];
                      return Card(
                        child: ListTile(
                          title: Text(annotation.title!),
                          subtitle: Text(
                            "${_formatDate(annotation.date!)} - ${annotation.description}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => UpadateDisplayWidget(
                                      annotation: annotation,
                                    ),
                                  );
                                  _recoverAnnotation();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: RichText(
                                        text: TextSpan(
                                          text:
                                              "Deseja excluir a anotação com o título: ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: " ${annotation.title}?",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              side: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Cancelar',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              side: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                          onPressed: () {
                                            homeProvider.removeAnnotation(
                                                annotation.id!);
                                            _recoverAnnotation();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FancyFab(
        onPressed: () async {
          await showDialog(
              context: context, builder: (_) => UpadateDisplayWidget());
          _recoverAnnotation();
        },
      ),
    );
  }

  _recoverAnnotation() async {
    List<AnnotationModel>? listTemp = <AnnotationModel>[];
    listTemp = await homeProvider.recoverAnnotation();
    setState(() {
      annotations = listTemp!;
    });
    listTemp = null;
  }

  _formatDate(String date) {
    initializeDateFormatting('pt_BR');
    var formatte = DateFormat.yMd("pt_BR");
    DateTime convertedDate = DateTime.parse(date);
    String formattedDate = formatte.format(convertedDate);
    return formattedDate;
  }
}
