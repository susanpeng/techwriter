<?php
//var_dump($_POST);

//if (1){
if($_POST){
$name = $_POST["name"];
$email = $_POST["email"];
$message = $_POST["msg"];
/*
$name = "Susan";
$email = "cibeixishe.2012@gmail.com";
$message = "hello2";
*/


echo("<p>".$name.$email.$message."</p>");

$to = "pengyl@gmail.com";
$subject = "testing Emails";
$body = "Name: ".$name."\nEmail: ".$email."\nMessage: ".$message;
$headers = "From: ". $email;

//send email
//mail($to, $subject, $body, $headers);

	if (mail($to,$subject,$body,$headers)) {
		echo("<p>success 1</p>");}
	else{
		echo("<p>failed 1</p>");}

}

?>
