Docker support for [Reservations](https://github.com/YaleSTC/reservations).

Available on Docker Hub as [`djjudas/reservations`](https://hub.docker.com/repository/docker/djjudas21/reservations)

This Docker image requires an external MySQL database and will fail to start without one. Set the following environment variables to configure your MySQL connection:
* `RES_DB_NAME`
* `RES_DB_USERNAME`
* `RES_DB_PASSWORD`
* `RES_DB_HOST`
