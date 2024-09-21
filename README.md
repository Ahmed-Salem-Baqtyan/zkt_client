# ZktClient

[![Gem Version](https://badge.fury.io/rb/annotate.svg)](http://badge.fury.io/rb/annotate)
![Ruby Version](https://img.shields.io/badge/Ruby-%3E%3D%203.3.3-red)
[![Downloads count](https://img.shields.io/gem/dt/annotate.svg?style=flat)](https://rubygems.org/gems/annotate)
[![CI Status](https://github.com/ctran/annotate_models/workflows/CI/badge.svg)](https://github.com/ctran/annotate_models/actions?workflow=CI)
[![Coveralls](https://coveralls.io/repos/ctran/annotate_models/badge.svg?branch=develop)](https://coveralls.io/r/ctran/annotate_models?branch=develop)
[![Maintenability](https://codeclimate.com/github/ctran/annotate_models/badges/gpa.svg)](https://codeclimate.com/github/ctran/annotate_models)

Ruby API Client for [Zkt platform](https://zkteco.eu/products/time-attendance/software/zkbio-time) it will help you to make an easy integration with [Zkt APIs](http://time.xmzkteco.com:8097/docs/api-docs/).

## Documentation

See the [Ruby API docs](http://time.xmzkteco.com:8097/docs/api-docs/).

# Key features:

* Provides a methods to do the requests.
* Returns the response as (JSON or Objects) depending on your configurations.
* Handle the errors for you.

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'zkt_client'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install zkt_client
```

# Configuration in Rails
#### You have two ways to tell ZktClient about your configurations:
* Pass them throught the configure file


To generate a configuration file please run the following command

    rails g zkt_client:install # config/initializers/zkt_client.rb

And write them there:
```ruby
ZktClient.configure do |config|
  # ZktClient configurations
  # config.host = 'http://localhost:3000'     # Required
  # config.username = 'admin'                 # Required unless access_token is set
  # config.password = 'admin'                 # Required unless access_token is set   
  # config.access_token = 'YOUR_ACCESS_TOKEN' # Required unless username and password are set
  # config.is_object_response_enabled = true  # Optional default is false
end
```
* Pass them throught the ENV variables

```ruby
# ZKT_CLIENT_HOST => For your host
# ZKT_CLIENT_USERNAME => For your username
# ZKT_CLIENT_PASSWORD => For your password
# ZKT_CLIENT_ACCESS_TOKEN => For your token (Optional if username & password provided)
# ZKT_OBJECT_RESPONSE_ENABLED => true to let ZktClient to return the response as objects.
```

# Important notes
* The return response will be JSON by default.
* The `is_object_response_enabled` option will let you to ask ZktClint to return the response as objects instead of JSON (but the pagination keys will not back to you in the list response if the option is enabled)
* If you provide the `access_token` directly, ZktClient will use that token to make the requests without doing login request (In this case ZktClient will not bring the token from the login API).
* If you passed the `username & password` in this case ZktClient will make a login request to bring the `access_token` and then will make the other requests for you.
* If you passed both `username + password` and `access_token`, ZktClient will take the `access_token` only.

# Usage

Table of Contents
-----------------
- [Helper Methods](#helper-methods)
- [Area Methods](#area-methods)
    - [Show Area](#show-area)
    - [List Areas](#list-areas)
    - [Update Area](#update-area)
    - [Create Area](#create-area)
    - [Delete Area](#delete-area)
* [Department Methods](#department-methods)
    - [Show Department](#show-department)
    - [List Departments](#list-departments)
    - [Update Department](#update-department)
    - [Create Department](#create-department)
    - [Delete Department](#delete-department)
* [Device Methods](#device-methods)
    - [Show Device](#show-device)
    - [List Devices](#list-devices)
    - [Update Device](#update-device)
    - [Create Device](#create-device)
    - [Delete Device](#delete-device)
* [Employee Methods](#employee-methods)
    - [Show Employee](#show-employee)
    - [List Employees](#list-employees)
    - [Update Employee](#update-employee)
    - [Create Employee](#create-employee)
    - [Delete Employee](#delete-employee)
* [Position Methods](#position-methods)
    - [Show Position](#show-position)
    - [List Positions](#list-positions)
    - [Update Position](#update-position)
    - [Create Position](#create-position)
    - [Delete Position](#delete-position)
* [Transaction Methods](#transaction-methods)
    - [Show Transaction](#show-transaction)
    - [List Transactions](#list-transactions)
    - [Delete Transaction](#delete-transaction)
* [Exceptions](#exceptions)


Helper Methods
------------
```ruby
ZktClient.configured? # Returns true if you provide the required configurations otherwise false (to check if ZktClient configured or not)
```

Area Methods
------------

#### Show Area

```ruby
# ZktClient::Area.show(id)

ZktClient::Area.show(4)

# JSON response
{ "id"=>4, "area_code"=>"4", "area_name"=>"Baqtyan", "parent_area"=>nil, "parent_area_name"=>nil }

# Object response
<OpenStruct id=4, area_code="4", area_name="Baqtyan", parent_area=nil, parent_area_name=nil>
```

#### List Areas

```ruby
# ZktClient::Area.list(**options)
# NOTE: Check the ZKT APIs documention for more details.

ZktClient::Area.list(page: 1)

# JSON response
{
  "count"=>12,
  "next"=>"http://biotime8.zkteco.eu/personnel/api/areas/?page=2",
  "previous"=>nil,
  "msg"=>"",
  "code"=>0,
  "data"=>[{ "id"=>1, "area_code"=>"11", "area_name"=>"Baqtyan", "parent_area"=>nil, "parent_area_name"=>nil }],
}

# Object response
[<OpenStruct id=1, area_code="11", area_name="Baqtyan", parent_area=nil, parent_area_name=nil>]
```

#### Create Area

```ruby
# ZktClient::Area.create(params)

ZktClient::Area.create(area_code: 100, area_name: 'Ahmed Baqtyan')

# JSON response
{ "id"=>15, "area_code"=>"100", "area_name"=>"Ahmed Baqtyan", "parent_area"=>nil }

# Object response
<OpenStruct id=15, area_code="100", area_name="Ahmed Baqtyan", parent_area=nil, parent_area_name=nil>
```

#### Update Area

```ruby
# ZktClient::Area.update(id, **params)

ZktClient::Area.update(4, area_name: 'Salim Baqtyan')

# JSON response
{ "id"=>4, "area_code"=>"4", "area_name"=>"Salim Baqtyan", "parent_area"=>nil }

# Object response
<OpenStruct id=4, area_code="4", area_name="Salim Baqtyan", parent_area=nil, parent_area_name=nil>
```

#### Delete Area

```ruby
# ZktClient::Area.delete(id)

ZktClient::Area.delete(16) # true
```
------------------------------------------------------------------------------------------

Department Methods
------------

#### Show Department

```ruby
# ZktClient::Department.show(id)

ZktClient::Department.show(4)

# JSON response
{ "id"=>1, "dept_code"=>"1", "dept_name"=>"Secretaria", "parent_dept"=>nil }

# Object response
<OpenStruct id=1, dept_code="1", dept_name="Secretaria", parent_dept=nil>
```

#### List Departments

```ruby
# ZktClient::Department.list(**options)
# NOTE: Check the ZKT APIs documention for more details.

ZktClient::Department.list(page: 1)

# JSON response
{
  "count"=>8,
  "next"=>nil,
  "previous"=>nil,
  "msg"=>"",
  "code"=>0,
  "data"=>
  [{ "id"=>1, "dept_code"=>"1", "dept_name"=>"Secretaria", "parent_dept"=>nil }]
}

# Object response
[<OpenStruct id=1, dept_code="1", dept_name="Secretaria", parent_dept=nil>]
```

#### Create Department

```ruby
# ZktClient::Department.create(params)

ZktClient::Department.create(dept_code: 1000, dept_name: 'Baqtyan 1000')

# JSON response
{ "id"=>15, "dept_code"=>"1000", "dept_name"=>"Baqtyan 1000", "parent_dept"=>nil }

# Object response
<OpenStruct id=15, dept_code="1000", dept_name="Baqtyan 1000", parent_dept=nil>
```

#### Update Department

```ruby
# ZktClient::Department.update(id, **params)

ZktClient::Department.update(15, dept_name: 'Baqtyan 10001')

# JSON response
{ "id"=>15, "dept_code"=>"1000", "dept_name"=>"Baqtyan 10001", "parent_dept"=>nil }

# Object response
<OpenStruct id=15, dept_code="1000", dept_name="Baqtyan 10001", parent_dept=nil>
```

#### Delete Department

```ruby
# ZktClient::Department.delete(id)

ZktClient::Department.delete(15)

# JSON response
true

# Object response
true
```

------------------------------------------------------------------------------------------

Device Methods
------------

#### Show Device

```ruby
# ZktClient::Device.show(id)

ZktClient::Device.show(1)

# JSON response
{
  "id"=>12,
  "sn"=>"AEVL201160168",
  "ip_address"=>"192.168.1.201",
  "alias"=>"2",
  "terminal_name"=>nil,
  "fw_ver"=>nil,
  "push_ver"=>nil,
  "state"=>"3",
  "terminal_tz"=>0,
  "area"=>{"id"=>12, "area_code"=>"151", "area_name"=>"empty"},
  "last_activity"=>nil,
  "user_count"=>nil,
  "fp_count"=>nil,
  "face_count"=>nil,
  "palm_count"=>nil,
  "transaction_count"=>nil,
  "push_time"=>nil,
  "transfer_time"=>"00:00;14:05",
  "transfer_interval"=>1,
  "is_attendance"=>1,
  "area_name"=>"empty"
}

# Object response
<OpenStruct id=12, sn="AEVL201160168", ip_address="192.168.1.201", alias="2", terminal_name=nil, fw_ver=nil, push_ver=nil, state="3", terminal_tz=0, area={"id"=>12, "area_code"=>"151", "area_name"=>"empty"}, last_activity=nil, user_count=nil, fp_count=nil, face_count=nil, palm_count=nil, transaction_count=nil, push_time=nil, transfer_time="00:00;14:05", transfer_interval=1, is_attendance=1, area_name="empty">
```

#### List Devices

```ruby
# ZktClient::Device.list(**options)
# NOTE: Check the ZKT APIs documention for more details.

ZktClient::Device.list(page: 1)

# JSON response
{
  "count"=>3,
  "next"=>nil,
  "previous"=>nil,
  "msg"=>"",
  "code"=>0,
  "data"=>[
    {
      "id"=>12,
      "sn"=>"AEVL201160168",
      "ip_address"=>"192.168.1.201",
      "alias"=>"2",
      "terminal_name"=>nil,
      "fw_ver"=>nil,
      "push_ver"=>nil,
      "state"=>"3",
      "terminal_tz"=>0,
      "area"=>{"id"=>12, "area_code"=>"151", "area_name"=>"empty"},
      "last_activity"=>nil,
      "user_count"=>nil,
      "fp_count"=>nil,
      "face_count"=>nil,
      "palm_count"=>nil,
      "transaction_count"=>nil,
      "push_time"=>nil,
      "transfer_time"=>"00:00;14:05",
      "transfer_interval"=>1,
      "is_attendance"=>1,
      "area_name"=>"empty"
    }
  ]
}

# Object response
[<OpenStruct id=12, sn="AEVL201160168", ip_address="192.168.1.201", alias="2", terminal_name=nil, fw_ver=nil, push_ver=nil, state="3", terminal_tz=0, area={"id"=>12, "area_code"=>"151", "area_name"=>"empty"}, last_activity=nil, user_count=nil, fp_count=nil, face_count=nil, palm_count=nil, transaction_count=nil, push_time=nil, transfer_time="00:00;14:05", transfer_interval=1, is_attendance=1, area_name="empty">]
```

#### Create Device

```ruby
# ZktClient::Device.create(params)

ZktClient::Device.create(area_code: 100, area_name: 'Ahmed Baqtyan')

# JSON response
{ "id"=>15, "area_code"=>"100", "area_name"=>"Ahmed Baqtyan", "parent_area"=>nil }

# Object response
<OpenStruct id=15, area_code="100", area_name="Ahmed Baqtyan", parent_area=nil, parent_area_name=nil>
```

#### Update Device

```ruby
# ZktClient::Device.update(id, **params)

ZktClient::Device.update(12, sn: '11111111122', alias: 'Baqtyan device')

# JSON response
{ "id"=>12, "sn"=>"AEVL201160168", "ip_address"=>"192.168.1.201", "alias"=>"Baqtyan device", "area"=>12, "heartbeat"=>10 }

# Object response
<OpenStruct id=12, sn="AEVL201160168", ip_address="192.168.1.201", alias="Baqtyan device", area=12, heartbeat=10>
```

#### Delete Device

```ruby
# ZktClient::Device.delete(id)

ZktClient::Device.delete(16)

# JSON response
true

# Object response
true
```

------------------------------------------------------------------------------------------

Employee Methods
------------

#### Show Employee

```ruby
# ZktClient::Employee.show(id)

ZktClient::Employee.show(4)

# JSON response
{
  "id"=>16,
  "emp_code"=>"1",
  "first_name"=>"Test",
  "last_name"=>nil,
  "nickname"=>"",
  "format_name"=>"1 Test",
  "photo"=>"",
  "full_name"=>"Test ",
  "device_password"=>nil,
  "card_no"=>nil,
  "department"=>{"id"=>13, "dept_code"=>"5", "dept_name"=>"Test"},
  "position"=>nil,
  "hire_date"=>"2024-09-20",
  "gender"=>nil,
  "birthday"=>nil,
  "verify_mode"=>0,
  "emp_type"=>nil,
  "contact_tel"=>"",
  "office_tel"=>nil,
  "mobile"=>"",
  "national"=>"",
  "city"=>"",
  "address"=>"",
  "postcode"=>"",
  "email"=>"",
  "enroll_sn"=>"",
  "ssn"=>nil,
  "religion"=>"",
  "attemployee"=>{"id"=>16, "enable_attendance"=>true, "enable_overtime"=>true, "enable_holiday"=>true, "enable_schedule"=>true},
  "dev_privilege"=>0,
  "area"=>[{"id"=>13, "area_code"=>"1", "area_name"=>"TestMadrid"}],
  "app_status"=>0,
  "app_role"=>1,
  "update_time"=>"2024-09-20 11:08:14",
  "fingerprint"=>"Ver 10:1",
  "face"=>"-",
  "palm"=>"-",
  "vl_face"=>"-",
  "vl_palm"=>"-",
  "vl_face_photo"=>"-"
}

# Object response
<OpenStruct id=16, emp_code="1", first_name="Test", last_name=nil, nickname="", format_name="1 Test", photo="", full_name="Test ", device_password=nil, card_no=nil, department={"id"=>13, "dept_code"=>"5", "dept_name"=>"Test"}, position=nil, hire_date="2024-09-20", gender=nil, birthday=nil, verify_mode=0, emp_type=nil, contact_tel="", office_tel=nil, mobile="", national="", city="", address="", postcode="", email="", enroll_sn="", ssn=nil, religion="", attemployee={"id"=>16, "enable_attendance"=>true, "enable_overtime"=>true, "enable_holiday"=>true, "enable_schedule"=>true}, dev_privilege=0, area=[{"id"=>13, "area_code"=>"1", "area_name"=>"TestMadrid"}], app_status=0, app_role=1, update_time="2024-09-20 11:08:14", fingerprint="Ver 10:1", face="-", palm="-", vl_face="-", vl_palm="-", vl_face_photo="-">
```

#### List Employees

```ruby
# ZktClient::AEmployeerea.list(**options)
# NOTE: Check the ZKT APIs documention for more details.

ZktClient::Employee.list(page: 1)

# JSON response
{
  "count"=>26,
  "next"=>"http://biotime8.zkteco.eu/personnel/api/employees/?page=2",
  "previous"=>nil,
  "msg"=>"",
  "code"=>0,
  "data"=>[
    {
      "id"=>16,
      "emp_code"=>"1",
      "first_name"=>"Test",
      "last_name"=>nil,
      "nickname"=>"",
      "format_name"=>"1 Test",
      "photo"=>"",
      "full_name"=>"Test ",
      "device_password"=>nil,
      "card_no"=>nil,
      "department"=>{"id"=>13, "dept_code"=>"5", "dept_name"=>"Test"},
      "position"=>nil,
      "hire_date"=>"2024-09-20",
      "gender"=>nil,
      "birthday"=>nil,
      "verify_mode"=>0,
      "emp_type"=>nil,
      "contact_tel"=>"",
      "office_tel"=>nil,
      "mobile"=>"",
      "national"=>"",
      "city"=>"",
      "address"=>"",
      "postcode"=>"",
      "email"=>"",
      "enroll_sn"=>"",
      "ssn"=>nil,
      "religion"=>"",
      "attemployee"=>{"id"=>16, "enable_attendance"=>true, "enable_overtime"=>true, "enable_holiday"=>true, "enable_schedule"=>true},
      "dev_privilege"=>0,
      "area"=>[{"id"=>13, "area_code"=>"1", "area_name"=>"TestMadrid"}],
      "app_status"=>0,
      "app_role"=>1,
      "update_time"=>"2024-09-20 11:08:14",
      "fingerprint"=>"Ver 10:1",
      "face"=>"-",
      "palm"=>"-",
      "vl_face"=>"-",
      "vl_palm"=>"-",
      "vl_face_photo"=>"-"
    }
  ]
}

# Object response
[<OpenStruct id=16, emp_code="1", first_name="Test", last_name=nil, nickname="", format_name="1 Test", photo="", full_name="Test ", device_password=nil, card_no=nil, department={"id"=>13, "dept_code"=>"5", "dept_name"=>"Test"}, position=nil, hire_date="2024-09-20", gender=nil, birthday=nil, verify_mode=0, emp_type=nil, contact_tel="", office_tel=nil, mobile="", national="", city="", address="", postcode="", email="", enroll_sn="", ssn=nil, religion="", attemployee={"id"=>16, "enable_attendance"=>true, "enable_overtime"=>true, "enable_holiday"=>true, "enable_schedule"=>true}, dev_privilege=0, area=[{"id"=>13, "area_code"=>"1", "area_name"=>"TestMadrid"}], app_status=0, app_role=1, update_time="2024-09-20 11:08:14", fingerprint="Ver 10:1", face="-", palm="-", vl_face="-", vl_palm="-", vl_face_photo="-">]
```

#### Create Employee

```ruby
# ZktClient::Employee.create(params)

ZktClient::Employee.create(emp_code: 100, first_name: 'Ahmed Baqtyan', department: 1, area: [1])

# JSON response
{
  "id"=>42,
  "emp_code"=>"100",
  "first_name"=>"Ahmed Baqtyan",
  "last_name"=>nil,
  "nickname"=>nil,
  "device_password"=>nil,
  "card_no"=>nil,
  "department"=>1,
  "position"=>nil,
  "hire_date"=>"2024-09-21",
  "gender"=>nil,
  "birthday"=>nil,
  "verify_mode"=>-1,
  "emp_type"=>nil,
  "contact_tel"=>nil,
  "office_tel"=>nil,
  "mobile"=>nil,
  "national"=>nil,
  "city"=>nil,
  "address"=>nil,
  "postcode"=>nil,
  "email"=>nil,
  "enroll_sn"=>"",
  "ssn"=>nil,
  "religion"=>nil,
  "dev_privilege"=>0,
  "self_password"=>"pbkdf2_sha256$390000$nN5kdBx0CHTMZ1j1wvs7M7$zn3e9jKcDDkHTqPlcXrPe8I0cCsZ6rvTEqIzFxiZcWE=",
  "flow_role"=>[],
  "area"=>[1],
  "app_status"=>0,
  "app_role"=>1
}

# Object response
<OpenStruct id=43, emp_code="1001", first_name="Ahmed Baqtyan", last_name=nil, nickname=nil, device_password=nil, card_no=nil, department=1, position=nil, hire_date="2024-09-21", gender=nil, birthday=nil, verify_mode=-1, emp_type=nil, contact_tel=nil, office_tel=nil, mobile=nil, national=nil, city=nil, address=nil, postcode=nil, email=nil, enroll_sn="", ssn=nil, religion=nil, dev_privilege=0, self_password="pbkdf2_sha256$390000$Thqtm5LEM6MLqmpdOsH76Y$eakgvOfq5xawUJzhGMByr/gn9uQ4YquQTfIvhscPayA=", flow_role=[], area=[1], app_status=0, app_role=1>
```

#### Update Employee

```ruby
# ZktClient::Employee.update(id, **params)

ZktClient::Employee.update(42, area: [1], first_name: 'Salim Baqtyan')

# JSON response
{
  "emp_code"=>"100",
  "first_name"=>"Salim Baqtyan",
  "last_name"=>nil,
  "nickname"=>nil,
  "device_password"=>nil,
  "card_no"=>nil,
  "department"=>1,
  "position"=>nil,
  "hire_date"=>"2024-09-21",
  "gender"=>nil,
  "birthday"=>nil,
  "verify_mode"=>-1,
  "emp_type"=>nil,
  "contact_tel"=>nil,
  "office_tel"=>nil,
  "mobile"=>nil,
  "national"=>nil,
  "city"=>nil,
  "address"=>nil,
  "postcode"=>nil,
  "email"=>nil,
  "enroll_sn"=>"",
  "ssn"=>nil,
  "religion"=>nil,
  "dev_privilege"=>0,
  "self_password"=>"pbkdf2_sha256$390000$nN5kdBx0CHTMZ1j1wvs7M7$zn3e9jKcDDkHTqPlcXrPe8I0cCsZ6rvTEqIzFxiZcWE=",
  "flow_role"=>[],
  "area"=>[1],
  "app_status"=>0,
  "app_role"=>1
}

# Object response
<OpenStruct emp_code="100", first_name="Salim Baqtyan", last_name=nil, nickname=nil, device_password=nil, card_no=nil, department=1, position=nil, hire_date="2024-09-21", gender=nil, birthday=nil, verify_mode=-1, emp_type=nil, contact_tel=nil, office_tel=nil, mobile=nil, national=nil, city=nil, address=nil, postcode=nil, email=nil, enroll_sn="", ssn=nil, religion=nil, dev_privilege=0, self_password="pbkdf2_sha256$390000$nN5kdBx0CHTMZ1j1wvs7M7$zn3e9jKcDDkHTqPlcXrPe8I0cCsZ6rvTEqIzFxiZcWE=", flow_role=[], area=[1], app_status=0, app_role=1>
```

#### Delete Employee

```ruby
# ZktClient::Employee.delete(id)

ZktClient::Employee.delete(42)

# JSON response
true

# Object response
true
```

------------------------------------------------------------------------------------------

Position Methods
------------

#### Show Position

```ruby
# ZktClient::Position.show(id)

ZktClient::Position.show(4)

# JSON response
{ "id"=>1, "position_code"=>"1", "position_name"=>"Secretaria", "parent_position"=>nil, "parent_position_name"=>nil }

# Object response
<OpenStruct id=1, position_code="1", position_name="Secretaria", parent_position=nil, parent_position_name=nil>
```

#### List Positions

```ruby
# ZktClient::Position.list(**options)
# NOTE: Check the ZKT APIs documention for more details.

ZktClient::Position.list(page: 1)

# JSON response
{
  "count"=>8,
  "next"=>nil,
  "previous"=>nil,
  "msg"=>"",
  "code"=>0,
  "data"=>[{ "id"=>1, "position_code"=>"1", "position_name"=>"Secretaria", "parent_position"=>nil, "parent_position_name"=>nil }]
}

# Object response
[<OpenStruct id=1, position_code="1", position_name="Secretaria", parent_position=nil, parent_position_name=nil>]
```

#### Create Position

```ruby
# ZktClient::Position.create(params)

ZktClient::Position.create(position_code: 100, position_name: 'Ahmed Baqtyan position')

# JSON response
{ "position_code"=>"100", "position_name"=>"Ahmed Baqtyan position", "parent_position"=>nil }

# Object response
<OpenStruct position_code="100", position_name="Ahmed Baqtyan position", parent_position=nil>
```

#### Update Position

```ruby
# ZktClient::Position.update(id, **params)

ZktClient::Position.update(10, position_name: 'Ahmed Baqtyan position updated')

# JSON response
{ "id"=>4, "area_code"=>"4", "area_name"=>"Salim Baqtyan", "parent_area"=>nil }

# Object response
<OpenStruct id=4, area_code="4", area_name="Salim Baqtyan", parent_area=nil, parent_area_name=nil>
```

#### Delete Position

```ruby
# ZktClient::Position.delete(id)

ZktClient::Position.delete(10)

# JSON response
true

# Object response
true
```

------------------------------------------------------------------------------------------

Transaction Methods
------------

#### Show Transaction

```ruby
# ZktClient::Transaction.show(id)

ZktClient::Transaction.show(1)

# JSON response
{
  "id"=>1,
  "emp"=>16,
  "emp_code"=>"1",
  "first_name"=>"Test",
  "last_name"=>nil,
  "department"=>"Test",
  "position"=>nil,
  "punch_time"=>"2024-09-05 01:01:00",
  "punch_state"=>"0",
  "punch_state_display"=>"Check In",
  "verify_type"=>0,
  "verify_type_display"=>"Any",
  "work_code"=>nil,
  "gps_location"=>"",
  "area_alias"=>nil,
  "terminal_sn"=>"",
  "temperature"=>0.0,
  "is_mask"=>"-",
  "terminal_alias"=>nil,
  "upload_time"=>"2024-09-10 14:34:58"
}

# Object response
<OpenStruct id=1, emp=16, emp_code="1", first_name="Test", last_name=nil, department="Test", position=nil, punch_time="2024-09-05 01:01:00", punch_state="0", punch_state_display="Check In", verify_type=0, verify_type_display="Any", work_code=nil, gps_location="", area_alias=nil, terminal_sn="", temperature=0.0, is_mask="-", terminal_alias=nil, upload_time="2024-09-10 14:34:58">
```

#### List Transactions

```ruby
# ZktClient::Transaction.list(**options)
# NOTE: Check the ZKT APIs documention for more details.

ZktClient::Transaction.list(page: 1)

# JSON response
{
  "count"=>25,
  "next"=>"http://biotime8.zkteco.eu/iclock/api/transactions/?page=2",
  "previous"=>nil,
  "msg"=>"",
  "code"=>0,
  "data"=>
   [
     {
      "id"=>1,
      "emp"=>16,
      "emp_code"=>"1",
      "first_name"=>"Test",
      "last_name"=>nil,
      "department"=>"Test",
      "position"=>nil,
      "punch_time"=>"2024-09-05 01:01:00",
      "punch_state"=>"0",
      "punch_state_display"=>"Check In",
      "verify_type"=>0,
      "verify_type_display"=>"Any",
      "work_code"=>nil,
      "gps_location"=>"",
      "area_alias"=>nil,
      "terminal_sn"=>"",
      "temperature"=>0.0,
      "is_mask"=>"-",
      "terminal_alias"=>nil,
    "upload_time"=>"2024-09-10 14:34:58"
   }
 ]
}

# Object response
[<OpenStruct id=1, emp=16, emp_code="1", first_name="Test", last_name=nil, department="Test", position=nil, punch_time="2024-09-05 01:01:00", punch_state="0", punch_state_display="Check In", verify_type=0, verify_type_display="Any", work_code=nil, gps_location="", area_alias=nil, terminal_sn="", temperature=0.0, is_mask="-", terminal_alias=nil, upload_time="2024-09-10 14:34:58">]
```

#### Delete Transaction

```ruby
# ZktClient::Transaction.delete(id)

ZktClient::Transaction.delete(16)

# JSON response
true

# Object response
true
```

Exceptions
------------

Class                                    | Description                                                       |  Message
---------------------------------------- | :---------------------------------------------------------------: | ------------------------------------
`ZktClient::MissingConfigurationError`   | If you do a request without configure ZktCleint configurations.   | Configurations are missing!
`ZktClient::UnauthorizedError`           | When Invalid login.                                               | Invalid credentials!
`ZktClient::RecordNotFound`              | When the request status id 404                                    | Picked from the response itself
`ZktClient::BadRequestError`             | When the request status is 404                                    | Picked from the response itself
`ZktClient::UnprocessableEntityError`    | When the request status is 422                                    | Picked from the response itself
`ZktClient::ServerError`                 | When the request status is (500..599)                             | Picked from the response itself
`ZktClient::RequestFailedError`          | When the request status with another status                       | Picked from the response itself

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [Zkt Client Repo](https://github.com/Ahmed-Salem-Baqtyan/zkt_client). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ZktClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/zkt_client/blob/main/CODE_OF_CONDUCT.md).
