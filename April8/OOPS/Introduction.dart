import 'package:flutter/material.dart';
import 'package:placeprep/Authentication/config.dart';
import 'package:placeprep/OOPS/widget/CustomAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        text: "Introduction",
        link: 'https://www.javatpoint.com/what-is-object-oriented-programming');
  }
}

//Class and Object
class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
      text: "class",
      link: 'https://www.geeksforgeeks.org/classes-objects-java/',
      topic: "classobj",
    );
  }
}

//Abstraction
class Abstraction extends StatefulWidget {
  const Abstraction({super.key});

  @override
  State<Abstraction> createState() => _AbstractionState();
}

class _AbstractionState extends State<Abstraction> {
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
      text: "Abstraction",
      link: 'https://www.javatpoint.com/abstract-class-in-java',
      topic: "abstraction",
    );
  }
}

//Encapsulation
class Encapsulation extends StatefulWidget {
  const Encapsulation({super.key});

  @override
  State<Encapsulation> createState() => _EncapsulationState();
}

class _EncapsulationState extends State<Encapsulation> {
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        text: "Encapsulation",
        link: 'https://www.javatpoint.com/encapsulation',
        topic: "encapsulation"
        );
  }
}

//Inheritance
class Inheritance extends StatefulWidget {
  const Inheritance({super.key});

  @override
  State<Inheritance> createState() => _InheritanceState();
}

class _InheritanceState extends State<Inheritance> {
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
      text: "Inheritance",
      link: 'https://www.javatpoint.com/inheritance-in-java',
      topic: "inheritance",
    );
  }
}

//Compile Polymorphism
class Cpolymorphism extends StatefulWidget {
  const Cpolymorphism({super.key});

  @override
  State<Cpolymorphism> createState() => _CpolymorphismState();
}

class _CpolymorphismState extends State<Cpolymorphism> {
  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        text: "Method Overloading",
        link: 'https://www.javatpoint.com/compile-time-polymorphism-in-java');
  }
}

//Runtime Polymorphism

class Rpolymorphism extends StatefulWidget {
  const Rpolymorphism({super.key});

  @override
  State<Rpolymorphism> createState() => _RpolymorphismState();
}

class _RpolymorphismState extends State<Rpolymorphism> {
  @override
  Widget build(BuildContext context) {
    return const CustomWidget(
        text: "Method Overriding",
        link: 'https://www.javatpoint.com/compile-time-polymorphism-in-java');
  }
}
