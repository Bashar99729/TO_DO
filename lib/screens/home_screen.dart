import 'package:flutter/material.dart';
import 'package:to_do/models/habit.dart';
import 'add_to_do.dart';
import 'package:provider/provider.dart';
import '../providers/add_to_do_provider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen();


  @override
  State<HomeScreen> createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'To Do',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        drawer: Drawer(backgroundColor: Colors.blue, child: Text('data')),
        body: Center(
       child:  Consumer<AddToDoProvider>(

          builder: (_,prov,__) {
            List<Habit> nonDon =prov.habits.where((h)=>h.isCompleted==false).toList();
            List<Habit> don =prov.habits.where((h)=>h.isCompleted==true).toList();
            return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  'للقيام به 📝',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Center(
                  child: nonDon.isEmpty?
                     Center(child: Text('لا وجد مهام للقيام بها'))
                   : ListView.builder(
                     itemCount: nonDon.length,

                     itemBuilder: (_, i) {
                       final h = nonDon[i];
                       return _listHabits(context, h, prov);
                     },
                   ),

                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'تم ✅🎉',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: don.isEmpty?Text(
                    'لا يوجد مهام مكتملة',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ): ListView.builder(
                      itemCount: don.length,
                      itemBuilder:(_,i){
                        final h=don[i];
                        return _listHabits(context, h, prov);
                  
                      }
                  )
                ),
              ),
            ],
          );}
        ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddToDo()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue.shade700,
          tooltip: 'إضافة عادات',
        ),
      ),

    );
  }

}
Icon cheakEnd (bool isCompleted){
  return  isCompleted?Icon(Icons.check_box,color: Colors.green):Icon(Icons.check_box_outline_blank);
}

Widget _listHabits(BuildContext context,Habit h,AddToDoProvider prov){

      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(

          onTap: () {
          },
          leading: IconButton(
            onPressed: (){prov.habitsIsCompleted(h.id);
            },
            icon: cheakEnd(h.isCompleted),
          ),

          title: Text('${h.title} (${h.duration.inHours}h ${h.duration.inMinutes%60}m)'),
          subtitle: Text('${h.dateTime}\n${h.notes}'),
          trailing: IconButton(
            onPressed: () {
              prov.removeHabit(h.id);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      );
}







