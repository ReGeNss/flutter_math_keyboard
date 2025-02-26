import 'package:flutter/material.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';
import 'package:math_keyboard/services/text_field_handle_and_create.dart';

class FormulasTreeParsersService {
  ReturnData? _parsedData;

  ReturnData? parseWidgetListWithReplacment(
      List<Widget> array, TextEditingController activeTextFieldController) {
    _parsedData = null;
    _parseWidgetWithPeplacment(array, activeTextFieldController);
    return _parsedData;
  }
  ReturnData? parseWidgetList(List<Widget> array, TextEditingController activeTextFieldController){
    _parsedData = null;
    _widgetTreeParser(array, activeTextFieldController); 
    return _parsedData; 
    
  }

  ReturnData? _parseWidgetWithPeplacment(
      List<Widget> array, TextEditingController activeTextFieldController) {
    // подумай чи точно тут потрібно перевіряти на колонку і
    final length = array.length;
    ReturnData? data;
    for (int index = 0; length > index; index += 1) {
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final row = array[index] as Row;
            data = _parseWidgetWithPeplacment(
              row.children,
              activeTextFieldController,
            );
            if (data != null) {
              return data;
            }
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
            data = _parseWidgetWithPeplacment(
              list.children,
              activeTextFieldController,
            );
            if (data != null) {
              return data;
            }
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              return ReturnData(
                  wigetData: array, index: index, widget: textFieldWidget);
            }
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              // print('ТУТА $globalKey');
              data = _textControllerWidgetParser(
                widget.child!,
                activeTextFieldController,
              );
              if (data != null) {
              data.index = index; // костилі
              data.wigetData = array;
              if (_parsedData == null) {
                _parsedData = data;
                // return data;
              }
            }
            }
            
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            data = _parseWidgetWithPeplacment(
              list.children,
              activeTextFieldController,
            );
            if (data != null) {
              // return data;
            }
            break;
          }
        case const (Positioned):
          {
            final widget = array[index] as Positioned;
            data = _textControllerWidgetParser(
                widget.child, activeTextFieldController);
            if (data != null) {
              if(data.index == null && data.wigetData == null){
                data.index = 0; 
                data.wigetData = [widget.child]; 
              }
              // data.index = index; // костилі
              // data.wigetData = array;
              if (_parsedData == null) {
                _parsedData = data;
                return null;
              }
            }
            break;
          }
        case const (BacketsWidget):
        {
          final widget = (array[index] as BacketsWidget).child as Row; 
          data = _parseWidgetWithPeplacment(widget.children, activeTextFieldController); 
          if (data != null) {
              return data;
            }
            break;
        }
        case const (ArgumentWidget): 
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          data = _parseWidgetWithPeplacment(widget.children, activeTextFieldController); 
          if (data != null) {
              return data;
            }
            break; 
        }
        case const (RelayedPositioned):
        {
          final widget = array[index] as RelayedPositioned;
          data = _textControllerWidgetParser(widget.widgetToWrap, activeTextFieldController);
          if (data != null) {
            if(data.index == null && data.wigetData == null){
              data.index = 0; 
              data.wigetData = [widget.widgetToWrap]; 
            }
            if (_parsedData == null) {
              _parsedData = data;
              return null;
            }
          }
          break;
        }
        case const (WidgetDynamicSizeWrapper):
        {
          final widget = array[index] as WidgetDynamicSizeWrapper;
          data = _textControllerWidgetParser(widget.wrappedWidget, activeTextFieldController);
          if (data != null) {
            if(data.index == null && data.wigetData == null){
              data.index = 0; 
              data.wigetData = [widget.wrappedWidget]; 
            }
            if (_parsedData == null) {
              _parsedData = data;
              return null;
            }
          }
          break;
        }
        case const (TextFieldWidgetHandler):
        {
           final widget =
                (array[index] as TextFieldWidgetHandler).textField as TextField;
              data = _textControllerWidgetParser(
                  widget, activeTextFieldController);
              if (data != null) {
                return data;
              }
            
          break; 
        }
      }
    }
    return null;
    // return parsedData;
  }

  ReturnData? _textControllerWidgetParser(
      Widget widget, TextEditingController activeTextFieldController) {
    ReturnData? data;
    final widgetRunType = widget.runtimeType;
    switch (widgetRunType) {
      case const (TextField):
        {
          final textFieldWidget = widget as TextField;
          if (textFieldWidget.controller == activeTextFieldController) {
            return ReturnData(widget: textFieldWidget);
          }
          break;
        }
      case const (Column):
        {
          final column = widget as Column;
          data = _parseWidgetWithPeplacment(
              column.children, activeTextFieldController);
          return data;
        }
      case const (Row):
        {
          final row = widget as Row;
          data = _parseWidgetWithPeplacment(
              row.children, activeTextFieldController);
          return data;
        }
      case const (Positioned):
        {
          final positioned = widget as Positioned;
          data = _textControllerWidgetParser(
            positioned.child,
            activeTextFieldController,
          );
          return data;
        }
      case const (SizedBox):
        {
          final sizedBox = widget as SizedBox;
          data = _textControllerWidgetParser(
            sizedBox.child!,
            activeTextFieldController,
          );
          return data;
        }
      case const (Stack):
        {
          final stack = widget as Stack;
          data = _parseWidgetWithPeplacment(
              stack.children, activeTextFieldController);
          return data;
        }
      case const (ArgumentWidget):
      {
        final integralArg = widget as ArgumentWidget;
        data = _textControllerWidgetParser(integralArg.child!, activeTextFieldController);
        return data;  
      }
      case const (TextFieldWidgetHandler):
      {
        final textFieldWidget = widget as TextFieldWidgetHandler;
        if(textFieldWidget.textField != null){
          data = _textControllerWidgetParser(textFieldWidget.textField!, activeTextFieldController);
        }
        return data;  
      }
    }
    return null;
  }

  ReturnData? _widgetTreeParser(List<Widget> array,
      TextEditingController activeTextFieldController,
      {bool isFromRowOrColumn = false}) {
    final length = array.length;
    // print("PARSED DATA: ${context.read<KeyboardModel>().parsedData}");
    ReturnData? data;
    // if(activeTextFieldController.text != ''){
    for (int index = 0; length > index; index += 1) {
      switch (array[index].runtimeType) {
        case const (Row):
          {
            final list = array[index] as Row;
            data = _widgetTreeParser(
                list.children, activeTextFieldController,
                isFromRowOrColumn: true);
            if (data?.widget is TextField) {
              final textField = data!.widget as TextField;
              if (_parsedData == null &&
                  textField.controller == activeTextFieldController) {
                _parsedData = ReturnData(wigetData: array);
              }
            }
            isFromRowOrColumn = false;
            // return data;
            break;
          }
        case const (Column):
          {
            final list = array[index] as Column;
            data = _widgetTreeParser(
                list.children, activeTextFieldController,
                isFromRowOrColumn: true);
            if (data?.widget is TextField) {
              final textField = data!.widget as TextField;
              if (_parsedData == null &&
                  textField.controller == activeTextFieldController) {
                _parsedData = ReturnData(wigetData: array);
              }
            }
            isFromRowOrColumn = false;
            break;
          }
        case const (TextField):
          {
            final textFieldWidget = array[index] as TextField;
            if (textFieldWidget.controller == activeTextFieldController) {
              return ReturnData(
                  wigetData: array, index: index, widget: textFieldWidget);
            }
            break;
          }
        case const (Stack):
          {
            final list = array[index] as Stack;
            data = _widgetTreeParser(
                list.children, activeTextFieldController,
                isFromRowOrColumn: true);
            if (data?.widget is TextField) {
              final textField = data!.widget as TextField;
              if (_parsedData == null &&
                  textField.controller == activeTextFieldController) {
                    data.index = index; 
                    data.wigetData = array; 
                    _parsedData = data; 
              }
            }
            isFromRowOrColumn = false;
            break;
          }
        case const (SizedBox):
          {
            final widget = array[index] as SizedBox;
            if (widget.child != null) {
              data = _widgetParser(
                  widget.child!, activeTextFieldController);
            }
            if (data != null && _parsedData == null) {
              data.index = index; // костилі
              if (isFromRowOrColumn == false) {
                data.wigetData = array;
              }
              if (data.widget is TextField && isFromRowOrColumn == false) {
                final controller = (data.widget as TextField).controller;
                if (controller == activeTextFieldController) {
                  _parsedData = data;
                }
              }
              return data;
            }
            // isFromRowOrColumn = false;
            break;
          }
        case const (Positioned):
          {
            {
              final widget = array[index] as Positioned;
              data = _widgetParser(
                  widget.child, activeTextFieldController);
            }
            if (data != null && _parsedData == null) {
              // data.index = index; // костилі
              if (isFromRowOrColumn == false) {
                data.wigetData = array;
              }
              if (data.widget is TextField && isFromRowOrColumn == false) {
                final controller = (data.widget as TextField).controller;
                if (controller == activeTextFieldController) {
                  _parsedData = data;
                }
              }
              return data;
            }
            break;
          }
        // case const (BacketsWidget):
        // {
        //   final widget = (array[index] as BacketsWidget).child as Row;
        //   data = _widgetTreeParser(
        //         widget.children, activeTextFieldController,
        //         isFromRowOrColumn: true);
        //     if (data?.widget is TextField) {
        //       final textField = data!.widget as TextField;
        //       if (_parsedData == null &&
        //           textField.controller == activeTextFieldController) {
        //         _parsedData = ReturnData(wigetData: array,index: index);
        //       }
        //     }
        //     isFromRowOrColumn = false;
        //     break;
        // }
        case const (ArgumentWidget):
        {
          final widget = (array[index] as ArgumentWidget).child as Row; 
          data = _widgetTreeParser(
                widget.children, activeTextFieldController,
                isFromRowOrColumn: true);
            if (data?.widget is TextField) {
              final textField = data!.widget as TextField;
              if (_parsedData == null &&
                  textField.controller == activeTextFieldController) {
                _parsedData = ReturnData(wigetData: array);
              }
            }
            isFromRowOrColumn = false;
            break;
        }
        case const (TextFieldWidgetHandler):
        {
          final textFieldWidget = array[index] as TextFieldWidgetHandler;
            if (textFieldWidget.textField!.controller == activeTextFieldController) {
              return ReturnData(
                  wigetData: array, index: index, widget: textFieldWidget);
            }
            break;
        }
        case const (RelayedPositioned): 
        {   
          final widget = array[index] as RelayedPositioned;
              data = _widgetParser(
                  widget.widgetToWrap, activeTextFieldController);
            if (data != null && _parsedData == null) {
              data.index = index; // костилі
              if (isFromRowOrColumn == false) {
                data.wigetData = array;
              }
              if (data.widget is TextField && isFromRowOrColumn == false) {
                final controller = (data.widget as TextField).controller;
                if (controller == activeTextFieldController) {
                  _parsedData = data;
                }
              }
              return data;
            }
        }
        case const (WidgetDynamicSizeWrapper): 
        {
          final widget = array[index] as WidgetDynamicSizeWrapper;
              data = _widgetParser(
                  widget.wrappedWidget, activeTextFieldController);
            if (data != null && _parsedData == null) {
              data.index = index; // костилі
              if (isFromRowOrColumn == false) {
                data.wigetData = array;
              }
              if (data.widget is TextField && isFromRowOrColumn == false) {
                final controller = (data.widget as TextField).controller;
                if (controller == activeTextFieldController) {
                  _parsedData = data;
                }
              }
              return data;
            }
        } 
      }
    }
    return null;
  }

  ReturnData? _widgetParser(
      Widget widget, TextEditingController activeTextFieldController) {
    ReturnData? data;
    final widgetRunType = widget.runtimeType;
    switch (widgetRunType) {
      case const (RelayedPositioned): 
        {   
          final relayedPositioned = widget as RelayedPositioned; 
          data = _widgetParser(relayedPositioned.widgetToWrap, activeTextFieldController);
          return data;
        } 
      case const (TextField):
        {
          final textFieldWidget = widget as TextField;
          if (textFieldWidget.controller == activeTextFieldController) {
            return ReturnData(widget: textFieldWidget);
          }
          break; 
        }
      case const (Column):
      {
        final column = widget as Column;
      data = _widgetTreeParser(
          column.children, activeTextFieldController, 
          isFromRowOrColumn: true);
      return data;
      }
      case  const (Row):
      {
        final row = widget as Row;
      data = _widgetTreeParser(
          row.children, activeTextFieldController,
          isFromRowOrColumn: true);
      return data;
      }
      case const (Stack):
      {
        final stack = widget as Stack;
      data = _widgetTreeParser(
          stack.children, activeTextFieldController,
          isFromRowOrColumn: true);
      return data;
      }
      case const (Positioned):
      {
        widget as Positioned; 
         data = _widgetParser(
          widget.child, activeTextFieldController);
      return data;
      }
      case const (SizedBox):
      {
        widget as SizedBox;
      data = _widgetParser(
          widget.child!, activeTextFieldController);
      return data;
      }
      case const (ArgumentWidget):
      {
        final integralArg = widget as ArgumentWidget;
        data = _widgetParser(integralArg.child!, activeTextFieldController);
        return data;  
      }
      case const (WidgetDynamicSizeWrapper): 
      {
        final widgetDynamicSizeWrapper = widget as WidgetDynamicSizeWrapper; 
        data = _widgetParser(widgetDynamicSizeWrapper.wrappedWidget, activeTextFieldController);
        return data;
      }
      case const (TextFieldWidgetHandler):
      {
        final textFieldHandler = widget as TextFieldWidgetHandler; 
        data = _widgetParser(textFieldHandler.textField!, activeTextFieldController);
        return data; 
      }
    }
    return null;
  }  
}

class ReturnData {
  List<Widget>? wigetData;
  bool? isGroop;
  int? index;
  Widget? widget;
  GlobalKey? globalKey;
  ReturnData({this.wigetData, this.index, this.widget, this.globalKey, this.isGroop});
}
