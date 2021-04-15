import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/app/controller/home_controller.dart';
import 'package:minhas_anotacoes/app/screens/construction_screens.dart';
import 'package:minhas_anotacoes/app/widget/annotation_recover_widget.dart';
import 'animation/circular_button_widget.dart';
import 'animation/degree_to_radians_widget.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  const FancyFab({
    Key key,
    this.onPressed,
    this.tooltip,
    this.icon,
  }) : super(key: key);
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 50.0;
  Animation rotationAnimation;
  Animation<double> _animation1;
  Animation<double> _animation2;
  Animation<double> _animation3;
  Animation<double> _animation4;
  HomeProvider homeProvider = HomeProvider();
  AnnotationRecover annotationRecover = AnnotationRecover();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.75,
          curve: _curve,
        ),
      ),
    );
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animation1 = new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );
    _animation2 = new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(0.5, 1.0, curve: Curves.linear),
    );

    _animation3 = new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(0.8, 1.0, curve: Curves.linear),
    );
    _animation4 = new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(1.0, 1.0, curve: Curves.linear),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget image() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(right: 1.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ScaleTransition(
            scale: _animation3,
            alignment: FractionalOffset.center,
            child: Container(
              child: Text(
                'Imagem',
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Roboto',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: FloatingActionButton(
              heroTag: 'btnImage',
              backgroundColor: Colors.grey[200],
              onPressed: () {
                animate();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConstructionScreen(
                      title: 'Imagem',
                    ),
                  ),
                );
              },
              tooltip: 'Image',
              child: Icon(
                Icons.add_a_photo,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget voice() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 12.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ScaleTransition(
            scale: _animation2,
            alignment: FractionalOffset.center,
            child: Container(
              child: Text(
                'Audio',
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Roboto',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: FloatingActionButton(
              heroTag: 'btnVoice',
              backgroundColor: Colors.grey[200],
              onPressed: () {
                animate();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConstructionScreen(
                      title: 'Audio',
                    ),
                  ),
                );
              },
              tooltip: 'Audio',
              child: Icon(
                Icons.keyboard_voice,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget add() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(right: 7.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ScaleTransition(
            scale: _animation1,
            alignment: FractionalOffset.center,
            child: Container(
              child: Text(
                'Anotação',
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Roboto',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: FloatingActionButton(
              heroTag: 'btnAdd',
              backgroundColor: Colors.grey[200],
              onPressed: () async {
                animate();
                await Future.delayed(Duration(milliseconds: 100));
                widget.onPressed();
              },
              tooltip: 'Add',
              child: Icon(
                Icons.add_outlined,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toggle() {
    return Container(
      margin: EdgeInsets.only(left: 50.0),
      child: Transform(
        transform:
            Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
        alignment: Alignment.center,
        child: CircularButton(
          color: Colors.purple,
          width: 56,
          height: 56,
          icon: Icon(
            _animationController.isCompleted ? Icons.close : Icons.add,
            color: Colors.white,
          ),
          onClick: () => animate(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var background = ScaleTransition(
      scale: _animation4,
      alignment: FractionalOffset.bottomLeft,
      child: GestureDetector(
        onTap: () {
          animate();
        },
        child: OverflowBox(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Container(
            color: Colors.black38,
            width: MediaQuery.of(context).size.width * 2,
            height: MediaQuery.of(context).size.height * 2,
          ),
        ),
      ),
    );
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        background,
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 3.0,
                0.0,
              ),
              child: image(),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 2.0,
                0.0,
              ),
              child: voice(),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value,
                0.0,
              ),
              child: add(),
            ),
            toggle(),
          ],
        ),
      ],
    );
  }
}
