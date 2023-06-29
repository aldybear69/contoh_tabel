import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh Tabel Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyTable(),
    );
  }
}

class MyTable extends StatefulWidget {
  const MyTable({super.key});

  @override
  MyTableState createState() => MyTableState();
}

class MyTableState extends State<MyTable> {
  final List<Map<String, dynamic>> tableData = [
    {'Nama': 'John Doe', 'Usia': 25, 'Kota': 'New York', 'Selected': false},
    {
      'Nama': 'Jane Smith',
      'Usia': 30,
      'Kota': 'Los Angeles',
      'Selected': false
    },
    {
      'Nama': 'Michael Johnson',
      'Usia': 35,
      'Kota': 'Chicago',
      'Selected': false
    },
    {
      'Nama': 'Emily Davis',
      'Usia': 28,
      'Kota': 'San Francisco',
      'Selected': false
    },
  ];

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _sortTable(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      tableData.sort((a, b) {
        if (ascending) {
          return a.values
              .toList()[columnIndex]
              .compareTo(b.values.toList()[columnIndex]);
        } else {
          return b.values
              .toList()[columnIndex]
              .compareTo(a.values.toList()[columnIndex]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Tabel Flutter'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortAscending: _sortAscending,
          sortColumnIndex: _sortColumnIndex,
          columns: [
            DataColumn(
              label: const Text('Nama'),
              onSort: (columnIndex, ascending) {
                _sortTable(columnIndex, ascending);
              },
            ),
            DataColumn(
              label: const Text('Usia'),
              numeric: true,
              onSort: (columnIndex, ascending) {
                _sortTable(columnIndex, ascending);
              },
            ),
            DataColumn(
              label: const Text('Kota'),
              onSort: (columnIndex, ascending) {
                _sortTable(columnIndex, ascending);
              },
            ),
            const DataColumn(
              label: Text('Pilih'),
            ),
          ],
          rows: List.generate(
            tableData.length,
            (index) => DataRow(
              selected: tableData[index]['Selected'],
              onSelectChanged: (value) {
                setState(() {
                  tableData[index]['Selected'] = value;
                });
              },
              cells: [
                DataCell(Text(tableData[index]['Nama'])),
                DataCell(Text(tableData[index]['Usia'].toString())),
                DataCell(Text(tableData[index]['Kota'])),
                DataCell(Checkbox(
                  value: tableData[index]['Selected'],
                  onChanged: (value) {
                    setState(() {
                      tableData[index]['Selected'] = value;
                    });
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
