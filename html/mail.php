<?php
// Die Nachricht
$message = "";

$subject = "Kein Betreff gesetzt";

if (isset($_GET['subject'])) {
  $subject = $_GET['subject'];
}

// Falls eine Zeile der Nachricht mehr als 70 Zeichen enthaelten koennte,
// sollte wordwrap() benutzt werden
$message = wordwrap($message, 70);

// Send
mail('norbert@familie-steiner.net', $subject, $message);
?>
