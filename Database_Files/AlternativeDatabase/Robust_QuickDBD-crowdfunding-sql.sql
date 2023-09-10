-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "campaign" (
    "cf_id" INT   NOT NULL,
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
    CONSTRAINT "pk_campaign" PRIMARY KEY (
        "cf_id"
     )
);

CREATE TABLE "category" (
    "category_id" VARCHAR(50)   NOT NULL,
    "category" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "category_campaign" (
    "category_campaign_id" INT   NOT NULL,
    "category_id" VARCHAR(50)   NOT NULL,
    "cf_id" INT   NOT NULL,
    CONSTRAINT "pk_category_campaign" PRIMARY KEY (
        "category_campaign_id"
     )
);

CREATE TABLE "contacts" (
    "contact_id" INT   NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "email" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
);

CREATE TABLE "subcategory" (
    "subcategory_id" VARCHAR(50)   NOT NULL,
    "subcategory" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_subcategory" PRIMARY KEY (
        "subcategory_id"
     )
);

CREATE TABLE "subcategory_campaign" (
    "subcategory_campaign_id" INT   NOT NULL,
    "subcategory_id" VARCHAR(50)   NOT NULL,
    "cf_id" INT   NOT NULL,
    CONSTRAINT "pk_subcategory_campaign" PRIMARY KEY (
        "subcategory_campaign_id"
     )
);

CREATE TABLE "contact_campaign" (
    "contacts_campaign_id" INT   NOT NULL,
    "contact_id" VARCHAR(50)   NOT NULL,
    "cf_id" INT   NOT NULL,
    CONSTRAINT "pk_contact_campaign" PRIMARY KEY (
        "contacts_campaign_id"
     )
);

CREATE TABLE "subcategory_category" (
    "subcategory_category_id" INT   NOT NULL,
    "category_id" VARCHAR(50)   NOT NULL,
    "subcategory_id" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_subcategory_category" PRIMARY KEY (
        "subcategory_category_id"
     )
);

ALTER TABLE "category_campaign" ADD CONSTRAINT "fk_category_campaign_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "category_campaign" ADD CONSTRAINT "fk_category_campaign_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

ALTER TABLE "subcategory_campaign" ADD CONSTRAINT "fk_subcategory_campaign_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");

ALTER TABLE "subcategory_campaign" ADD CONSTRAINT "fk_subcategory_campaign_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

ALTER TABLE "contact_campaign" ADD CONSTRAINT "fk_contact_campaign_contact_id" FOREIGN KEY("contact_id")
REFERENCES "contacts" ("contact_id");

ALTER TABLE "contact_campaign" ADD CONSTRAINT "fk_contact_campaign_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

ALTER TABLE "subcategory_category" ADD CONSTRAINT "fk_subcategory_category_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "subcategory_category" ADD CONSTRAINT "fk_subcategory_category_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");

