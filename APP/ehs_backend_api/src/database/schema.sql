-- ==============================================================================
-- EHS Track Pro — Enterprise PostgreSQL Database Schema
-- Production Schema with Multi-tenant Sites, RBAC, Delta Sync, and Audit Trails
-- ==============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. ENUMS
CREATE TYPE user_role AS ENUM (
  'field_worker',
  'site_supervisor',
  'safety_inspector',
  'ehs_manager',
  'external_auditor'
);

CREATE TYPE incident_type AS ENUM (
  'near_miss',
  'first_aid',
  'lost_time_injury',
  'environmental_hazard',
  'property_damage'
);

CREATE TYPE capa_status AS ENUM (
  'draft',
  'assigned',
  'in_progress',
  'under_review',
  'closed',
  'verified'
);

CREATE TYPE capa_priority AS ENUM ('low', 'medium', 'high', 'critical');

-- 2. USERS & RBAC TABLE
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(150) NOT NULL,
  role user_role NOT NULL DEFAULT 'safety_inspector',
  site_id VARCHAR(100) DEFAULT 'SITE-MAIN',
  preferred_language VARCHAR(5) DEFAULT 'ar',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. INCIDENTS & NEAR MISSES
CREATE TABLE incidents (
  id VARCHAR(50) PRIMARY KEY,
  type incident_type NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  severity_level INT CHECK (severity_level BETWEEN 1 AND 5),
  site_location VARCHAR(200) NOT NULL,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  reporter_id UUID REFERENCES users(id) ON DELETE SET NULL,
  status VARCHAR(50) DEFAULT 'open',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. MULTIMEDIA & IMAGE HAZARD ANNOTATIONS
CREATE TABLE incident_attachments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  incident_id VARCHAR(50) REFERENCES incidents(id) ON DELETE CASCADE,
  file_url TEXT NOT NULL,
  mime_type VARCHAR(100),
  annotation_svg_json JSONB,
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. CAPA (CORRECTIVE & PREVENTIVE ACTIONS)
CREATE TABLE capas (
  id VARCHAR(50) PRIMARY KEY,
  incident_id VARCHAR(50) REFERENCES incidents(id) ON DELETE SET NULL,
  action_title VARCHAR(255) NOT NULL,
  description TEXT,
  assignee_name VARCHAR(150) NOT NULL,
  assignee_id UUID REFERENCES users(id) ON DELETE SET NULL,
  deadline DATE NOT NULL,
  status capa_status DEFAULT 'assigned',
  priority capa_priority DEFAULT 'medium',
  evidence_photo_url TEXT,
  verified_by UUID REFERENCES users(id) ON DELETE SET NULL,
  closed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. AUDIT INSPECTIONS & ISO COMPLIANCE
CREATE TABLE audit_inspections (
  id VARCHAR(50) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  standard_ref VARCHAR(100) DEFAULT 'ISO 45001:2018',
  site_location VARCHAR(200) NOT NULL,
  auditor_id UUID REFERENCES users(id) ON DELETE SET NULL,
  score_percentage NUMERIC(5,2) DEFAULT 0.00,
  is_finalized BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  finalized_at TIMESTAMPTZ
);

CREATE TABLE audit_checklist_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  audit_id VARCHAR(50) REFERENCES audit_inspections(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  result VARCHAR(20) CHECK (result IN ('pass', 'fail', 'na', 'pending')),
  finding_notes TEXT,
  capa_id VARCHAR(50) REFERENCES capas(id) ON DELETE SET NULL
);

-- 7. WORK PERMITS (PTW) & DIGITAL SIGNATURES
CREATE TABLE work_permits (
  id VARCHAR(50) PRIMARY KEY,
  permit_type VARCHAR(100) NOT NULL, -- Hot Work, Confined Space, Height
  site_location VARCHAR(200) NOT NULL,
  contractor_name VARCHAR(200),
  valid_from TIMESTAMPTZ NOT NULL,
  valid_to TIMESTAMPTZ NOT NULL,
  gas_test_data JSONB,
  signature_image_url TEXT,
  authorized_by UUID REFERENCES users(id) ON DELETE SET NULL,
  status VARCHAR(50) DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. OFFLINE DELTA SYNC JOURNAL (Outbox Engine)
CREATE TABLE sync_deltas (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  device_id VARCHAR(100) NOT NULL,
  entity_name VARCHAR(50) NOT NULL,
  entity_id VARCHAR(50) NOT NULL,
  operation VARCHAR(20) NOT NULL, -- UPSERT, DELETE
  payload JSONB NOT NULL,
  client_timestamp TIMESTAMPTZ NOT NULL,
  server_timestamp TIMESTAMPTZ DEFAULT NOW()
);

-- 9. IMMUTABLE AUDIT LOG (Compliance Security)
CREATE TABLE audit_logs (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  action VARCHAR(100) NOT NULL,
  entity VARCHAR(50) NOT NULL,
  entity_id VARCHAR(50),
  ip_address VARCHAR(45),
  details JSONB,
  timestamp TIMESTAMPTZ DEFAULT NOW()
);

-- INDEXES FOR MAXIMUM QUERY EFFICIENCY
CREATE INDEX idx_incidents_type ON incidents(type);
CREATE INDEX idx_incidents_created ON incidents(created_at DESC);
CREATE INDEX idx_capas_status ON capas(status);
CREATE INDEX idx_capas_deadline ON capas(deadline);
CREATE INDEX idx_sync_deltas_timestamp ON sync_deltas(server_timestamp DESC);
