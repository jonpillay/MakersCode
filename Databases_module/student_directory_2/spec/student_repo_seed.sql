DROP TABLE IF EXISTS "public"."students";
DROP TABLE IF EXISTS "public"."cohorts";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS cohorts_id_seq;
CREATE SEQUENCE IF NOT EXISTS students_id_seq;

-- Table Definition
CREATE TABLE "public"."cohorts" (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

CREATE TABLE "public"."students" (
  id SERIAL PRIMARY KEY,
  name text,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id) on delete cascade
);

INSERT INTO "public"."cohorts" ("id", "name", "start_date") VALUES
(1, 'Nineteen Eighty-Four', '1985-01-01'),
(2, 'A Christmas Carol', '2023-02-01'),
(3, 'Fear and Loathing', '2023-03-07');

INSERT INTO "public"."students" ("id", "name", "cohort_id") VALUES
(1, 'Bill', 1),
(2, 'Sarah', 1),
(3, 'Jill', 2),
(4, 'Tony', 2),
(5, 'Sampson', 2),
(6, 'Seton', 2),
(7, 'Phaedra', 3),
(8, 'Jon', 3);