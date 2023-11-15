import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "Api Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    var url = Uri.parse('http://10.128.176.20/restfullapi/list.php'); //Api Link
    final response = await http.post(url);
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("PHP MySQL CRUD - Sekar Ayu"),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        automaticallyImplyLeading: false, // Hapus ikon "arrow left"
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => NewData(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.connectionState == ConnectionState.waiting) {
            // Jika masih dalam proses loading, tampilkan CircularProgressIndicator di tengah layar.
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (ss.hasError) {
            // Jika terjadi kesalahan, tampilkan pesan kesalahan.
            return Text('Error: ${ss.error}');
          } else if (ss.hasData) {
            // Jika data tersedia, tampilkan daftar item.
            return Items(list: ss.data!);
          } else {
            // Jika tidak ada data, tampilkan pesan lain atau widget kosong.
            return Text('No Data');
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        return Container(
          margin: const EdgeInsets.all(7.0), // Atur margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0), // Atur radius border
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(1), // Warna shadow
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 2), // Offset shadow
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              list[i]['name']
                  .split(' ')
                  .map((String word) =>
                      word[0].toUpperCase() + word.substring(1))
                  .join(' '),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(list[i]['address']),
                Text(list[i]['salary']),
              ],
            ),
            leading: const Icon(Icons.text_snippet_outlined),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            dense: true,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Details(list: list, index: i),
            )),
          ),
        );
      },
    );
  }
}
