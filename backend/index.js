const express = require('express');
const cors = require('cors');
require('dotenv').config();

const pool = require('./config/db');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Route cek server
app.get('/', (req, res) => {
  res.json({ message: 'API DesaKita aktif dan berjalan!' });
});

// GET semua kategori
app.get('/api/categories', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM categories ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Gagal mengambil data toko', detail: err.message });
  }
});

// GET semua toko
app.get('/api/stores', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM stores ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    console.error('ERROR STORES:', err);
    res.status(500).json({
      error: 'Gagal mengambil data toko',
      detail: err.message || err.code || String(err),
    });
  }
});

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});