import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_pertemuan_5/main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final List list;
  final int index;
  Edit({Key? key, required this.list, required this.index}) : super(key: key);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController salary;
  void editData() {
    var url = Uri.parse(
        'http://10.128.176.20/restfullapi/update.php'); //update api calling
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'name': name.text,
      'address': address.text,
      'salary': salary.text
    });
  }

  @override
  void initState() {
    name = TextEditingController(
        text: widget.list[widget.index]
            ['name']); //setting up the existing values in textediting control
    address = TextEditingController(text: widget.list[widget.index]['address']);
    salary = TextEditingController(text: widget.list[widget.index]['salary']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        flexibleSpace: Center(
          child: Text(
            '${widget.list[widget.index]['name']}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Mebulatkan sudut
                ),
                labelText: 'Enter Title',
                hintText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
                filled: true, // Mengisi bidang dengan warna latar belakang
                fillColor: Colors.white, // Warna latar belakang putih
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: address,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Mebulatkan sudut
                ),
                labelText: 'Enter Title',
                hintText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
                filled: true, // Mengisi bidang dengan warna latar belakang
                fillColor: Colors.white, // Warna latar belakang putih
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: salary,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Mebulatkan sudut
                ),
                labelText: 'Enter Title',
                hintText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
                filled: true, // Mengisi bidang dengan warna latar belakang
                fillColor: Colors.white, // Warna latar belakang putih
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius:
                  BorderRadius.circular(30), // Membuat tombol berbentuk bulat
            ),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20), // Atur ukuran tombol
              child: const Text(
                "Edit Data",
                style: TextStyle(color: Colors.white), // Warna teks putih
              ),
              onPressed: () {
                editData();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Home()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
