CREATE TABLE `key_store` (
    `key_id` varchar(50) NOT NULL,
   `record_type` varchar(50)   NOT NULL ,
   `validity` varchar(50)    NOT NULL ,
   `key_length` varchar(50)    NOT NULL ,
   `algorithm` varchar(50)    NOT NULL ,
   `date_creation` varchar(50)    NOT NULL ,
   `date_expire` varchar(50)    NOT NULL ,
   `serial_number` varchar(50)    NOT NULL ,
   `owner_trust` varchar(50)    NOT NULL ,
   `user_id` varchar(50)    NOT NULL ,
   `signature_class` varchar(50)    NOT NULL, 
   KEY `key_key_id` (`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
