//  import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  // ignore: non_constant_identifier_names
  final Students = [
    'ABHIJITH MOHANAN',
    'ABHINAV BIJUKUMAR',
    'ABIN SUDHAKARAN',
    'ADHARSH VARGHESE JOJO',
    'ADHIN GEORGE',
    'AIMAL JINOY',
    'AJO PRASAD',
    'ALAN JOY',
    'ALBIN BIJU',
    'ALBIN SANY',
    'ANAND S JACOB',
    'ANN MARIYA BIJU',
    'ASWIN MANOJ',
    'BASIL ELDHO',
    'BASIL GEORGE',
    'BESTO VARGHESE B',
    'BINEX SHIBU THOMAS',
    'CHRISTO BENNY',
    'DAVID SEBASTIAN GIGI',
    'DHANANJAY M JAYAN',
    'EDVIN JOHN',
    'GOUTHAM GOPAN',
    'HEAVEN JOSE',
    'IBNU EBRAHIM',
    'JACOB LAL',
    'JAYADEV BIJU',
    'JOYES JOSEPH TOJI',
    'JUDE GIGIMON',
    'LEO SAN GEORGE',
    'MAHIN KABEER',
    'MALAVIKA BIJU',
    'MIJU SHAJI',
    'MURSHID IQBAAL.K.M',
    'NIKHIL V',
    'NIKIL SHAJI',
    'NOYAL BINOY',
    'SANJAY SUNIL',
    'SREEHARI UNNIKRISHNAN',
    'SUBIN V S',
    'VINAYAK SURESH',
    'ALINA SAJAN',
    'AMEENA T A',
    'ANGEL MARY SAJI',
    'ANJAL CHANDRAN',
    'APARNA MOHAN',
    'ASHNA HAMEED',
    'DEVIKA DASAN',
    'DEVU S NAIR',
    'DINAH BIJU',
    'DRISHYA ANTONY',
    'ERFANA RAHMAN',
    'FASNA ASHRAF',
    'FATHIMA SHARIEF',
    'HANNAH ELIZABETH REGI',
    'JESNA JOY',
    'KARTHKA S',
    'MEENAKSHI ',
    'MUFEEDHA MAHEEN',
    'NANDHANA AJITH',
    'NEENU O S',
    'RAHMATH RABIYA.KM',
    'REES JAMES',
    'RISNA N A',
    'ROSE MARY BENNY',
    'SONA JOY',
    'SREELEKSHMI B R',
    'FAYAZ P AJIMS',
  ];

  final recent = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recent
        : Students.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].subString(0, query.length),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].subString(query.length),
                  style: const TextStyle(color: Colors.grey),
                ),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
