import 'dart:convert';

import 'package:api_expmple/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {

  List<PostsModel> postList =[]; // if listname is available to not need this line of code
  Future<List<PostsModel>> maazakbar() async {
    try {
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
       // postList.clear();
        List<PostsModel> tempList = [];
        for (Map i in data) {
          tempList.add(PostsModel.fromJson(i));
        }
        return tempList; // Return the list of posts
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Api example"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: maazakbar(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Text('Loading');

                }else{
                  postList = snapshot.data!;
                  return  ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context,index){


                    return  Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "UserId:\t",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16, // Example font size
                                      color: Colors.blue, // Example color
                                    ),
                                  ),
                                  TextSpan(
                                    text: postList[index].userId.toString(),
                                  ),
                                ],
                              ),
                            ),


                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Id:\t",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16, // Example font size
                                      color: Colors.blue, // Example color
                                    ),
                                  ),
                                  TextSpan(
                                    text: postList[index].id .toString(),
                                  ),
                                ],
                              ),
                            ),

                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Titile:\t",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16, // Example font size
                                      color: Colors.blue, // Example color
                                    ),
                                  ),
                                  TextSpan(
                                    text: postList[index].title.toString(),
                                  ),
                                ],
                              ),
                            ),


                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Body:\t",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16, // Example font size
                                      color: Colors.blue, // Example color
                                    ),
                                  ),
                                  TextSpan(
                                    text: postList[index].body.toString(),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );


                  });
                }
              },
            ),
          )

        ],
      ),
    );
  }
}

