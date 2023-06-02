DROP DATABASE poa;

CREATE DATABASE poa;

CREATE TYPE roles AS ENUM ('Administrator', 'Director', 'Assistant');
-- To validate activities
CREATE TYPE status_check AS ENUM ('Approved', 'Rejected', 'Pending');
-- To manage the activity's process
CREATE TYPE status_activity AS ENUM ('Rejected', 'Done', 'In Process');
-- To manage when the activities were done
CREATE TYPE status_time AS ENUM ('On time', 'Reprogram', 'Early');
-- To manage the delivery date of the POA and the quarterly reports
CREATE TYPE status_delivery AS ENUM ('Delivered on time', 'Delivered late');
--SELECT unnest(enum_range(NULL::enum_name)) AS valor_enum;
CREATE TABLE users
(
    id               serial primary key,
    name             varchar(30) not null,
    lastname         varchar(30) not null,
    email            varchar(50) not null unique,
    password         text        not null,
    phone_number     varchar     not null,
    extension_number varchar     not null,
    status           boolean     not null default true,
    role             roles       not null
);
CREATE TABLE areas
(
    id           serial primary key,
    title        varchar(50) not null unique,
    abbreviation varchar(20) not null unique,
    status       boolean     not null default true,
    director     int,
    assistant    int,
    constraint fk_area_director foreign key (director) references users (id),
    constraint fk_area_assistant foreign key (assistant) references users (id)
);
CREATE TABLE processes
(
    id             serial primary key,
    tittle         varchar not null unique,
    process_number int     not null,
    sheet_number   int,
    status         boolean not null default true
);
CREATE TABLE area_processes
(
    id      serial primary key,
    area    int not null,
    process int not null,
    constraint fk_area foreign key (area) references areas (id),
    constraint fk_process foreign key (process) references processes (id)
);
CREATE TABLE periods
(
    id             serial primary key,
    title          varchar not null,
    requested_date date    not null,
    due_date       date    not null,
    adjourned_date date
);
CREATE TABLE indicator_numbers
(
    id               serial primary key,
    indicator_number varchar,
    status           boolean not null default true
);
CREATE TABLE measure_units
(
    id           serial primary key,
    title varchar not null unique,
    status       boolean not null default true
);
CREATE TABLE annual_programmes
(
    id           serial primary key,
    area         json            not null,
    process      json            not null,
    activities   json            not null,
    status       status_delivery not null,
    date         date            not null default now(),
    pdf_document text,
    period       int             not null,
    constraint fk_poa_period foreign key (period) references periods (id)
);
/*
{
    "activity": {
        "name": "Activity 1",
        "annual_goal": 100,
        "measure_unit": "visits",
        "indicators": {
            "type": 1,
            "number": "indicator number example"
        },
        "status_activity": "In Process",
        "quarters": {
            "1": {
                "status_time": "On Time",
                "status_check": "Pending",
                "goals": {
                    "quarterly_scheduled_goal": 25,
                    "quarterly_achieved_goal": 20,
                    "annual_scheduled_goal": 25,
                    "annual_achieved_goal": 20
                },
                "comments": "comments example",
                "evidence": "evidence.pdf"
            },
            "2": {
                "status_time": "On Time",
                "status_check": "Pending",
                "goals": {
                    "quarterly_scheduled_goal": 25,
                    "quarterly_achieved_goal": 20,
                    "annual_scheduled_goal": 25,
                    "annual_achieved_goal": 20
                },
                "comments": "comments example",
                "evidence": "evidence.pdf"
            },
            "3": {
                "status_time": "On Time",
                "status_check": "Pending",
                "goals": {
                    "quarterly_scheduled_goal": 25,
                    "quarterly_achieved_goal": 20,
                    "annual_scheduled_goal": 25,
                    "annual_achieved_goal": 20
                },
                "comments": "comments example",
                "evidence": "evidence.pdf"
            }
        }
    }
}
*/
CREATE TABLE quarterly_reports
(
    id           serial primary key,
    status       status_delivery not null,
    date         date            not null default now(),
    pdf_document text,
    period       int             not null,
    poa          int             not null,
    constraint fk_period foreign key (period) references periods (id),
    constraint fk_poa foreign key (poa) references annual_programmes (id)
);


CREATE VIEW areas_users AS
SELECT a.id           AS area_id,
       a.title        AS area_title,
       a.abbreviation AS area_abbreviation,
       u.id           AS assistant_id,
       u.name         AS assistant_name,
       u.lastname     AS assistant_lastname,
       u.email        AS assistant_email,
       u.role         AS assistant_role,
       u2.id          AS director_id,
       u2.name        AS director_name,
       u2.lastname    AS director_lastname,
       u2.email       AS director_email,
       u2.role        AS director_role
FROM areas a
         LEFT JOIN users u ON u.id = a.assistant
         LEFT JOIN users u2 ON u2.id = a.director;


-- Insert

INSERT INTO areas (id, title, abbreviation)
VALUES (1, 'Secretaría Academica', 'SRIA. ACADEMICA');
INSERT INTO areas (id, title, abbreviation)
VALUES (2, 'División Academica1', 'DATID');
INSERT INTO areas (id, title, abbreviation)
VALUES (3, 'División Academica2', 'DAMI');
INSERT INTO areas (id, title, abbreviation)
VALUES (4, 'División Academica3', 'DACEA');
INSERT INTO areas (id, title, abbreviation)
VALUES (5, 'División Academica4', 'DATEFI');
INSERT INTO areas (id, title, abbreviation)
VALUES (6, 'División Academica5', 'DAF');
INSERT INTO areas (id, title, abbreviation)
VALUES (7, 'Dirección de Planeación y Servicios Escolares', 'DPSE');
INSERT INTO areas (id, title, abbreviation)
VALUES (8, 'ABOGADO GENERAL', 'ABOGADO GENERAL');


INSERT INTO public.users (id, name, lastname, email, password, phone_number, extension_number, status, role)
VALUES (DEFAULT, 'Joel', 'Herrera', 'joel@utez.edu.mx', '123456', '7774138126', '55', DEFAULT, 'Assistant'::roles),
       (DEFAULT, 'Mario', 'Perez', 'mario@utez.edu.mx', '123456', '6776862478', '47', DEFAULT, 'Director'::roles),
       (DEFAULT, 'Carlos', 'Martinez', 'carlos@utez.edu.mx', '123456', '9079766678', '24', DEFAULT, 'Assistant'::roles);



SELECT a.id           AS area_id,
       a.title        AS area_title,
       a.abbreviation AS area_abbreviation,
       u.id           AS assistant_id,
       u.name         AS assistant_name,
       u.lastname     AS assistant_lastname,
       u.email        AS assistant_email,
       u.role         AS assistant_role,
       u2.id          AS director_id,
       u2.name        AS director_name,
       u2.lastname    AS director_lastname,
       u2.email       AS director_email,
       u2.role        AS director_role
FROM areas a
         LEFT JOIN users u ON u.id = a.assistant
         LEFT JOIN users u2 ON u2.id = a.director;



