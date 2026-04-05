sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.course.app.courseuiapp',
            componentId: 'CoursesList',
            contextPath: '/Courses'
        },
        CustomPageDefinitions
    );
});