

// class OptionRadio extends StatefulWidget {
//    final String text;
//   final int index;
//   final ValueChanged<Object> press;
//   final int selectButton;

//   const OptionRadio({
//     super.key,
//     required this.text,
//     required this.index,
//     required this.press, 
//     required this.selectButton,
//   }) : super();

//   @override
//   OptionRadioPage createState() =>
//       OptionRadioPage(this.text, this.index, this.press);
// }


// class OptionRadioPage extends State<OptionRadio> {
//   final ValueChanged<Object> press;
//    final String text;
//       int index;
//       final VoidCallback press;

//       // int id = 1;
//       // int selectedButton ;
//       // bool _isButtonDisabled;

//       OptionRadioPage(this.text, this.index, this.press);

//       @override
//       void initState() {
//         _isButtonDisabled = false;
//       }

//       int _selected = null;

//   @override
//   Widget build(BuildContext context) {
//     return   RadioListTile(
//                               title: Text(
//                                 "${index + 1}. $text",
//                                 style: TextStyle(
//                                     color: Colors.green, fontSize: 16),
//                                 softWrap: true,
//                               ),
//                               groupValue: widget.selectButton,
//                               value: index,
//                               activeColor: Colors.green,
//                               onChanged: widget.press,
//                             )}
// }