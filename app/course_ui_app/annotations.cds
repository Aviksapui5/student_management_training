using TrainingManagementAPI as service from '../../srv/service';


annotate service.Courses with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Value : duration,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : trainer.name,
            Label : '{i18n>TrainerName}',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>CourseDetails}',
            ID : 'i18nCourseDetails',
            Target : '@UI.FieldGroup#i18nCourseDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>EnrollmentsDetails}',
            ID : 'i18nEnrollmentsDetails',
            Target : 'enrollments/@UI.LineItem#i18nEnrollmentsDetails',
        },
    ],
    UI.FieldGroup #i18nCourseDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : trainer_ID,
                Label : '{i18n>TrainerId}',
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Value : duration,
            },
            {
                $Type : 'UI.DataField',
                Value : trainer.name,
                Label : '{i18n>TrainerName}',
            },
            {
                $Type : 'UI.DataField',
                Value : trainer.expertise,
                Label : '{i18n>TrainerExpertise}',
            },
            {
                $Type : 'UI.DataField',
                Value : course_status.description,
                Label : 'Status',
                Criticality : course_status.colorCode,
                CriticalityRepresentation : #WithoutIcon,
            },
        ],
    },
    UI.HeaderInfo: {
        TypeNamePlural : 'Courses',
    },
    UI.SelectionFields : [
        ID,
        trainer_ID,
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TrainingManagementAPI.discontinueCourseData',
            Label : '{i18n>Discontinue}',
            Criticality : #Negative,
        },
    ],
);

annotate service.Enrollments with @(
    UI.LineItem #i18nEnrollmentsDetails : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : enrolledDate,
            Label : 'Enrolled Date',
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : student_ID,
            Label : 'Student ID',
        },
        {
            $Type : 'UI.DataField',
            Value : student.name,
            Label : 'Name',
        },
        {
            $Type : 'UI.DataField',
            Value : student.email,
            Label : 'Email',
        },
        {
            $Type : 'UI.DataField',
            Value : student.phone,
            Label : 'Phone',
        },
        {
            $Type : 'UI.DataField',
            Value : student.address,
            Label : 'Address',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Enrollment Details',
            ID : 'EnrollmentDetails',
            Target : '@UI.FieldGroup#EnrollmentDetails',
        },
    ],
    UI.FieldGroup #EnrollmentDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : course_ID,
                Label : 'Course Name',
            },
            {
                $Type : 'UI.DataField',
                Value : course.title,
            },
            {
                $Type : 'UI.DataField',
                Value : enrolledDate,
                Label : 'Enrolled Date',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'Status',
            },
            {
                $Type : 'UI.DataField',
                Value : course.trainer.name,
            },
            {
                $Type : 'UI.DataField',
                Value : student_ID,
                Label : 'Student ID',
            },
            {
                $Type : 'UI.DataField',
                Value : student.name,
                Label : 'Student name',
            },
            {
                $Type : 'UI.DataField',
                Value : student.phone,
                Label : 'Phone',
            },
            {
                $Type : 'UI.DataField',
                Value : student.email,
                Label : 'Email',
            },
            {
                $Type : 'UI.DataField',
                Value : student.address,
                Label : 'Address',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : course.title,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

// annotate service.Courses with {
//     ID @(
//         Common.Label : '{i18n>Courses}',
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Courses',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : ID,
//                     ValueListProperty : 'ID',
//                 },
//             ],
//         },
//         Common.ValueListWithFixedValues : false,
//         Common.Text : title,
//         Common.Text.@UI.TextArrangement : #TextOnly,
//     )
// };

annotate service.Courses with {
    trainer @(
        Common.Label : 'Trainer',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Trainers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : trainer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'expertise',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.Trainers with {
    ID @(
        Common.Text : name,
        )
};

annotate service.Courses @(
    Common.SideEffects #updateTrainerDetails: {
        SourceProperties : [
            'trainer_ID'
        ],
        TargetProperties: [
            'trainer/name',
            'trainer/expertise'
        ]
    }
);

annotate service.Enrollments @(
    Common.SideEffects #updateStudentDetails: {
        SourceProperties : [
            'student_ID'
        ],
        TargetProperties: [
            'student/name',
            'student/address',
            'student/email',
            'student/phone'
        ]
    }
);

annotate service.Trainers with {
    name @Common.FieldControl : #ReadOnly
};

annotate service.Trainers with {
    expertise @Common.FieldControl : #ReadOnly
};

annotate service.Students with {
    name @Common.FieldControl : #ReadOnly
};

annotate service.Students with {
    email @Common.FieldControl : #ReadOnly
};

annotate service.Students with {
    phone @Common.FieldControl : #ReadOnly
};

annotate service.Students with {
    address @Common.FieldControl : #ReadOnly
};

annotate service.Enrollments with {
    status @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'EnrollmentStatus',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.EnrollmentStatus with {
    code @(
        Common.Text : description,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Enrollments with {
    student @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Students',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : student_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'phone',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'address',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.CourseStatus with {
    description @Common.FieldControl : #ReadOnly
};

