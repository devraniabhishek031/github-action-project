const express = require('express');
const app = express();
const PORT = 3000;

// Middleware to parse JSON
app.use(express.json());

// Basic route
app.get('/', (req, res) => {
  res.send('Hello from Node.js backend!');
});

// Test POST route
app.post('/echo', (req, res) => {
  res.json({
    message: 'Received your data!',
    data: req.body,
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
