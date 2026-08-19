const winston = require('winston');
const fluentLogger = require('fluent-logger');

const fluentTransport = fluentLogger.createFluentSender('js_app', {
  host: process.env.FLUENT_HOST || 'fluentd',
  port: Number(process.env.FLUENT_PORT || 24224),
  timeout: 3.0
});

const consoleLogger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [new winston.transports.Console()]
});

function write(level, message, meta = {}) {
  const record = {
    level,
    message,
    ...meta,
    timestamp: new Date().toISOString()
  };

  consoleLogger.log(level, message, meta);
  fluentTransport.emit('winston', record);
}

module.exports = {
  info: (message, meta = {}) => write('info', message, meta),
  warn: (message, meta = {}) => write('warn', message, meta),
  error: (message, meta = {}) => write('error', message, meta),
  debug: (message, meta = {}) => write('debug', message, meta)
};
