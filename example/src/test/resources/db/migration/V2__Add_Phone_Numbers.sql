ALTER TABLE PERSON ADD PHONE_NUMBER BIGINT;

UPDATE PERSON SET PHONE_NUMBER = 1234567 WHERE ID = 1;
UPDATE PERSON SET PHONE_NUMBER = 2345678 WHERE ID = 2;
UPDATE PERSON SET PHONE_NUMBER = 3456789 WHERE ID = 3;