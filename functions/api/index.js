exports.http = (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(204).send('');
    return;
  }

  const response = {
    message: 'Hello from Cloud Function API',
    environment: process.env.ENVIRONMENT || 'unknown',
    timestamp: new Date().toISOString(),
    projectId: process.env.PROJECT_ID || 'unknown'
  };

  res.status(200).json(response);
};
