import 'package:flutter/material.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

enum ElementsType{fracElement,sqrtElement,fieldElement,exponentiationElement}

class MathConstructionsBuilding{
  final TextFieldHandleAndCreateService textFiledService;
  
  MathConstructionsBuilding({required this.textFiledService}); 
  void createTextField(){
    final textField = textFiledService.createTextField(1,true);

  }

  Widget createFracWidget(){    
    final textFiledWidgets = textFiledService.createTextField(2,true);
    final globalKey = GlobalKey(); 
    final fracWidget = Column(
      key: const ValueKey(ElementsType.fracElement),
      children: [
        SizedBox(
          child: Row(
            key: globalKey,
            children: [
              textFiledWidgets[0]
            ],
          ),
        ),
        FracDividerWidget(globalKey: globalKey,),
        SizedBox(
          child: Row(
            children: [
             textFiledWidgets[1]
            ],
          ),
        )
      ],
    );
    return fracWidget; 
  }

  Widget initialization(){
    final textField = textFiledService.createTextField(1,true);
    return textField.first; 
  }
  
}

class FracDividerWidget extends StatefulWidget {
  const FracDividerWidget({Key? key, required this.globalKey}) : super(key: key);
  final GlobalKey globalKey; 

  @override
  State<FracDividerWidget> createState() => _FracDividerWidgetState();
}

class _FracDividerWidgetState extends State<FracDividerWidget> {
  Size? size; 
  getSize(){
    final renderBox = widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    size = renderBox.size; 
    setState(() {
      
    });   
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_)=> getSize()); 
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size?.width ?? 50 ,child: const Divider(color: Colors.black,),);
  }
}