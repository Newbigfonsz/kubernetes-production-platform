CREATE TABLE IF NOT EXISTS todos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_todos_completed ON todos(completed);
CREATE INDEX idx_todos_created_at ON todos(created_at);

INSERT INTO todos (title, description, completed) VALUES
('Setup Kubernetes Cluster', 'Deploy K3s on 3 nodes', true),
('Install Monitoring', 'Prometheus and Grafana', true),
('Add Logging', 'Loki and Promtail', true),
('Implement Tracing', 'Jaeger distributed tracing', true),
('Deploy Full-Stack App', 'React + Node.js + PostgreSQL', false),
('Update Resume', 'Add this amazing project!', false),
('Apply for Jobs', 'Senior DevOps Engineer roles', false);
