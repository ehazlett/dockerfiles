# Tree.io
Business management platform (http://tree.io)

By default the container will use SQLite for the database backend.

* `docker build -t treeio .`
* `docker run -i -t -p 8000 treeio`

Ports

* 8000

Environment Variables

* `DB_ENGINE`: Database engine (default `sqlite3`)
* `DB_HOST`: Database host (optional)
* `DB_PORT`: Database port (optional)
* `DB_USER`: Database user (optional)
* `DB_PASS`: Database password (optional)
* `DB_NAME`: Database name (default: `treeio.db`)
* `SMTP_HOST`: SMTP Host (optional)
* `SMTP_PORT`: SMTP Port (optional)
* `SMTP_USER`: SMTP Username (optional)
* `SMTP_PASS`: SMTP Password (optional)
* `SMTP_USE_TLS`: Enable TLS for SMTP (optional)
* `SMTP_FROM_ADDRESS`: SMTP From address (optional)

