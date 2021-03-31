import 'package:flutter/material.dart';
import 'package:test_haup/services/getCategories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loadData = false;
  bool _isSearch = false;
  List<String> _list;
  List _searchresult = [];
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_loadData = true) {
              _controller.clear();
              _isSearch = false;
            }
            _loadData = true;
          });
        },
        child: (_loadData == false)
            ? Icon(Icons.download_sharp)
            : Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(hintText: 'search'),
                controller: _controller,
                onChanged: searchList,
              ),
              flex: 1,
            ),
            (_loadData == false)
                ? Expanded(
                    child: Center(child: Text('No Data')),
                    flex: 10,
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          _list = snapshot.data;
                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (_isSearch == false)
                                        ? snapshot.data.length
                                        : _searchresult.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          height: 40,
                                          child: Center(
                                              child: Text(
                                            (_isSearch == false)
                                                ? snapshot.data[index]
                                                : _searchresult[index],
                                            style: TextStyle(fontSize: 20),
                                          )));
                                    })
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    flex: 10,
                  ),
          ],
        ),
      ),
    );
  }

  void searchList(String searchText) {
    setState(() {
      _isSearch = true;
      _searchresult.clear();
      if (_list != null) {
        for (int i = 0; i < _list.length; i++) {
          String data = _list[i];
          if (data.toLowerCase().contains(searchText.toLowerCase())) {
            _searchresult.add(data);
          }
        }
        if (_searchresult.length == 0) {
          _searchresult.add('No Data');
        }
      }
    });
  }
}
