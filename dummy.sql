-- Dummy SQL queries to ensure GitHub detects SQL

CREATE TABLE dummy_table (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO dummy_table (id, name)
VALUES (1, 'Test'), (2, 'Example');

SELECT * FROM dummy_table;

DROP TABLE dummy_table;