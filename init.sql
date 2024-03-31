create table Balance
(
    id           bigint primary key,
    balanceValue numeric,
    limitValue   numeric,
    modified     TIMESTAMPTZ
);
create table ClientStatusType
(
    id   bigint primary key,
    name text
);
create table ClientType
(
    id   bigint primary key,
    name text
);
create table ClientInfo
(
    id               bigint primary key,
    lastname         text,
    firstname        text,
    middlename       text,
    organisationName text,
    phoneNumber      text,
    birthdate        Date,
    city             text,
    postalCode       text,
    street           text,
    buildingNumber   text,
    flatNumber       text,
    clientTypeId     bigint,
    FOREIGN KEY (clientTypeId) REFERENCES ClientType (id)
);
create table OperatorInfo
(
    id          bigint primary key,
    lastname    text,
    firstname   text,
    middlename  text,
    phoneNumber text,
    birthdate   Date
);
create table Roles
(
    id   bigint primary key,
    name text
);
create table Operators
(
    id             bigint primary key,
    operatorInfoId bigint,
    login          text,
    password       text,
    roleId         bigint,
    creatorId      bigint,
    created        TIMESTAMPTZ,
    modified       TIMESTAMPTZ,
    FOREIGN KEY (operatorInfoId) REFERENCES OperatorInfo (id),
    FOREIGN KEY (roleId) REFERENCES Roles (id),
    FOREIGN KEY (creatorId) REFERENCES Operators (id)
);
create table Clients
(
    id                 bigint primary key,
    balanceId          bigint,
    clientStatusTypeId bigint,
    clientInfoId       bigint,
    creatorId          bigint,
    created            TIMESTAMPTZ,
    modified           TIMESTAMPTZ,
    FOREIGN KEY (balanceId) REFERENCES Balance (id),
    FOREIGN KEY (clientStatusTypeId) REFERENCES ClientStatusType (id),
    FOREIGN KEY (clientInfoId) REFERENCES ClientInfo (id),
    FOREIGN KEY (creatorId) REFERENCES Operators (id)
);



create table Services
(
    id   bigint primary key,
    name text
);
create table Tariffs
(
    id               bigint primary key,
    description      text,
    price            numeric,
    howoftenpermonth integer
);
create table ServiceTariff
(
    id         bigint primary key,
    clientId   bigint,
    tariffsId  bigint,
    servicesId bigint,
    ispaided   bool,
    FOREIGN KEY (servicesId) REFERENCES Services (id),
    FOREIGN KEY (tariffsId) REFERENCES Tariffs (id),
    FOREIGN KEY (clientId) REFERENCES Clients (id)
);


create table Logger
(
    id         bigint primary key,
    actionType text,
    clientId   bigint,
    operatorId bigint,
    created    TIMESTAMPTZ,
    FOREIGN KEY (clientId) REFERENCES Clients (id),
    FOREIGN KEY (operatorId) REFERENCES Operators (id)
);


create table PaymentType
(
    id   bigint primary key,
    name text
);
create table Payments
(
    id            bigint primary key,
    clientId      bigint,
    paymentTypeId bigint,
    value         numeric,
    FOREIGN KEY (clientId) REFERENCES Clients (id),
    FOREIGN KEY (paymentTypeId) REFERENCES PaymentType (id)
);
create table Correction
(
    id         bigint primary key,
    value      numeric,
    operatorId bigint,
    clientId   bigint,
    created    TIMESTAMPTZ,
    FOREIGN KEY (clientId) REFERENCES Clients (id),
    FOREIGN KEY (operatorId) REFERENCES Operators (id)
);
CREATE TABLE Sessions
(
    id         BIGINT PRIMARY KEY,
    token      text,
    operatorid BIGINT,
    created    TIMESTAMPTZ,
    expirytime TIMESTAMPTZ
);
INSERT INTO operatorinfo (id, lastname, firstname, middlename, phonenumber, birthdate)
VALUES ('1'::bigint, 'Загвоздкин'::text,
        'Вячеслав'::text, 'Сергеевич'::text,
        '89159948816'::text, '24.01.2003'::date);
INSERT INTO roles (id, name)
VALUES ('1'::bigint, 'admin'::text);

INSERT INTO roles (id, name)
VALUES ('2'::bigint, 'operator'::text);

INSERT INTO operators (id, operatorinfoid, login, password, roleid, created)
VALUES ('1'::bigint, '1'::bigint, 'admin'::text, 'admin
'::text, '1'::bigint, 'now()'::timestamp with time zone);

INSERT INTO clientstatustype (id, name)
VALUES ('1'::bigint, 'Подключен'::text);

INSERT INTO clientstatustype (id, name)
VALUES ('2'::bigint, 'Активен'::text);

INSERT INTO clientstatustype (id, name)
VALUES ('3'::bigint, 'Блокировка'::text);

INSERT INTO clientstatustype (id, name)
VALUES ('4'::bigint, 'Расторгнут'::text);

INSERT INTO clienttype (id, name)
VALUES ('1'::bigint, 'Физическое лицо'::text);
INSERT INTO clienttype (id, name)
VALUES ('2'::bigint, 'Юридическое лицо'::text);

INSERT INTO services (id, name)
VALUES ('1'::bigint, 'Интернет'::text);
INSERT INTO services (id, name)
VALUES ('2'::bigint, 'Телефония'::text);

INSERT INTO tariffs (id, description, price, howoftenpermonth)
VALUES ('1'::bigint, '100 мб сек'::text, '300'::numeric, 1::integer);
INSERT INTO tariffs (id, description, price, howoftenpermonth)
VALUES ('2'::bigint, '250 мб сек'::text, '500'::numeric, 1::integer);
INSERT INTO tariffs (id, description, price, howoftenpermonth)
VALUES ('3'::bigint, 'безлимитный интернет'::text, '30'::numeric, 30::integer);
INSERT INTO tariffs (id, description, price, howoftenpermonth)
VALUES ('4'::bigint, '30 гб мес'::text, '300'::numeric, 1::integer);
INSERT INTO tariffs (id, description, price, howoftenpermonth)
VALUES ('5'::bigint, 'музыка на звонки'::text, '5'::numeric, 30::integer);

INSERT INTO servicetariff (id, clientid, tariffsid, servicesid, ispaided)
VALUES ('1'::bigint, '1'::bigint, '5'::bigint, '2'::bigint, false::boolean);

CREATE SEQUENCE logger_seq START WITH 10;
CREATE SEQUENCE balance_seq START WITH 10;
CREATE SEQUENCE clientinfo_seq START WITH 10;
CREATE SEQUENCE clients_seq START WITH 10;
CREATE SEQUENCE clientstatustype_seq START WITH 10;
CREATE SEQUENCE clienttype_seq START WITH 10;
CREATE SEQUENCE correction_seq START WITH 10;
CREATE SEQUENCE operatorinfo_seq START WITH 10;
CREATE SEQUENCE operators_seq START WITH 10;
CREATE SEQUENCE payments_seq START WITH 10;
CREATE SEQUENCE paymenttype_seq START WITH 10;
CREATE SEQUENCE roles_seq START WITH 10;
CREATE SEQUENCE services_seq START WITH 10;
CREATE SEQUENCE servicetariff_seq START WITH 10;
CREATE SEQUENCE tariffs_seq START WITH 10;
CREATE SEQUENCE sessions_seq START WITH 10;




