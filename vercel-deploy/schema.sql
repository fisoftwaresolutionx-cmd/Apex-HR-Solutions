CREATE TABLE "admin_users" (
	"id" serial PRIMARY KEY NOT NULL,
	"username" text NOT NULL,
	"name" text NOT NULL,
	"email" text,
	"password" text NOT NULL,
	"role" text DEFAULT 'admin' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "admin_users_username_unique" UNIQUE("username")
);
--> statement-breakpoint
CREATE TABLE "announcements" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"content" text NOT NULL,
	"priority" text DEFAULT 'medium' NOT NULL,
	"created_by" text NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "applications" (
	"id" serial PRIMARY KEY NOT NULL,
	"candidate_id" integer NOT NULL,
	"job_id" integer NOT NULL,
	"status" text NOT NULL,
	"applied_date" timestamp DEFAULT now(),
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "appreciations" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"awarded_by" text NOT NULL,
	"rating" integer,
	"date" date NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "assets" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"category" text NOT NULL,
	"serial_number" text NOT NULL,
	"purchase_date" date NOT NULL,
	"purchase_price" numeric(10, 2) NOT NULL,
	"assigned_to" integer,
	"status" text NOT NULL,
	"condition" text NOT NULL,
	"notes" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "assets_serial_number_unique" UNIQUE("serial_number")
);
--> statement-breakpoint
CREATE TABLE "attendance" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"date" date NOT NULL,
	"check_in" timestamp NOT NULL,
	"check_out" timestamp,
	"type" text NOT NULL,
	"hours_worked" numeric(5, 2),
	"location" text,
	"notes" text,
	"selfie" text,
	"project_id" integer
);
--> statement-breakpoint
CREATE TABLE "audit_logs" (
	"id" serial PRIMARY KEY NOT NULL,
	"action" text NOT NULL,
	"entity_type" text NOT NULL,
	"entity_id" integer,
	"user_id" text,
	"details" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "automation_rules" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"trigger" text NOT NULL,
	"condition" text,
	"action" text NOT NULL,
	"action_config" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"run_count" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "bank_accounts" (
	"id" serial PRIMARY KEY NOT NULL,
	"account_type" text DEFAULT 'company' NOT NULL,
	"account_holder_name" text NOT NULL,
	"bank_name" text NOT NULL,
	"account_number" text NOT NULL,
	"routing_code" text,
	"account_category" text DEFAULT 'current' NOT NULL,
	"currency" text DEFAULT 'USD' NOT NULL,
	"bank_branch" text,
	"bank_address" text,
	"swift_code" text,
	"is_default" boolean DEFAULT false NOT NULL,
	"employee_id" integer,
	"current_balance" numeric(14, 2) DEFAULT '0',
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "biometric_devices" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"device_id" text NOT NULL,
	"location" text,
	"device_type" text NOT NULL,
	"api_key" text NOT NULL,
	"status" text NOT NULL,
	"last_sync" timestamp,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "biometric_devices_device_id_unique" UNIQUE("device_id")
);
--> statement-breakpoint
CREATE TABLE "candidates" (
	"id" serial PRIMARY KEY NOT NULL,
	"first_name" text NOT NULL,
	"last_name" text NOT NULL,
	"email" text NOT NULL,
	"phone" text,
	"position" text NOT NULL,
	"resume" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "candidates_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "certifications" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"name" text NOT NULL,
	"issued_by" text NOT NULL,
	"issued_date" date NOT NULL,
	"expiry_date" date,
	"file_url" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "companies" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"legal_name" text,
	"country" text DEFAULT 'Pakistan' NOT NULL,
	"currency" text DEFAULT 'PKR' NOT NULL,
	"address" text,
	"phone" text,
	"email" text,
	"tax_id" text,
	"registration_no" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"employee_count" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "course_enrollments" (
	"id" serial PRIMARY KEY NOT NULL,
	"course_id" integer NOT NULL,
	"employee_id" integer NOT NULL,
	"progress" integer DEFAULT 0 NOT NULL,
	"completed_at" timestamp,
	"enrolled_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "courses" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"category" text NOT NULL,
	"duration" integer NOT NULL,
	"instructor" text,
	"status" text DEFAULT 'active' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "departments" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "departments_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "designations" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "designations_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "documents" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"name" text NOT NULL,
	"type" text NOT NULL,
	"file_url" text,
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "employee_loans" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"loan_type" text DEFAULT 'personal' NOT NULL,
	"amount" numeric(12, 2) NOT NULL,
	"purpose" text,
	"total_installments" integer DEFAULT 12 NOT NULL,
	"paid_installments" integer DEFAULT 0 NOT NULL,
	"monthly_installment" numeric(10, 2) NOT NULL,
	"status" text DEFAULT 'active' NOT NULL,
	"approved_by" text,
	"notes" text,
	"disbursed_at" timestamp DEFAULT now(),
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "employee_taxes" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"slab_id" integer,
	"period" text NOT NULL,
	"gross_income" numeric(12, 2) NOT NULL,
	"taxable_income" numeric(12, 2) NOT NULL,
	"tax_amount" numeric(12, 2) NOT NULL,
	"status" text DEFAULT 'calculated' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "employees" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"phone" text,
	"department" text NOT NULL,
	"designation" text,
	"shift" text NOT NULL,
	"join_date" date NOT NULL,
	"salary" numeric(10, 2) NOT NULL,
	"salary_type" text NOT NULL,
	"allowance_hra" numeric(10, 2) DEFAULT '0',
	"allowance_medical" numeric(10, 2) DEFAULT '0',
	"allowance_transport" numeric(10, 2) DEFAULT '0',
	"password" text,
	"profile_image" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "employees_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "expenses" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"title" text NOT NULL,
	"amount" numeric(10, 2) NOT NULL,
	"category" text NOT NULL,
	"notes" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "gate_passes" (
	"id" serial PRIMARY KEY NOT NULL,
	"pass_number" text NOT NULL,
	"visitor_id" integer,
	"holder_name" text NOT NULL,
	"holder_type" text DEFAULT 'visitor' NOT NULL,
	"purpose" text NOT NULL,
	"vehicle_number" text,
	"valid_from" timestamp NOT NULL,
	"valid_to" timestamp NOT NULL,
	"issued_by_id" integer,
	"status" text DEFAULT 'active' NOT NULL,
	"notes" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "gate_passes_pass_number_unique" UNIQUE("pass_number")
);
--> statement-breakpoint
CREATE TABLE "goals" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"progress" integer DEFAULT 0 NOT NULL,
	"due_date" date,
	"status" text DEFAULT 'active' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "holidays" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"date" date NOT NULL,
	"type" text NOT NULL,
	"description" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "holidays_date_unique" UNIQUE("date")
);
--> statement-breakpoint
CREATE TABLE "integration_connections" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"provider" text NOT NULL,
	"category" text NOT NULL,
	"status" text DEFAULT 'disconnected' NOT NULL,
	"api_key" text,
	"webhook_url" text,
	"config" text,
	"connected_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "jobs" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"department" text NOT NULL,
	"description" text NOT NULL,
	"requirements" text,
	"salary" text,
	"status" text NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"closed_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "leaves" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"leave_type" text NOT NULL,
	"start_date" date NOT NULL,
	"end_date" date NOT NULL,
	"reason" text NOT NULL,
	"status" text NOT NULL,
	"approved_by" integer,
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "licenses" (
	"id" serial PRIMARY KEY NOT NULL,
	"license_key" text NOT NULL,
	"plan" text DEFAULT 'basic' NOT NULL,
	"email" text NOT NULL,
	"company_name" text,
	"max_users" integer DEFAULT 10 NOT NULL,
	"status" text DEFAULT 'active' NOT NULL,
	"expires_at" timestamp,
	"activated_at" timestamp,
	"notes" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "licenses_license_key_unique" UNIQUE("license_key")
);
--> statement-breakpoint
CREATE TABLE "notifications" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"message" text NOT NULL,
	"type" text DEFAULT 'info' NOT NULL,
	"is_read" boolean DEFAULT false NOT NULL,
	"recipient" text,
	"link" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "onboarding_tasks" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"task_type" text NOT NULL,
	"title" text NOT NULL,
	"category" text NOT NULL,
	"is_completed" boolean DEFAULT false NOT NULL,
	"due_date" date,
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "orders" (
	"id" serial PRIMARY KEY NOT NULL,
	"plan" text NOT NULL,
	"email" text NOT NULL,
	"company_name" text,
	"phone" text,
	"amount" numeric(10, 2) NOT NULL,
	"currency" text DEFAULT 'USD' NOT NULL,
	"payment_method" text DEFAULT 'payoneer' NOT NULL,
	"payment_status" text DEFAULT 'pending' NOT NULL,
	"license_id" integer,
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "payroll" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"period" text NOT NULL,
	"base_salary" numeric(10, 2) NOT NULL,
	"allowances" numeric(10, 2) DEFAULT '0',
	"deductions" numeric(10, 2) NOT NULL,
	"net_salary" numeric(10, 2) NOT NULL,
	"status" text NOT NULL,
	"payment_method" text DEFAULT 'bank_transfer',
	"notes" text,
	"paid_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "performance_reviews" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"reviewer_name" text NOT NULL,
	"period" text NOT NULL,
	"rating" integer NOT NULL,
	"kpis" text,
	"feedback" text,
	"status" text DEFAULT 'draft' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "project_members" (
	"id" serial PRIMARY KEY NOT NULL,
	"project_id" integer NOT NULL,
	"employee_id" integer NOT NULL,
	"role" text DEFAULT 'member' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "project_tasks" (
	"id" serial PRIMARY KEY NOT NULL,
	"project_id" integer NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"status" text DEFAULT 'todo' NOT NULL,
	"priority" text DEFAULT 'medium' NOT NULL,
	"assignee_id" integer,
	"due_date" date,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "projects" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"status" text DEFAULT 'planning' NOT NULL,
	"priority" text DEFAULT 'medium' NOT NULL,
	"start_date" date,
	"end_date" date,
	"budget" numeric(12, 2),
	"manager_id" integer,
	"progress" integer DEFAULT 0 NOT NULL,
	"tags" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "reception_meetings" (
	"id" serial PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"host_employee_id" integer,
	"visitor_name" text,
	"visitor_company" text,
	"meeting_date" date NOT NULL,
	"start_time" text NOT NULL,
	"end_time" text NOT NULL,
	"meeting_room" text,
	"attendees" text,
	"status" text DEFAULT 'scheduled' NOT NULL,
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "roles" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"permissions" text DEFAULT '[]' NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "roles_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "shift_roster" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"shift_id" integer NOT NULL,
	"date" date NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "shifts" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"start_time" text NOT NULL,
	"end_time" text NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "shifts_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "tax_slabs" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"min_income" numeric(12, 2) DEFAULT '0' NOT NULL,
	"max_income" numeric(12, 2),
	"rate" numeric(5, 2) NOT NULL,
	"fixed_amount" numeric(12, 2) DEFAULT '0' NOT NULL,
	"description" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "timesheets" (
	"id" serial PRIMARY KEY NOT NULL,
	"employee_id" integer NOT NULL,
	"date" date NOT NULL,
	"project" text NOT NULL,
	"hours" numeric(5, 2) NOT NULL,
	"description" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "visitors" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"phone" text,
	"email" text,
	"company" text,
	"purpose" text NOT NULL,
	"host_employee_id" integer,
	"check_in" timestamp DEFAULT now() NOT NULL,
	"check_out" timestamp,
	"status" text DEFAULT 'checked_in' NOT NULL,
	"id_type" text,
	"id_number" text,
	"badge" text,
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
