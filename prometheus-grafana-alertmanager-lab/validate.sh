#!/usr/bin/env bash
set -e

echo "=== Docker containers ==="
docker compose ps

echo
echo "=== Prometheus ready ==="
curl -fsS http://localhost:9090/-/ready
echo

echo
echo "=== Alertmanager ready ==="
curl -fsS http://localhost:9093/-/ready
echo

echo
echo "=== Grafana health ==="
curl -fsS http://localhost:3000/api/health
echo

echo
echo "=== Node Exporter metrics ==="
curl -fsS http://localhost:9100/metrics >/dev/null
echo "node-exporter OK"

echo
echo "=== cAdvisor metrics ==="
curl -fsS http://localhost:8080/metrics >/dev/null
echo "cAdvisor OK"

echo
echo "=== Prometheus targets ==="
curl -fsS 'http://localhost:9090/api/v1/targets'
echo
