import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


  String email = "fillproject966@gmail.com";
  String password  = "kjpu8vk6";
class ResetPassword{
  
  String recipent; 
  ResetPassword({this.recipent});

  
  
  Future<void> sendEmail(String recipent) async {

   final smtpServer = gmail(email, password); 
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(email)
    ..recipients.add(recipent) //recipent email
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
   // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
    ..text = 'This is the plain text.\nThis is line 2 of the text part.';//body of the email

         try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n'+ e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
  }

  
 
}