#!/bin/bash
rethinkdb create --server-tag default
rethinkdb serve --bind all
