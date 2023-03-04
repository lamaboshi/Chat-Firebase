import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum PickerType {
  DateTime,
  Date,
  Time,
}

class ChatTextFormField extends StatefulWidget {
  const ChatTextFormField(
    this.title, {
    this.defaultText,
    this.primaryColor = Colors.indigo,
    this.onSaved,
    this.maxlines,
    this.minlines = 1,
    this.datePicker = false,
    this.keyboardType = TextInputType.name,
    this.datePickerCallBack,
    this.prefixIcon,
    this.onChanged,
    this.onFieldSubmited,
    this.pickerType = PickerType.DateTime,
    this.width = 500,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.validator = _defaultValidator,
    this.inputFormatters,
    this.textDirection = TextDirection.ltr,
    this.readOnly = false,
    this.autofillHints,
    this.autofocus = false,
    this.focusNode,
    this.inputBorder,
    this.focusedBorder,
    this.onFoucsChange,
  });
  final double width;
  final String title;
  final String? defaultText;
  final Color primaryColor;
  final Function(String?)? onSaved;
  final Function(DateTime)? datePickerCallBack;
  final int? maxlines;
  final int? minlines;
  final bool datePicker;
  final PickerType pickerType;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Function(String)? onFieldSubmited;
  final TextInputAction textInputAction;
  final bool obscureText;
  final FormFieldValidator<String?> validator;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection textDirection;
  final bool readOnly;
  final Iterable<String>? autofillHints;
  final bool autofocus;
  final FocusNode? focusNode;
  final InputBorder? inputBorder;
  final InputBorder? focusedBorder;
  final Function(bool?)? onFoucsChange;

  @override
  _ChatTextFormFieldState createState() => _ChatTextFormFieldState();
}

class _ChatTextFormFieldState extends State<ChatTextFormField> {
  final _controller = TextEditingController();
  late bool _isVisible;
  FocusNode? foucsNode = FocusNode();
  bool? isFocusing;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isVisible = widget.obscureText;
    if (widget.focusNode != null) {
      foucsNode = widget.focusNode;
    }
    isFocusing = foucsNode?.hasFocus;
    foucsNode?.addListener(() {
      isFocusing = foucsNode?.hasFocus;
      widget.onFoucsChange?.call(isFocusing);
    });
  }

  void onFieldSubmitted(String value) {
    if (widget.onFieldSubmited != null) {
      widget.onFieldSubmited!(value);
    }
    _isVisible = !_isVisible;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if ((widget.defaultText?.isNotEmpty ?? false) ||
          (widget.defaultText?.isNotEmpty ?? false)) {
        _controller.value = TextEditingValue(
          text: widget.defaultText ?? '',

          ///prevent revesed text :!
          selection: TextSelection.collapsed(
            offset: widget.defaultText?.length ?? 0,
          ),
        );
      }
    });
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            focusNode: foucsNode,
            autofocus: widget.autofocus,
            autofillHints: widget.autofillHints,
            textDirection: widget.textDirection,
            inputFormatters: widget.inputFormatters,
            controller: _controller,
            obscureText: _isVisible,
            enableSuggestions: true,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            onSaved: widget.onSaved,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            cursorColor: widget.primaryColor,
            readOnly: widget.datePicker || widget.readOnly,
            enabled: !widget.readOnly,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: widget.title,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(
                      widget.prefixIcon,
                      size: 20,
                      color: widget.primaryColor,
                    ),
              suffix: null,
              icon: null,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        _isVisible = !_isVisible;
                        setState(() {});
                      },
                    )
                  : null,
            ),
            maxLines: _isVisible ? 1 : widget.maxlines,
            minLines: widget.minlines ?? 1,
            validator: widget.validator,
          ),
        ),
      ],
    );

    return child;
  }
}

String? _defaultValidator(String? s) {
  return (s != null && s.trim().isEmpty) ? 'msg_cannotBeEmpty'.tr : null;
}
