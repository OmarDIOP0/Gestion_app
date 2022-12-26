import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';

class HistoriqueDepense extends StatefulWidget {
  const HistoriqueDepense({Key? key}) : super(key: key);

  @override
  State<HistoriqueDepense> createState() => _HistoriqueDepenseState();
}

class _HistoriqueDepenseState extends State<HistoriqueDepense> {
  @override
  Widget build(BuildContext context) {
    return Column(
       children:[
         const SizedBox(height: 10),
         SingleChildScrollView(
           child:Container(
             width: MediaQuery.of(context).size.width*1,
             child: FutureBuilder(
                 future: getExpense(),
                 builder: (context, snapshot) {
                   if (snapshot.data == null) {
                     return CircularProgressIndicator();
                   }
                   else {
                     return DataTable(
                         columns:[
                           DataColumn(label: Text('Cat')),
                           DataColumn(label: Text('Its')),
                           DataColumn(label: Text('U')),
                           DataColumn(label: Text('A')),
                           DataColumn(label: Text('Q')),
                           DataColumn(label: Text('UP')),
                           DataColumn(label: Text('Pay')),
                           DataColumn(label: Text('Cnt')),
                         ],
                         rows: snapshot.data.map<DataRow>((data){
                           var categories =data['name_item_categories'].toString();
                           var items =data['name_items'].toString();
                           var units =data['name_units'].toString();
                           var payment =data['name_payment'].toString();
                           var quantity =data['quantity'].toString();
                           var unit_price =data['unit_price'].toString();
                           var comments = data['comments'].toString();
                           var amount = data['amount'].toString();

                           return DataRow(
                               cells: [
                                 DataCell(Text(categories)),
                                 DataCell(Text(items)),
                                 DataCell(Text(units)),
                                 DataCell(Text(amount)),
                                 DataCell(Text(quantity)),
                                 DataCell(Text(unit_price)),
                                 DataCell(Text(payment)),
                                 DataCell(Text(comments)),
                               ]
                           );
                         }).toList()
                     );
                   }
                 }),
           ),
         ),
       ]

    );
  }
}
