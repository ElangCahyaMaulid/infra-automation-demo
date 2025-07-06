const express = require('express');
const { Client } = require('pg');

const app = express();
const PORT = 3000;

const db = new Client({
  host: 'db',
  user: 'user',
  password: 'pass',
  database: 'appdb'
});

db.connect()
  .then(() => console.log('Connected to DB'))
  .catch((err) => console.error('DB connection error:', err.message));

app.get('/', async (req, res) => {
  try {
    const result = await db.query('SELECT NOW()');
    res.send(`Hello from Node.js! DB time: ${result.rows[0].now}`);
  } catch (err) {
    res.status(500).send(`Error: ${err.message}`);
  }
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});
