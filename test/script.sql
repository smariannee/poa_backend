CREATE DATABASE poa;

CREATE TYPE roles AS ENUM ('Administrator', 'Director', 'Assistant');
CREATE TYPE status AS ENUM ('Approved', 'Rejected', 'Pending');
CREATE TYPE status_activity AS ENUM ('Rejected', 'Done', 'In Process');

CREATE TABLE users (
    id serial primary key,
    name varchar(30) not null,
    lastname varchar(30) not null,
    email varchar(50) not null,
    password text not null,
    status boolean not null default true,
    role roles not null
);

CREATE TABLE areas (
    id serial primary key,
    area varchar(50) not null,
    status boolean not null,
    director int,
    assistant int,
    constraint fk_area_director foreign key (director) references users (id),
    constraint fk_area_assistant foreign key (assistant) references  users (id)
);

CREATE TABLE processes (
    id serial primary key,
    process varchar not null,
    process_number int not null,
    sheet_number int not null,
    status boolean not null
);

CREATE TABLE area_processes (
    id serial primary key,
    area int not null,
    process int not null,
    constraint fk_area foreign key (area) references areas (id),
    constraint fk_process foreign key (process) references processes (id)
);

CREATE TABLE periods (
    id serial primary key,
    period varchar not null,
    requested_date date not null,
    due_date date not null,
    adjourned_date date
);

CREATE TABLE annual_programmes (
    id serial primary key,
    status status not null,
    dates json,
    pdf_document text,
    area_process int not null,
    period int not null,
    constraint fk_poa_area_process foreign key (area_process) references area_processes (id),
    constraint fk_poa_period foreign key (period) references periods (id)
);

CREATE TABLE quarterly_reports (
    id serial primary key,
    pdf_document text,
    status status not null,
    period int not null,
    poa int not null,
    constraint fk_qr_period foreign key (period) references periods (id),
    constraint fk_qr_poa foreign key (poa) references annual_programmes (id)
);

CREATE TABLE measure_units (
    id serial primary key,
    measure_unit varchar not null,
    status boolean not null
);

CREATE TABLE activities (
    id serial primary key,
    activity varchar not null,
    status boolean not null,
    indicator_num int not null,
    indicator_type int not null,
    measure_unit int not null,
    constraint fk_activity_measure foreign key (measure_unit) references measure_units (id)
);

CREATE TABLE poa_activities (
    id serial primary key,
    status status_activity not null,
    annual_goal int not null,
    observations text,
    evidence text,
    poa int not null,
    activity int not null,
    constraint fk_poa foreign key (poa) references annual_programmes (id),
    constraint fk_activity foreign key (activity) references activities (id)
);

CREATE TABLE quarterly_goals (
    id serial primary key,
    quarter_number int not null,
    programmed_goal int not null,
    achieved_goal int not null,
    programmed_annual_goal int not null,
    achieved_annual_goal int not null,
    poa_activity int not null,
    constraint fk_goal_activity foreign key (poa_activity) references poa_activities (id)
);





