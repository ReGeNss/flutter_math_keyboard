import 'package:flutter/material.dart';
import 'package:math_keyboard/keyboard_model.dart';
import 'package:math_keyboard/widgets/keyboard.dart';
import 'package:provider/provider.dart';



const double _spaceBetweenWidth = 5; 

class scroolGreekSymbolsWidget extends StatelessWidget {
  const scroolGreekSymbolsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardModel>(); 
    return SizedBox(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('α');              
            },
            style: buttonStyle,
            child: const Text('α'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('β');
            },
            style: buttonStyle,
            child: const Text('β'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('γ');
            },
            style: buttonStyle,
            child: const Text('γ'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('Δ');
            },
            style: buttonStyle,
            child: const Text('Δ'),
          ),          
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('ε');
            },
            style: buttonStyle,
            child: const Text('ε'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('η');
            },
            style: buttonStyle,
            child: const Text('η'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('θ');
            },
            style: buttonStyle,
            child: const Text('θ'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('σ');
            },
            style: buttonStyle,
            child: const Text('σ'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('τ');
            },
            style: buttonStyle,
            child: const Text('τ'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('φ');
            },
            style: buttonStyle,
            child: const Text('φ'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('ψ');
            },
            style: buttonStyle,
            child: const Text('	ψ'),
          ),
        ),
        const SizedBox(width: _spaceBetweenWidth,),
        SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
            onPressed: () {
              model.addCharToTextField('ω');
            },
            style: buttonStyle,
            child: const Text('ω'),
          ),
        ),
      ]),
    ));
  }
}