#!/usr/bin/env bash

echo "Generating full SQL script"
cat ./sql/base_schema.sql > database.sql
find ./sql -type f -name "*.sql" ! -name "base_schema.sql" -exec cat {} \; -exec echo \; -exec echo \; >> database.sql
echo "Done."

echo "Generating demo data file"
echo "USE DVD_Store;" > demo.sql
echo >> demo.sql
find ./demo -type f -name "*.sql" -exec cat {} \; -exec echo \; -exec echo \; >> demo.sql
echo "Done."

echo "Applying schema and demo data to database"
mysql -u root < ./database.sql
mysql -u root < ./demo.sql
echo "Done."