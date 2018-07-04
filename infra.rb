# frozen_string_literal: true

require 'cfndsl'

CloudFormation do
  Transform 'AWS::Serverless-2016-10-31'

  Description 'Simple SAM Application'

  Parameter(:prefix) do
    Type String
    AllowedPattern '[a-z]*[-a-z0-9]*'
    MinLength 3
    MaxLength 16
  end

  Parameter(:env) do
    Type String
    AllowedPattern '[a-z]*[-a-z0-9]*'
    MinLength 3
    MaxLength 16
  end

  Serverless_Function(:helloworldfunction) do
    Handler 'index.handler'
    Runtime 'nodejs6.10'
    CodeUri '../functions/hello_world'
    Events(
      GetResource: {
        Type: 'Api',
        Properties: {
          Path: '/',
          Method: 'get'
        }
      }
    )
  end

  Output(:apiurl) do
    Value FnSub('https://${ServerlessRestApi}.execute-api.${AWS::Region}.amazonaws.com/Prod/')
  end
end
