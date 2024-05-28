CREATE DATABASE empdatabase;
USE empdatabase;
CREATE TABLE depttable (
  Dept_No INTEGER PRIMARY KEY,
  Dept_Name TEXT NOT NULL,
  Head_Name TEXT NOT NULL
);

-- dept table
INSERT INTO depttable (Dept_No, Dept_Name, Head_Name) VALUES (1, 'Human Resources', 'Khurseed');
INSERT INTO depttable (Dept_No, Dept_Name, Head_Name) VALUES (2, 'Finance', 'Alina');
INSERT INTO depttable (Dept_No, Dept_Name, Head_Name) VALUES (3, 'Marketing', 'Alisha');
INSERT INTO depttable (Dept_No, Dept_Name, Head_Name) VALUES (4, 'Information Technology', 'Michael');

CREATE TABLE emptable (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  address TEXT NOT NULL,
  phone TEXT NOT NULL,
  dept_no INTEGER NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES depttable(Dept_No)
);

-- emp table
INSERT INTO emptable VALUES (1, 'Maryum', 'maryum@example.com', 'GNoida', '9576325841', 1);
INSERT INTO emptable VALUES (2, 'Urooj', 'urooj@example.com', 'GNoida', '0522136954', 4);
INSERT INTO emptable VALUES (3, 'Ahmed', 'ahmed@example.com', 'GNoida', '9855497865', 4);
INSERT INTO emptable VALUES (4, 'qadija', 'qadija@example.com', 'BSB', '9853698465', 3);
INSERT INTO emptable VALUES (5, 'Areesha', 'areesha@example.com', 'BSB', '9855498235', 2);
INSERT INTO emptable VALUES (6, 'shina', 'shina@example.com', 'GNoida', '9851678465', 1);
INSERT INTO emptable VALUES (7, 'Yasir', 'yasir@example.com', 'BSBS', '9856723465', 3);
INSERT INTO emptable VALUES (8, 'John', 'john@example.com', 'GNoida', '9851238465', 1);
INSERT INTO emptable VALUES (9, 'Emily', 'emily@example.com', 'GNoida', '9855498123', 2);
INSERT INTO emptable VALUES (10, 'Michael', 'michael@example.com', 'BSB', '9853698521', 3);
INSERT INTO emptable VALUES (11, 'Sophia', 'sophia@example.com', 'BSB', '9855498965', 4);
INSERT INTO emptable VALUES (12, 'William', 'william@example.com', 'GNoida', '9851678546', 1);
INSERT INTO emptable VALUES (13, 'Emma', 'emma@example.com', 'BSBS', '9856723485', 3);
INSERT INTO emptable VALUES (14, 'James', 'james@example.com', 'GNoida', '9855498547', 2);
INSERT INTO emptable VALUES (15, 'Olivia', 'olivia@example.com', 'GNoida', '9853698532', 4);
INSERT INTO emptable VALUES (16, 'Alexander', 'alexander@example.com', 'BSB', '9855498214', 3);
INSERT INTO emptable VALUES (17, 'Isabella', 'isabella@example.com', 'GNoida', '9851678564', 1);
INSERT INTO emptable VALUES (18, 'Mason', 'mason@example.com', 'BSBS', '9856723478', 2);
INSERT INTO emptable VALUES (19, 'Evelyn', 'evelyn@example.com', 'GNoida', '9855498796', 4);
INSERT INTO emptable VALUES (20, 'Ethan', 'ethan@example.com', 'GNoida', '9853698579', 3);

-- Update trying
UPDATE emptable SET address = 'Delhi' WHERE id = 5;

SELECT * FROM emptable;
SELECT * FROM depttable;


SELECT e.id, e.name, e.email, e.address, e.phone, d.Dept_Name, d.Head_Name
FROM emptable e
INNER JOIN depttable d ON e.dept_no = d.Dept_No;

SELECT e.id, e.name, e.email, e.address, e.phone, d.Dept_Name, d.Head_Name
FROM emptable e
LEFT JOIN depttable d ON e.dept_no = d.Dept_No;

SELECT e.id, e.name, e.email, e.address, e.phone, d.Dept_Name, d.Head_Name
FROM emptable e
RIGHT JOIN depttable d ON e.dept_no = d.Dept_No;

SELECT e.id, e.name, e.email, e.address, e.phone, d.Dept_Name, d.Head_Name
FROM emptable e
FULL OUTER JOIN depttable d ON e.dept_no = d.Dept_No;

