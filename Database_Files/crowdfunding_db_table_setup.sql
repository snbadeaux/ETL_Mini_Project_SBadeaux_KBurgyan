--Create table schema
CREATE TABLE "category" (
    "category_id" VARCHAR(50) PRIMARY KEY  NOT NULL,
    "category" VARCHAR(50)   NOT NULL
);
CREATE TABLE "contacts" (
    "contact_id" INT PRIMARY KEY  NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "email" VARCHAR(50)   NOT NULL
);
CREATE TABLE "subcategory" (
    "subcategory_id" VARCHAR(50) PRIMARY KEY NOT NULL,
    "subcategory" VARCHAR(50)   NOT NULL
);
CREATE TABLE "campaign" (
    "cf_id" INT PRIMARY KEY  NOT NULL,
    "contact_id" INT   NOT NULL,
        FOREIGN KEY (contact_id) REFERENCES contacts(contact_id),
    "company_name" VARCHAR(50)   NOT NULL,
    "description" VARCHAR(225)   NOT NULL,
    "goal" NUMERIC(10,2)   NOT NULL,
    "pledged" NUMERIC(10,2)   NOT NULL,
    "outcome" VARCHAR(50)   NOT NULL,
    "backers_count" INT   NOT NULL,
    "country" VARCHAR(50)   NOT NULL,
    "currency" VARCHAR(50)   NOT NULL,
    "launched_date" DATE   NOT NULL,
    "end_date" DATE   NOT NULL,
    "category_id" VARCHAR(50)   NOT NULL,
        FOREIGN KEY (category_id) REFERENCES category(category_id),
    "subcategory_id" VARCHAR(50)   NOT NULL,
        FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
);









