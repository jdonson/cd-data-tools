<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xml:lang="en-us" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>KillerPHP Video Tutorial: My First OOPlet</title>
	<link rel="stylesheet" media="screen" type="text/css" href="??.css" />
	<script type='text/javascript' src='??.js'></script>
<?php include("class_lib.php"); ?>
</head>
<body>
<?php

$first_object = new person();

$first_object->set_name("Stefan Mischook");

$first_object->get_name();

$jimmy = new person();

$jimmy->set_name("Nick Waddles");

$first_object->get_name();

echo "<hr/>FIRST OBJECT: <pre>",print_r($first_object), "</pre>";

echo "<hr/>SECOND OBJECT \$jimmy: <pre>", print_r($jimmy), "</pre>";

echo "<hr/>CLASSES: <pre>", print_r(get_declared_classes()), "</pre>";

echo "<hr/>FUNCTIONS: <pre>", print_r(get_defined_functions()), "</pre>";

?>
</body>
</html>