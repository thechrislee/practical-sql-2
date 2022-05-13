-- Chapter 2 Exercise 1:
CREATE TABLE animals(
	id bigserial,
	name varchar(50),
	age smallint
);

CREATE TABLE animal_info(
	id bigserial,
	name varchar(50),
	class varchar(50),
	ord varchar(50),
	family varchar(50),
	genus varchar(50),
	species varchar (50),
	birth_date date
)

-- Chapter 2 Exercise 2:
INSERT INTO animals(name, age)
VALUES ('Tony the Tiger', 70),
           ('Tucan Sam', 59),
           ('Chester Cheetah', 37);

INSERT INTO animal_info(name, class, ord, family, genus, species, birth_date)
VALUES ('Tony the Tiger','Mammalia', 'Carnivora', 'Felidae', 'Panthera', 'P. tigris', '1952-01-01'),
       ('Tucan Sam', 'Aves', 'Piciformes', 'Ramphastidae', 'Ramphastos', 'Ramphastos toco', '1963-01-01'),
       ('Chester Cheetah', 'Mammalia', 'Carnivora', 'Felidae', 'Acinonyx', 'A. jubatus', '1985-01-01');
