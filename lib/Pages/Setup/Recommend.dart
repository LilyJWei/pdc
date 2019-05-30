import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Recommend{

  int waiNum = 0,neiNum = 0,wuNum = 0,erNum = 0,piNum = 0,zhongNum = 0,fuNum = 0,qiNum = 0;
  List visitNum = [0,0,0,0,0,0,0,0];
  List visitPro = [0,0,0,0,0,0,0,0];

   var recommendDoc = List<DocumentSnapshot>();
  List tabs = ['内科','外科','五官科','儿科','皮肤科','中医科','妇产科','其他'];
  int recommendNum = 20;

//  getNums(){
//    FirebaseAuth.instance.currentUser().then((user){
//      Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).getDocuments()
//          .then((userDoc){
//         Firestore.instance.collection('users').document(userDoc.documents[0].documentID)
//         .collection('HistoryTopic').getDocuments().then((docs){
//           docs.documents.forEach((element){
//             DocumentReference reference = element['reftopic'];
//             String path = reference.path;
//             List splitPath = path.split('/');
//             String tab = splitPath[2];
//             if(tab == '外科'){
//               waiNum += 1;
//               visitNum[0] += 1;
//             }else if(tab == '内科'){
//               neiNum += 1;
//               visitNum[1] += 1;
//             }else if(tab == '五官科'){
//               wuNum += 1;
//               visitNum[2] += 1;
//             }else if(tab == '儿科'){
//               erNum += 1;
//               visitNum[3] += 1;
//             }else if(tab == '皮肤科'){
//               piNum += 1;
//               visitNum[4] += 1;
//             }else if(tab == '中医科'){
//               zhongNum += 1;
//               visitNum[5] += 1;
//             }else if(tab == '妇产科'){
//               fuNum += 1;
//               visitNum[6] += 1;
//             }else{
//               qiNum += 1;
//               visitNum[7] += 1;
//             }
//           });
//           print(visitNum);
//           int sum = 0;
//           visitNum.forEach((num){
//             sum = sum + num;
//           });
//           for(int i = 0; i < 8; i++){
//             int tmp = (visitNum[i] / sum * recommendNum).round();
//             visitPro[i] = tmp;
//           }
//           //print(visitPro);
//           return visitPro;
//         });
//      });
//    });
//  }
  getDocs() {
    FirebaseAuth.instance.currentUser().then((user) {
      return Firestore.instance.collection('users').where(
          'uid', isEqualTo: user.uid).getDocuments();
    }).then((userDoc) {
      return Firestore.instance.collection('users').document(
          userDoc.documents[0].documentID)
          .collection('HistoryTopic').snapshots();
    });
  }



  getNums(docs){
    docs.documents.forEach((element){
      DocumentReference reference = element['reftopic'];
      String path = reference.path;
      List splitPath = path.split('/');
      String tab = splitPath[2];
      if(tab == '内科'){
        visitNum[0] += 1;
      }else if(tab == '外科'){
        visitNum[1] += 1;
      }else if(tab == '五官科'){
        visitNum[2] += 1;
      }else if(tab == '儿科'){
        visitNum[3] += 1;
      }else if(tab == '皮肤科'){
        visitNum[4] += 1;
      }else if(tab == '中医科'){
        visitNum[5] += 1;
      }else if(tab == '妇产科'){
        visitNum[6] += 1;
      }else{
        visitNum[7] += 1;
      }
      //print(visitNum);
      int sum = 0;
      visitNum.forEach((num){
        sum = sum + num;
      });
        for(int i = 0; i < 8; i++){
          if(sum == 0){
            visitPro[i] = 1;
          }else{
            int tmp = (visitNum[i] / sum * recommendNum).round();
            visitPro[i] = tmp;
          }
        }
    });
    if(docs.documents.length == 0){
      return [3,3,3,3,3,3,3,3];
    }
    return visitPro;
  }

  getQuesNums(docs){
    docs.documents.forEach((element){
      DocumentReference reference = element['refquestion'];
      String path = reference.path;
      List splitPath = path.split('/');
      String tab = splitPath[2];
      if(tab == '内科'){
        visitNum[0] += 1;
      }else if(tab == '外科'){
        visitNum[1] += 1;
      }else if(tab == '五官科'){
        visitNum[2] += 1;
      }else if(tab == '儿科'){
        visitNum[3] += 1;
      }else if(tab == '皮肤科'){
        visitNum[4] += 1;
      }else if(tab == '中医科'){
        visitNum[5] += 1;
      }else if(tab == '妇产科'){
        visitNum[6] += 1;
      }else{
        visitNum[7] += 1;
      }
      //print(visitNum);
      int sum = 0;
      visitNum.forEach((num){
        sum = sum + num;
      });
      for(int i = 0; i < 8; i++){
        if(sum == 0){
          visitPro[i] = 1;
        }else{
          int tmp = (visitNum[i] / sum * recommendNum).round();
          visitPro[i] = tmp;
        }
      }
    });
    if(docs.documents.length == 0){
      return [3,3,3,3,3,3,3,3];
    }
    return visitPro;
  }

}