import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostUp extends StatefulWidget {
  final String image;
  final String description;
  final String date;
  final String time;

  PostUp(this.image,this.description,this.date,this.time);  

  _PostUpState createState() => _PostUpState();

}

class _PostUpState extends State<PostUp> {
/*  final String image;
  final String description;
  final String date;
  final String time;

  _PostUpState({this.image,this.description,this.date,this.time});*/

  void printer()  {
    var a = widget.image;
    var b = widget.description;
    var c = widget.date;
    var d = widget.time;
    print(" image = $a\ndescription = $b\ndate = $c\ntime  = $d");
    //print(" image = $widget.image\ndescription = $widget.description\ndate = $widget.date\ntime  = $widget.time");
  }

  void goToHomePage()
{
  Navigator.push
  (context,
   MaterialPageRoute(builder: (context)
   {
     return new HomePage();

   }
   )
   );
}

  Widget build(BuildContext context) {
    return new Scaffold
    (
      appBar: new AppBar
      ( centerTitle: true,
        title: new Text("Blog Viewer"),    
        
      ),
      body: new Container
      (
            
        child:// show image and complete text here
        
        PostsUI(widget.image, widget.description, widget.date, widget.time),
          
      ),
      
      bottomNavigationBar: new BottomAppBar
      (
        color: Colors.red,
        
        child: new Container
        (
        margin: const EdgeInsets.only(left:50.0,right: 50.0),
        child: new Row
        ( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>
          [
            new IconButton
            (
              icon: new Icon(Icons.home),
              iconSize: 50,
              color: Colors.white,

              onPressed: goToHomePage,
              
            ),
            // new IconButton
            // (
            //   icon: new Icon(Icons.account_circle_rounded),
            //   iconSize: 50,
            //   color: Colors.white,

            //   onPressed: null
            // ),
            new IconButton
            (
              icon: new Icon(Icons.add_a_photo),
              iconSize: 50,
              color: Colors.white,

              onPressed: (){
 
              },
            ),             
          ]
        ),
        ),
      ),
    );

  }

  Widget PostsUI(String image,String description,String date,String time)
  {
    return new Card
    (
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),

      child: new Container
      (
        padding: new EdgeInsets.all(14.0),
        child: new Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,

          children:<Widget>
           [
             new Row
             (
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:<Widget>
                [
                  new Text
                  (
                    date,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  new Text
                  (
                    time,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),             

                ],
             ),
             SizedBox(height:10.0,),

             new Image.network(image,fit:BoxFit.cover),

             SizedBox(height:10.0,),

              new Text
                  (
                    description,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),  
           ],
        ),
      ),

    );
  }


}