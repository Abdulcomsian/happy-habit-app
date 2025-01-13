// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' as Calendar;
// import 'package:intl/intl.dart';
//
// class RangeCalendarScreen extends StatefulWidget {
//   final DateTime startDate;
//   final DateTime endDate;
//
//   const RangeCalendarScreen({
//     Key? key,
//     required this.startDate,
//     required this.endDate,
//   }) : super(key: key);
//
//   @override
//   _RangeCalendarScreenState createState() => _RangeCalendarScreenState();
// }
//
// class _RangeCalendarScreenState extends State<RangeCalendarScreen> {
//   late DateTime selectedStartDate;
//   late DateTime selectedEndDate;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedStartDate = widget.startDate;
//     selectedEndDate = widget.endDate;
//   }
//
//   // To format date as a string
//   String formatDate(DateTime date) {
//     return DateFormat('yyyy-MM-dd').format(date);
//   }
//
//   // Create a list of events to mark the selected dates
//   Map<DateTime, List<Calendar.Event>> _getMarkedDates() {
//     Map<DateTime, List<Calendar.Event>> markedDates = {};
//
//     for (DateTime date = selectedStartDate;
//     !date.isAfter(selectedEndDate);
//     date = date.add(Duration(days: 1))) {
//       markedDates[date] = [
//         Calendar.Event(
//           date: date,
//           title: 'Selected Range', // You can add any title or data here if needed
//         )
//       ];
//     }
//
//     return markedDates;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Range Calendar')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Calendar widget
//             Calendar.CalendarCarousel(
//               onDayPressed: (DateTime date, List events) {
//                 setState(() {
//                   // Select a new range if the day is clicked
//                   if (selectedStartDate.isAfter(date)) {
//                     selectedStartDate = date;
//                   } else {
//                     selectedEndDate = date;
//                   }
//                 });
//               },
//               selectedDateTime: selectedStartDate,
//               weekendTextStyle: TextStyle(
//                 color: Colors.red,
//               ),
//               selectedDayTextStyle: TextStyle(
//                 color: Colors.white,
//               ),
//               selectedDayButtonColor: Colors.blue,
//               todayButtonColor: Colors.transparent,
//               todayTextStyle: TextStyle(color: Colors.black),
//               markedDatesMap: _getMarkedDates(), // Pass the marked dates map
//               customGridViewPhysics: NeverScrollableScrollPhysics(),
//               height: 400.0,
//               markedDateWidget: Container(), // To prevent showing a default mark
//             ),
//
//             SizedBox(height: 20),
//
//             // Selected Range Display
//             Row(
//               children: [
//                 Text(
//                   'Selected Range: ${formatDate(selectedStartDate)} to ${formatDate(selectedEndDate)}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 Spacer(),
//                 // Add Fire Icon at the end of the range (last date)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: SvgPicture.asset(
//                     'assets/fire_icon.svg', // Your fire SVG file location
//                     height: 24.0,
//                     width: 24.0,
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 20),
//
//             // Gradient Background for selected range
//             Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [
//                     Color(0xFFFFDA58), // #FFDA58
//                     Color(0xFFFF924D), // #FF924D
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Center(
//                 child: Text(
//                   'Selected Range Highlighted',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
