const cds = require('@sap/cds');
const { message } = require('@sap/cds/lib/log/cds-error');
const { UPDATE } = require('@sap/cds/lib/ql/cds-ql');

class TrainingManagementAPI extends cds.ApplicationService {
    async init() {
        const { Enrollments, Courses, EnrollmentStatus, SDHEADERSet } = this.entities;

        const s4system = await cds.connect.to('ExternalService');

        this.on('READ', SDHEADERSet, async (req) => {
            let data = await s4system.run(req.query);
            return data;
        });

        this.before('CREATE', Enrollments.drafts, async (req) => {
            if (req) {
                req.data.status_code = "01";
            }
        });

        this.before('UPDATE', Courses.drafts, async (req) => {
            if (req.data?.duration) {
                if (req.data.duration > 60) {
                    req.reject({
                        status: 400,
                        target: 'duration',
                        message: "Duration cannot be greater than 60"
                    });
                }
            }
        });

        this.on('READ', EnrollmentStatus, async (req) => {
            if (req.query) {
                let data = await cds.run(req.query);
                if (data) {
                    data.push({
                        code: '04',
                        description: 'Not Applicable'
                    });

                    return data;
                }
            }
        });
        //this.after();
        this.on('updateCourseStatus', async (req) => {
            console.log("Action Invoked");
            try {
                const { courseID, statusCode } = req.data;
                if (courseID && statusCode) {
                    let updated = await UPDATE(Courses, courseID).with({
                        course_status_code: statusCode
                    });

                    if (updated) {
                        return req.info("Status Updated Successfully!")
                    }
                }
            } catch (error) {
                req.reject({
                    status: 400,
                    message: "Failed to Update Status"
                });
            }

        });

        this.on('discontinueCourseData', async (req) => {
            debugger;
        });

        this.on('READ', Courses, async (req) => {
            let oUserData = await SELECT.one.from(UserTable).where({
                useremail: $user.email
            })
            if(oUserData) {
                let country = oUserData.country;
                let oCourses = await SELECT.from(Courses) .where({
                    country: country
                });
                return oCourses;
            }
        });

        return super.init();
    }
}

module.exports = TrainingManagementAPI;