

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './transaction.dart';
import '../db/provider.dart';
import 'package:intl/intl.dart';




class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTrans;


  

  TransactionList(this.transactions, this.deleteTrans);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(children: <Widget>[
          SizedBox(height: 20,),
            Text(
              "لا يوجد مشتريات",
              style: TextStyle(fontSize: 30),
            ),
            // Container(
            //     height: 200,
            //     child: Image.asset(
            //       "assest/image/waiting.png",
            //       fit: BoxFit.cover,
            //     ))
          ]):
          Scaffold(
      
      body: 
      ChangeNotifierProvider<Trans>(
          create: (context) => Trans(),
          child: Consumer<Trans>(
                  builder: (context, provider, child) =>
      
      FutureBuilder(
          future: Provider.of<Trans>(context, listen: false).fetchData(),
          builder:(context, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
        ListView.builder(
            itemBuilder: (transcontext, index) {
              return Container(
                  child: Column(
                children: [
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: FittedBox(
                              child: Text(
                            "\$${transactions[index].amount}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      title: Text(transactions[index].title,
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(
                       DateFormat.yMMMd().format(transactions[index].date)),
                      
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTrans(transactions[index].id)),
                    ),
                  ),
                  // //             Container( width:5, decoration: BoxDecoration(
                  // // image: DecorationImage(
                  // //   image:
                  // //   fit: BoxFit.fill,),

                  //             )),
                ],
              ));
            },
            itemCount: transactions.length,
        
        ):
         SizedBox(height: 0.1)
        )
        )
        ));
        
        }
}









// transactions.isEmpty
//         ? Column(children: <Widget>[
//           SizedBox(height: 20,),
//             Text(
//               "لا يوجد مشتريات",
//               style: TextStyle(fontSize: 30),
//             ),
//             // Container(
//             //     height: 200,
//             //     child: Image.asset(
//             //       "assest/image/waiting.png",
//             //       fit: BoxFit.cover,
//             //     ))
//           ])
//         :FutureBuilder(
//           future: Provider.of<Trans>(context, listen: false).fetchData(),
//           builder:(context, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
//         ListView.builder(
//             itemBuilder: (transcontext, index) {
//               return Container(
//                   child: Column(
//                 children: [
//                   Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(
//                       vertical: 8,
//                       horizontal: 5,
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 30,
//                         child: Padding(
//                           padding: EdgeInsets.all(2),
//                           child: FittedBox(
//                               child: Text(
//                             "\$${transactions[index].amount}",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           )),
//                         ),
//                       ),
//                       title: Text(transactions[index].title,
//                           style: Theme.of(context).textTheme.headline6),
//                       subtitle: Text(
//                         DateFormat.yMMMd().format(transactions[index].date),
//                       ),
//                       trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           color: Theme.of(context).errorColor,
//                           onPressed: () => deleteTrans(transactions[index].id)),
//                     ),
//                   ),
//                   // //             Container( width:5, decoration: BoxDecoration(
//                   // // image: DecorationImage(
//                   // //   image:
//                   // //   fit: BoxFit.fill,),

//                   //             )),
//                 ],
//               ));
//             },
//             itemCount: transactions.length,
        
//         )
//         );
        
//         }
// }

