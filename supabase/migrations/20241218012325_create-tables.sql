CREATE TABLE "organization" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "organization_name" TEXT NOT NULL,
    "created_at" TIMESTAMP DEFAULT now(),
    "email_suffix" TEXT
);

CREATE TABLE "course" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "course_name" TEXT NOT NULL,
    "organization_id" UUID REFERENCES organization(id) ON DELETE CASCADE ON UPDATE CASCADE,
    "created_at" TIMESTAMP DEFAULT now()
);

CREATE TABLE "roles" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "role_name" TEXT UNIQUE NOT NULL,
    "created_at" TIMESTAMP DEFAULT now()
);

CREATE TABLE "users" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "first_name" TEXT DEFAULT NULL,
    "last_name" TEXT DEFAULT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "phone" TEXT,
    "role_id" UUID REFERENCES role(id) ON DELETE SET NULL ON UPDATE CASCADE
)
