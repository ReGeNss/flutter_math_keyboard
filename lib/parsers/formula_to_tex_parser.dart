import 'package:flutter/material.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class FormulaToTexParser {
  String formulaInTeX = '';
  String start(List<Widget> widgetList) {
    formulaInTeX = '';
    _formulaParser(widgetList);
    print(formulaInTeX);
    return formulaInTeX;
  }

  String? _formulaParser(List<Widget> widgetList) {
    for (final element in widgetList) {
      switch (element.runtimeType) {
        case const (Row):
          {
            element as Row;
            if (element.key != null &&
                element.key.runtimeType != LabeledGlobalKey<State<StatefulWidget>>) {
              final keyValue = (element.key as ValueKey).value;
              switch (keyValue) {
                case (ElementsType.exponentiationElement):
                  {
                    return addToTeXData(
                        widgets: element.children,
                        parseFunctionByChildren: expParser);
                  }
                case (ElementsType.indefiniteIntegralElement):
                  {
                    addToTeXData(
                        widgets: element.children,
                        parseFunctionByChildren: undefinitIntegralParser);
                  }
              }
            } else {
              final intermediateTeXData = formulaInTeX;
              formulaInTeX = '';
              _formulaParser(element.children);
              formulaInTeX = intermediateTeXData + formulaInTeX;
              return formulaInTeX;
            }
            break;
          }
        case const (Column):
          {
            element as Column;
            if (element.key != null) {
              final key = element.key as ValueKey;
              if (key.value == ElementsType.fracElement) {
                final fracString = fracParser(element.children);
                formulaInTeX = formulaInTeX + fracString;
                // return formulaInTeX;
              } 
            }

            break;
          }
        case const (Stack):
          {
            element as Stack;
            if (element.key != null) {
              final key = element.key as ValueKey;
              switch (key.value) {
              }
            } else {
              if (element.children.isNotEmpty) {
                _formulaParser(element.children);
                return formulaInTeX ;
              }
            }

            break;
          }
        case const (SizedBox):
          {
            element as SizedBox;
            if (element.child != null) {
              if (element.key != null && element.key is ValueKey) {
                final key = element.key as ValueKey;
                final keyValue = key.value;
                switch (keyValue) {
                  case (ElementsType.absElement):
                    {
                      addToTeXData(
                        widget: element.child!,
                        parseFunctionByChild: absParser
                      );
                    }
                  case (ElementsType.logElement):
                  {
                    addToTeXData(widget: element.child!, parseFunctionByChild: logParser);
                  }
                  case (ElementsType.sqrtElement):
                    {
                      if(element.child != null){
                        addToTeXData(
                          widgets: [element.child!],
                          parseFunctionByChildren: sqrtParser
                        );
                      }
                    }
                    case (ElementsType.cosElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\cos'
                    );
                  }
                case (ElementsType.sinElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\sin'
                    );
                  }
                case (ElementsType.tanElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\tan'
                    );
                  }
                case (ElementsType.cotElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\cot'
                    );
                  }
                case (ElementsType.arccosElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arccos'
                    );
                  }
                case (ElementsType.arcsinElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arcsin'
                    );
                  }
                case (ElementsType.arctanElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arctan'
                    );
                  }
                case (ElementsType.arccotElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\arcctg'
                    );
                  }
                case (ElementsType.naturalLogElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\ln'
                    );
                  }
                case (ElementsType.logBaseTwoElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\log_2'
                    );
                  }
                case (ElementsType.decimalLogElement):
                  {
                    addToTeXData(
                      widgets: [element.child!],
                      parseFunctionWithTeXFormula: trigonometricParser,
                      teXFormula: '\\lg'
                    );
                  }
                case (ElementsType.derevativeElement):
                  {
                    addToTeXData(widget: element.child!, parseFunctionByChild: derevativeParser);
                  }
                }
              } else {
                _formulaParser([element.child!]);
              }
            }

            break;
          }
        case const (Positioned):
          {
            element as Positioned;
            _formulaParser([element.child]);

            break;
          }
        case const (TextField):
          {
            element as TextField;
            formulaInTeX = formulaInTeX + element.controller!.text;
            return element.controller?.text;
            // break;
          }
        case const (IntegralWidget):
          {
            element as IntegralWidget;
              addToTeXData(widget: element, parseFunctionByChild: integralParser);
              break; 
          }
        case const (BacketsWidget):
          {
            element as BacketsWidget;
            addToTeXData(
                widgets: [element.child!], parseFunctionByChildren: backetsParer);
            break;
          }
        case const (ArgumentWidget):
          {
            element as ArgumentWidget;
            _formulaParser([element.child!]);
            break;
          }
        case const (ExpRowWidget):
          {
            element as ExpRowWidget;
            _formulaParser([element.child!]);
            break;
          }
        case const (TextFieldWidgetHandler):
          {
            element as TextFieldWidgetHandler;
            return _formulaParser([element.textField!]);
          }
        case const (LimStackWidget):
          {
            element as LimStackWidget;
            addToTeXData(widget: element.child!, parseFunctionByChild: limitParser);
            break;
          }
      }
    }
    print(formulaInTeX);
    return null;
  }

  String addToTeXData({
      Function(List<Widget>)? parseFunctionByChildren,
      Function(Widget)? parseFunctionByChild,
      List<Widget>? widgets,
      Widget? widget,
      Function(List<Widget>, String)? parseFunctionWithTeXFormula,
      String? teXFormula
    }) {
    final intermediateTeXData = formulaInTeX;
    formulaInTeX = '';
    var teXData = '';
    if (parseFunctionByChildren != null && widgets != null) {
      teXData = parseFunctionByChildren(widgets) as String;
    } else if (teXFormula != null && parseFunctionWithTeXFormula != null && widgets != null) {
      teXData = parseFunctionWithTeXFormula(widgets, teXFormula) as String;
    } else if( parseFunctionByChild != null && widget != null){
      teXData = parseFunctionByChild(widget) as String;
    }
    formulaInTeX = intermediateTeXData + teXData;
    print(formulaInTeX);
    return formulaInTeX;
  }

  String backetsParer(List<Widget> widgets) {
    String backetData = '';
    for (final element in widgets) {
      if (element is SizedBox && element.child != null) {
        _formulaParser([element.child!]);
      } else if (element is Row) {
        _formulaParser(element.children);
      }
      if (formulaInTeX.isNotEmpty) {
        backetData = '$backetData$formulaInTeX';
      }
      formulaInTeX = '';
    }
    return '($backetData)';
  }

  String expParser(List<Widget> widgets) {
    String teXExpData = '';
    for (final element in widgets) {
      if (element.runtimeType == SizedBox) {
        element as SizedBox;
        if (element.child != null) {
          formulaInTeX = '';
          _formulaParser([element.child!]);
          if (formulaInTeX.isNotEmpty) {
            teXExpData = '$teXExpData$formulaInTeX ';
          }
        }
      } else {}
    }

    return '^{$teXExpData}';
  }

  String sqrtParser(List<Widget> widgets) {
    String textData = '';
    for (final element in widgets) {
      if (element.runtimeType == SizedBox) {
        element as SizedBox;
        if (element.child != null) {
          final data = _formulaParser([element.child!]);
          textData = '$textData$data';
        }
      } else if (element.runtimeType == Stack) {
        element as Stack;
        final data = _formulaParser([element]);
        textData = '$textData$data';
      }else if(element is MultiChildRenderObjectWidget){
        _formulaParser(element.children);
        textData = '$textData$formulaInTeX';
      }
      formulaInTeX = '';
    }
    final teXSqrtData = '\\sqrt{$textData}';
    return teXSqrtData;
  }

  String fracParser(List<Widget> widgets) {
    final List<String> fracData = ['', ''];
    for (final element in widgets) {
      if (element.runtimeType == SizedBox) {
        element as SizedBox;
        if (element.child != null) {
          final textController = _formulaParser([element.child!]);

          if (fracData.first.isEmpty) {
            fracData.first = textController ?? '';
          } else if (fracData[1].isEmpty) {
            fracData[1] = textController ?? '';
          }
          formulaInTeX = '';
        }
      } else {}
    }
    final fracStringData = '\\frac{${fracData[0]}}{${fracData[1]}} ';
    return fracStringData;
  }

  String derevativeParser(Widget widget) {
    final List<String> derevativeData = ['', ''];
    final widgets = (widget as Column).children;
    for (final element in widgets) {
      if (element.runtimeType == SizedBox) {
        element as SizedBox;
        if (element.child != null) {
          final textController = _formulaParser([element.child!]);
          if (derevativeData[0].isEmpty) {
            derevativeData[0] = textController ?? '';
          } else if (derevativeData[1].isEmpty) {
            derevativeData[1] = textController ?? '';
          }
        }
        formulaInTeX = '';
      }
    }
    final derevativeString =
        '\\frac{d${derevativeData[0]}}{d${derevativeData[1]}} ';
    return derevativeString;
  }

  String logParser(Widget widget) {
    final List<String> logData = ['', ''];
    if (widget is Stack) {
        for (final element in widget.children) {
          if (element is Positioned) {
            final fieldData = _formulaParser([element.child]);
            if (logData[0].isEmpty) {
              logData[0] = fieldData ?? '';
            } else if (logData[1].isEmpty) {
              logData[1] = fieldData ?? '';
            }
            formulaInTeX = '';
          }
        }
    }

    final logStringData = '\\log_{${logData[1]}}${logData[0]} ';
    return logStringData;
  }

  String integralParser(Widget widget) {
    final List<String> integralData = ['', '', '', ''];
    final integralWidget = widget as IntegralWidget;
    final sizedBox = integralWidget.child as SizedBox;
    final stack = sizedBox.child as Stack;
    for (final element in stack.children) {
      if (element.runtimeType == Positioned) {
        element as Positioned;
        _formulaParser([element.child]);
        if (integralData[0].isEmpty) {
          integralData[0] = formulaInTeX;
        } else if (integralData[1].isEmpty) {
          integralData[1] = formulaInTeX;
        } else if (integralData[2].isEmpty) {
          integralData[2] = formulaInTeX;
        } else if (integralData[3].isEmpty) {
          integralData[3] = formulaInTeX;
        }
        formulaInTeX = '';
      }
    }
    formulaInTeX = '';
    final integralString =
        '\\int_{${integralData[0]}}^{${integralData[1]}} ${integralData[2]} d${integralData[3]} ';
    return integralString;
  }

  String undefinitIntegralParser(List<Widget> widgets) {
    final List<String> integralData = ['', ''];
    for (final element in widgets) {
      if (element.runtimeType == Row && integralData[1].isEmpty) {
        final arg = element as Row;
        _formulaParser(arg.children);
        if(integralData[0].isEmpty){
          integralData[0] = formulaInTeX;
        }else {
          integralData[1] = formulaInTeX;
        }
      formulaInTeX = '';
      }
    }

    final integral = '\\int ${integralData[0]} d${integralData[1]} ';
    return integral;
  }

  String absParser(Widget widget) {
    if (widget is Row) {
      final fieldData = _formulaParser(widget.children);
      formulaInTeX = '';
      return '\\left| $fieldData \\right|';
    }
    return '';
  }

  String limitParser(Widget widget) {
    final List<String> limitData = ['', '', ''];
    final stack = widget as Stack;
    for (final element in stack.children) {
      if (element is Positioned) {
        final fieldData = _formulaParser([element.child]);
        if (limitData[0].isEmpty) {
          limitData[0] = fieldData ?? '';
        } else if (limitData[1].isEmpty) {
          limitData[1] = fieldData ?? '';
        } else if (limitData[2].isEmpty) {
          limitData[2] = fieldData ?? '';
        }
        formulaInTeX = '';
      }
    }
    final limitStringData =
        '\\lim_{${limitData[1]}\\to ${limitData[2]}} ${limitData[0]} ';
    return limitStringData;
  }

  String trigonometricParser(List<Widget> widgets, String teXFormula) {
    var stringData = '';
    formulaInTeX = '';
    for (final element in widgets) {
      if (element is MultiChildRenderObjectWidget) {
        _formulaParser(element.children);
          stringData = '$stringData$formulaInTeX ';
      }else if(element is SingleChildRenderObjectWidget) {
        _formulaParser([element.child!]);
          stringData = '$stringData$formulaInTeX';
      }
      formulaInTeX = '';
    }
    return '$teXFormula$stringData';
  }
}
