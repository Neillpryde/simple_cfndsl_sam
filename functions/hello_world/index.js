'use strict';
console.log('Loading function');

exports.handler = (event, context, callback) => {

    var response = {
        "statusCode": 200,
        "headers": {},
        "body": "AWS Auckland meetup!"
    };

    callback(null, response);
};
