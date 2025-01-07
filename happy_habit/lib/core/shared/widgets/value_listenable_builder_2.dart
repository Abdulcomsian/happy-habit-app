import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilder2<T1, T2> extends StatefulWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.valueListenable1,
    required this.valueListenable2,
    required this.builder,
  });

  final ValueListenable<T1> valueListenable1;
  final ValueListenable<T2> valueListenable2;
  final Widget Function(BuildContext context, T1 value1, T2 value2, Widget? child) builder;

  @override
  // _CustomValueListenableBuilderState<T> createState() => _CustomValueListenableBuilderState<T>();
  State<ValueListenableBuilder2<T1, T2>> createState() => _ValueListenableBuilder2State<T1, T2>();
}

class _ValueListenableBuilder2State<T1, T2> extends State<ValueListenableBuilder2<T1, T2>> {
  late T1 _value1;
  late T2 _value2;

  @override
  void initState() {
    super.initState();
    _value1 = widget.valueListenable1.value;
    _value2 = widget.valueListenable2.value;
    widget.valueListenable1.addListener(_updateValue1);
    widget.valueListenable2.addListener(_updateValue2);
  }

  @override
  void didUpdateWidget(covariant ValueListenableBuilder2<T1, T2> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valueListenable1 != oldWidget.valueListenable1) {
      oldWidget.valueListenable1.removeListener(_updateValue1);
      widget.valueListenable1.addListener(_updateValue1);
      _value1 = widget.valueListenable1.value;
    }
    if (widget.valueListenable2 != oldWidget.valueListenable2) {
      oldWidget.valueListenable2.removeListener(_updateValue2);
      widget.valueListenable2.addListener(_updateValue2);
      _value2 = widget.valueListenable2.value;
    }
  }

  @override
  void dispose() {
    widget.valueListenable1.removeListener(_updateValue1);
    widget.valueListenable2.removeListener(_updateValue2);
    super.dispose();
  }

  void _updateValue1() {
    setState(() {
      _value1 = widget.valueListenable1.value;
    });
  }

  void _updateValue2() {
    setState(() {
      _value2 = widget.valueListenable2.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value1, _value2, null);
  }
}


class ValueListenableBuilder3<T1, T2, T3> extends StatefulWidget {
  const ValueListenableBuilder3({
    super.key,
    required this.valueListenable1,
    required this.valueListenable2,
    required this.valueListenable3,
    required this.builder,
  });

  final ValueListenable<T1> valueListenable1;
  final ValueListenable<T2> valueListenable2;
  final ValueListenable<T3> valueListenable3;
  final Widget Function(BuildContext context, T1 value1, T2 value2, T3 value3, Widget? child) builder;

  @override
  // _CustomValueListenableBuilderState<T> createState() => _CustomValueListenableBuilderState<T>();
  State<ValueListenableBuilder3<T1, T2, T3>> createState() => _ValueListenableBuilder3State<T1, T2, T3>();
}

class _ValueListenableBuilder3State<T1, T2, T3> extends State<ValueListenableBuilder3<T1, T2, T3>> {
  late T1 _value1;
  late T2 _value2;
  late T3 _value3;

  @override
  void initState() {
    super.initState();
    _value1 = widget.valueListenable1.value;
    _value2 = widget.valueListenable2.value;
    _value3 = widget.valueListenable3.value;
    widget.valueListenable1.addListener(_updateValue1);
    widget.valueListenable2.addListener(_updateValue2);
    widget.valueListenable3.addListener(_updateValue3);
  }

  @override
  void didUpdateWidget(covariant ValueListenableBuilder3<T1, T2, T3> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valueListenable1 != oldWidget.valueListenable1) {
      oldWidget.valueListenable1.removeListener(_updateValue1);
      widget.valueListenable1.addListener(_updateValue1);
      _value1 = widget.valueListenable1.value;
    }
    if (widget.valueListenable2 != oldWidget.valueListenable2) {
      oldWidget.valueListenable2.removeListener(_updateValue2);
      widget.valueListenable2.addListener(_updateValue2);
      _value2 = widget.valueListenable2.value;
    }
    if (widget.valueListenable3 != oldWidget.valueListenable3) {
      oldWidget.valueListenable3.removeListener(_updateValue3);
      widget.valueListenable3.addListener(_updateValue3);
      _value3 = widget.valueListenable3.value;
    }
  }

  @override
  void dispose() {
    widget.valueListenable1.removeListener(_updateValue1);
    widget.valueListenable2.removeListener(_updateValue2);
    widget.valueListenable3.removeListener(_updateValue3);
    super.dispose();
  }

  void _updateValue1() {
    setState(() {
      _value1 = widget.valueListenable1.value;
    });
  }

  void _updateValue2() {
    setState(() {
      _value2 = widget.valueListenable2.value;
    });
  }

  void _updateValue3() {
    setState(() {
      _value3 = widget.valueListenable3.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value1, _value2, _value3, null);
  }
}
