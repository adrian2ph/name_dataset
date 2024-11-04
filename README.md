# First and Last Names Database


## Installation

```sql
drop table if exists name_dataset;
-- auto-generated definition
create table if not exists name_dataset
(
    id           int auto_increment
        primary key,
    first_name   varchar(100) default '' not null,
    last_name    varchar(100) default '' not null,
    gender       char         default '' not null,
    country_code char(2)      default '' not null
) collate=utf8mb4_unicode_ci;


LOAD DATA INFILE '/var/lib/mysql-files/US_en_unique.csv'
INTO TABLE name_dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(@first_name, @last_name, @gender, @country_code)
SET
  first_name = LEFT(@first_name, 100),
  last_name = LEFT(@last_name, 100),
  gender = @gender,
  country_code = @country_code;
```

```
mysqldump --add-drop-table -u root -p freeim name_dataset > name_dataset_dump.sql
```

## Usage

* remove charset and lock table
* build the iamge

```shell
docker buildx build  . --platform linux/amd64 -t adrian2armstrong/name_dataset:us
```

* import the table name_dataset to your db
  
```shell
docker run --rm -d adrian2armstrong/name_dataset:us /bin/sh -c "mysql -u jalaim -h jalaim.cluster-cjacqo8m6n3h.ap-southeast-3.rds.amazonaws.com -p'jalaim(IJN8uhb&YGttfd&#WSXbk' freeim  < name_dataset_dump.sql"
```

## Full dataset

The dataset is available here [name_dataset.zip (3.3GB)](https://drive.google.com/file/d/1QDbtPWGQypYxiS4pC_hHBBtbRHk9gEtr/view?usp=sharing).

<img width="284" alt="image" src="https://user-images.githubusercontent.com/4516927/220814570-85340302-4c49-4648-b1c8-dedebd0e570b.png">

- The data contains **491,655,925** records from 106 countries. 
- The uncompressed version takes around 10GB on the disk.
- Each country is in a separate CSV file.
- A CSV file contains rows of this format: first_name,last_name,gender,country_code. 
- Each record is a real person.

## ref

https://github.com/philipperemy/name-dataset/tree/master