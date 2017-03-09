<?php
$message = "";
$subject = "Kein Betreff gesetzt";
$recipient = 'norbert@familie-steiner.net';

if (isset($_GET['subject'])) {
  $subject = $_GET['subject'];
}

if (isset($_GET['recipient'])) {
  $recipient = $_GET['recipient'];
}

if (isset($_GET['message'])) {
  $message = $_GET['message'];
}

// Falls eine Zeile der Nachricht mehr als 70 Zeichen enthaelten koennte,
// sollte wordwrap() benutzt werden
$message = wordwrap($message, 70);

// Send
mail($recipient, $subject, $message);
?>
