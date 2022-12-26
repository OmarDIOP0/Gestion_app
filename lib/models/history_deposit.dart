import 'package:flutter/material.dart';

import '../methode/apiMethode.dart';


class HistoryDeposit extends StatefulWidget {
  const HistoryDeposit({Key? key}) : super(key: key);

  @override
  State<HistoryDeposit> createState() => _HistoryDepositState();
}

class _HistoryDepositState extends State<HistoryDeposit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width*1,
          child: FutureBuilder(
              future: getDeposit(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                else {
                  return DataTable(
                      columns:[
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('B_Before')),
                        DataColumn(label: Text('B_After')),
                      ],
                      rows: snapshot.data.map<DataRow>((data){
                        var date = data['created_at'].toString();
                        var amount = data['amount'].toString();
                        var balance_before = data['balance_before'].toString();
                        var balance_after = data['balance_after'].toString();
                        return DataRow(
                            cells: [
                              DataCell(Text(date)),
                              DataCell(Text(amount)),
                              DataCell(Text(balance_before)),
                              DataCell(Text(balance_after)),
                            ]
                        );
                      }).toList()
                  );
                }
              }),
        )
      ],
    );
  }
}
