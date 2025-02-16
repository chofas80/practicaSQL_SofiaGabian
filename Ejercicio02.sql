-- Crear la tabla students
create table students (
    id serial primary key,
    name varchar(100),
    surnames varchar(255),
    nif varchar(25),
    email varchar(255) not null,
    phone varchar(20),
    birthdate date,
    registration_date date not null,
    usser varchar(50) not null,
    pass varchar(50) not null,
    permissions varchar(255),
    active boolean not null
);

alter table students
add constraint unique_email_student unique (email);

alter table students
add constraint unique_usser_student unique (usser);

create index idx_registration_date_students on students (registration_date);


-- Crear la tabla teachers
create table teachers (
    id serial primary key,
    name varchar(100),
    surnames varchar(255),
    nif varchar(25),
    email varchar(255) not null,
    phone varchar(20),
    specialty varchar(100),
    registration_date date not null,
    usser varchar(50) not null,
    pass varchar(50) not null,
    permissions varchar(255),
    active boolean not null
);

alter table teachers
add constraint unique_email_teacher unique (email);

alter table teachers
add constraint unique_usser_teacher unique (usser);

create index idx_registration_date_teachers on teachers (registration_date);


-- Crear la tabla bootcamps
create table bootcamps (
    id serial primary key,
    name varchar(255),
    description text,
    hours_total int,
    start_date date not null,
    end_date date not null,
    id_responsible int not null,
    total_cost float,
    active boolean not null,
    foreign key (id_responsible) references teachers(id)
);

create index idx_start_date_bootcamps on bootcamps (start_date);
create index idx_end_date_bootcamps on bootcamps (end_date);


-- Crear la tabla courses
create table courses (
    id serial primary key,
    name varchar(255),
    description text,
    hours_total int,
    start_date date not null,
    end_date date not null,
    id_teacher int not null,
    id_bootcamp int not null,
    active boolean not null,
    practice_name varchar(255),
    pratice_description text,
    foreign key (id_teacher) references teachers(id),
    foreign key (id_bootcamp) references bootcamps(id)
);

create index idx_start_date_courses on courses (start_date);
create index idx_end_date_courses on courses (end_date);


-- Crear la tabla registrations
create table registrations (
    id serial primary key,
    id_student int not null,
    id_bootcamp int not null,
    id_course int not null,
    foreign key (id_student) references students(id),
    foreign key (id_bootcamp) references bootcamps(id),
    foreign key (id_course) references courses(id)
);


-- Crear la tabla course_materials
create table course_materials (
    id serial primary key,
    name varchar(255),
    observations text,
    format varchar(50) not null,
    id_course int not null,
    id_teacher int not null,
    foreign key (id_course) references courses(id),
    foreign key (id_teacher) references teachers(id)
);

create index idx_format_course_materials on course_materials (format);

-- Crear la tabla practices_course
create table practices_course (
    id serial primary key,
    id_student int not null,
    id_course int not null,
    approved int not null,
    observations text,
    delivery_date date not null,
    attempt_number int not null,
    foreign key (id_student) references students(id),
    foreign key (id_course) references courses(id)
);

create index idx_approved_practices_course on practices_course (approved);
create index idx_delivery_date_practices_course on practices_course (delivery_date);
create index idx_attempt_number_practices_course on practices_course (attempt_number);

-- Crear la tabla final_projects
create table final_projects (
    id serial primary key,
    name varchar(255),
    team_number int,
    id_student int not null,
    id_bootcamp int not null,
    approved int not null,
    observations text,
    delivery_date date not null,
    foreign key (id_student) references students(id),
    foreign key (id_bootcamp) references bootcamps(id)
);

create index idx_approved_final_projects on final_projects (approved);
create index idx_delivery_date_final_projects on final_projects  (delivery_date);

-- Crear la tabla payments
create table payments (
    id serial primary key,
    id_student int not null,
    id_bootcamp int not null,
    id_course int not null,
    pay float,
    failure_to_pay float,
    settle boolean not null,
    registration_date date not null,
    foreign key (id_student) references students(id),
    foreign key (id_bootcamp) references bootcamps(id),
    foreign key (id_course) references courses(id)
);

create index idx_registration_date_payments on payments (registration_date);


-- Crear la tabla administratives
create table administratives (
    id serial primary key,
    name varchar(100),
    surnames varchar(255),
    nif varchar(25),
    email varchar(255) not null,
    registration_date date not null,
    usser varchar(50) not null,
    pass varchar(50) not null,
    permissions varchar(255),
    active boolean not null
);

alter table administratives
add constraint unique_email_administrative unique (email);

alter table administratives
add constraint unique_usser_administrative unique (usser);

create index idx_registration_date_administratives on administratives (registration_date);