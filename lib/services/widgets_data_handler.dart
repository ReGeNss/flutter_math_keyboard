import 'package:flutter/material.dart';
import 'package:math_keyboard/parsers/formulas_tree_parsers_and_handler.dart';
import 'package:math_keyboard/services/math_constructions_building.dart';

class WidgetsDataHandler{
  void replaceWidgetInTree(ReturnData parsedData, MathConstructionData mathConstructions){
    if(mathConstructions.addictionalWidget != null){
      parsedData.wigetData?.replaceRange(parsedData.index!, parsedData.index!+1,[mathConstructions.construction, mathConstructions.addictionalWidget!]);
    }else{
      parsedData.wigetData?[parsedData.index!] = mathConstructions.construction;
    }
  }
  void addToWidgetTree(ReturnData parsedData, List<Widget> widget){
    parsedData.wigetData!.addAll(widget); 
  }
  void deleteFromWidgetTree(ReturnData parsedData){
    parsedData.wigetData?.removeAt(parsedData.index!); 
  }
}