<?php

// Load SQL schema from file
$sqlSchema = file_get_contents(__DIR__ . '/../sql/schema.sql');

// Apply schema to database
$db = new PDO('mysql:host=localhost;dbname=scotchbox;', 'root', 'root');
$db->exec($sqlSchema);

