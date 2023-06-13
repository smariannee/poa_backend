drop database if exists poa;
create database poa;

-- formato de fecha dd/mm/yyyy
set datestyle = dmy;

-- roles para los usuarios
create type roles as enum ('Administrador','Director','Asistente');
-- estados para permitir al administrador conocer el estado del llenado del formato poa por parte de los directores
create type poa_filling_status as enum ('En planeacion','Completado');
-- estados para conocer el progreso de las actividades
create type activity_progress_status as enum ('En proceso','Completada','Cancelada');
-- estados para llevar control de las metas alcanzadas y programadas de las actividades
create type activity_timing_status as enum ('Reprogramada','Cumplida','Adelantada');
-- estados para que el administrador pueda validar las actividades
create type activity_check_status as enum ('Pendiente','Aprobada','Rechazada');

create table if not exists users (
    id serial primary key,
    name varchar not null,
    lastname1 varchar not null,
    lastname2 varchar not null,
    email varchar not null unique,
    password text not null,
    phone_number varchar,
    extension_number varchar,
    status boolean not null default true,
    availability boolean not null default true,
    role roles not null,
    reset_token text
);

create table areas (
    id serial primary key,
    name varchar not null unique,
    abbreviation varchar,
    status boolean not null default true,
    director int not null,
    assistant int not null,
    constraint fk_area_director foreign key (director) references users (id),
    constraint fk_area_assistant foreign key (assistant) references users (id)
);

create table processes (
    id serial primary key,
    name varchar not null unique,
    number int,
    sheet_number int,
    status boolean not null default true
);

-- tabla intersección de áreas y procesos
create table area_processes (
    id serial primary key,
    area int not null,
    process int not null,
    status boolean not null default true,
    constraint fk_area foreign key (area) references areas (id),
    constraint fk_process foreign key (process) references processes (id)
);

create table periods (
    id serial primary key,
    name varchar not null,
    requested_date date not null,
    due_date date not null,
    adjourned_date date not null
);

create table measure_units (
    id serial primary key,
    name varchar not null unique,
    status boolean not null default true
);

create table indicator_numbers (
    id serial primary key,
    name varchar not null unique,
    status boolean not null default true
);

create table annual_programmes (
    id serial primary key,
    fill_status poa_filling_status,
    delivery_date date,
    delivery_status boolean,
    pdf_document text,
    area_process int not null,
    period int not null,
    constraint fk_poa_area_process foreign key (area_process) references area_processes (id),
    constraint fk_poa_period foreign key (period) references periods (id)
);

create table activities (
    id serial primary key,
    name varchar not null,
    date date not null,
    programmed_annual_goal int not null,
    final_annual_goal int not null,
    cumulative_goal int not null default 0,
    measure_unit int not null,
    indicator_number int not null,
    indicator_type int not null,
    progress_status activity_progress_status not null default 'En proceso',
    poa int not null,
    constraint fk_activity_poa foreign key (poa) references annual_programmes (id),
    constraint fk_activity_measure_unit foreign key (measure_unit) references measure_units (id),
    constraint fk_activity_indicator_number foreign key (indicator_number) references indicator_numbers (id)
);

create table quarters (
    id serial primary key,
    quarter int not null,
    timing_status activity_timing_status,
    check_status activity_check_status not null default 'Pendiente',
    cumulative_annual_goal int not null default 0,
    quarterly_programmed_goal int not null,
    final_quarterly_programmed_goal int not null,
    quarterly_achieved_goal int not null default 0,
    extra_activities int,
    reprogrammed_activities int,
    observations text,
    evidence text,
    activity int not null,
    constraint fk_quarter_activity foreign key (quarter) references activities (id)
);

create table quarterly_reports (
    id serial primary key,
    delivery_date date,
    delivery_status boolean,
    pdf_document text,
    poa int not null,
    period int not null,
    constraint fk_quarterly_report_poa foreign key (poa) references annual_programmes (id),
    constraint fk_quarterly_report_period foreign key (period) references periods (id)
);

-- vista para mostrar a un usuario con su área
create or replace view users_view as
    select u.id, CONCAT(u.name, ' ', u.lastname1, ' ', u.lastname2) as fullname, u.email, u.phone_number, u.extension_number, u.status, u.availability, u.role, a.name as area
        from areas a
        inner join users u on a.director = u.id or a.assistant = u.id;

-- vista para mostrar un área con su director y su asistente
create or replace view areas_view as
    select a.id, a.name, a.abbreviation, a.status, CONCAT(u.name, ' ', u.lastname1, ' ', u.lastname2) as director, CONCAT(u2.name, ' ', u2.lastname1, ' ', u2.lastname2) as assistant
        from areas a
        inner join users u on u.id = a.director
        inner join users u2 on u2.id = a.assistant;

-- vista para mostrar las áreas con sus procesos
create or replace view area_processes_view as
    select ap.id, a.id as id_area, a.name as area, p.id as id_process, p.name as process
        from area_processes ap
        inner join areas a on a.id = ap.area
        inner join processes p on p.id = ap.process;

-- vista para ver todos los programas operativos anuales por área, proceso y/o periodo
create or replace view annual_programmes_view as
    select poa.id, a.id as id_area, a.name as area, p.id as id_process, p.name as process, poa.fill_status, poa.delivery_date, poa.delivery_status, poa.pdf_document, pe.id as id_period, pe.name as period
        from annual_programmes poa
        inner join area_processes ap on ap.id = poa.area_process
        inner join areas a on a.id = ap.area
        inner join processes p on p.id = ap.process
        inner join periods pe on pe.id = poa.period;

-- vista para ver toda la información de un programa operativo anual
--create or replace view poa_format_view as
   -- select a.name as activity, mu.name as measure_unit, a.programmed_annual_goal, q.quarter, q.quarterly_programmed_goal, q.quarterly_achieved_goal, in.name as indicator_number,

-- vista para ver todos los reportes cuatrimestrales por poa y/o periodo
create or replace view quarterly_reports_view as
    select qr.id, poa.id as id_poa, a.name as area, p.name as process, qr.delivery_date, qr.delivery_status, qr.pdf_document, pe.id as id_period, pe.name as period
        from quarterly_reports qr
        inner join annual_programmes poa on poa.id = qr.poa
        inner join area_processes ap on ap.id = poa.area_process
        inner join areas a on a.id = ap.area
        inner join processes p on p.id = ap.process
        inner join periods pe on pe.id = qr.period;

-- vista para ver todas las actividades por programa operativo anual
create or replace view activities_view as
    select a.id, a.name, a.date, a.programmed_annual_goal, a.final_annual_goal, a.cumulative_goal, mu.name as measure_unit, inu.name as indicator_number, a.indicator_type, a.progress_status, poa.id as id_poa
        from activities a
        inner join measure_units mu on mu.id = a.measure_unit
        inner join indicator_numbers inu on inu.id = a.indicator_number
        inner join annual_programmes poa on poa.id = a.poa;

-- vista para ver todas las metas y estados cuatrimestrales de cada actividad
create or replace view quarters_view as
    select q.id, q.quarter, q.timing_status, q.check_status, q.cumulative_annual_goal, q.quarterly_programmed_goal, q.final_quarterly_programmed_goal, q.quarterly_achieved_goal, q.extra_activities, q.reprogrammed_activities, q.observations, q.evidence, a.id as id_activity, a.name as activity
        from quarters q
        inner join activities a on a.id = q.activity;

insert into users(name, lastname1, lastname2, email, password, phone_number, extension_number, role) values('Emmanuel', 'Narváez', 'Bahena', 'emmanuelnarvaez@utez.edu.mx', 'En123456.', '777 123 45 67', '123', 'Administrador');
insert into users(name, lastname1, lastname2, email, password, phone_number, extension_number, role) values('Martha Fabiola', 'Wences', 'Díaz', 'fabiolawences@utez.edu.mx', 'Fw123456.', '777 123 45 67', '123', 'Director');
insert into users(name, lastname1, lastname2, email, password, phone_number, extension_number, role) values('Juan', 'Murillo', 'Torres', 'juanmurillo@utez.edu.mx', '12345678', '777 123 45 67', '123', 'Asistente');
insert into users(name, lastname1, lastname2, email, password, phone_number, extension_number, role) values('Víctor', 'Pérez', 'Aguilar', 'victorperez@utez.edu.mx', 'Vp123456.', '777 123 45 67','123', 'Director');
insert into users(name, lastname1, lastname2, email, password, phone_number, extension_number, role) values('María', 'Herrera', 'Sandoval', 'mariaherrera@utez.edu.mx', '12345678', '777 123 45 67', '123', 'Asistente');

insert into areas(name, director, assistant) values('Secretaría Académica', 4, 5);
insert into areas(name, abbreviation, director, assistant) values('División Académica de Tecnologías de la Información y Comunicación', 'DATIC', 2, 3);

insert into processes(name, number) values('Mejoramiento de la capacidad académica', 1);
insert into processes(name, number) values('Incremento de la competitividad académica', 2);

insert into area_processes(area, process) values(1, 1);
insert into area_processes(area, process) values(1, 2);
insert into area_processes(area, process) values(2, 1);

select * from quarterly_reports_view;