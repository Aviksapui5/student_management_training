using {training.managment as dataModel} from '../db/schema';
using {ExternalService as external} from './external/ExternalService';

service TrainingManagementAPI {
    @readonly
    entity Students         as projection on dataModel.Students;

    entity Trainers         as projection on dataModel.Trainers;

    entity CourseStatus     as projection on dataModel.CourseStatus
        actions {
            action discontinueCourseData() returns String;
        };

    entity EnrollmentStatus as projection on dataModel.EnrollmentStatus;

    @odata.draft.enabled
    entity Courses @(restrict: [
        {
            grant: [
                'READ',
                'WRITE'
            ],
            to   : ['AdminPerson']
        },
        {
            grant: ['READ'],
            to   : ['Student']
        }
    ])                      as projection on dataModel.Courses;

    @Capabilities: {
        InsertRestrictions.Insertable: true,
        UpdateRestrictions.Updatable : true,
        DeleteRestrictions.Deletable : false
    }
    entity Enrollments      as projection on dataModel.Enrollments;

    //Unbound Action
    action updateCourseStatus(courseID: String, statusCode: String) returns String;

    entity SDHEADERSet as projection on external.SDHEADERSet;
}

annotate TrainingManagementAPI.Students with @(requires: 'authenticated-user');
