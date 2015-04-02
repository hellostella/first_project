
DROP TABLE IF EXISTS accounts, transactions;

CREATE TABLE accounts (
  id           SERIAL PRIMARY KEY,
  name         TEXT NOT NULL,
  account_type TEXT NOT NULL

);

CREATE TABLE transactions (
  id           SERIAL PRIMARY KEY,
  payee        TEXT,
  category     TEXT NOT NULL,
  credit       MONEY,
  debit        MONEY,
  time_added   TIMESTAMP,
  account_id   INTEGER REFERENCES accounts(id)
);


-- credit_debit BOOLEAN
-- when credit_debit = True add from balance
-- when credit_debit = False subtract from balance
