create database hospital_portal;
use hospital_portal;

create table patients (
patient_id int not null unique auto_increment primary key,
patient_name varchar(45) not null,
age int not null,
admission_date date,
discharge_date date
); 


insert into patients (patient_name, age, admission_date, discharge_date)
values ("Mario Sanchez", 43, "2022/09/10", "2022/09/17");
insert into patients (patient_name, age, admission_date, discharge_date)
values ("Anna Belle", 46, "2021/01/19", "2021/01/27");
insert into patients (patient_name, age, admission_date, discharge_date)
values ("Marcus Grey", 26, "2023/07/25", "2023/08/02");
insert into patients (patient_name, age, admission_date, discharge_date)
values ("Jessiah Simmons", 26, "2023/07/25", "2023/08/02");
create table doctors (
doctor_id int not null unique auto_increment primary key,
doctor_name varchar (45) not null,
age int not null, 
number_of_patients int,
number_of_appointments int
);

alter table doctors add patient_id int, add foreign key (patient_id) references patients (patient_id);
insert into doctors (doctor_name, age, number_of_patients, number_of_appointments) 
values ("Samantha Greyson", 48, 2, 1);
insert into doctors (doctor_name, age, number_of_patients, number_of_appointments) 
values("Marcus Rogers", 36, 1, 2);
insert into doctors (doctor_name, age, number_of_patients, number_of_appointments) 
values("Max Jets", 55, 1, 1);

create table appointments (
appointment_id int not null unique auto_increment primary key,
patient_id int not null, foreign key (patient_id) references patients(patient_id),
doctor_id int not null, foreign key (doctor_id) references doctors(doctor_id),
appointment_date date not null,
appointment_time decimal (4,2) not null
);

delimiter //
create procedure ScheduleAppointments(
in portal_patient_id int,
in portal_doctor_id int,
in portal_appointment_date date,
in portal_appointment_time decimal (4,2)
)
begin
insert into appointments (patient_id, doctor_id, appointment_date, appointment_time)
values (portal_patient_id, portal_doctor_id, portal_appointment_date, portal_appointment_time);
end //
delimiter ;

delimiter //
create procedure DischargePatients(
in portal_patient_id int
)
begin 
delete from patients where portal_patient_id=patient_id and discharge_date is not null;
end //
delimiter ;
call DischargePatients(1);

create view Hospital_Info as SELECT patients.patient_name, doctors.doctor_name, appointments.appointment_date, appointments.appointment_time FROM
patients join doctors ON patients.patient_id =doctors.patient_id
join appointments ON doctors.doctor_id =appointments.doctor_id;

