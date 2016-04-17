-- Before setting up any privileges, we revoke existing ones to make sure we
-- start from a clean slate.
-- Note that dropping a non-existing user produces an error that aborts the
-- script, so we first grant a harmless privilege to each user to ensure it
-- exists.
DROP USER IF EXISTS 'policy'@'localhost';
DROP USER IF EXISTS 'sa'@'localhost';
DROP USER IF EXISTS 'ocsp_resp'@'localhost';
DROP USER IF EXISTS 'ocsp_update'@'localhost';
DROP USER IF EXISTS 'revoker'@'localhost';
DROP USER IF EXISTS 'importer'@'localhost';
DROP USER IF EXISTS 'mailer'@'localhost';
DROP USER IF EXISTS 'cert_checker'@'localhost';
DROP USER IF EXISTS 'backfiller'@'localhost';
