--
-- Copyright 2015 ISRG.  All rights reserved
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- This file defines the default users for the primary database, used by
-- all the parts of Boulder except the Certificate Authority module, which
-- utilizes its own database.
--

-- Create users for each component with the appropriate permissions. We want to
-- drop each user and recreate them, but if the user doesn't already exist, the
-- drop command will fail. So we grant the dummy `USAGE` privilege to make sure
-- the user exists and then drop the user.

-- In MariaDB 10.1 the DROP USER command now uses IF EXISTS to keep from failing
-- when the USER does not exist.
-- It is also nescessary to CREATE the USER prior to GRANT of Privileges.

-- Storage Authority
DROP USER IF EXISTS 'sa'@'localhost';
CREATE USER 'sa'@'localhost';
GRANT SELECT,INSERT,UPDATE ON authz TO 'sa'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON pendingAuthorizations TO 'sa'@'localhost';
GRANT SELECT(id,Lockcol) ON pendingAuthorizations TO 'sa'@'localhost';
GRANT SELECT,INSERT ON certificates TO 'sa'@'localhost';
GRANT SELECT,INSERT,UPDATE ON certificateStatus TO 'sa'@'localhost';
GRANT SELECT,INSERT ON issuedNames TO 'sa'@'localhost';
GRANT SELECT,INSERT ON sctReceipts TO 'sa'@'localhost';
GRANT SELECT,INSERT ON deniedCSRs TO 'sa'@'localhost';
GRANT INSERT ON ocspResponses TO 'sa'@'localhost';
GRANT SELECT,INSERT,UPDATE ON registrations TO 'sa'@'localhost';
GRANT SELECT,INSERT,UPDATE ON challenges TO 'sa'@'localhost';
GRANT SELECT,INSERT on fqdnSets TO 'sa'@'localhost';

-- OCSP Responder
DROP USER IF EXISTS 'ocsp_resp'@'localhost';
CREATE USER 'ocsp_resp'@'localhost';
GRANT SELECT ON certificateStatus TO 'ocsp_resp'@'localhost';
GRANT SELECT ON ocspResponses TO 'ocsp_resp'@'localhost';

-- OCSP Generator Tool (Updater)
DROP USER IF EXISTS 'ocsp_update'@'localhost';
CREATE USER 'ocsp_update'@'localhost';
GRANT INSERT ON ocspResponses TO 'ocsp_update'@'localhost';
GRANT SELECT ON certificates TO 'ocsp_update'@'localhost';
GRANT SELECT,UPDATE ON certificateStatus TO 'ocsp_update'@'localhost';
GRANT SELECT ON sctReceipts TO 'ocsp_update'@'localhost';

-- Revoker Tool
DROP USER IF EXISTS 'revoker'@'localhost';
CREATE USER 'revoker'@'localhost';
GRANT SELECT ON registrations TO 'revoker'@'localhost';
GRANT SELECT ON certificates TO 'revoker'@'localhost';
GRANT SELECT,INSERT ON deniedCSRs TO 'revoker'@'localhost';

-- External Cert Importer
DROP USER IF EXISTS 'importer'@'localhost';
CREATE USER 'importer'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON identifierData TO 'importer'@'localhost';
GRANT SELECT,INSERT,UPDATE,DELETE ON externalCerts TO 'importer'@'localhost';

-- Expiration mailer
DROP USER IF EXISTS 'mailer'@'localhost';
CREATE USER 'mailer'@'localhost';
GRANT SELECT ON certificates TO 'mailer'@'localhost';
GRANT SELECT,UPDATE ON certificateStatus TO 'mailer'@'localhost';
GRANT SELECT ON fqdnSets TO 'mailer'@'localhost';

-- Cert checker
DROP USER IF EXISTS 'cert_checker'@'localhost';
CREATE USER 'cert_checker'@'localhost';
GRANT SELECT ON certificates TO 'cert_checker'@'localhost';

-- Name set table backfiller
DROP USER IF EXISTS 'backfiller'@'localhost';
CREATE USER 'backfiller'@'localhost';
GRANT SELECT ON certificates to 'backfiller'@'localhost';
GRANT INSERT,SELECT ON fqdnSets to 'backfiller'@'localhost';

-- Test setup and teardown
DROP USER IF EXISTS 'test_setup'@'localhost';
CREATE USER 'test_setup'@'localhost';
GRANT ALL PRIVILEGES ON * to 'test_setup'@'localhost';
