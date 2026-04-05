namespace training.managment;

using {
    cuid,
    managed
} from '@sap/cds/common';

type customName : String(50);

entity Students : cuid {
    //key ID      : UUID;
    name    : customName;
    email   : String;
    phone   : String;
    address : String;
}

entity Courses : cuid, managed {
    title         : String  @title: '{i18n>title}';
    trainer       : Association to Trainers;
    duration      : Integer @title: '{i18n>duration}';
    enrollments   : Composition of many Enrollments
                        on enrollments.course = $self;
    course_status : Association to CourseStatus default '01'; // default status for course id
}

entity Trainers : cuid {
    name      : String @title: '{i18n>TrainerName}';
    expertise : String @title: '{i18n>TrainerExpertise}';
}

entity CourseStatus {
    key code        : String;
        description : String;
        colorCode   : Integer;
}

entity EnrollmentStatus {
    key code        : String;
        description : String;
}

entity Enrollments : cuid, managed {
    student      : Association to Students; // managed association
    course       : Association to Courses;
    enrolledDate : Date;
    status       : Association to EnrollmentStatus;
}
