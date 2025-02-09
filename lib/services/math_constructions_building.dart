// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

enum ElementsType {
  fracElement,
  sqrtElement,
  fieldElement,
  exponentiationElement,
  naturalLogElement,
  decimalLogElement,
  logBaseTwoElement,
  logElement,
  absElement,
  limitElement,
  cosElement,
  sinElement,
  tanElement,
  cotElement,
  arcsinElement,
  arccosElement,
  arctanElement,
  arccotElement,
  indefiniteIntegralElement,
  integralElement,
  derevativeElement,
  backetsWidget,
}

class MathConstructionsBuilding {
  final TextFieldHandleAndCreateService textFieldService;

  MathConstructionsBuilding({required this.textFieldService});
  MathConstructionData createTextField({bool replaceOldFocus = false, bool? standartSize}) {
    late final Widget textField;  
    if(standartSize == null){
      textField = textFieldService.createTextField(
        isReplaceOperation: replaceOldFocus, 
        isActiveTextField: true,
      );
    } else { 
      textField = textFieldService.createTextField(
        isReplaceOperation: replaceOldFocus, 
        isActiveTextField: true,
        selectedTextFieldFormat: standartSize ? TextFieldFormat.standart : TextFieldFormat.small
      );
    }
    return MathConstructionData(construction: textField);
  }

  MathConstructionData createFracWidget() {
    final upperField = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final downField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: true);
    textFieldService.markAsGrop(upperField, downField);
    final upperGlobalKey = GlobalKey();
    final downGlobalKey = GlobalKey();
    final fracWidget = SizedBox(
      child: Row(
        children: [
          const SizedBox(width: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            key: const ValueKey(ElementsType.fracElement),
            children: [
              SizedBox(
                child: Row(
                  key: upperGlobalKey,
                  children: [upperField],
                ),
              ),
              FracDividerWidget(
                upperGlobalKey: upperGlobalKey,
                downGlobalKey: downGlobalKey,
              ),
              SizedBox(
                child: Row(
                  key: downGlobalKey,
                  children: [downField],
                ),
              )
            ],
          ),
          const SizedBox(width: 5,),
        ],
      ),
    );
    return MathConstructionData(construction: fracWidget);
  }

  MathConstructionData createExpWidget(Widget baseWidget, TextFieldData baseFieldData) {
    final expGlobalKey = GlobalKey();
    final baseGlobalKey = GlobalKey();
    final textField = textFieldService.createTextField(
      isReplaceOperation: false,
      isActiveTextField: true,
      selectedTextFieldFormat: TextFieldFormat.small);
    textFieldService.markAsGrop(baseFieldData, textField);
    final widget = ExpRowWidget(
      baseWidget: baseWidget,
      expGlobalKey: expGlobalKey,
      textField: textField,
      baseGlobalKey: baseGlobalKey,
    );
    return MathConstructionData(construction: widget);
  }

  Widget createCharWidget({required bool isActiveTextField}) {
    final textFieldWidget = textFieldService.createTextField(
        isActiveTextField: isActiveTextField, isReplaceOperation: false);
    return textFieldWidget;
  }

  MathConstructionData createSqrtWidget() {
    final globalKey = GlobalKey();
    final textFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final adictionalField =
        textFieldService.createTextField(isReplaceOperation: false);
    final sqrtWidget = SizedBox(
      key: const ValueKey(ElementsType.sqrtElement),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            key: globalKey,
            top: 5,
            left: 25,
            child: Row(
              children: [
                textFieldWidget,
              ],
            ),
          ),
          IgnorePointer(
            child: _SqrtCustomPaint(
              globalKey: globalKey,
            ),
          ),
        ],
      ),
    );
    return MathConstructionData(construction: sqrtWidget, addictionalWidget: adictionalField);
  }

  MathConstructionData createLogWidget() {
    final argField =
        textFieldService.createTextField(isReplaceOperation: false);
    final baseField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        selectedTextFieldFormat: TextFieldFormat.small);
    textFieldService.markAsGrop(baseField, argField);
    final logWidget = SizedBox(
      key: const ValueKey(ElementsType.logElement),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const SizedBox(
              height: 50,
              child:
                  Center(child: Text('log', style: TextStyle(fontSize: 25)))),
          Positioned(
              left: 40,
              child: Row(
                children: [
                  argField,
                ],
              )),
          Positioned(
              bottom: -5,
              left: 30,
              child: Row(
                children: [
                  baseField,
                ],
              )),
        ],
      ),
    );
    return MathConstructionData(construction: logWidget);
  }

  MathConstructionData createLimitWidget() {
    final argField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: true);
    final firstDownField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        selectedTextFieldFormat: TextFieldFormat.small);
    final secondDownField = textFieldService.createTextField(
        isReplaceOperation: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final globalKey = GlobalKey();
    final limitWidget = LimStackWidget(
      key: const ValueKey(ElementsType.limitElement),
      argField: argField,
      firstDownField: firstDownField,
      secondDownField: secondDownField,
      globalKey: globalKey,
    );
    return MathConstructionData(construction: limitWidget);
  }

  MathConstructionData createNamedFunctionWidget(String functionName, ElementsType type) {
    final textFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: true);
    final widget = SizedBox(
      key: ValueKey(type),
      child: Row(
        children: [
          Text(
            functionName,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(
            width: 3,
          ),
          textFieldWidget,
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
    return MathConstructionData(construction: widget);
  }

  MathConstructionData createAbsWidget() {
    final textFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: false);
    final adictionalField =
        textFieldService.createTextField(isReplaceOperation: false);

    final globalKey = GlobalKey();
    final absWidget = SizedBox(
      key: const ValueKey(ElementsType.absElement),
      child: Row(
        key: globalKey,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: AbsLineWidget(
              globalKey: globalKey,
            ),
          ),
          Row(
            children: [
              textFieldWidget,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: AbsLineWidget(
              globalKey: globalKey,
            ),
          ),
        ],
      ),
    );
    return MathConstructionData(construction: absWidget, addictionalWidget: adictionalField);
  }

  MathConstructionData createBracketsWidget() {
    final textFieldWidget = textFieldService.createTextField(
      isReplaceOperation: true,
      isActiveTextField: true,
    );
    final adictionalField = textFieldService.createTextField(
      isReplaceOperation: false,
    );
    final backetsWidget = BacketsWidget(textFieldWidget: textFieldWidget);
    return MathConstructionData(construction: backetsWidget, addictionalWidget: adictionalField);
  }

  MathConstructionData createUndefinitIntegralWidget() {
    final argFieldWidget = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final addictionalField = textFieldService.createTextField(
      isReplaceOperation: false,
    );
    final derevativeField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: false);
    textFieldService.markAsGrop(argFieldWidget, derevativeField); 
    final integralWidget = Row(
      key: const ValueKey(ElementsType.indefiniteIntegralElement),
      children: [
        const Text(
          '∫',
          style: TextStyle(fontSize: 25),
        ),
        Row(
          children: [argFieldWidget],
        ),
        const Text(
          'd',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          children: [
            derevativeField,
          ],
        ),
      ],
    );
    return MathConstructionData(construction: integralWidget, addictionalWidget: addictionalField);
  }

  MathConstructionData createDerevativeWidget(String? upperFieldText, String? downFieldText) {
    final upperField = textFieldService.createTextField(
        isReplaceOperation: true, isActiveTextField: true);
    final downField = textFieldService.createTextField(
        isReplaceOperation: false, performAdictionalTextField: true);
    if (upperFieldText != null && downFieldText != null) {
      upperField as SizedBox;
      (upperField.child as TextFieldWidgetHandler).initTextInField =
          upperFieldText;
      downField as SizedBox;
      (downField.child as TextFieldWidgetHandler).initTextInField =
          downFieldText;
    }
    textFieldService.markAsGrop(upperField, downField);
    final derevativeWidget = SizedBox(
      key: const ValueKey(ElementsType.derevativeElement),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              children: [
                const Text('d', style: TextStyle(fontSize: 20)),
                upperField
              ],
            ),
          ),
          const SizedBox(width: 25, child: Divider(color: Colors.black)),
          SizedBox(
            child: Row(
              children: [
                const Text(
                  'd',
                  style: TextStyle(fontSize: 20),
                ),
                downField,
              ],
            ),
          ),
        ],
      ),
    );
    return MathConstructionData(construction: derevativeWidget);
  }

  MathConstructionData createIntegralWidget() {
    final startPointField = textFieldService.createTextField(
        isReplaceOperation: true,
        isActiveTextField: true,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final derevativeField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: true,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final argFieldWidget = textFieldService.createTextField(
        isReplaceOperation: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    final finishPointField = textFieldService.createTextField(
        isReplaceOperation: false,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.small);
    final globalKey = GlobalKey();

    textFieldService.markAsGrop(startPointField, derevativeField);
    final integralWidget = IntegralWidget(
        key: ValueKey(ElementsType.integralElement),
        startPointField: startPointField,
        finishPointField: finishPointField,
        argFieldWidget: argFieldWidget,
        derevativeField: derevativeField,
        globalKey: globalKey);
    return MathConstructionData(construction: integralWidget);
  }

  Widget initialization() {
    final textField = textFieldService.createTextField(
        isReplaceOperation: false,
        isActiveTextField: true,
        performAdictionalTextField: false,
        selectedTextFieldFormat: TextFieldFormat.standart);
    return textField;
  }
}

class LimStackWidget extends StatefulWidget {
  LimStackWidget({
    super.key,
    required this.argField,
    required this.firstDownField,
    required this.secondDownField,
    required this.globalKey,
  });

  final Widget argField;
  final Widget firstDownField;
  final Widget secondDownField;
  final GlobalKey globalKey;
  Widget? child;

  @override
  State<LimStackWidget> createState() => _LimStackWidgetState();
}

class _LimStackWidgetState extends State<LimStackWidget> {
  Size? size;
  getSize() {
    final renderBox = widget.globalKey.currentContext?.findRenderObject();
    if (renderBox is RenderBox) {
      if (size == null || size != renderBox.size) {
        size = renderBox.size;
        // pi
        setState(() {});
      }
    }
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    widget.child ??= Stack(
      clipBehavior: Clip.none,
      // alignment: Alignment.centerLeft,
      children: [
        const Positioned(
          left: 0,
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'lim',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
        Positioned(
          key: widget.globalKey,
          left: 45,
          child: Row(
            children: [
              widget.argField,
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          left: 0,
          child: Row(
            children: [widget.firstDownField],
          ),
        ),
        const Positioned(
            bottom: -20, left: 20, child: Icon(Icons.arrow_forward_outlined)),
        Positioned(
          bottom: -20,
          left: 40,
          child: Row(
            children: [widget.secondDownField],
          ),
        ),
      ],
    );
    return SizedBox(
      width: 70 + (size?.width ?? 0),
      height: size?.height ?? 50,
      child: widget.child,
    );
  }
}

class IntegralWidget extends StatefulWidget {
  IntegralWidget({
    super.key,
    required this.startPointField,
    required this.finishPointField,
    required this.argFieldWidget,
    required this.derevativeField,
    required this.globalKey,
  });

  final Widget startPointField;
  final Widget finishPointField;
  final Widget argFieldWidget;
  final Widget derevativeField;
  final GlobalKey globalKey;
  Widget? child;
  @override
  State<IntegralWidget> createState() => _IntegralWidgetState();
}

class _IntegralWidgetState extends State<IntegralWidget> {
  Size? size;

  void getSize(List<FrameTiming> frameTiming) {
    if (widget.globalKey.currentContext != null) {
      final renderBox =
          widget.globalKey.currentContext?.findRenderObject() as RenderBox;
      if (size == null || size!.width != renderBox.size.width) {
        size = Size(renderBox.size.width + 70, renderBox.size.height);
        setState(() {});
      }
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  // }
  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final Stack stack;
    if (widget.child != null) {
      final box = widget.child as SizedBox;
      stack = box.child as Stack;
    } else {
      stack = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const Positioned(
            left: 0,
            child: Center(
                child: Text(
              '∫',
              style: TextStyle(fontSize: 30),
            )),
          ),
          Positioned(bottom: 0, left: 5, child: widget.startPointField),
          Positioned(top: 0, left: 10, child: widget.finishPointField),
          Positioned(
              key: widget.globalKey,
              left: 30,
              child: ArgumentWidget(argumentWidget: widget.argFieldWidget)),
          const Positioned(
            right: 30,
            child: Text(
              'd',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Positioned(right: 10, child: widget.derevativeField),
        ],
      );
    }

    final child = SizedBox(
      width: size?.width ?? 150,
      height: 60,
      child: stack,
    );
    widget.child = child;
    return child;
  }
}

class ArgumentWidget extends StatefulWidget {
  ArgumentWidget({super.key, required this.argumentWidget});
  final Widget argumentWidget;
  Widget? child;
  @override
  State<ArgumentWidget> createState() => _ArgumentWidgetState();
}

class _ArgumentWidgetState extends State<ArgumentWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return widget.child!;
    }
    widget.child = Row(
      children: [
        widget.argumentWidget,
      ],
    );
    return widget.child!;
  }
}

class BacketsWidget extends StatefulWidget {
  BacketsWidget({
    key = const ValueKey(ElementsType.backetsWidget),
    required this.textFieldWidget,
  }) : super(key: key);
  final Widget textFieldWidget;
  Widget? child;

  @override
  State<BacketsWidget> createState() => _BacketsWidgetState();
}

class _BacketsWidgetState extends State<BacketsWidget> {
  @override
  Widget build(BuildContext context) {
    widget.child ??= Row(
        children: [
          widget.textFieldWidget,
        ],
      );
    return Row(
      children: [
        const Text('(',style: TextStyle(fontSize: 20),),
        widget.child!,
        const Text(')',style: TextStyle(fontSize: 20),)
      ],
    );
  }
}

class AbsLineWidget extends StatefulWidget {
  const AbsLineWidget({super.key, required this.globalKey});
  final GlobalKey globalKey;

  @override
  State<AbsLineWidget> createState() => _AbsLineWidgetState();
}

class _AbsLineWidgetState extends State<AbsLineWidget> {
  Size? size;
  getSize() {
    if (widget.globalKey.currentContext != null) {
      final rendexBox =
          widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      size = rendexBox.size;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPersistentFrameCallback((_) => getSize());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 2,
      height: size?.height ?? 50,
    );
  }
}

class _SqrtCustomPaint extends StatefulWidget {
  const _SqrtCustomPaint({
    required this.globalKey,
  });
  final GlobalKey globalKey;

  @override
  State<_SqrtCustomPaint> createState() => _SqrtCustomPaintState();
}

class _SqrtCustomPaintState extends State<_SqrtCustomPaint> {
  Size? size;
  _SqrtCustomPaintState();
  void getSize(List<FrameTiming> frameTiming) {
    final renderBox =
        widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    if (size == null || (size != null && size != renderBox.size)) {
      size = renderBox.size;
      setState(() {});
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  // }
  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size((size?.width ?? 80) + 30, 50), painter: _SqrtPainter());
  }
}

class _SqrtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(10, size.height)
      ..lineTo(20, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// ignore: must_be_immutable
class ExpRowWidget extends StatefulWidget {
  ExpRowWidget(
      {super.key,
      required this.baseWidget,
      required this.expGlobalKey,
      this.child,
      required this.textField, required this.baseGlobalKey});
  final Widget baseWidget;
  final GlobalKey expGlobalKey;
  final GlobalKey baseGlobalKey;
  Widget? child;
  final Widget textField;

  @override
  State<ExpRowWidget> createState() => _ExpRowWidgetState();
}

class _ExpRowWidgetState extends State<ExpRowWidget> {
  Size size = const Size(120, 60);
  void getSize(List<FrameTiming> frameTiming) {
    final expRenderBox =
        widget.expGlobalKey.currentContext?.findRenderObject() as RenderBox;
    final baseRenderBox =
        widget.baseGlobalKey.currentContext?.findRenderObject() as RenderBox;
    late final double newHeight; 
    late final double newWidth; 
    if(expRenderBox.size.height > baseRenderBox.size.height){
      newHeight = expRenderBox.size.height + 15; 
    }else{ 
      newHeight = baseRenderBox.size.height + 15; 
    }
    if(expRenderBox.size.width > baseRenderBox.size.width){
      newWidth = expRenderBox.size.width + 25; 
    }else{ 
      newWidth = baseRenderBox.size.width + 20; 
    }
    if (size != Size(newWidth,newHeight) ) {
      // print('adadadadadadada');
      size = Size(newWidth,newHeight);
      setState(() {});
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  // }
  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget firstPositioned = Positioned(
        key: widget.baseGlobalKey,
        left: 0,
        bottom: 0,
        child: Row(
          children: [
            widget.baseWidget,
          ],
        ));
    Widget secondPositioned = Positioned(
        key: widget.expGlobalKey,
        top: -5,
        right: 0,
        child: Row(
          key: const ValueKey(ElementsType.exponentiationElement),
          children: [
            SizedBox(height: 30, child: widget.textField),
          ],
        ));
    if (widget.child != null) {
      // final row = widget.child as Row;
      final sizedBox = widget.child as SizedBox;
      final stack = sizedBox.child! as Stack;
      firstPositioned = stack.children[0];
      secondPositioned = stack.children[1];
    }
    final child = SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          firstPositioned,
          secondPositioned,
        ],
      ),
    );
    widget.child = child;
    return child;
  }
}

class FracDividerWidget extends StatefulWidget {
  const FracDividerWidget({
    super.key,
    required this.upperGlobalKey,
    required this.downGlobalKey,
  });
  final GlobalKey upperGlobalKey;
  final GlobalKey downGlobalKey;

  @override
  State<FracDividerWidget> createState() => _FracDividerWidgetState();
}

class _FracDividerWidgetState extends State<FracDividerWidget> {
  Size? size;
  final trimingCallBack = TimingsCallback;

  void getSize(List<FrameTiming> timings) {
    final upperRenderBox =
        widget.upperGlobalKey.currentContext?.findRenderObject() as RenderBox;
    final downRenderBox =
        widget.downGlobalKey.currentContext?.findRenderObject() as RenderBox;
    if (upperRenderBox.size.width > downRenderBox.size.width) {
      size = upperRenderBox.size;
    } else {
      size = downRenderBox.size;
    }
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(getSize);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addTimingsCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width ?? 50,
      child: const Divider(
        color: Colors.black,
      ),
    );
  }
}

class MathConstructionData {
  final Widget? addictionalWidget;
  final Widget construction;

  MathConstructionData({required this.construction, this.addictionalWidget});
}