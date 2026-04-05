sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/course/app/courseuiapp/test/integration/pages/CoursesList",
	"com/course/app/courseuiapp/test/integration/pages/CoursesObjectPage"
], function (JourneyRunner, CoursesList, CoursesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/course/app/courseuiapp') + '/test/flp.html#app-preview',
        pages: {
			onTheCoursesList: CoursesList,
			onTheCoursesObjectPage: CoursesObjectPage
        },
        async: true
    });

    return runner;
});

